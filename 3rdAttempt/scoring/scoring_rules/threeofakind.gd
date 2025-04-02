extends ScoringRule
class_name ThreeOfAKindRule
var name : String = "3 of a Kind"

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
	
	for v in dice_values:
		counted_values[v] = dice_values.count(v)		
		
	var score = 0
	var used_dice : Array
	
	for v in counted_values:
		
		if counted_values[v] == 3:
		
			score += 500
				
			for d in dice:
				if d.rolled_value == v:
					used_dice.append(d)
	
	return [{
		"score" : score,
		"used_dice" : used_dice
	}]
