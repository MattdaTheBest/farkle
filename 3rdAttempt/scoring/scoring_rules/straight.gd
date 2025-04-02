extends ScoringRule
class_name StraightRule
var name : String = "Straight"

var LVL : int = 1

func evaluate(dice : Array):
	var dice_entered : Array
	for d in dice:
		dice_entered.append(d.rolled_value)
	
	var dice_values : Array
	var counted_values : Dictionary
	var value_to_dice := {}
	
	for d in dice:
		var val = d.rolled_value
		dice_values.append(val)
	
	var score = 0
	var used_dice : Array
	
	if dice_values.has(1) and dice_values.has(2) and dice_values.has(3) and  dice_values.has(4) and dice_values.has(5) and dice_values.has(6):
		score = 1500
		used_dice = dice
					
	return [{
		"score" : score,
		"used_dice" : used_dice
	}]
