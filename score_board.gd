extends Control

var types_in_use : Array
const SCORE_TYPE_BOX = preload("res://score_type_box.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer/VBoxContainer2

@onready var ones_top: Control = $VBoxContainer/VBoxContainer2/onesTOP
@onready var fives_top: Control = $VBoxContainer/VBoxContainer2/fivesTOP
@onready var _3_ofakind_top: Control = $"VBoxContainer/VBoxContainer2/3ofakindTOP"
@onready var _4_ofakind_top: Control = $"VBoxContainer/VBoxContainer2/4ofakindTOP"
@onready var _5_ofakind_top_2: Control = $"VBoxContainer/VBoxContainer2/5ofakindTOP2"
@onready var _6_ofakind_top_3: Control = $"VBoxContainer/VBoxContainer2/6ofakindTOP3"
@onready var fullhouse: Control = $VBoxContainer/VBoxContainer2/fullhouse
@onready var straight: Control = $VBoxContainer/VBoxContainer2/straight
@onready var threepair: Control = $VBoxContainer/VBoxContainer2/threepair
@onready var _2_triples: Control = $"VBoxContainer/VBoxContainer2/2triples"
@onready var unuseddice: Control = $VBoxContainer/VBoxContainer2/unuseddice

@onready var round_scorel_label: Label = $VBoxContainer/Round_Score/RoundScorelLabel

var round_score = 0

var scores_dict : Dictionary
 
const SCORE_TYPE_BOX_REWORK = preload("res://score_type_box_rework.tscn")

func _process(delta: float) -> void:
	round_scorel_label.text = "Round : " + str(round_score)

func update_board(type, score, mult, loading_rules, dice_in_use, used_dice, unused_dice):

	#var created : bool = false
	#
	#for nodes in v_box_container.get_children():
		#var child_node = nodes.get_child(0)
		#
		#if child_node.in_use and not (child_node.header_mode or child_node.unused_mode) and not created:
			#if child_node.score_type == type:
				#print("UPDATED")
				#created = true
				#child_node.set_score(type, score, mult, dice_in_use)
				#
		#elif child_node.in_use and not (child_node.header_mode or child_node.unused_mode):
			#if not loading_rules.has(child_node.score_type):
				#print(child_node.score_type)
				#print(loading_rules.has(child_node.score_type))
				#child_node.disappear()
				#pass
					#
	#if not created:
		#for nodes in v_box_container.get_children():
			#var child_node = nodes.get_child(0)
			#if not child_node.in_use and not (child_node.header_mode or child_node.unused_mode):
				#print("CREATED")
				#child_node.set_score(type, score, mult, dice_in_use)
				#created = true
				#break
	
	
	
	
	
	#var created : bool = false
	#for nodes in v_box_container.get_children():
		#var child_node = nodes.get_child(0)
#
		#if not child_node.header_mode and not child_node.unused_mode:
			#if child_node.in_use and not loading_rules.has(child_node.score_type):
				#print("HEHR")
				#print(child_node.score_type)
				#child_node.disappear()
			#
			#if child_node.in_use and child_node.score_type == type:
				#child_node.set_score(type, score, mult, dice_in_use)
				#created = true
				#break
	#
	#if not created:
		#for nodes in v_box_container.get_children():
			#var child_node = nodes.get_child(0)
			#if not child_node.in_use and not (child_node.header_mode or child_node.unused_mode):
				#child_node.set_score(type, score, mult, dice_in_use)
				#created = true
				#break
				
	#if unused_dice.size() > 0:
		#unuseddice.get_child(0).set_score("Unused", 0, 0,unused_dice)
		#v_box_container.move_child(unuseddice, 1)
	#else:	
		#unuseddice.get_child(0).disappear()
	
	
		#
	if type == "Single One":
		#print("ones")
		
		ones_top.get_child(0).set_score(type, score, mult, dice_in_use)
		v_box_container.move_child(ones_top, 1)
		
	if not loading_rules.has("Single One"):
		print("!WHAT!?")
		ones_top.get_child(0).disappear()
		
	if type == "Single Five":
		#print("fives")
		
		fives_top.get_child(0).set_score(type, score,mult, dice_in_use)
		v_box_container.move_child(fives_top, 1)
		
	if not loading_rules.has("Single Five"):
		fives_top.get_child(0).disappear()
		
	if type == "3 of a Kind":
		#print("threes")
		
		_3_ofakind_top.get_child(0).set_score(type, score,mult, dice_in_use)
		v_box_container.move_child(_3_ofakind_top, 1)
		
	if not loading_rules.has("3 of a Kind"):
		_3_ofakind_top.get_child(0).disappear()
		
	if type == "4 of a Kind":
		#print("fours")
		
		_4_ofakind_top.get_child(0).set_score(type, score,mult, dice_in_use)
		v_box_container.move_child(_4_ofakind_top, 1)
		
	if not loading_rules.has("4 of a Kind"):
		_4_ofakind_top.get_child(0).disappear()
		
	if type == "5 of a Kind":
		#print("fives")
		
		_5_ofakind_top_2.get_child(0).set_score(type, score,mult, dice_in_use)
		v_box_container.move_child(_5_ofakind_top_2, 1)
		
	if not loading_rules.has("5 of a Kind"):
		_5_ofakind_top_2.get_child(0).disappear()
		
	if type == "6 of a Kind":
		#print("sixes")
		
		_6_ofakind_top_3.get_child(0).set_score(type, score, mult,dice_in_use)
		v_box_container.move_child(_6_ofakind_top_3, 1)
		
	if not loading_rules.has("6 of a Kind"):
		_6_ofakind_top_3.get_child(0).disappear()
		
	if type == "Full House":
		#print("sixes")
		
		fullhouse.get_child(0).set_score(type, score, mult,dice_in_use)
		v_box_container.move_child(fullhouse, 1)
		
	if not loading_rules.has("Full House"):
		fullhouse.get_child(0).disappear()
	
	if type == "Straight":
		#print("sixes")
		
		straight.get_child(0).set_score(type, score, mult,dice_in_use)
		v_box_container.move_child(straight, 1)
		
	if not loading_rules.has("Straight"):
		straight.get_child(0).disappear()
		
	if type == "3 Pair":
		#print("sixes")
		
		threepair.get_child(0).set_score(type, score, mult,dice_in_use)
		v_box_container.move_child(threepair, 1)
		
	if not loading_rules.has("3 Pair"):
		threepair.get_child(0).disappear()
		
	if type == "2 Triples":
		#print("sixes")
		
		_2_triples.get_child(0).set_score(type, score,mult, dice_in_use)
		v_box_container.move_child(_2_triples, 1)
		
	if not loading_rules.has("2 Triples"):
		_2_triples.get_child(0).disappear()
		
	if unused_dice.size() > 0:
		unuseddice.get_child(0).set_score("Unused", 0, 0,unused_dice)
		v_box_container.move_child(unuseddice, 1)
	else:	
		unuseddice.get_child(0).disappear()
	
	#hand_label.text = "Hand : " + str(Player.hovered_score)

func scoring_updates(type, score, mult):
	
	var node = get_child_type(type)
	await node.scoring_update_score(score,mult)
	
	return true
	
func update_round_score():
	round_scorel_label.text = ("Round : " + str(ScoringScript.round_score))
			
func find_unused_dice():
	var unused_dice : Array	
	for dice in Player.selected_for_scoring:
		unused_dice.append(dice)
		
	if unused_dice.size() > 0:
		unuseddice.get_child(0).set_score("Unused", 0, unused_dice)
		v_box_container.move_child(unuseddice, 1)
		
		
	print("Not used Dice : ", unused_dice)

func clear():
	var children = v_box_container.get_children()
	
	for c in children:
		var node = c.get_child(0)
		if not node.header_mode and not node.unused_mode:
			node.disappear()

func collapse_scores():
	var rules : Array
	for r in ScoringScript.saved_score_sets:
		rules.append(r[0])
		
	for r in rules:
		await collapse_scores_selection(r)
			
	#update_round_score()	

func collapse_scores_selection(type):
	var node = get_child_type(type)
	
	await node.collapse_score_animation()
	
	return true
			
func get_child_type(type):
	if type == "Single One":
		#print("ones")
		
		return ones_top.get_child(0)
		
	if type == "Single Five":
		#print("fives")
		
		return fives_top.get_child(0)
		
	if type == "3 of a Kind":
		#print("threes")
		
		return _3_ofakind_top.get_child(0)
		
	if type == "4 of a Kind":
		#print("fours")
		
		return _4_ofakind_top.get_child(0)

	if type == "5 of a Kind":
		#print("fives")
		
		return _5_ofakind_top_2.get_child(0)
		
	if type == "6 of a Kind":
		#print("sixes")
		
		return _6_ofakind_top_3.get_child(0)
		
	if type == "Full House":
		#print("sixes")
		
		return fullhouse.get_child(0)
	
	if type == "Straight":
		#print("sixes")
		
		return straight.get_child(0)
		
	if type == "3 Pair":
		#print("sixes")
		
		return threepair.get_child(0)
		
	if type == "2 Triples":
		#print("sixes")
		
		return _2_triples.get_child(0)
		
func create_panel():
	pass		
		
		
