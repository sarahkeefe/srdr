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