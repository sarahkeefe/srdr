function bindMyStuff() {
// Call this function in any partial that is loaded via javascript (not initially in a page)
		$j.ajaxSetup({
			'beforeSend': function(xhr) {
				xhr.setRequestHeader("Accept", "text/javascript")
			}
		})

		$j('.has_other_hidden').ready(function() {
			$j('.has_other_hidden').each(function(i, ele){

				var arr = $j(ele).attr('value').toString().split("---");
				if ((arr[0].toString() == "false") && (arr[1] != "") && (arr[1] != null))
				{
					$j(this).prev().val('Other');
					$j(this).prev().change(function(){
						the_obj = document.getElementById('other_custom_text_' + name);
						if (the_obj != null)
						{
							the_obj.remove();
						}
					});
					
					var name =$j(this).prev().attr('name');

					var parNode =$j(this).prev().parentNode; 
					var other_element = document.createElement("div");

					other_element.setAttribute("class", 'other_custom_text_' + name);
					other_element.setAttribute("id", 'other_custom_text_' + name);
					other_element.innerHTML += "<br/>";
					other_element.innerHTML += "<label>Please Specify \"Other\":</label>";
						
					var hidden_field = document.createElement("input");
					hidden_field.setAttribute("type", "hidden");
					hidden_field.setAttribute("name", name);
					other_element.appendChild(hidden_field);			
						
					var inp = document.createElement("input");
					inp.setAttribute("type", "text");
					inp.setAttribute("id", 'other_custom_text_input_' + name);
					inp.setAttribute("name", name);
					inp.setAttribute("value", arr[1]);
					other_element.appendChild(inp);
					other_element.innerHTML += ("<br/><br/>");

					var theForm = this.form;
					$j(this).prev().after(other_element);
								
					theForm.onsubmit = function()
					{
						var name = name;
						hidden_field.value = inp.value;

						the_obj = document.getElementById('other_custom_text_' + name);
						if (the_obj != null)
						{
							parNode.removeChild(the_obj);
						}
					}			
				}
			});
		});
		
}

jQuery(document).ready(function($j) {

  //bindMyStuff();

$j(".edit_link").live('click', function(event)
{

	$j('.has_other_hidden').bind(function(){
		alert("Hi");
		alert($j(this).value);

	});
	
});

$j('.has_other').live('change', function() 
{
	var name = $j(this).attr('name');
	var parNode =this.parentNode; 

	if ($j(this).val() == 'Other')
	{
		var input_box = document.getElementById("other_custom_text_input_" + name);
		if (input_box == null)  // if input thing doesn't already exist
		{
			var other_element = document.createElement("div");

			other_element.setAttribute("class", 'other_custom_text_' + name);
			other_element.setAttribute("id", 'other_custom_text_' + name);
			other_element.innerHTML += "<br/>";
			other_element.innerHTML += "<label>Please Specify \"Other\":</label>";
						
			var hidden_field = document.createElement("input");
			hidden_field.setAttribute("type", "hidden");
			hidden_field.setAttribute("name", name);
			other_element.appendChild(hidden_field);			
						
			var inp = document.createElement("input");
			inp.setAttribute("type", "text");
			inp.setAttribute("id", 'other_custom_text_input_' + name);
			inp.setAttribute("name", name);
			
			other_element.appendChild(inp);
			other_element.innerHTML += ("<br/><br/>");
			//parNode.appendChild(other_element);
			$j(this).after(other_element);
			var theForm = this.form;
						
			theForm.onsubmit = function()
			{
				var name = name;
				hidden_field.value = inp.value;

				the_obj = document.getElementById('other_custom_text_' + name);
				if (the_obj != null)
				{
					parNode.removeChild(the_obj);
				}
			}
		}
	}
	else
	{
		the_obj = document.getElementById('other_custom_text_' + name);
		if (the_obj != null)
		{
			parNode.removeChild(the_obj);
		}
	}
});

});
