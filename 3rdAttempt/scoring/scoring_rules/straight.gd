extends ScoringRule
class_name StraightRule
var name : String = "Straight"

var LVL : int = 1

var base_score : int = 60 
var base_mult : int = 4

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
		score = base_score * base_mult
		used_dice = dice.duplicate()
					
	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": used_dice
	}]
