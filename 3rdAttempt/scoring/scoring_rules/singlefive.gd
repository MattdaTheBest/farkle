extends ScoringRule
class_name SingleFiveRule
var name : String = "Single Five"

var LVL : int = 1

var base_score : int = 5
var base_mult : int = 1

func evaluate(dice : Array):
	var dice_entered : Array
	for d in dice:
		dice_entered.append(d.rolled_value)

	var fives = []
	for d in dice:
		if d.rolled_value == 5:
			fives.append(d)
			
	if fives.is_empty():
		return []
	
	var score = base_score * base_mult
		
	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": fives
	}]
