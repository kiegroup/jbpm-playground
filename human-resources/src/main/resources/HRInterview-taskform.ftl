<div>	
    <input type="hidden" name="taskId" value="${task.id}"/>
    <#if task.taskData.status = 'Ready'>	
      <h4>You need to first claim the task before start working</h4> 
    </#if>
    <#if task.taskData.status = 'Reserved'>	
      <h4>Start the task to begin with the interview</h4> 
    </#if> 
    <legend>Task Inputs</legend>
    <div class="control-group">
        <label class="control-label">Candidate Name</label>
        <div class="controls">
            <span class="uneditable-input">${in_name}</span>
        </div>
    </div>    	
    <legend>Task Outputs</legend>
    <div class="control-group">
        <label class="control-label" for="out_age">Age</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
               <input type="text" value="" id="out_age" name="out_age" disabled>
	    </#if> 
            <#if task.taskData.status = 'InProgress'>
               <input type="text" value="" id="out_age" name="out_age">
	    </#if>
        </div>	
    </div>
    <div class="control-group">
        <label class="control-label" for="out_mail">Email</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
              <input type="email" value="" id="out_mail" name="out_mail" disabled>
            </#if> 
            <#if task.taskData.status = 'InProgress'>
	       <input type="email" value="" id="out_mail" name="out_mail">
            </#if> 	
        </div>
    </div>                            
    <div class="control-group">        
        <label class="control-label" for="out_score">Score</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
            <select id="out_score" name="out_score" disabled>
                  <option value="1">1 - Poor</option>
                  <option value="2">2</option>
                  <option value="3">3 - Well</option>
                  <option value="4">4</option>
                  <option value="5">5 - Excellent</option>
            </select>
            </#if> 
            <#if task.taskData.status = 'InProgress'>
               <select id="out_score" name="out_score">
                  <option value="1">1 - Poor</option>
                  <option value="2">2</option>
                  <option value="3">3 - Well</option>
                  <option value="4">4</option>
                  <option value="5">5 - Excellent</option>
            </select>
	   </#if> 
        </div>	
    </div>
</div>