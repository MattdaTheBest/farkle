#extends Node2D
#class_name  BasicDie
#
#var face_values : Array = [1, 2, 3, 4, 5, 6]
#var rolled_value : int = 0
#
#const BASIC_DICE_UI = preload("res://newVersion/basic_dice_ui.tscn")
#
#func roll():
	#rolled_value = face_values.pick_random()
	#
	#var die = BASIC_DICE_UI.instantiate()
	#die.set_face(rolled_value)
	#die.set_reference(self)
	#
	#get_tree().get_nodes_in_group("world")[0].add_dice_to_scene(die)
	#
	#print("Rolled Value : ", rolled_value)
	#
