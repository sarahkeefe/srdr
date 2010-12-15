function add_continuous_outcome_analysis_row(){
	var row_id = "row_1"
	var row_num = 1
	var num_analyses = $('continuous_analysis_table').getElementsByTagName('tr').length
	if(num_analyses > 2){
		var previous_row = $('continuous_analysis_table').getElementsByTagName('tr')[num_analyses-1].id.toString();
	  row_num = parseInt(previous_row.replace("row_","")) + 1;
	  row_id = "row_" + row_num.toString();
	  //alert("row id = " + row_id);
	  //alert("row_num = " + row_num);
	}
	var tbody = $('continuous_analysis_table').getElementsByTagName("tbody")[0];
	var row_class = get_next_row_class('continuous_analysis_table');
	var tr = Builder.node('tr', {id: row_id, class: row_class}),
		//td1 = Builder.node('td'),
		td2 = Builder.node('td'),
		td3 = Builder.node('td'),
		td4 = Builder.node('td'),
		td5 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td6 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td7 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td8 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td9 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td10 = Builder.node('td',{class: 'non_adjusted_analysis'}),
		td11 = Builder.node('td',{class: 'adjusted_analysis'}),
		td12 = Builder.node('td',{class: 'adjusted_analysis'});
		td13 = Builder.node('td',{class: 'adjusted_analysis'});
		td14 = Builder.node('td',{class: 'adjusted_analysis'});
		td15 = Builder.node('td',{class: 'adjusted_analysis'});
		td16 = Builder.node('td',{class: 'adjusted_analysis'});
	  td17 = Builder.node('td',{class: 'adjusted_analysis'});
		td18 = Builder.node('td');
		
		// GET THE NUMBER OF ARMS THAT WE NEED TO ITERATE THROUGH
		var num_arms = $('available_arms').options.length
		arm_select_options = ""
		var selected = ""
		for(i=0; i<num_arms; i++){
			if(i == 1){
				selected = "selected"
			}else{
				selected = ""
			}
			arm_select_options = arm_select_options + "<option value='" + 
													$('available_arms').options[i].value.toString() + 
													"'>" + $('available_arms').options[i].innerHTML.toString() + "</option>"
		}
		var analysis_type_options = "<option value='Analysis Type...'>Analysis Type...</option>"+
											"<option value='ANOVA'>ANOVA</option>"+
											"<option value='ANCOVA'>ANCOVA</option>"+
											"<option value='Chi-Squared'>Chi-Squared</option>"+
											"<option value='Chi-Squared, Corrected'>Chi-Squared, Corrected</option>"+
											"<option value='Fisher Exact'>Fisher Exact</option>"+
											"<option value='Kruskal-Wallis'>Kruskal-Wallis</option>";
											
	  var ci_level_options = "<option value='95%'>95%</option>"+
	  											  "<option value='90%'>90%</option>";
		
		//td1.innerHTML = "<select id='outcome_analysis_"+row_num+"_outcome_id' name='outcome_analysis_"+row_num+"[outcome_id]'>"+outcome_select_options+"</select>";
		td2.innerHTML = "<select id='outcome_analysis_"+row_num+"_statistical_test' name='outcome_analysis_"+row_num+"[statistical_test]'>" + analysis_type_options+"</select>";
		td3.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm1_id' name='outcome_analysis_"+row_num+"[arm1_id]'>"+arm_select_options+"</select>";
		td4.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm2_id' name='outcome_analysis_"+row_num+"[arm2_id]'>"+arm_select_options+"</select>";
		td5.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[estimation_parameter_value]' id='outcome_analysis_"+row_num+"_estimation_parameter_value' size='30' />";
		td6.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[unadjusted_ci_level]' id='outcome_analysis_"+row_num+"_unadjusted_ci_level' size='3' />";
		td8.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[unadjusted_ci_lower_limit]' id='outcome_analysis_"+row_num+"_unadjusted_ci_lower_limit' size='3' />";
		td9.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[unadjusted_ci_upper_limit]' id='outcome_analysis_"+row_num+"_unadjusted_ci_upper_limit' size='3' />";
		td10.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[p_value]' id='outcome_analysis_"+row_num+"_p_value' size='3' />";
		td11.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_estimation_parameter_value]' id='outcome_analysis_"+row_num+"adjusted_estimation_parameter_value' size='30' />";
		td12.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_parameter_dispersion_value]' id='outcome_analysis_"+row_num+"adjusted_parameter_dispersion_value' size='10'/>";
		td13.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_ci_level]' id='outcome_analysis_"+row_num+"_adjusted_ci_level' size='3' />";
		td14.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_ci_lower_limit]' id='outcome_analysis_"+row_num+"_adjusted_ci_lower_limit' size='3' />";
		td15.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_ci_upper_limit]' id='outcome_analysis_"+row_num+"_adjusted_ci_upper_limit' size='3' />";
		td16.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_p_value]' id='outcome_analysis_"+row_num+"_p_value' size='3' />";
		td17.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_for]' id='outcome_analysis_"+row_num+"_adjusted_for' size='8' />";
		td18.innerHTML = "<a onClick=remove_outcome_analysis_row('" + row_id + "'" + ",'continuous_analysis_table');>Remove</a>";
		//tr.appendChild(td1);
		tr.appendChild(td2);
		tr.appendChild(td3);
		tr.appendChild(td4);
		tr.appendChild(td5);
		tr.appendChild(td6);
		tr.appendChild(td7);
		tr.appendChild(td8);
		tr.appendChild(td9);
		tr.appendChild(td10);
		tr.appendChild(td11);
		tr.appendChild(td12);
		tr.appendChild(td13);
		tr.appendChild(td14);
		tr.appendChild(td15);
		tr.appendChild(td16);
		tr.appendChild(td17);
		tr.appendChild(td18);
	
	
		tbody.appendChild(tr)		
    //Custom.init()
} // end add_continuous_outcome_analysis_row

function remove_outcome_analysis_row(row, analysis_table){
	var row_to_remove = document.getElementById(row)
	var tbody = $(analysis_table).getElementsByTagName("tbody")[0];
	tbody.removeChild(row_to_remove);
	update_row_classes(analysis_table);
}
// after a row has been deleted, go through the table updating the rows
function update_row_classes(tableName){
	var tbody = $(tableName).getElementsByTagName("tbody")[0];
	var trs = tbody.getElementsByTagName("tr")
	var i = 1;
	var row_class = "even"
	if(tableName == "categorical_analysis_table"){
		i = 2;
	}
	for(i; i<trs.length; i++){
		trs[i].className = row_class
		row_class = toggle_row(row_class)
	}
}

// determine what class the next row being added should contain
function get_next_row_class(tableName){
	var tbody = $(tableName).getElementsByTagName("tbody")[0];
	var trs = tbody.getElementsByTagName("tr")
	current_class = trs[trs.length-1].className
	var next_row = toggle_row(current_class)
	return(next_row);
}

// utility function to toggle between odd and even rows
function toggle_row(row){
	var retVal = "even"
	if(row == "even"){
	  retVal = "odd"
  }
  return(retVal);
}