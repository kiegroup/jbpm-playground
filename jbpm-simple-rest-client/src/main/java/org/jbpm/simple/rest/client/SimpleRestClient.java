package org.jbpm.simple.rest.client;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.process.ProcessInstance;
import org.kie.api.task.TaskService;
import org.kie.services.client.api.RemoteRestSessionFactory;

/**
 * This is a very simple Rest Client to test against a running
 *  instance of the KIE Workbench. 
 * You can parameterize
 *   - the Deployment Unit Id
 *   - the Application URL
 *   - the user/pass to execute operations
 */
public class SimpleRestClient 
{
    public static void main( String[] args ) throws MalformedURLException
    {
        String deploymentId = "org.jbpm:human-resources:1.0";
        URL appUrl = new URL("http://localhost:8080/kie-wb/");
        String user = "jbpm";
        String password = "jbpm6";
        
        RemoteRestSessionFactory restSessionFactory 
            = new RemoteRestSessionFactory(deploymentId, appUrl, user, password);
        RuntimeEngine engine = restSessionFactory.newRuntimeEngine();
        
        KieSession ksession = engine.getKieSession();
        TaskService taskService = engine.getTaskService();
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("candidate", "johny");
        
        ProcessInstance processInstance = ksession.startProcess("hiring", params);
        // do some more interactions here... for example try the Human Task APIs
        // List<TaskSummary> tasksAssignedAsPotentialOwner = taskService.getTasksAssignedAsPotentialOwner("jbpm", "en-UK"); 
        
        
    }
}
