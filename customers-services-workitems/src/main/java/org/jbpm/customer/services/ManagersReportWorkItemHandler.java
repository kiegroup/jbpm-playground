/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jbpm.customer.services;

import org.kie.api.runtime.process.WorkItem;
import org.kie.api.runtime.process.WorkItemHandler;
import org.kie.api.runtime.process.WorkItemManager;

/**
 *
 * @author salaboy
 */
public class ManagersReportWorkItemHandler implements WorkItemHandler{

    public ManagersReportWorkItemHandler() {
    }

    
    public void executeWorkItem(WorkItem wi, WorkItemManager wim) {
        System.out.println(" ------------------- Managers Report -----------------------------");
        CustomerRelationshipsService service = CustomerRelationshipsService.getInstance();
        System.out.println(" \t\t ------------------- All Comments -------------------");
        for(String customer : service.getAllComments().keySet()){
             System.out.println("Customer: "+customer + " says: " + service.getAllComments().get(customer));
        }
        System.out.println(" \t\t ------------------- Comments By Age -------------------");
        for(Integer age : service.getCommentsByAge().keySet()){
             System.out.println("Customer from age: "+age + " says: ");
             for(String comment : service.getCommentsByAge().get(age)){
                System.out.println(" \t\t - "+comment);
             }
        }
        System.out.println(" -----------------------------------------------------------------");
        wim.completeWorkItem(wi.getId(), null);
    }

    public void abortWorkItem(WorkItem wi, WorkItemManager wim) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
