/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jbpm.customer.relationships.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jbpm.customer.services.AddCustomerCommentsWorkItemHandler;
import org.jbpm.customer.services.CreateCustomerWorkItemHandler;
import org.jbpm.customer.services.ManagersReportWorkItemHandler;
import org.jbpm.services.task.utils.ContentMarshallerHelper;
import org.jbpm.test.JbpmJUnitBaseTestCase;
import org.junit.Ignore;
import org.junit.Test;
import org.kie.api.io.ResourceType;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.process.ProcessInstance;
import org.kie.api.task.TaskService;
import org.kie.api.task.model.Content;
import org.kie.api.task.model.Task;
import org.kie.api.task.model.TaskSummary;

/**
 *
 * @author salaboy
 */
public class SimpleProcessJUnitTest extends JbpmJUnitBaseTestCase {

    public SimpleProcessJUnitTest() {
        super(true, true, "org.jbpm.sample");
    }

    @Test
    @Ignore("endpoint not available")
    public void simpleProcessTest() {
        Map<String, ResourceType> resources = new HashMap<String, ResourceType>();
        resources.put("customers.bpmn2", ResourceType.BPMN2);
        createRuntimeManager(resources, "simple-no-cdi-test");
        RuntimeEngine engine = getRuntimeEngine();
        assertNotNull(engine);

        KieSession ksession = engine.getKieSession();
        ksession.getWorkItemManager().registerWorkItemHandler("CreateCustomer", new CreateCustomerWorkItemHandler());
        ksession.getWorkItemManager().registerWorkItemHandler("AddCustomerComment", new AddCustomerCommentsWorkItemHandler());
        ksession.getWorkItemManager().registerWorkItemHandler("ManagersReport", new ManagersReportWorkItemHandler());
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("customer_phone", "4444-55555");
        ProcessInstance processInstance = ksession.startProcess("CustomersRelationship.customers", params);

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
