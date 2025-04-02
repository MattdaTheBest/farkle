extends ScoringRule
class_name SingleOneRule
var name : String = "Single One"

var LVL : int = 1

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
	
	var score = ones.size() * 100
		
	return [{
		"score" : score,
		"used_dice" : ones
	}]

	
