package org.kie.tests.listener;

import java.util.List;
import java.util.Map;

import javax.enterprise.inject.spi.BeanManager;

import org.drools.core.process.instance.WorkItemManager;
import org.jbpm.services.api.DefinitionService;
import org.jbpm.workflow.instance.node.HumanTaskNodeInstance;
import org.kie.api.event.process.ProcessCompletedEvent;
import org.kie.api.event.process.ProcessEventListener;
import org.kie.api.event.process.ProcessNodeLeftEvent;
import org.kie.api.event.process.ProcessNodeTriggeredEvent;
import org.kie.api.event.process.ProcessStartedEvent;
import org.kie.api.event.process.ProcessVariableChangedEvent;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.manager.RuntimeManager;
import org.kie.api.runtime.process.NodeInstance;
import org.kie.api.task.TaskService;
import org.kie.api.task.model.Task;
import org.kie.internal.runtime.manager.context.ProcessInstanceIdContext;

public class TaskInfoProcessEventListener implements ProcessEventListener {

    private RuntimeManager runtimeManager;

    public TaskInfoProcessEventListener(RuntimeManager runtimeManager) { 
        this.runtimeManager = runtimeManager;
    }
    
    public RuntimeManager getRuntimeManager() {
        return runtimeManager;
    }

    public void setRuntimeManager(RuntimeManager runtimeManager) {
        this.runtimeManager = runtimeManager;
    }
    
    public void beforeProcessStarted( ProcessStartedEvent event ) {
        // DBG Auto-generated method stub

    }

    public void afterProcessStarted( ProcessStartedEvent event ) {
        // DBG Auto-generated method stub

    }

    public void beforeProcessCompleted( ProcessCompletedEvent event ) {
        // DBG Auto-generated method stub

    }

    public void afterProcessCompleted( ProcessCompletedEvent event ) {
        // DBG Auto-generated method stub

    }

    public void beforeNodeTriggered( ProcessNodeTriggeredEvent event ) {

    }

    public void afterNodeTriggered( ProcessNodeTriggeredEvent event ) {
        Long myTaskId = null;
        String deploymentId = null;
        String taskName = null;
        
        NodeInstance nodeInstance = event.getNodeInstance();
        if( nodeInstance instanceof HumanTaskNodeInstance ) { 
            taskName = nodeInstance.getNode().getName();
            long procInstid = event.getProcessInstance().getId();
            if( runtimeManager != null ) { 
                RuntimeEngine runtime = runtimeManager.getRuntimeEngine(ProcessInstanceIdContext.get(procInstid));
                TaskService taskService = runtime.getTaskService();
                List<Long> taskIds = taskService.getTasksByProcessInstanceId(procInstid);
                Task myTask = null;
                for( long taskId : taskIds ) { 
                    Task task = taskService.getTaskById(taskId);
                    if( taskName.equals(task.getName()) ) { 
                        myTask = task; 
                        myTaskId = myTask.getId();
                        deploymentId = myTask.getTaskData().getDeploymentId();
                    }
                }

            }
        }
        
        String processId = event.getProcessInstance().getProcessId();
        if( myTaskId != null ) { 
            BeanManager beanManager = CDIUtils.lookUpBeanManager();
            if( beanManager != null ) { 
                DefinitionService defService;
                try {
                    defService = CDIUtils.createBean(DefinitionService.class, beanManager);
                    Map<String, String> inputMappings = defService.getTaskInputMappings(deploymentId, processId, taskName);
                } catch( Exception e ) {
                    // // do nothing
                }
               
            }
        }
    }

    public void beforeNodeLeft( ProcessNodeLeftEvent event ) {
        // DBG Auto-generated method stub

    }

    public void afterNodeLeft( ProcessNodeLeftEvent event ) {
        // DBG Auto-generated method stub

    }

    public void beforeVariableChanged( ProcessVariableChangedEvent event ) {
        // DBG Auto-generated method stub

    }

    public void afterVariableChanged( ProcessVariableChangedEvent event ) {
        // DBG Auto-generated method stub

    }

}
