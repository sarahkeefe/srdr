footnotes_count = [];    // keep track of the number of fields assigned to a given footnote
footnotes_count["categorical"] = [];     // extra lines added to keep track of separate tables in same page
footnotes_count["continuous"] = [];
footnotes_assigned = []; // keep track of footnotes assigned to a given field
footnotes_assigned["categorical"] = [];  // extra lines added to keep track of separate tables in same page
footnotes_assigned["continuous"] = [];

// used on the outcome results page to initialize the above arrays
// pass in the name of the page and an array of study arm ids
// and populate the footnotes_count and footnotes_assigned arrays
// RIGHT NOW THIS IS ONLY SET UP FOR THE RESULTS TABLE
function init_footnote_values(page,categorical,continuous){
	//alert("I'm in.");
	var cat_fields = categorical
	var cont_fields = continuous
	cat_fields = cat_fields.split(",");
	cont_fields = cont_fields.split(",");
	
	for(var i=0; i<cat_fields.length;i++){
		//alert(cat_fields[i]);
	}
	for(var j=0; j<cont_fields.length;j++){
		//alert(cont_fields[j]);
	}
	if(page == "outcome_results"){  
		do_updates_for_init(cat_fields,"categorical");
		do_updates_for_init(cont_fields,"continuous");
	}
}
function do_updates_for_init(fields, type){
	//alert("fields.length is: " + fields.length.toString());
	for(var i=0; i < fields.length; i++){
		//alert("Setting current field to be: " + fields[i].toString())
		var notes_assigned = [];
		var val= $(fields[i]).value;
		var start_loc = val.indexOf("[");
		var end_loc = val.indexOf("]");
		
		// if we found the brackets we can continue
		if(start_loc >= 0 && end_loc >= 0){
		  var note_nums = val.substring(start_loc+1 , end_loc);
		  note_nums = note_nums.split(",");
		  
		  //iterate through the note numbers and update the counts and assignments
		  for(var k=0; k<note_nums.length; k++){
		  	
		  	var note = parseInt(note_nums[k]);
		  	if(footnotes_count[type][note] == undefined){
		  		footnotes_count[type][note] = 1;
		  		//alert("footnotes_count for "+note+" is now " + footnotes_count[type][note] + " (" + fields[i] + ")");
		  	}else{
		  		footnotes_count[type][note] += 1;
		  		//alert("footnotes_count for "+note+" is now " + footnotes_count[type][note] + " (" + fields[i] + ")");
		  	}
		  	notes_assigned.push(note);
		  }	
		}
		if(notes_assigned.length > 0){
			footnotes_assigned[type][fields[i]] = notes_assigned;
			//alert('footnotes assigned for ' + fields[i] + 'are: ' + notes_assigned);
		}
		
	}	
}
function check_for_footnote(val, elementid, data_type){
	var start_loc = val.indexOf("[")
	var end_loc = val.indexOf("]")
	var div_to_check = ""
	if(data_type == null){
		// do something here for other pages?
	}else{
		if(data_type == "categorical"){
			div_to_check = "categorical_footnotes";
		}else if(data_type == "continuous"){
			div_to_check = "continuous_footnotes";
		}else{
		  div_to_check = "footnotes";
		}
	}
	if(start_loc >= 0 && end_loc >= 0){
	  
		var fnotes_div = $(div_to_check)
	  var fnote_numbers = get_footnote_numbers(val, elementid, data_type)
	  
	  for(i=0; i<fnote_numbers.length; i++){
	  	var fnote_span = document.createElement('span');
	  	var id = data_type.toString() + "_footnote_" + fnote_numbers[i];
	  	$(fnote_span).id = id + "_span"
	  	fnote_span.className = 'footnote'
	  	fnote_span.innerHTML = "	<span style='font-weight: bold;'>" + fnote_numbers[i] + ".</span> <input class='footnote' style='width:95%;' id=" + id.toString() + " name ='" + id.toString() + "' size=120 /><br/>"
	  	fnotes_div.appendChild(fnote_span)	
	  }
  }else{
  	remove_unused_footnotes(elementid,data_type);
  }
}
// Based on an entry string, get footnote values for a given element
// entry = a string containing the values (ex: 10 [1,2,3])
// element is the name of the field
function get_footnote_numbers(entry, element, type){
	//alert ("element is " + element.toString())
	var dataType = type;

	var start = entry.indexOf("[");
  var end = entry.indexOf("]");
  var values = entry.substring(start+1, end);
  var nums_array = [];
  
  var vals = values.split(",");
  vals.sort(function(a,b){return a - b})
  var footnotes_assigned_to_element = [];
  
  for(i=0; i<vals.length; i++){
  	var tmpVal = parseInt(vals[i].trim())
  	var already_done = span_exists(vals[i], dataType);

	  if(!already_done){
	  	var tmpVal = parseInt(vals[i].trim())
			//alert("Length of footnotes_assigned_to_element is " + footnotes_assigned_to_element.length + ".");
	  	if(footnotes_count[dataType][tmpVal] in {undefined:1, 0:1}){
	  		footnotes_count[dataType][tmpVal] = 1;
	  		footnotes_assigned_to_element.push(tmpVal);
	  		nums_array.push(tmpVal);
	  	
			}else{
	  		footnotes_count[dataType][tmpVal] += 1;
	  		footnotes_assigned_to_element.push(tmpVal);
	  	}
	  }else{
	  	footnotes_assigned_to_element.push(tmpVal);
	  	if(!(in_array(tmpVal, footnotes_assigned[type][element.toString()]))){
	  		footnotes_count[dataType][tmpVal] += 1;
	  	}
	  }
  }
  unassign_footnotes(footnotes_assigned_to_element, footnotes_assigned[dataType][element.toString()], dataType)
  footnotes_assigned[dataType][element.toString()] = footnotes_assigned_to_element;
  
  return(nums_array); 
}

