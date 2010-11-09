// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Clear the form in the key questions creation after the information is submitted
// and updated via ajax
function clear_kq_form(){
	var form = document.getElementById("new_key_question");
	for(var i=0; i<form.length; i++){
		form.elements[i].value = "";
	}
}

// Get a list of elements based on the css class
// searchClass = class name
// domNode is "document" by default
// tagName allows us to specify the html tag, <a>, <input, etc.
function getElementsByClass( searchClass, domNode, tagName) { 
	if (domNode == null) domNode = document;
	if (tagName == null) tagName = '*';
	var el = new Array();
	var tags = domNode.getElementsByTagName(tagName);
	var tcl = " "+searchClass+" ";
	for(i=0,j=0; i<tags.length; i++) { 
		var test = " " + tags[i].className + " ";
		if (test.indexOf(tcl) != -1) 
			el[j++] = tags[i];
	} 
	return el;
} 

function disable_delete_links(){
	alert('In the function');
	var links = getElementsByClass("kq_delete_link")
	alert("Made it back from getElementsByClass and have " + links.length + " links.");
	for(i=0; i<links.length; i++){
		alert(links[i])
		links[i].disabled = true
	}	
}

function add_continuous_outcome_analysis_row(){
	var row_id = "row_1"
	var row_num = 1
	var num_analyses = $('outcome_analysis_table').getElementsByTagName('tr').length
	if(num_analyses > 1){
		//alert("length > 1");
		var previous_row = $('outcome_analysis_table').getElementsByTagName('tr')[num_analyses-1].id.toString();
	  row_num = parseInt(previous_row.replace("row_","")) + 1;
	  row_id = "row_" + row_num.toString();
	  //alert("row id = " + row_id);
	  //alert("row_num = " + row_num);
	}
	
	var tr = Builder.node('tr', {id: row_id}),
		td1 = Builder.node('td'),
		td2 = Builder.node('td'),
		td3 = Builder.node('td'),
		td4 = Builder.node('td'),
		td5 = Builder.node('td'),
		td6 = Builder.node('td'),
		td7 = Builder.node('td'),
		td8 = Builder.node('td');
		
		// GET THE NUMBER OF OUTCOMES THAT WE NEED TO ITERATE THROUGH
		var num_outcomes = $('continuous_outcomes').options.length
		var i = 0;
		var outcome_select_options = ""
		
		// CREATE A STRING OF OUTCOME OPTIONS 
		for(i=0; i<num_outcomes; i++){
			outcome_select_options = outcome_select_options + "<option value='" + 
															 $('continuous_outcomes').options[i].value.toString() + 
															 "'>"+ $('continuous_outcomes').options[i].innerHTML.toString() + "</option>";
		}
		
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
		
		td1.innerHTML = "<select id='outcome_analysis_"+row_num+"_outcome_id' name='outcome_analysis_"+row_num+"[outcome_id]'>"+outcome_select_options+"</select>";
		td2.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm1_id' name='outcome_analysis_"+row_num+"[arm1_id]'>"+arm_select_options+"</select>";
		td3.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm2_id' name='outcome_analysis_"+row_num+"[arm2_id]'>"+arm_select_options+"</select>";
		td4.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[n_analyzed]' id='outcome_analysis_"+row_num+"_n_analyzed' size='10' />";
		td5.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[estimation_parameter_value]' id='outcome_analysis_"+row_num+"_estimation_parameter_value' size='30' />";
		td6.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[parameter_dispersion_value]' id='outcome_analysis_"+row_num+"_parameter_dispersion_value' size='30'/>";
		td7.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[p_value]' id='outcome_analysis_"+row_num+"_p_value' size='10' />";
		td8.innerHTML = "<a href='#' onClick=remove_outcome_analysis_row('" + row_id + "','outcome_analysis_table');>Remove</a>";
		tr.appendChild(td1);
		tr.appendChild(td2);
		tr.appendChild(td3);
		tr.appendChild(td4);
		tr.appendChild(td5);
		tr.appendChild(td6);
		tr.appendChild(td7);
		tr.appendChild(td8);
	
	
		$('outcome_analysis_table').appendChild(tr)		

} // end add_outcome_analysis_row

