This project shows a business process which interacts with an external (public) web services to store customers.
Because the web service is hosted in a remote server, you will need to have internet connection to run the example.
It is also important that you deploy the WorkItemHandlers in charge of contacting with the web services inside the
WEB-INF/lib directory of the kie-wb.war application.

You can find the source code for this custom workitem handlers here:


and configure them inside the WEB-INF/classes/META-INF/CustomWorkItemHandlers.conf
For Example:

...
"CreateCustomer": new com.salaboy.jbpm.customer.services.CreateCustomerWorkItemHandler(),
 "AddCustomerComment": new com.salaboy.jbpm.customer.services.AddCustomerCommentsWorkItemHandler(),
 "ManagersReport": new com.salaboy.jbpm.customer.services.ManagersReportWorkItemHandler(),
...
