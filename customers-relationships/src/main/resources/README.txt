This project shows a business process which interacts with an external (public) web services to store customers.
Because the web service is hosted in a remote server, you will need to have internet connection to run the example.
It is also important that you deploy the WorkItemHandlers in charge of contacting with the web services inside the
WEB-INF/lib directory of the kie-wb.war application.

You can find the source code for these custom WorkItemHandlers here:
https://github.com/droolsjbpm/jbpm-playground.git

In order to get your workitems compiled you can:
1) Clone the repository:
git clone https://github.com/droolsjbpm/jbpm-playground.git
2) Compile the project:
cd jbpm-playground/customers-services-workitems/
mvn clean install
3) Install/Copy the workitemhandlers *jar file (that you can find inside the customers-services-workitems/target/ directory)
into the kie-wb.war/WEB-INF/lib directory 
4) Configure the handlers inside the WEB-INF/classes/META-INF/CustomWorkItemHandlers.conf

For Example:
...
"CreateCustomer": new org.jbpm.customer.services.CreateCustomerWorkItemHandler(),
"AddCustomerComment": new org.jbpm.customer.services.AddCustomerCommentsWorkItemHandler(),
"ManagersReport": new org.jbpm.customer.services.ManagersReportWorkItemHandler(),
...

*) Notice that for the Process Designer to show Custom Service Tasks, you need to configure them
into the WorkItemDefinitions Categories. You will find inside the "customer-relationships" project
a file called WorkDefinitions.wid which contains: 
...
[
    "name" : "CreateCustomer",
    "parameters" : [
	"in_customer_id" : new StringDataType()	
    ],
    "displayName" : "Create Customer",
    "icon" : "defaultemailicon.gif"
  ],
  [
    "name" : "ManagersReport",
    "parameters" : [
	"Report" : new StringDataType()	
    ],
    "displayName" : "Managers Report",
    "icon" : "defaultemailicon.gif"
  ],
  [
    "name" : "AddCustomerComment",
    "parameters" : [
	"Comment" : new StringDataType()	
    ],
    "displayName" : "Add Customer Comment",
    "icon" : "defaultemailicon.gif"
  ],
...

This configuration is only used by the Process Designer, and notice that it doesn't have anything that
points to the actual WorkItemHandlers implementations.
