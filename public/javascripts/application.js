// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function do_confirm(event, str)
{
var answer = confirm(str); 
if (answer) {
}
else
{
	event.preventDefault();
	}
}

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

//utility function to toggle show/hide for a given element id
function toggle_display(element, link){
	var e = document.getElementById(element);
	var plus_minus_sign = document.getElementById(link);
	if(e.style.display == "none" || e.style.display == ""){
		//e.slideDown(100, plus_minus_sign.innerHTML = "-");
		e.style.display = "inline";
		plus_minus_sign.innerHTML = "-";
		plus_minus_sign.className = "toggle_hide_link"
	}else if(e.style.display == "inline" || e.style.display == "block"){
		//e.slideUp(100, plus_minus_sign.innerHTML="+")
		e.style.display = "none";
		plus_minus_sign.innerHTML = "+";
		plus_minus_sign.className = "toggle_display_link"
	}else{
		e.style.display = "inline"
		plus_minus_sign.innerHTML = "-";
	}	
}
function check_project_title(){
	title_field = document.getElementById("project_title")
	title_text = title_field.value
	if(title_text.length < 5){
		alert('The title that you chose for your project is insufficient. Please try again.');
		return false
	}
}

function toggle_display_by_class(class_name,default_display,element_id){
	var cssRules;
	//alert("Toggling display.");
	if(document.styleSheets[0]['rules']){ //IE
		cssRules = 'rules';
	}else if(document.styleSheets[0]['cssRules']){ //FIREFOX, ETC
		alert ('Found the cssRules.');
		cssRules = 'cssRules';
	}else{
		//browser unknown
	}
	
	for (var j= 0; j < document.styleSheets.length; j++){
		var mysheet = document.styleSheets[j];		
		for (var i=0; i < mysheet.cssRules.length; i++){		
			if (mysheet.cssRules[i].selectorText == class_name){
				//alert(mysheet.cssRules[i].selectorText);
				
				if(mysheet.cssRules[i].style['display'] == 'none'){
					//alert ('displaying...');
					mysheet.cssRules[i].style['display'] = default_display;
					$(element_id).innerHTML = "Hide"
				}else{
					//alert ('hiding...')
					mysheet.cssRules[i].style['display'] = 'none'
					$(element_id).innerHTML = "Show"
				}
			}
		}
	}
}

