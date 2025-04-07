extends ScoringRule
class_name FourOfAKindRule
var name : String = "4 of a Kind"

var LVL : int = 1

var base_score : int = 40 
var base_mult : int = 3

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
		
		if counted_values[v] == 4:
		
			score = base_score * base_mult
				
			for d in dice:
				if d.rolled_value == v:
					used_dice.append(d)
	
	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": used_dice
	}]
