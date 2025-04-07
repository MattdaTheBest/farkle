extends ScoringRule
class_name TwoTriplets
var name : String = "2 Triples"

var LVL : int = 1

var base_score : int = 80 
var base_mult : int = 6

func evaluate(dice: Array):
	var dice_values: Array = []
	for d in dice:
		dice_values.append(d.rolled_value)

	var counted_values := {}
	for v in dice_values:
		counted_values[v] = counted_values.get(v, 0) + 1

	var triplet_count := 0
	for v in counted_values:
		if counted_values[v] == 3:
			triplet_count += 1

	var score := 0
	var used_dice: Array = []
	if triplet_count == 2:
		score = base_score * base_mult
		used_dice = dice.duplicate()  # all dice used

	return [{
		"score": score,
		"base_score": base_score,
		"base_mult": base_mult,
		"used_dice": used_dice
	}]