// This is called when there are no footnotes specified to be sure that
// we get rid of any that existed before
function remove_unused_footnotes(element,dat_type){
	//alert ("trying to remove the footnotes");
	var earlier_notes = footnotes_assigned[dat_type][element.toString()]
	if(earlier_notes != undefined && earlier_notes != []){
		for(var i=0; i<earlier_notes.length; i++){
			//alert("current is: " + earlier_notes[i].toString());
			footnotes_count[dat_type][earlier_notes[i]] -= 1;
			
			if(footnotes_count[dat_type][earlier_notes[i]] == 0){
				//alert("should be removing " + earlier_notes[i].toString());
				remove_footnote(earlier_notes[i],dat_type);					
			}
			footnotes_assigned[dat_type][element.toString()] = undefined;
		}	
	}
}


function unassign_footnotes(current,former, dat_type){
	if(former != undefined && former.length != 0){
		for(var i=0; i<former.length; i++){
		  var exists = false;
			for(var j=0; j<current.length; j++){
		  	if(former[i] == current[j]){
		  		exists = true;
		  		break;
		  	}
		  }
		  if(!exists){
		  	footnotes_count[dat_type][former[i]] -= 1;
		  	
		    if(footnotes_count[dat_type][former[i]] == 0){
		  		remove_footnote(former[i],dat_type);
		  	}
		  }
		}
	}
}

// delete an individual footnote from the table based on its number
function remove_footnote(note_number,type){
  var fn_span_id = type.toString() + "_footnote_"+note_number.toString()+"_span"
  $(fn_span_id).empty();
  $(fn_span_id).remove(); 
}

// determine if an item is found within an array
function in_array(item_to_find, array_to_search){
	var retVal = false;
	if(array_to_search != undefined && array_to_search.length > 0){
		for(var i=0; i<array_to_search.length; i++){
			if(parseInt(item_to_find) == parseInt(array_to_search[i])){
				retVal = true;
				break;
			}
		}
	}
	//alert("returning: " + retVal)
	return(retVal);
}

// determine if a span exists for the footnote with a number indicated by
// fn_num and type (categorical or continuous, etc.)
function span_exists(fn_num, type){
	//alert("fn_num is: " + fn_num);
  var retVal = true;  
  var id = type.toString() + "_footnote_"+fn_num.toString()+"_span"
  var span = $(id)
  if(span == null){
  	//alert ("the span was not found")
  	retVal = false;
  }
  return(retVal)
}