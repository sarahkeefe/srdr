var footnotes_count = [];    // keep track of the number of fields assigned to a given footnote
var footnotes_assigned = []; // keep track of footnotes assigned to a given field

// used on the outcome results page to initialize the above arrays
// pass in the name of the page and an array of study arm ids
// and populate the footnotes_count and footnotes_assigned arrays
function init_footnote_values(page,arm_ids){
	footnotes_count = [];
	footnotes_assigned = [];
	var start = arm_ids.indexOf("[");
  var end = arm_ids.indexOf("]");
  var arms = arm_ids.substring(start+1, end);
  arms = arms.split(",");
  
  if(page == "outcome_results"){  
		//alert (arms + ", length is : " + arms.length);
		for(var i=0; i<arms.length; i++){
			var nanalyzed = "arm_nanalyzed_"+arms[i].toString()
			var measurereg = "arm_measurereg_"+arms[i].toString()
			var measuredisp = "arm_measuredisp_"+arms[i].toString()
			var pvalue = "arm_pvalue_"+arms[i].toString()
			
			// iterate through the fields and update the arrays
			var fields = [nanalyzed,measurereg,measuredisp,pvalue];
			for(var j=0; j<fields.length; j++){
				var notes_assigned = [];
				var val= $(fields[j]).value
				var start_loc = val.indexOf("[")
				var end_loc = val.indexOf("]")
				
				// if we find the brackets we can continue
				if(start_loc >= 0 && end_loc >= 0){
				  var note_nums = val.substring(start_loc+1 , end_loc);
				  note_nums = note_nums.split(",")
				  
				  //iterate through the note numbers and update the counts and assignments
				  for(var k=0; k<note_nums.length; k++){
				  	
				  	var note = parseInt(note_nums[k]);
				  	if(footnotes_count[note] == undefined){
				  		footnotes_count[note] = 1;
				  		//alert("footnotes_count for "+note+" is now " + footnotes_count[note]);
				  	}else{
				  		footnotes_count[note] += 1;
				  		//alert("footnotes_count for "+note+" is now " + footnotes_count[note]);
				  	}
				  	notes_assigned.push(note);
				  }	
				}
				footnotes_assigned[fields[j].toString()] = notes_assigned;
				//alert('footnotes assigned for ' + fields[j] + 'are: ' + notes_assigned);
			}
		}
  
	}
}
function check_for_footnote(val, elementid){
	var start_loc = val.indexOf("[")
	var end_loc = val.indexOf("]")
	var model = $('model_name').value
	var outcome = $('selected_outcome').value
	var subgroup = $('selected_subgroup').value
	var timepoint = $('selected_timepoint').value	
	
	if(start_loc >= 0 && end_loc >= 0){
	  var fnotes_div = $('footnotes')
	  var fnote_numbers = get_footnote_numbers(val, elementid)
	  
	  for(i=0; i<fnote_numbers.length; i++){
	  	var fnote_span = document.createElement('span');
	  	var id = "footnote_" + fnote_numbers[i] + "_" + outcome.toString() + "_" + subgroup.toString() + "_" + timepoint.toString();
	  	$(fnote_span).id = "footnote_" + fnote_numbers[i].toString() + "_span" 
	  	fnote_span.className = 'footnote'
	  	fnote_span.innerHTML = "	<span style='font-weight: bold;'>" + fnote_numbers[i] + ".</span> <input class='footnote' style='width:95%;' id=" + id.toString() + " name ='" + id.toString() + "' size=120 /><br/>"
	  	fnotes_div.appendChild(fnote_span)	
	  }
  }else{
  	remove_unused_footnotes(elementid);
  }
}
// Based on an entry string, get footnote values for a given element
// entry = a string containing the values (ex: 10 [1,2,3])
// element is the name of the field
function get_footnote_numbers(entry, element){
	//alert ("element is " + element.toString())
	var start = entry.indexOf("[");
  var end = entry.indexOf("]");
  var values = entry.substring(start+1, end);
  var nums_array = [];
  
  var vals = values.split(",");
  vals.sort(function(a,b){return a - b})
  var footnotes_assigned_to_element = [];
  
  for(i=0; i<vals.length; i++){
  	var tmpVal = parseInt(vals[i].trim())
  	var already_done = span_exists(vals[i]);
  	//if(footnotes_assigned[element.toString()] != undefined){
	  	//already_done = in_array?(vals[i],footnotes_assigned[element.toString()]);
	  	
	  //}
	  if(!already_done){
	  	var tmpVal = parseInt(vals[i].trim())
			//alert("Length of footnotes_assigned_to_element is " + footnotes_assigned_to_element.length + ".");
	  	if(footnotes_count[tmpVal] in {undefined:1, 0:1}){
	  		footnotes_count[tmpVal] = 1;
	  		footnotes_assigned_to_element.push(tmpVal);
	  		nums_array.push(tmpVal);
	  	
			}else{
	  		footnotes_count[tmpVal] += 1;
	  		footnotes_assigned_to_element.push(tmpVal);
	  	}
	  }else{
	  	footnotes_assigned_to_element.push(tmpVal);
	  	if(!(in_array(tmpVal, footnotes_assigned[element.toString()]))){
	  		footnotes_count[tmpVal] += 1;
	  	}
	  }
  }
  unassign_footnotes(footnotes_assigned_to_element, footnotes_assigned[element.toString()])
  footnotes_assigned[element.toString()] = footnotes_assigned_to_element;
  
  return(nums_array); 
}

// This is called when there are no footnotes specified to be sure that
// we get rid of any that existed before
function remove_unused_footnotes(element){
	//alert ("trying to remove the footnotes");
	var earlier_notes = footnotes_assigned[element.toString()]
	if(earlier_notes != undefined && earlier_notes != []){
		for(var i=0; i<earlier_notes.length; i++){
			//alert("current is: " + earlier_notes[i].toString());
			footnotes_count[earlier_notes[i]] -= 1;
			
			if(footnotes_count[earlier_notes[i]] == 0){
				//alert("should be removing " + earlier_notes[i].toString());
				remove_footnote(earlier_notes[i]);					
			}
			footnotes_assigned[element.toString()] = undefined;
		}	
	}
}


function unassign_footnotes(current,former){
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
		  	footnotes_count[former[i]] -= 1;
		  	
		    if(footnotes_count[former[i]] == 0){
		  		remove_footnote(former[i]);
		  	}
		  }
		}
	}
}

// delete an individual footnote from the table based on its number
function remove_footnote(note_number){
  var fn_span_id = "footnote_"+note_number.toString()+"_span"
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
// fn_num
function span_exists(fn_num){
	//alert("fn_num is: " + fn_num);
  var retVal = true;  
  var id = "footnote_"+fn_num.toString()+"_span"
  var span = $(id)
  if(span == null){
  	//alert ("the span was not found")
  	retVal = false;
  }
  return(retVal)
}