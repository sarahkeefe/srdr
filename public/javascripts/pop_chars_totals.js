 var $j = jQuery.noConflict();


 $j(function(e) 
	{
	
		// Get arm and category id values from the hidden field
		var cat_ids_list = $j('#category_ids').val();
		var arm_ids_list = $j('#arm_ids').val();
		var cat_and_subcat_ids = cat_ids_list.split(" ");
		
		var arm_ids = arm_ids_list.split(" ");
		
		// Set up an onchange event for each input box associated with each arm and category id and subcategory_id
		for (i = 0; i < cat_and_subcat_ids.length; i++)
		{
			// cat_and_subcat_ids array elements are in the format of  CAT_ID:SUBCAT_ID-SUBCAT-ID-SUBCAT_ID...
			var cat_and_subcat_ids_arr = cat_and_subcat_ids[i].split(":");
			var  the_cat_id = cat_and_subcat_ids_arr[0];
			
			if ((cat_and_subcat_ids_arr[1]) != null && (cat_and_subcat_ids_arr[1] != ""))
			{
				var  subcat_ids_arr = cat_and_subcat_ids_arr[1].split("-");
			}
			else
			{
				var subcat_ids_arr = [];
			}
			
			for (j = 0; j < arm_ids.length; j++)
			{
				if (arm_ids[j] != "")
				{	
					if (subcat_ids_arr.length == 0)
					{
						$j("#arm" + arm_ids[j] + "attribute_" + the_cat_id + "_-1").change(function(e) {
								var str = this.name.split("[")[1];
								var str2 = str.split("]")[0];
								var str3 = str2.split("_");
								var the_cat_id = parseInt(str3[0]);
								var newTotal = 0;
								for (k = 0; k < arm_ids.length; k++)
								{
									if (arm_ids[k] != "")
									{
										var newVal = $j("#arm" + arm_ids[k] + "attribute_" + the_cat_id + "_-1").val()
										newTotal += parseFloat(newVal);
									}
								}
								$j('#attribute_total_' + the_cat_id + "_-1").val(newTotal);
							});
					}
					else
					{
						for (m = 0; m < subcat_ids_arr.length; m++)
						{
								$j("#arm" + arm_ids[j] + "attribute_" + the_cat_id + "_" + subcat_ids_arr[m]).change(function(e) {
										//var str = this.name.split("[")[1];
										//var str2 = str.split("]")[0];
										//var str3 = str2.split("_");
										//var the_subcat_id = parseInt(str3[1]);
									//	var the_cat_id = parseInt(str3[0]);
										var newTotal = 0;
										for (k = 0; k < arm_ids.length; k++)
										{
											if (arm_ids[k] != "")
											{
												var newVal = $j("#arm" + arm_ids[k] + "attribute_" + the_cat_id + "_" +  subcat_ids_arr[m]).val()
												newTotal += parseFloat(newVal);
											}
										}
										$j('#attribute_total_' + the_cat_id + "_" +  subcat_ids_arr[m]).val(newTotal);
								});
						}
					}
				}
			}
		}
		
    });

