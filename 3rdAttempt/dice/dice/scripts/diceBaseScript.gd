extends Control
class_name DiceBaseScript

var full_weight : int 

var rolled_value : int = 0
var selected : bool = false
var dragging : bool = false

var tween_highlight : Tween
var tween_select : Tween

var unroll_running : bool = false

enum states {IDLE, SELECTED, HOVERED}
var curr_state = states.IDLE

enum stats_unrolled {idle, opening, closing}
var unrolled_state = stats_unrolled.idle

var dice_rolling_animations : Tween

var disappearing : bool = false
var appearing : bool = false
var roll_tween : Tween
var rolling : bool = false


func animate_popIN():
	pass
	
func animate_popOUT():
	pass

func animate_dice():
	pass

func animate_select(objectA):
	if tween_highlight:
		tween_highlight.kill()
	
	if tween_select:
		tween_select.kill()
		
	tween_select = create_tween()

	tween_select.parallel().tween_property(objectA.material, "shader_parameter/clr:a", 1, .25).set_trans(Tween.TRANS_BACK)
	tween_select.parallel().tween_property(objectA, "scale", Vector2(1.45,1.45), .25).set_trans(Tween.TRANS_CIRC)
	tween_select.parallel().tween_property(objectA, "scale", Vector2(1.25,1.25), .25).set_trans(Tween.TRANS_BACK).set_delay(.25)
	tween_select.parallel().tween_property(objectA, "rotation_degrees", 0, .25).set_trans(Tween.TRANS_BACK).set_delay(.25)
	
	await tween_select
	
	curr_state = states.SELECTED
	
#func animate_deselect(objectA, objectB):
	#if tween_highlight:
		#tween_highlight.kill()
	#
	#if tween_select:
		#tween_select.kill()
		#
	#tween_select = create_tween()
	#
	#tween_select.parallel().tween_property(objectA.material, "shader_parameter/clr:a", 0, .25).set_trans(Tween.TRANS_BACK)
	#tween_select.parallel().tween_property(objectA, "scale", Vector2(1,1), .25).set_trans(Tween.TRANS_BACK)
	#
	#await tween_select
	#
	#curr_state = states.IDLE

func animate_idle(die):
	
	await get_tree().create_timer(randf_range(0,1)).timeout
	
	var tween = create_tween()
	
	tween.tween_interval(randf_range(0,1))
	
	tween.tween_property(die, "rotation_degrees", -4, 3).set_ease(Tween.EASE_IN)
	
	tween.tween_interval(randf_range(0,1))
	
	tween.tween_property(die, "rotation_degrees", 0, 3).set_ease(Tween.EASE_IN)
	
	tween.tween_property(die, "rotation_degrees", 4, 3).set_ease(Tween.EASE_IN)
	
	tween.set_loops()
	
func animate_deselect(objectA):
	if tween_highlight:
		tween_highlight.kill()
	
	if tween_select:
		tween_select.kill()
		
	tween_select = create_tween()
	
	tween_select.parallel().tween_property(objectA.material, "shader_parameter/clr:a", 0, .25).set_trans(Tween.TRANS_BACK)
	tween_select.parallel().tween_property(objectA, "scale", Vector2(1.45,1.45), .25).set_trans(Tween.TRANS_CIRC)
	tween_select.parallel().tween_property(objectA, "scale", Vector2(1.25,1.25), .25).set_trans(Tween.TRANS_BACK).set_delay(.25)
	
	await tween_select
	
	curr_state = states.IDLE	

func animate_highlight(objectA, objectB):
	if tween_highlight:
		tween_highlight.kill()
	if tween_select:
		tween_select.kill()
		
	tween_highlight = create_tween()
	
	tween_highlight.parallel().tween_property(objectA, "scale", Vector2(1.25,1.25), .35).set_trans(Tween.TRANS_BACK)
	#tween_highlight.parallel().tween_property(objectA, "rotation_degrees", randf_range(-12,12), .25).set_trans(Tween.TRANS_BACK)
	
	await tween_highlight
	
	curr_state = states.HOVERED
	
func animate_unhighlight(objectA, objectB):
	if not selected:
		if tween_highlight:
			tween_highlight.kill()
		if tween_select:
			tween_select.kill()
			
		tween_highlight = create_tween()
		
		tween_highlight.tween_property(objectA.material, "shader_parameter/clr:a", 0, .35).set_trans(Tween.TRANS_BACK)
		tween_highlight.parallel().tween_property(objectA, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)
		#tween_highlight.parallel().tween_property(objectA, "rotation_degrees", 0, .25).set_trans(Tween.TRANS_BACK).set_delay(.25)
		
		await tween_highlight
		
		curr_state = states.IDLE

#func appear_unrolled_dice(objectA, faces, weights, d_name, animation):
	#unrolled_state = stats_unrolled.opening
	#var index = 0
	#var list = objectA.get_children()
	#list.reverse()
	#for d in list:
		#if index > faces.size():
			#break
		#
		#if unrolled_state == stats_unrolled.closing:
			#break
			#
		#await get_tree().create_timer(.065).timeout
				#
		#if index == 0:
			#
			#d.appear(d_name)
		#
		#else:
		#
			#var weight = (float(weights[index - 1])/float(full_weight)) * 100
			#
			#var frames = animation.get_sprite_frames()
			#var frame = frames.get_frame_texture("faces", index)
			#
			#d.appear(faces[index - 1],weight, frame)
		#
		#index += 1

func appear_name(die_name, label):
	
	label.get_child(0).appear(die_name)
	
