/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jbpm.customer.services;

import com.predic8.common._1.AddressType;
import com.predic8.common._1.PersonType;
import com.predic8.crm._1.CustomerType;
import com.predic8.wsdl.crm.crmservice._1.CustomerService;
import java.math.BigInteger;
import org.kie.api.runtime.process.WorkItem;
import org.kie.api.runtime.process.WorkItemHandler;
import org.kie.api.runtime.process.WorkItemManager;

/**
 *
 * @author salaboy
 */
public class CreateCustomerWorkItemHandler implements WorkItemHandler{

    public CreateCustomerWorkItemHandler() {
    }

    
    public void executeWorkItem(WorkItem workItem, WorkItemManager manager) {
        
        CustomerService cs = new CustomerService();
        CustomerType ct = new CustomerType();
        ct.setId((String)workItem.getParameter("in_customer_email"));
        PersonType pt = new PersonType();
        pt.setFirstName((String)workItem.getParameter("in_customer_name"));
        pt.setLastName((String)workItem.getParameter("in_customer_lastname"));
        pt.setAge(new BigInteger((String)workItem.getParameter("in_customer_age")));
        AddressType address = new AddressType();
        address.setStreet((String)workItem.getParameter("in_customer_address"));
        pt.setAddress(address);
        
        ct.setPerson(pt);
        cs.getCRMServicePTPort().create(ct);
       
        manager.completeWorkItem(workItem.getId(), null);
    }

    public void abortWorkItem(WorkItem workItem, WorkItemManager manager) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
