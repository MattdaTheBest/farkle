extends Control

#var tween : Tween
@onready var label: Label = $Node2D/score_type_box/Label
@onready var score_type_box: PanelContainer = $Node2D/score_type_box
@onready var h_box_container: HBoxContainer = $Node2D/HBoxContainer
var score_type
var displayed_score = 0


#func _ready() -> void:
	#
		#var tween = create_tween()
		#
		#tween.tween_property(score_type_box, "rotation_degrees",2,1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		#
		#tween.tween_property(score_type_box, "rotation_degrees", 0,1).set_ease(Tween.EASE_IN)
		#
		#tween.tween_property(score_type_box, "rotation_degrees", -2,1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		#
		#tween.tween_property(score_type_box, "rotation_degrees", 0,1).set_ease(Tween.EASE_IN)
		#
		#tween.set_loops()

func _process(delta: float) -> void:
	pass
	
	self.global_position = self.global_position.lerp(get_parent().global_position + Vector2( - size.x/2 + 55, + 32), 4 * delta)
	
	score_type_box.global_position = score_type_box.global_position.lerp(self.global_position, 4 * delta)
	h_box_container.global_position	= h_box_container.global_position.lerp(self.global_position - Vector2( - (size.x), 2), 4 * delta)

func set_score(type, score, dice_in_use, spawn):
	
	var children = h_box_container.get_children()
	var in_use : Array
	
	for d in dice_in_use:
		var frames = d.dice_animations.get_sprite_frames()
		var frame = frames.get_frame_texture("faces", d.dice_animations.get_frame())	
		children[0].get_child(0).texture = frame
		in_use.append(children[0].get_child(0))
		children.remove_at(0)
	
	#print("To Remove Count : ", children.size())	
	for c in children:
		disappear_die(c.get_child(0))
		
	score_type = type
	
	label.text = (str(type) + " : " + str(score))
	
	if visible and displayed_score != score:
		#print("Bump!")
		displayed_score = score
		var tween = create_tween()
		
		tween.set_parallel().tween_property(score_type_box, "scale", Vector2(1.2,1.2),.35).set_trans(Tween.TRANS_BACK)
		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees",3,.35).set_trans(Tween.TRANS_BACK)
		
		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees", -3,.35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		tween.set_parallel().tween_property(score_type_box, "scale", Vector2(1,1),.35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		
		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees", 0,.15).set_trans(Tween.TRANS_BACK).set_delay(.8)
		#tween.set_loops()
		
	else:
		displayed_score = score
	
	#print("DICE USED : ", in_use)
	appear(in_use, spawn)
	
func set_only_score(type, score):
	label.text = (str(type) + " : " + str(score))

func appear(sprites, spawn):
	
	if not visible:
		global_position = spawn + Vector2(7.5, 0)
		
		visible = true
		
		score_type_box.global_position = get_parent().global_position
		
		var tween	
			
		score_type_box.global_position = self.global_position

		tween = create_tween()
		
		tween.tween_property(score_type_box, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
		tween.tween_property(score_type_box, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)
	
	for s in sprites:
		var tween2
		
		tween2 = create_tween()
		
		tween2.parallel().tween_property(s, "scale", Vector2(.5,.5), .35).set_trans(Tween.TRANS_BACK)
	
	#tween.parallel().tween_property(score_type_box, "global_position", self.global_position + Vector2(0,self.size.y/2 + score_type_box.size.y/2), .5).set_trans(Tween.TRANS_BACK)	

func disappear_die(die):
	var tween	
	
	tween = create_tween()
	
	tween.tween_property(die, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_CIRC)

func disappear():
	
	var children = h_box_container.get_children()
	
	for c in children:
		var tween2
		
		tween2 = create_tween()
		
		tween2.tween_property(c.get_child(0), "scale", Vector2(0,0), .15).set_trans(Tween.TRANS_CIRC)
		
	var tween	
		
	tween = create_tween()
	
	tween.tween_property(score_type_box, "scale", Vector2(1,0), .15).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	
	visible = false
	
