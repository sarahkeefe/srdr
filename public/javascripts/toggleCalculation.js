function toggleCalculation(outcome_id, arm_id, timepoint_id, col_id)
{
	var cbox = $j("#out" + outcome_id.toString() + "_arm" + arm_id.toString() + "_tp" + timepoint_id.toString() + "_col" + col_id.toString() + "_calc");
	var checked = false;
	if (cbox.attr('checked'))
	{
		//alert('checked');
		cbox.attr('checked', false);
		checked = false;
	}
	else{
		//alert('nonchecked');
		cbox.attr('checked', true);
		checked = true;
	}
	
	toggleCalculationHighlighting(outcome_id, arm_id, timepoint_id, col_id, checked);
}

function toggleCalculationHighlighting(outcome_id, arm_id, timepoint_id, col_id, checked){
	the_td = $j("#out" + outcome_id.toString() + "_arm" + arm_id.toString() + "_tp" + timepoint_id.toString() + "_col" + col_id.toString());
	if (checked)
	{
		the_td.css('background-color', '#ffff00');
	}
	else
	{
		the_td.css('background-color', "");
	}
}