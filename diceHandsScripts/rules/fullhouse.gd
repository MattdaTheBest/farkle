extends ScoringRule
class_name FullHouseRule

func evaluate(dice: Array) -> Array:
	var dice_values: Array = []
	var counted_values: Dictionary = {}
	var value_to_dice: Dictionary = {}
	
	for d in dice:
		var val = d.value
		dice_values.append(val)
		
		if not counted_values.has(val):
			counted_values[val] = 0
			value_to_dice[val] = []
		
		counted_values[val] += 1
		value_to_dice[val].append(d)

	var triple_val = null
	var pair_val = null

	for v in counted_values:
		if counted_values[v] >= 3 and triple_val == null:
			triple_val = v

	for v in counted_values:
		if counted_values[v] >= 2 and v != triple_val and pair_val == null:
			pair_val = v

	if triple_val != null and pair_val != null:
		var used_dice = value_to_dice[triple_val].slice(0, 3) + value_to_dice[pair_val].slice(0, 2)
		return [{
			"score": 1500,
			"used_dice": used_dice
		}]

	return []
