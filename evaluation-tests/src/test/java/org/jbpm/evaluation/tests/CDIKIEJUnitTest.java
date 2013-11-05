package org.jbpm.evaluation.tests;

import bitronix.tm.resource.jdbc.PoolingDataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.ArchivePaths;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.spec.JavaArchive;
import org.jbpm.services.task.utils.ContentMarshallerHelper;
import org.junit.AfterClass;
import static org.junit.Assert.*;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.manager.RuntimeManager;
import org.kie.api.runtime.process.ProcessInstance;
import org.kie.api.task.TaskService;
import org.kie.api.task.model.Content;
import org.kie.api.task.model.Task;
import org.kie.api.task.model.TaskSummary;
import org.kie.internal.runtime.manager.cdi.qualifier.Singleton;
import org.kie.internal.runtime.manager.context.EmptyContext;

/**
 *
 * @author salaboy
 */
@RunWith(Arquillian.class)
public class CDIKIEJUnitTest  {

    public CDIKIEJUnitTest() {
    }

    private static PoolingDataSource pds;

    @Deployment()
    public static Archive<?> createDeployment() {
        return ShrinkWrap.create(JavaArchive.class, "evaluation-tests.jar")
                .addPackage("org.jboss.seam.transaction")
                .addPackages(true, "org.kie.api.task")
                .addPackages(true, "org.kie.api.runtime.manager")
                .addPackages(true, "org.kie.internal.runtime.manager")
                .addPackages(true, "org.jbpm.kie")
                .addPackages(true, "org.jbpm.kie.services")
                .addPackages(true, "org.jbpm.services")
                .addPackages(true, "org.jbpm.services.task")
                .addPackages(true, "org.jbpm.services.task.identity")
                .addPackages(true, "org.jbpm.runtime")
                .addPackages(true, "org.jbpm.runtime.manager.impl")
                .addPackages(true, "org.jbpm.runtime.manager.impl.cdi")
                .addPackages(true, "org.jbpm.shared")
                .addPackage("org.jbpm.evaluation.tests")
                
                .addAsManifestResource("META-INF/persistence.xml", ArchivePaths.create("persistence.xml"))
                .addAsManifestResource("META-INF/beans.xml", ArchivePaths.create("beans.xml"));
   
    }
    
    
    @BeforeClass
    public static void setupOnce() {
        pds = new PoolingDataSource();
        pds.setUniqueName("jdbc/jbpm-ds");
        pds.setClassName("bitronix.tm.resource.jdbc.lrc.LrcXADataSource");
        pds.setMaxPoolSize(5);
        pds.setAllowLocalTransactions(true);
        pds.getDriverProperties().put("user", "sa");
        pds.getDriverProperties().put("password", "");
        pds.getDriverProperties().put("url", "jdbc:h2:mem:jbpm-db;MVCC=true");
        pds.getDriverProperties().put("driverClassName", "org.h2.Driver");
        pds.init();
    }

    @AfterClass
    public static void cleanup() {
        if (pds != null) {
            pds.close();
        }
    }

    @Inject
    @Singleton
    @ApplicationScoped
    private RuntimeManager runtimeManager;

  
    @Test
    public void processExecutionTest() {
        
        RuntimeEngine engine = runtimeManager.getRuntimeEngine(EmptyContext.get());
        assertNotNull(engine);
        KieSession kieSession = engine.getKieSession();
        
 
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("employee", "salaboy");
        ProcessInstance processInstance = kieSession.startProcess("evaluation", params);
        
        assertNotNull(processInstance);
        TaskService taskService = engine.getTaskService();
        List<TaskSummary> tasksAssignedAsPotentialOwner = taskService.getTasksAssignedAsPotentialOwner("salaboy", "en-UK");
        
        assertTrue(!tasksAssignedAsPotentialOwner.isEmpty());
        TaskSummary taskSummary = tasksAssignedAsPotentialOwner.get(0);
        assertEquals("Self Evaluation", taskSummary.getName());
        
        
        taskService.start(taskSummary.getId(), "salaboy");

        Task selfEvaluationTask = taskService.getTaskById(taskSummary.getId());

        long contentId = selfEvaluationTask.getTaskData().getDocumentContentId();
        assertTrue(contentId != -1);

        Content content = taskService.getContentById(contentId);
        Object unmarshalledObject = ContentMarshallerHelper.unmarshall(content.getContent(), null);
        if (!(unmarshalledObject instanceof Map)) {
            fail("The variables should be a Map");

        }
        Map<String, Object> unmarshalledvars = (Map<String, Object>) unmarshalledObject;

        
        
        //.. continue with the next task from here
        
    }
}
