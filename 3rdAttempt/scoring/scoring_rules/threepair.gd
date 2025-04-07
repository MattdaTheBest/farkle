extends ScoringRule
class_name ThreePairRule
var name : String = "3 Pair"

var LVL : int = 1

var base_score : int = 40
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
	
	for v in dice_values:
		counted_values[v] = dice_values.count(v)		
		
	var score = 0
	var used_dice : Array
	var breaks_rule : bool = false
	
	if counted_values.size() == 3:
		for v in counted_values:
			if v == 2:
				pass
			else:
				breaks_rule = true
				break
				
		if not breaks_rule:
			score = base_score * base_mult
			used_dice = dice.duplicate()					
						
	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": used_dice
	}]
