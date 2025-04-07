extends Control

#var tween : Tween

var dice_count : int = 0
var need_update_less : bool = false
var need_update_more : bool = false

@onready var h_box_container: HBoxContainer = $Node2D/HBoxContainer

var displayed_score = 0
var displayed_mult = 0
var final_score = 0

@onready var label: Label = $Node2D/score_type_box/Label
@onready var mult_label: Label = $Node2D/mult/multLabel
@onready var score_label: Label = $Node2D/score/scoreLabel

@onready var score_type_box: PanelContainer = $Node2D/score_type_box
@onready var mult: PanelContainer = $Node2D/mult
@onready var score: PanelContainer = $Node2D/score
@onready var x: Sprite2D = $Node2D/X

@onready var backdrop: PanelContainer = $Node2D/backdrop

@export var header_mode : bool = false
@export var unused_mode : bool = false
@onready var if_unused: PanelContainer = $Node2D/ifUnused
@onready var unused_label: Label = $Node2D/ifUnused/unusedLabel
@onready var scored_value: PanelContainer = $Node2D/scored_value
@onready var scored_value_label: Label = $Node2D/scored_value/scored_valueLabel

var idle_tween : Tween

var score_type
var in_use : bool = false



func _ready() -> void:
	pass
		
		#var tween_val_vector = Vector2(1.025,1.025)
	#
		#var idle_tween = create_tween()
		#
		#idle_tween.parallel().tween_property(score_type_box, "scale", tween_val_vector, .15).set_delay(.1).set_trans(Tween.TRANS_CIRC)
		#
		#idle_tween.parallel().tween_property(mult, "scale", tween_val_vector, .15).set_delay(.2).set_trans(Tween.TRANS_CIRC)
	#
		#idle_tween.parallel().tween_property(score, "scale", tween_val_vector, .15).set_delay(.3).set_trans(Tween.TRANS_CIRC)
		#
		#idle_tween.parallel().tween_property(score_type_box, "scale", Vector2(1,1), .15).set_delay(.45)
		#idle_tween.parallel().tween_property(mult, "scale", Vector2(1,1), .15).set_delay(.6)
		#idle_tween.parallel().tween_property(score, "scale", Vector2(1,1), .15).set_delay(.75)
		#
		#idle_tween.tween_interval(1)
		#
		#idle_tween.set_loops()

func _process(delta: float) -> void:
	pass
	if header_mode:
		self.global_position = self.global_position.lerp(get_parent().global_position  + Vector2(-55,15), 4 * delta)
	else:
		self.global_position = self.global_position.lerp(get_parent().global_position  + Vector2(-55,15), 4 * delta)
		
	scored_value_label.text = str(final_score)
	
	#if header_mode:
		#self.global_position = self.global_position.lerp(get_parent().global_position + Vector2(55,0), 4 * delta)
	#else:
		#pass
		##self.global_position = self.global_position.lerp(get_parent().global_position + Vector2( - size.x/2 + 55,25), 4 * delta)
		#
		#self.global_position = self.global_position.lerp(get_parent().global_position + Vector2(55,25), 4 * delta)
	##
		#score_type_box.global_position = score_type_box.global_position.lerp(self.global_position + Vector2(- 101,7), 4 * delta)
	#h_box_container.global_position	= h_box_container.global_position.lerp(self.global_position - Vector2( - (size.x), 2), 4 * delta)

