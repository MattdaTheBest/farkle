extends Control

const SCORE_TYPE_BOX = preload("res://score_type_box.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer/VBoxContainer

func add_panel(type, score):
	var box = SCORE_TYPE_BOX.instantiate()
	
	v_box_container.add_child(box)
	
	box.set_score(type, score)
	
func clear():
	var children = v_box_container.get_children()
	children.remove_at(0)
	
	for c in children:
		c.disappear()
