jQuery(document).ready(function($j) {


$j(".edit_link").live('click', function(event)
{
	$j('select').each(function()
	{
			$j(this).addClass("has_other");
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
