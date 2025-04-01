extends Control

var tween : Tween
@onready var label: Label = $Label
@onready var panel_container: PanelContainer = $"."

func appear(d_name):
	
	label.text = str(d_name)
	
	if tween:
		tween.kill()
	
	tween = create_tween()

	tween.set_parallel().tween_property(panel_container, "scale", Vector2(1,1), .25).set_trans(Tween.TRANS_BACK)
	#tween.set_parallel().tween_property(panel_container, "modulate:a", 1, .25).set_trans(Tween.TRANS_CIRC)
	
func disappear():
	if tween:
		tween.kill()
	
	tween = create_tween()

	tween.set_parallel().tween_property(panel_container, "scale", Vector2(0,0), .15).set_trans(Tween.TRANS_CIRC)
	#tween.set_parallel().tween_property(panel_container, "modulate:a", 0, .15).set_trans(Tween.TRANS_CIRC)
