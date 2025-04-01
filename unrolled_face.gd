extends Control

var tween : Tween
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var panel_container: PanelContainer = $PanelContainer
@onready var label: Label = $PanelContainer/Label
var color

var used : bool = false

var f_value
var w
var f
var parent_die
var face_index

func appear(face_value, weight, frame, dice_reference, index):
	f_value = face_value
	w = weight
	f = frame
	parent_die = dice_reference
	face_index = index
	
	used = true
	
	sprite_2d.texture = frame
	label.text = "   " + str("%0.2f" % weight) + "% "
	
	if tween:
		tween.kill()
	
	tween = create_tween()

	tween.set_parallel().tween_property(sprite_2d, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_CIRC)
	tween.set_parallel().tween_property(panel_container, "scale:x", 1, .35).set_trans(Tween.TRANS_CIRC).set_delay(.15)
	tween.set_parallel().tween_property(panel_container, "modulate:a", 1, .35).set_trans(Tween.TRANS_CIRC).set_delay(.15)
	
func disappear():
	if tween:
		tween.kill()
	
	tween = create_tween()

	tween.set_parallel().tween_property(sprite_2d, "scale", Vector2(0,0), .15).set_trans(Tween.TRANS_CIRC)
	tween.set_parallel().tween_property(panel_container, "scale:x", 0, .05).set_trans(Tween.TRANS_CIRC)
	tween.set_parallel().tween_property(panel_container, "modulate:a", 0, .15).set_trans(Tween.TRANS_CIRC)

func change_parent_die_weight_Up():
	parent_die.weighted_value[face_index] += 1

	appear(f_value,w,f,parent_die,face_index)
	
func change_parent_die_weight_Down():
	parent_die.weighted_value[face_index] -= 1
	
