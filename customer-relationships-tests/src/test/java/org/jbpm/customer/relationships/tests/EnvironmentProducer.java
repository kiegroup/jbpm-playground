package org.jbpm.customer.relationships.tests;


import java.util.Collections;
import java.util.List;

import javax.annotation.PreDestroy;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.BeanManager;
import javax.inject.Inject;
import javax.persistence.EntityManagerFactory;

import org.jbpm.process.audit.AbstractAuditLogger;
import org.jbpm.runtime.manager.impl.RuntimeEnvironmentBuilder;
import org.jbpm.runtime.manager.impl.jpa.EntityManagerFactoryManager;
import org.jbpm.services.api.DeploymentService;
import org.jbpm.services.cdi.Kjar;
import org.jbpm.services.cdi.impl.manager.InjectableRegisterableItemsFactory;
import org.jbpm.services.task.audit.JPATaskLifeCycleEventListener;
import org.jbpm.services.task.identity.JBossUserGroupCallbackImpl;
import org.kie.api.io.ResourceType;
import org.kie.api.task.TaskLifeCycleEventListener;
import org.kie.internal.identity.IdentityProvider;
import org.kie.internal.io.ResourceFactory;
import org.kie.internal.runtime.manager.RuntimeEnvironment;
import org.kie.internal.runtime.manager.cdi.qualifier.PerProcessInstance;
import org.kie.internal.runtime.manager.cdi.qualifier.PerRequest;
import org.kie.internal.runtime.manager.cdi.qualifier.Singleton;
import org.kie.internal.task.api.UserGroupCallback;



/**
 * CDI producer that provides all required beans for the execution.
 * 
 * IMPORTANT: this is for JavaSE environment and not for JavaEE. 
 * JavaEE environment should rely on RequestScoped EntityManager and some TransactionInterceptor 
 * to manage transactions.
 * <br/>
 * Here complete <code>RuntimeEnvironment</code> is built for selected strategy of RuntimeManager.
 */

@ApplicationScoped
public class EnvironmentProducer {

    @Inject
    private BeanManager beanManager;
    private EntityManagerFactory emf;
    
    @Inject
    @Kjar
    private DeploymentService deploymentService;
    
    @Produces
    @Singleton
    @PerRequest
    @PerProcessInstance
    public RuntimeEnvironment produceEnvironment(EntityManagerFactory emf) {
        
        RuntimeEnvironment environment = RuntimeEnvironmentBuilder.getDefault()
                .entityManagerFactory(emf)
                .userGroupCallback(produceSelectedUserGroupCallback())
                .registerableItemsFactory(InjectableRegisterableItemsFactory.getFactory(beanManager, (AbstractAuditLogger)null))
                .addAsset(ResourceFactory.newClassPathResource("customers.bpmn2"), ResourceType.BPMN2)
                .get();
        return environment;
    }
    
    @Produces    
    public UserGroupCallback produceSelectedUserGroupCallback() {
        return new JBossUserGroupCallbackImpl("classpath:/usergroups.properties");
    }

    
    @Produces
    public EntityManagerFactory produceEntityManagerFactory() {
        if (this.emf == null) {
            this.emf = EntityManagerFactoryManager.get().getOrCreate("org.jbpm.sample"); 
        }
        
        return this.emf;
    }
    
    @PreDestroy
    public void doCleanUp() {
    	EntityManagerFactoryManager.get().clear();
    }

    
    @Produces
    public DeploymentService produceKjarDeployService() {
    	return deploymentService;
    }
    
    @Produces
    public TaskLifeCycleEventListener produceTaskAuditLogger() {
    	return new JPATaskLifeCycleEventListener(true);
    }
    
    @Produces
    public IdentityProvider produceProvider() {
    	return new IdentityProvider() {
			
			public boolean hasRole(String role) {
				return false;
			}
			
			public List<String> getRoles() {
				return Collections.emptyList();
			}
			
			public String getName() {
				return "salaboy";
			}
		};
    }
}