func disappear_name(label):

	label.get_child(0).disappear()

func appear_unrolled_dice(objectA, faces, weights, d_name, animation, dice_reference):
	unrolled_state = stats_unrolled.opening
	
	var index = 0
	var slot_index = 0
	
	var list_A = objectA.get_child(0).get_child(0).get_children()
	var list_B = objectA.get_child(0).get_child(1).get_children()
	var list_C = objectA.get_child(0).get_child(2).get_children()
	var list_D = objectA.get_child(0).get_child(3).get_children()
	
	list_A.reverse()
	list_B.reverse()
	list_C.reverse()
	list_D.reverse()
	
	list_A.append_array(list_B)
	list_A.append_array(list_C)
	list_A.append_array(list_D)
	
	for d in list_A:
				
		if slot_index + 1 > faces.size():
			break
		
		if unrolled_state == stats_unrolled.closing:
			break
			
		await get_tree().create_timer(.065).timeout

		var weight = (float(weights[slot_index])/float(full_weight)) * 100
		
		var face_index = faces[slot_index]
		
		var frames = animation.get_sprite_frames()
		var frame = frames.get_frame_texture("faces", face_index)
		
		d.appear(faces[slot_index],weight, frame, dice_reference, slot_index)
		
		slot_index += 1
		
		index += 1
		
func disappear_unrolled_dice(objectA, faces):
	unrolled_state = stats_unrolled.closing

	var list_A = objectA.get_child(0).get_child(0).get_children()
	var list_B = objectA.get_child(0).get_child(1).get_children()
	var list_C = objectA.get_child(0).get_child(2).get_children()
	var list_D = objectA.get_child(0).get_child(3).get_children()
	
	list_A.append_array(list_B)
	list_A.append_array(list_C)
	list_A.append_array(list_D)
	
	for d in list_A:
						
		if unrolled_state == stats_unrolled.opening:
			break
			
		if d.used:
			
			await get_tree().create_timer(.045).timeout
			
			d.disappear()
			
func roll(faces : Array, weights : Array):
	var varint = randi_range(0,1)
	if varint == 1:
		rolled_value = 1
	else:
		rolled_value = 5
		
	#var total_weight : int = 0
	#for w in weights:
		#total_weight += w
	#
	#var roll = randi_range(1, total_weight)
	#
	#var count : int = 0
	#var index : int = 0
	#for w in weights:
		#count += w
		#
		#if roll <= count:
			#rolled_value = faces[index]
			#break
			#
		#index += 1
		
func animate_roll(die_visual, dice, faces):
		
	rolling = true

	roll_tween = create_tween()
	
	roll_tween.tween_property(die_visual.material, "shader_parameter/clr:a", 0, .35).set_trans(Tween.TRANS_BACK)
	
	roll_tween.parallel().tween_property(die_visual, "rotation_degrees", 360 * 4, .85).set_trans(Tween.TRANS_CUBIC)
	
	roll_tween.parallel().tween_property(die_visual, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_BACK)
	
	roll_tween.parallel().tween_property(die_visual, "scale", Vector2(1.5,1.5), .55).set_trans(Tween.TRANS_CUBIC).set_delay(.5)
	
	roll_tween.parallel().tween_property(die_visual, "scale", Vector2(1,1), .5).set_trans(Tween.TRANS_BACK).set_delay(1)

	await get_tree().create_timer(.35).timeout

	die_visual.play("faces")
	die_visual.pause()
	die_visual.set_frame_and_progress(rolled_value, 0)
	
	print(rolled_value + 1)
	
	await roll_tween.finished
	
	die_visual.rotation_degrees = 0
	
	rolling = false





	
	
	
	
	
	
	
	
	#dice_rolling_animations = create_tween()
	##bounce 1 starts at 0 delay .75
	#dice_rolling_animations.parallel()
	#
	#dice_rolling_animations.parallel().tween_property(die_visual, "position:y", die_visual.position.y - 50, .55).set_ease(Tween.EASE_OUT)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:y", .5, .75).set_ease(Tween.EASE_OUT)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:x", 1.5, .75).set_ease(Tween.EASE_OUT)
#
	#dice_rolling_animations.parallel().tween_property(die_visual, "position:y", die_visual.position.y, .35).set_ease(Tween.EASE_OUT).set_delay(.75)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:y", 1, .75).set_ease(Tween.EASE_OUT).set_delay(.75)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:x", 1, .75).set_ease(Tween.EASE_OUT).set_delay(.75)
	#
	##bounce 2 starts at 1.5 delay .35
	#dice_rolling_animations.parallel().tween_property(die_visual, "position:y", die_visual.position.y - 30, .25).set_ease(Tween.EASE_OUT).set_delay(1.5)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:y", .5, .75).set_ease(Tween.EASE_OUT).set_delay(1.5)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:x", 1.5, .75).set_ease(Tween.EASE_OUT).set_delay(1.5)
	#
	#dice_rolling_animations.parallel().tween_property(die_visual, "position:y", die_visual.position.y, .10).set_ease(Tween.EASE_OUT).set_delay(2.25)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:y", 1, .75).set_ease(Tween.EASE_OUT).set_delay(2.25)
	#dice_rolling_animations.parallel().tween_property(die_visual, "scale:x", 1, .75).set_ease(Tween.EASE_OUT).set_delay(2.25)
	
	pass
	
func wobble(die_visual):
	var tween = create_tween()
	
	tween.tween_property(die_visual, "rotation_degrees", randi_range(-8,8), .5).set_trans(Tween.TRANS_CIRC)