function add_categorical_outcome_analysis_row(){
	var row_id = "categorical_row_1"
	var row_num = 1
	var num_analyses = $('categorical_analysis_table').getElementsByTagName('tr').length
	
	if(num_analyses > 2){
		//alert("length > 1");
		var previous_row = $('categorical_analysis_table').getElementsByTagName('tr')[num_analyses-1].id.toString();
	  row_num = parseInt(previous_row.replace("categorical_row_","")) + 1;
	  row_id = "categorical_row_" + row_num.toString();
	  //alert("row id = " + row_id);
	  //alert("row_num = " + row_num);
	}
	
	var tr = Builder.node('tr', {id: row_id}),
		td1 = Builder.node('td'),
		td2 = Builder.node('td'),
		td3 = Builder.node('td'),
		td4 = Builder.node('td'),
		td5 = Builder.node('td'),
		td6 = Builder.node('td'),
		td7 = Builder.node('td'),
		td8 = Builder.node('td'),
		td9 = Builder.node('td'),
		td10 = Builder.node('td'),
		td11 = Builder.node('td'),
		td12 = Builder.node('td');
		
		// GET THE NUMBER OF OUTCOMES THAT WE NEED TO ITERATE THROUGH
		var num_outcomes = $('categorical_outcomes').options.length
		var i = 0;
		var outcome_select_options = ""
		
		// CREATE A STRING OF OUTCOME OPTIONS 
		for(i=0; i<num_outcomes; i++){
			outcome_select_options = outcome_select_options + "<option value='" + 
															 $('categorical_outcomes').options[i].value.toString() + 
															 "'>"+ $('categorical_outcomes').options[i].innerHTML.toString() + "</option>";
		}
		
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
		
		td1.innerHTML = "<select id='outcome_analysis_"+row_num+"_outcome_id' name='outcome_analysis_"+row_num+"[outcome_id]'>"+outcome_select_options+"</select>";
		td2.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm1_id' name='outcome_analysis_"+row_num+"[arm1_id]'>"+arm_select_options+"</select>";
		td3.innerHTML = "<select id='outcome_analysis_"+row_num+"_arm2_id' name='outcome_analysis_"+row_num+"[arm2_id]'>"+arm_select_options+"</select>";
		td4.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[n_total]' id='outcome_analysis_"+row_num+"_n_total' size='10' />";
		td5.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[n_event]' id='outcome_analysis_"+row_num+"_n_event' size='10' />";
		td6.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[estimation_parameter_value]' id='outcome_analysis_"+row_num+"_estimation_parameter_value' size='30' />";
		td7.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[parameter_dispersion_value]' id='outcome_analysis_"+row_num+"_parameter_dispersion_value' size='30'/>";
		td8.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[p_value]' id='outcome_analysis_"+row_num+"_p_value' size='10' />";
		td9.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_estimation_parameter_value]' id='outcome_analysis_"+row_num+"_estimation_parameter_value' size='30' />";
		td10.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_parameter_dispersion_value]' id='outcome_analysis_"+row_num+"_parameter_dispersion_value' size='30'/>";
		td11.innerHTML = "<input type='text' name='outcome_analysis_"+row_num+"[adjusted_p_value]' id='outcome_analysis_"+row_num+"_p_value' size='10' />";
		td12.innerHTML = "<a href='#' onClick=remove_outcome_analysis_row('" + row_id + "'" + ",'categorical_analysis_table');>Remove</a>";
		tr.appendChild(td1);
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
	
	
		$('categorical_analysis_table').appendChild(tr)		

} // end add_categorical_outcome_analysis_row
function remove_outcome_analysis_row(row, analysis_table){
	var row_to_remove = document.getElementById(row)
	$(analysis_table).removeChild(row_to_remove)
}
function say_the_word(word){
	alert(word.toString)
}