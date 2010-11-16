 var $j = jQuery.noConflict();
    $j(function(e) 
	{
	
		// Get arm and category id values from the hidden field
		var cat_ids_list = $j('#category_ids').val();
		var arm_ids_list = $j('#arm_ids').val();
		var cat_ids = cat_ids_list.split(" ");
		var arm_ids = arm_ids_list.split(" ");
		
		// Set up an onchange event for each input box associated with each arm and category id
		for (i = 0; i < cat_ids.length; i++)
		{
			var the_cat_id = cat_ids[i];
			for (j = 0; j < arm_ids.length; j++)
			{
				if (arm_ids[j] != "")
				{		
					$j("#arm" + arm_ids[j] + "attribute_" + the_cat_id).change(function(e) {
							var str = this.name.split("[")[1];
							var cat_id = str.split("]")[0];
							//alert(cat_id);
							var the_cat_id = parseInt(cat_id);
							var newTotal = 0;
							for (k = 0; k < arm_ids.length; k++)
							{
								if (arm_ids[k] != "")
								{
									//alert ("arm_ids[k]: " + arm_ids[k]);
									//alert("cat_ids[i]: " + the_cat_id);
									var newVal = $j("#arm" + arm_ids[k] + "attribute_" + cat_id).val()
									//alert (newVal);
									newTotal += parseFloat(newVal);
									//alert(newTotal);
								}
							}
							$j('#attribute_total_' + cat_id).val(newTotal);
					});
				}
			}
		}
		
    });

