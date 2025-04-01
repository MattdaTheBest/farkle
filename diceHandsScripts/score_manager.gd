extends Node

func find_best_outcome(selected_dice : Array, available_rules : Array):
	var rule_sequences = get_permutations(available_rules)
	rule_sequences.shuffle()
	var trimmed = rule_sequences.slice(0, 10)
	
	var scores : Array
	
	#print(rule_sequences.size())
	
	for rule_sets in rule_sequences:
		var dice : Array = selected_dice.duplicate()
		
		#print("Trying rule order:", rule_sets)
		var curr_score = 0
		for rule in rule_sets:
			#print(" - Evaluating rule:", rule)
			
			var result = rule.evaluate(dice)
			
			for r in result:
				curr_score += r.score
				if r.used_dice != null:
					for d in r.used_dice:
						dice.erase(d)
				
			if dice.size() == 0:
				
				break
		
		scores.append(curr_score)
		
	scores.sort()
	
	var final = scores[scores.size() - 1]
	GlobalCanvasLayer.scoreSelected = final
	
func get_permutations(arr: Array):
	var result = []

	if arr.size() <= 1:
		result.append(arr.duplicate())
		return result

	for i in range(arr.size()):
		var current = arr[i]
		var rest = arr.duplicate()
		rest.remove_at(i)

		var sub_perms = get_permutations(rest)
		for perm in sub_perms:
			result.append([current] + perm)
	
	return result
