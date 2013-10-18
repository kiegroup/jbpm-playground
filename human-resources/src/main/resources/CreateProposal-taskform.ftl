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
        <label class="control-label">Technical Score</label>
        <div class="controls">
		<span class="uneditable-input">${in_tech_score}</span>
        </div>
    </div>   
    <div class="control-group">
        <label class="control-label">HR Score</label>
        <div class="controls">
            <span class="uneditable-input">${in_hr_score}</span>
        </div>
    </div>                         
    <legend>Task Outputs</legend>
    <div class="control-group">
        <label class="control-label" for="out_offering">Job Offer Salary</label>
        <div class="controls">
             <#if task.taskData.status = 'Reserved'>
               <input type="text" value="" id="out_offering" class="" name="out_offering" disabled>
	    </#if> 
            <#if task.taskData.status = 'InProgress'>
               <input type="text" value="" id="out_offering" class="" name="out_offering">
	    </#if>

            
        </div>	
    </div>
</div>

