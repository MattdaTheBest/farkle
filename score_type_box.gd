extends Control

var tween : Tween
@onready var label: Label = $Node2D/score_type_box/Label
@onready var score_type_box: PanelContainer = $Node2D/score_type_box

func _process(delta: float) -> void:
	score_type_box.global_position = score_type_box.global_position.lerp(self.global_position, 8 * delta)
		

func set_score(type, score):
	label.text = (str(type) + " : " + str(score))
	
	appear()

func appear():
	
	if tween:
		tween.kill()
		
	score_type_box.global_position = self.global_position

	tween = create_tween()
	
	tween.parallel().tween_property(score_type_box, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)
	#tween.parallel().tween_property(score_type_box, "global_position", self.global_position + Vector2(0,self.size.y/2 + score_type_box.size.y/2), .5).set_trans(Tween.TRANS_BACK)	

func disappear():
	if tween:
		tween.kill()
		
	tween = create_tween()
	
	tween.tween_property(score_type_box, "scale", Vector2(1,0), .35).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	
	visible = false
	
	free()
