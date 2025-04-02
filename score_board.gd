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

@onready var control_4: Control = $VBoxContainer/VBoxContainer2/Control4

func update_board(type, score, loading_rules, dice_in_use):
	#print("!")
	
	#print(dice_in_use)
	
	if type == "Single One":
		#print("ones")
		
		ones_top.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(ones_top, 1)
		
	elif not loading_rules.has("Single One"):
		ones_top.get_child(0).disappear()
		
	if type == "Single Five":
		#print("fives")
		
		fives_top.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(fives_top, 1)
		
	elif not loading_rules.has("Single Five"):
		fives_top.get_child(0).disappear()
		
	if type == "3 of a Kind":
		#print("threes")
		
		_3_ofakind_top.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(_3_ofakind_top, 1)
		
	elif not loading_rules.has("3 of a Kind"):
		_3_ofakind_top.get_child(0).disappear()
		
	if type == "4 of a Kind":
		#print("fours")
		
		_4_ofakind_top.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(_4_ofakind_top, 1)
		
	elif not loading_rules.has("4 of a Kind"):
		_4_ofakind_top.get_child(0).disappear()
		
	if type == "5 of a Kind":
		#print("fives")
		
		_5_ofakind_top_2.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(_5_ofakind_top_2, 1)
		
	elif not loading_rules.has("5 of a Kind"):
		_5_ofakind_top_2.get_child(0).disappear()
		
	if type == "6 of a Kind":
		#print("sixes")
		
		_6_ofakind_top_3.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(_6_ofakind_top_3, 1)
		
	elif not loading_rules.has("6 of a Kind"):
		_6_ofakind_top_3.get_child(0).disappear()
		
	if type == "Full House":
		#print("sixes")
		
		fullhouse.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(fullhouse, 1)
		
	elif not loading_rules.has("Full House"):
		fullhouse.get_child(0).disappear()
	
	if type == "Straight":
		#print("sixes")
		
		straight.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(straight, 1)
		
	elif not loading_rules.has("Straight"):
		straight.get_child(0).disappear()
		
	if type == "3 Pair":
		#print("sixes")
		
		threepair.get_child(0).set_score(type, score, dice_in_use, control_4.global_position)
		v_box_container.move_child(threepair, 1)
		
	elif not loading_rules.has("3 Pair"):
		threepair.get_child(0).disappear()		

func clear():
	var children = v_box_container.get_children()
	children.remove_at(0)
	
	for c in children:
		c.get_child(0).disappear()
