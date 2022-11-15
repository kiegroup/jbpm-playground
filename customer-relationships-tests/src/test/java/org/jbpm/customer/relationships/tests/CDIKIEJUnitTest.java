package org.jbpm.customer.relationships.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

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
import org.jbpm.customer.services.AddCustomerCommentsWorkItemHandler;
import org.jbpm.customer.services.CreateCustomerWorkItemHandler;
import org.jbpm.customer.services.ManagersReportWorkItemHandler;
import org.jbpm.services.task.utils.ContentMarshallerHelper;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
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

import bitronix.tm.resource.jdbc.PoolingDataSource;

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
        return ShrinkWrap.create(JavaArchive.class, "customer-relationships-tests.jar")
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
                .addPackage("org.jbpm.customer.relationships.tests")
                
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
    @Ignore("endpoint not available")
    public void processExecutionTest() {
        
        RuntimeEngine engine = runtimeManager.getRuntimeEngine(EmptyContext.get());
        assertNotNull(engine);
        KieSession kieSession = engine.getKieSession();
        
        kieSession.getWorkItemManager().registerWorkItemHandler("CreateCustomer", new CreateCustomerWorkItemHandler());
        kieSession.getWorkItemManager().registerWorkItemHandler("AddCustomerComment", new AddCustomerCommentsWorkItemHandler());
        kieSession.getWorkItemManager().registerWorkItemHandler("ManagersReport", new ManagersReportWorkItemHandler());
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("customer_phone", "4444-55555");
        ProcessInstance processInstance = kieSession.startProcess("CustomersRelationship.customers", params);
        
        assertNotNull(processInstance);
        TaskService taskService = engine.getTaskService();
        List<TaskSummary> tasksAssignedAsPotentialOwner = taskService.getTasksAssignedAsPotentialOwner("mary", "en-UK");
        
        assertTrue(!tasksAssignedAsPotentialOwner.isEmpty());
        TaskSummary taskSummary = tasksAssignedAsPotentialOwner.get(0);
        assertEquals("Obtain Customer Info", taskSummary.getName());
        
        taskService.claim(taskSummary.getId(), "mary");
        
        taskService.start(taskSummary.getId(), "mary");

        Task obtainDataTask = taskService.getTaskById(taskSummary.getId());

        long contentId = obtainDataTask.getTaskData().getDocumentContentId();
        assertTrue(contentId != -1);

        Content content = taskService.getContentById(contentId);
        Object unmarshalledObject = ContentMarshallerHelper.unmarshall(content.getContent(), null);
        if (!(unmarshalledObject instanceof Map)) {
            fail("The variables should be a Map");

        }
        Map<String, Object> unmarshalledvars = (Map<String, Object>) unmarshalledObject;

        assertEquals("4444-55555", unmarshalledvars.get("in_customer_phone"));

        Map<String, Object> taskParams = new HashMap<String, Object>();
        taskParams.put("out_customer_name", "salaboy");
        taskParams.put("out_customer_lastname", "salaboyLN");
        taskParams.put("out_customer_age", "30");
        taskParams.put("out_customer_email", "fake@email.com");
        taskParams.put("out_customer_address", "fake address 45");

        taskService.complete(taskSummary.getId(), "mary", taskParams);
        
        tasksAssignedAsPotentialOwner = taskService.getTasksAssignedAsPotentialOwner("mary", "en-UK");
        assertTrue(!tasksAssignedAsPotentialOwner.isEmpty());
        
        taskSummary = tasksAssignedAsPotentialOwner.get(0);
        assertEquals("Call Customer For Comments", taskSummary.getName());
        
        taskService.claim(taskSummary.getId(), "mary");
        
        //.. continue with the next task from here
        
    }
}