func update_score_animation():
	var tween = create_tween()
	
	tween.tween_property(score, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
	
	tween.set_parallel().set_parallel().tween_property(score, "rotation_degrees", -4, .15).set_trans(Tween.TRANS_CIRC)
	
	tween.set_parallel().tween_property(score, "rotation_degrees", 4, .25).set_trans(Tween.TRANS_CIRC).set_delay(.15)
	
	tween.set_parallel().tween_property(score, "rotation_degrees", 0, .15).set_trans(Tween.TRANS_CIRC).set_delay(.4)
	
	tween.set_parallel().tween_property(score, "scale", Vector2(1,1), .25).set_trans(Tween.TRANS_CIRC).set_delay(.35)
		
	await tween.finished
	
	return true	
	
func update_mult_animation():
	var tween = create_tween()
	
	tween.tween_property(mult, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
	
	tween.set_parallel().set_parallel().tween_property(mult, "rotation_degrees", -4, .15).set_trans(Tween.TRANS_CIRC)
	
	tween.set_parallel().tween_property(mult, "rotation_degrees", 4, .25).set_trans(Tween.TRANS_CIRC).set_delay(.15)
	
	tween.set_parallel().tween_property(mult, "rotation_degrees", 0, .15).set_trans(Tween.TRANS_CIRC).set_delay(.4)
	
	tween.set_parallel().tween_property(mult, "scale", Vector2(1,1), .25).set_trans(Tween.TRANS_CIRC).set_delay(.35)
		
	await tween.finished
	
	return true	
	
func collapse_score_animation():
	final_score = displayed_mult * displayed_score
	
	var tween = create_tween()
	
	tween.parallel().tween_property(score, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
	
	tween.parallel().tween_property(x, "scale", Vector2(2,2), .35).set_trans(Tween.TRANS_BACK).set_delay(.25)
	
	tween.parallel().tween_property(mult, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK).set_delay(.5)
		
	tween.set_parallel().tween_property(score, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(1.05)
	
	tween.set_parallel().tween_property(x, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(1.05)
	
	tween.set_parallel().tween_property(mult, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(1.05)
	
	tween.parallel().tween_property(scored_value, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK).set_delay(1.05)
	tween.parallel().tween_property(scored_value, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_CIRC).set_delay(1.7)
	
	await tween.finished
	
	var tween2 = create_tween()
	
	tween2.parallel().tween_property(self, "final_score", 0, 1)
	tween2.parallel().tween_property(Player.score_board, "round_score", Player.score_board.round_score + final_score, 1)
	
	await tween2.finished
	
	await disappear()
	
	return true
	
	#tween.set_parallel().set_parallel().tween_property(self, "rotation_degrees", -4, .15).set_trans(Tween.TRANS_CIRC)
	#
	#tween.set_parallel().tween_property(self, "rotation_degrees", 4, .25).set_trans(Tween.TRANS_CIRC).set_delay(.15)
	#
	#tween.set_parallel().tween_property(self, "rotation_degrees", 0, .15).set_trans(Tween.TRANS_CIRC).set_delay(.4)
	#
	#tween.set_parallel().tween_property(self, "scale", Vector2(1,1), .25).set_trans(Tween.TRANS_CIRC).set_delay(.35)

func set_score(type, score, mult, dice_in_use):
	
	#backdrop.visible = false
	
	in_use = true
	score_type = type
	
	var children = h_box_container.get_children()
	var in_use : Array
	
	if dice_count < dice_in_use.size():
		need_update_more = true
	elif dice_count > dice_in_use.size():
		need_update_less = true
		
	dice_count = dice_in_use.size()
	
	for d in dice_in_use:
		var frames = d.dice_animations.get_sprite_frames()
		var frame = frames.get_frame_texture("faces", d.dice_animations.get_frame())	
		children[0].get_child(0).texture = frame
		in_use.append(children[0].get_child(0))
		children.remove_at(0)
	
	#print("To Remove Count : ", children.size())	
	for c in children:
		disappear_die(c.get_child(0))
	
	#label.text = (str(type) + " : " + str(score))
	label.text = (str(type))
	score_label.text = str(score)
	mult_label.text = str(mult)
	
	if score == 0:
		unused_label.text = (str(type))
		if_unused.visible = true
	else:
		if_unused.visible = false
	
	if visible:
		#print("Bump!")
		
		var size_change : Vector2 
		if need_update_less:
			size_change = Vector2(.9,.9)
			need_update_less = false
		elif need_update_more:
			size_change = Vector2(1.1,1.1)
			need_update_more = false
		else:
			size_change = Vector2(1,1)
			
		displayed_score = score
		displayed_mult = mult
		
		if idle_tween:
			idle_tween.pause()
		
		var tween = create_tween()
		
		tween.tween_property($Node2D, "scale", size_change, .35).set_trans(Tween.TRANS_BACK)
		
		tween.tween_property($Node2D, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_CIRC)
		
		if idle_tween:
			idle_tween.play()
		
		
		#tween.set_parallel().tween_property(score_type_box, "scale", Vector2(1.2,1.2),.35).set_trans(Tween.TRANS_BACK)
		#tween.set_parallel().tween_property($Node2D/HBoxContainer2, "scale", Vector2(1.2,1.2),.35).set_trans(Tween.TRANS_BACK)
		#
		#tween.set_parallel().tween_property(score_type_box, "scale", Vector2(1,1),.35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		#tween.set_parallel().tween_property($Node2D/HBoxContainer2, "scale", Vector2(1,1),.35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		

		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees",3,.35).set_trans(Tween.TRANS_BACK)
		
		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees", -3,.35).set_trans(Tween.TRANS_BACK).set_delay(.35)
	
		
		#tween.set_parallel().tween_property(score_type_box, "rotation_degrees", 0,.15).set_trans(Tween.TRANS_BACK).set_delay(.8)
		#tween.set_loops()
		
	else:
		displayed_score = score
		displayed_mult = mult
		
		#self.global_position = get_parent().global_position + Vector2( - size.x/2 + 155,25)		
		#score_type_box.global_position = self.global_position + Vector2(- 101,7)
	
	#print("DICE USED : ", in_use)
	appear(in_use)

func scoring_update_score(score, mult):
	
	if score != displayed_score:
		await update_score_animation()
	
	if mult != displayed_mult:
		await update_mult_animation()
		
	displayed_score = score
	displayed_mult = mult
		
	score_label.text = str(score)
	mult_label.text = str(mult)
	
func set_only_score(type, score):
	label.text = (str(type) + " : " + str(score))

func appear(sprites):
	
	#self.global_position = get_parent().global_position + Vector2( - size.x/2 + 155,25)		
	#score_type_box.global_position = self.global_position + Vector2(- 101,7)
	
	if not visible:
		#global_position = spawn + Vector2(7.5, 0)\
		#self.global_position = self.global_position.lerp(get_parent().global_position + Vector2( - size.x/2 + 55,25), 4 * delta)
		
		$Node2D.scale = Vector2(0,0)
		
		self.global_position = get_parent().global_position + Vector2(-55,22)
		#score_type_box.global_position = self.global_position + Vector2(- 101,7)
		
		visible = true
		
		#score_type_box.global_position = get_parent().global_position
		
		var tween	
			
		#score_type_box.global_position = self.global_position

		#$Node2D.scale = Vector2(1,1)
	
		tween = create_tween()
#
		tween.set_parallel().tween_property($Node2D, "scale", Vector2(1.1,1.1), .35).set_trans(Tween.TRANS_BACK)
		tween.set_parallel().tween_property($Node2D, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		
		#tween.set_parallel().tween_property(score_type_box, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
		#tween.set_parallel().tween_property($Node2D/HBoxContainer2, "scale", Vector2(1.2,1.2), .35).set_trans(Tween.TRANS_BACK)
		#
		tween.set_parallel().tween_property($Node2D, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(.35)
		tween.set_parallel().tween_property($Node2D, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK).set_delay(.35)


	
	for s in sprites:
		var tween2
		
		tween2 = create_tween()
		
		tween2.parallel().tween_property(s, "scale", Vector2(.65,.65), .35).set_trans(Tween.TRANS_BACK)
	
	#tween.parallel().tween_property(score_type_box, "global_position", self.global_position + Vector2(0,self.size.y/2 + score_type_box.size.y/2), .5).set_trans(Tween.TRANS_BACK)	

func disappear_die(die):
	var tween	
	
	tween = create_tween()
	
	tween.tween_property(die, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_CIRC)

func disappear():
	
	in_use = false
	score_type = null
	
	var children = h_box_container.get_children()
	
	for c in children:
		var tween2
		
		tween2 = create_tween()
		
		tween2.tween_property(c.get_child(0), "scale", Vector2(0,0), .15).set_trans(Tween.TRANS_CIRC)
		
	var tween	
		
	tween = create_tween()
	
	tween.tween_property($Node2D, "scale", Vector2(0,1), .25).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	
	$Node2D/scored_value.scale = Vector2(0,0)
	
	visible = false
	
