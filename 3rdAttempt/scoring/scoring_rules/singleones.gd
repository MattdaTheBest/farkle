extends ScoringRule
class_name SingleOneRule
var name : String = "Single One"

var LVL : int = 1

var base_score : int = 10
var base_mult : int = 2

func evaluate(dice : Array):
	var dice_entered : Array
	for d in dice:
		dice_entered.append(d.rolled_value)

	var ones = []
	for d in dice:
		if d.rolled_value == 1:
			ones.append(d)
			
	if ones.is_empty():
		return []
	
	var score = base_score * base_mult
		
	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": ones
	}]

	
