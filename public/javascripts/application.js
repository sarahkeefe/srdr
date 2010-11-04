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

function add_outcome_analysis_row(){
	
	var tr = Builder.node('tr', {id: "row2"}),
		td1 = Builder.node('td'),
		td2 = Builder.node('td'),
		td3 = Builder.node('td'),
		td4 = Builder.node('td'),
		td5 = Builder.node('td'),
		td6 = Builder.node('td'),
		td7 = Builder.node('td'),
		td8 = Builder.node('td'),
		td9 = Builder.node('td'),
		#deleteLink = Builder.node('a','Delete',{onclick:"remove_row('row2')"})
	td9.appendChild(deleteLink)
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td4);
	tr.appendChild(td5);
	tr.appendChild(td6);
	tr.appendChild(td7);
	tr.appendChild(td8);
	tr.appendChild(td9);
	
	
	$('outcome_analysis_table').appendChild(tr)
		
}
 
