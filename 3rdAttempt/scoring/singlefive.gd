extends ScoringRule
class_name SingleFiveRule

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
	
	var score = fives.size() * 50
		
	return [{
		"score" : score,
		"used_dice" : fives
	}]
