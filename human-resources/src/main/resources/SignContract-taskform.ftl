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
     <div class="control-group">
        <label class="control-label">Offer</label>
        <div class="controls">
            <span class="uneditable-input">${in_offering}</span>
        </div>
    </div>      
    <legend>Task Outputs</legend>
    <div class="control-group">
        <label class="control-label" for="out_age">Signed</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
               <select name="out_signed" id="out_signed" disabled>
                  <option value="true">True</option>
                  <option value="false">False</option>
              </select>
	    </#if> 
            <#if task.taskData.status = 'InProgress'>
               <select name="out_signed" id="out_signed">
                  <option value="true">True</option>
                  <option value="false">False</option>
               </select>
	    </#if>
            
        </div>	
    </div>        
</div>