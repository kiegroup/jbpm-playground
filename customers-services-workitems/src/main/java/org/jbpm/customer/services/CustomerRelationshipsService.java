/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jbpm.customer.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author salaboy
 */
public class CustomerRelationshipsService {
    // CustomerId, Comment
    private Map<String, String> comments = new HashMap<String, String>();
    private Map<Integer, List<String>> commentsByAge = new HashMap<Integer, List<String>>();
    private static CustomerRelationshipsService instance;
    
    public static CustomerRelationshipsService getInstance(){
        if(instance == null){
            instance = new CustomerRelationshipsService();
        }
        return instance;
    }
    
    private CustomerRelationshipsService() {
        
    }
    
    public void addComment(String customerId, String comment, int age){
        comments.put(customerId, comment);
        if(commentsByAge.get(age) == null){
            commentsByAge.put(age, new ArrayList<String>());
        }
        commentsByAge.get(age).add(comment);
    }
    
    public Map<String, String> getAllComments(){
        return comments;
    }
    
    public Map<Integer, List<String>> getCommentsByAge(){
        return commentsByAge;
    }
    
}
