extends Node

var calculated_score : int = 0
var calculated_mult : int = 0

var curr_score : int = 0
var curr_mult : int = 0

var round_score : int = 0
var round_farkles : int = 1

var overall_score : int = 0

var rulesOneDie : Array
var rulesThreeDie : Array
var rulesFourDie : Array
var rulesFiveDie : Array
var rulesSixDie : Array

func set_up_rules():
	rulesOneDie = [
		SingleOneRule.new(),
		SingleFiveRule.new()
	]
	
	rulesThreeDie = [
		ThreeOfAKindRule.new()
	]
	
	rulesFourDie = [
		FourOfAKindRule.new()
	]
	
	rulesFiveDie = [
		FiveOfAKindRule.new()
	]
		
	rulesSixDie = [
		SixOfAKindRule.new(),
		FullHouseRule.new(),
		StraightRule.new(),
		ThreePairRule.new()
	]

func find_best_outcome(selected_dice : Array):
	
	var rule_set : Array
		
	if selected_dice.size() >= 6:	
		rule_set += rulesSixDie.duplicate()
	if selected_dice.size() >= 5:	
		rule_set += rulesFiveDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 3:	
		rule_set += rulesThreeDie.duplicate()
	if selected_dice.size() >= 1:	
		rule_set += rulesOneDie.duplicate()
		
	rule_set = get_types_in_hand(selected_dice,rule_set)
		
	var rule_sequences = get_permutations(rule_set)	
	rule_sequences.shuffle()
		
	var scores : Array
	var rules_sets_checked : int = 0
	
	for rule_sets in rule_sequences:
		var dice : Array = selected_dice.duplicate()
		
		var curr_score = 0
		var rule_names : Array
		for rule in rule_sets:
			#print(rule.name)
			
			if dice.size() == 0:
			
				break
			
			rules_sets_checked += 1
			
			var result = rule.evaluate(dice)
			
			for r in result:
				
				curr_score += r.score
				if r.used_dice != null:
					for d in r.used_dice:
						dice.erase(d)
				
				if r.score > 0:
					rule_names.append([rule.name, r.score, r.used_dice])
							
			if dice.size() == 0:
				
				break
		
		scores.append([curr_score, dice.size(), rule_names])
		
	scores.sort()
	
	print("Calculated Rules : ", rules_sets_checked)
	
	var final = scores[scores.size() - 1]
	#if final[1] != 0:
		#calculated_score = 0
		#calculated_mult = 1
	#else:
		#calculated_score = final[0]
		#calculated_mult = 1
	Player.update_selectedscore_label(final[0])
	print("Score : ", final[0])
	print("Rules Used : ", final[2])
	
	Player.update_score_board(final[2])
	
	if final[0] == 0 and Player.held_dice.size() == selected_dice.size():
		print("bust")
	
	return final[0]
	
	#update_calc_s_and_m(calculated_score, calculated_mult)

func get_types_in_hand(hand, rules):

	var rules_used : Array

	for rule in rules:

		var outcome = rule.evaluate(hand)
		
		for r in outcome:
			if r.score > 0:
				if not rules_used.has(rule):
					rules_used.append(rule)

	return rules_used
	
func check_bust(selected_dice : Array):
	var rule_set : Array
		
	if selected_dice.size() >= 6:	
		rule_set += rulesSixDie.duplicate()
	if selected_dice.size() >= 5:	
		rule_set += rulesFiveDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 4:	
		rule_set += rulesFourDie.duplicate()
	if selected_dice.size() >= 3:	
		rule_set += rulesThreeDie.duplicate()
	if selected_dice.size() >= 1:	
		rule_set += rulesOneDie.duplicate()
		
	rule_set = get_types_in_hand(selected_dice,rule_set)
		
	var rule_sequences = get_permutations(rule_set)	
	rule_sequences.shuffle()
	
	var scores : Array
	
	for rule_sets in rule_sequences:
		var dice : Array = selected_dice.duplicate()
		
		var curr_score = 0
		for rule in rule_sets:
			
			var result = rule.evaluate(dice)
			
			for r in result:
				curr_score += r.score
				if r.used_dice != null:
					for d in r.used_dice:
						dice.erase(d)
				
			if dice.size() == 0:
				
				break
		
		scores.append([curr_score, dice.size()])
		
	scores.sort()
	
	var final = scores[scores.size() - 1]

	if final[0] == 0 and Player.held_dice.size() == selected_dice.size():
		print("bust")
	
	return final[0]

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

func score_hand():
	curr_score += calculated_score * calculated_mult
	calculated_score = 0
	calculated_mult = 0
	
	Player.score_dice()
	
	if Player.drawn_dice.size() == 0:
		round_farkles += 1
		update_farkles(round_farkles)
		
		await get_tree().create_timer(1).timeout
		
		Player.draw_dice()
	
	update_round_score(curr_score)
	
	update_calc_s_and_m(calculated_score, calculated_mult)
	
	check_win_con()
	
	await get_tree().create_timer(.5).timeout
	
	Player.roll_hand()

func end_round_scoring():
	curr_score += calculated_score * calculated_mult
	overall_score += curr_score * round_farkles
	
	calculated_score = 0
	calculated_mult = 0
	
	curr_score = 0
	round_farkles = 1
	
	print(overall_score)
	
	Player.score_dice()
	
	update_round_score(curr_score)
	
	update_calc_s_and_m(calculated_score, calculated_mult)

	update_farkles(round_farkles)
	
	update_overall_score(overall_score)
	
	check_win_con()

func check_win_con():
	if overall_score >= get_tree().get_nodes_in_group("world")[0].score_goal:
		print("Winner!")

func update_round_score(score):
	get_tree().get_nodes_in_group("world")[0].set_round_score(score)

func update_calc_s_and_m(calculated_score, calculated_mult):
	get_tree().get_nodes_in_group("world")[0].set_score(calculated_mult, calculated_score)
	
func update_farkles(farkles):
	get_tree().get_nodes_in_group("world")[0].set_farkle(farkles)
	
func update_overall_score(score):
	get_tree().get_nodes_in_group("world")[0].set_overall_score(score)
	
func reset():
	calculated_score = 0
	calculated_mult = 0
	curr_score = 0
	curr_mult = 0
	round_score = 0
	round_farkles = 1
	overall_score = 0
	
	update_round_score(curr_score)
	update_calc_s_and_m(calculated_score, calculated_mult)
	update_farkles(round_farkles)
	update_overall_score(overall_score)
