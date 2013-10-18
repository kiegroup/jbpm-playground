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
        <label class="control-label">Candite Name</label>
        <div class="controls">
            <span class="uneditable-input">${in_name}</span>
        </div>
    </div>   
    <div class="control-group">
        <label class="control-label">Age</label>
        <div class="controls">
	    <span class="uneditable-input">${in_age}</span>
        </div>
    </div> 
    <div class="control-group">
        <label class="control-label">Email</label>
        <div class="controls">
           <span class="uneditable-input">${in_mail}</span> 
        </div>
    </div>                               
    <legend>Task Outputs</legend>
    <div class="control-group">
        <label class="control-label" for="out_skills">Skills</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
              <input type="text" value="" id="out_skills" name="out_skills" disabled>
            </#if> 
            <#if task.taskData.status = 'InProgress'>
              <input type="text" value="" id="out_skills" name="out_skills">
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
    <div class="control-group">
        <label class="control-label" for="out_twitter">Twitter</label>
        <div class="controls">
            <#if task.taskData.status = 'Reserved'>
              <div class="input-prepend">
                <span class="add-on">@</span>
                <input type="text" value="" id="out_twitter" class="span2" name="out_twitter" disabled>
              </div>
            </#if> 
            <#if task.taskData.status = 'InProgress'>
 		<div class="input-prepend">
                <span class="add-on">@</span>
                <input type="text" value="" id="out_twitter" class="span2" name="out_twitter">
              </div>
            </#if> 
        </div>	
    </div>
</div>

