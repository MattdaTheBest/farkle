extends Node

var dice_pouch : Array # Dice Excluding dice Drawn
var held_dice : Array # Dice Drawn from Bag
var selected_for_discard : Array # Dice Selected to be removed
var selected_for_scoring : Array # Dice Selected to be scored

var hovered_score : int = 0 # current selected score
var actual_score : int = 0 # score after scored

var hand_size = 6
@onready var dice_hand: HBoxContainer = $dice_hand
@onready var dice_bag: Node2D = $dice_bag

const BASIC_DIE = preload("res://3rdAttempt/dice/dice/BasicDie.tscn")
const EIGHTER_DIE = preload("res://3rdAttempt/dice/dice/eighterDie.tscn")
const ODD_DIE = preload("res://3rdAttempt/dice/dice/OddDie.tscn")
const EVEN_DIE = preload("res://3rdAttempt/dice/dice/EvenDie.tscn")
const LOW_FOUR = preload("res://3rdAttempt/dice/dice/LowFour.tscn")
const HIGH_FOUR = preload("res://3rdAttempt/dice/dice/HighFour.tscn")
const GOLDEN_3_DIE = preload("res://3rdAttempt/dice/dice/Golden3Die.tscn")
const PIE_DIE = preload("res://3rdAttempt/dice/dice/PieDie.tscn")

enum sorting_states {LEFT, CENTER, RIGHT}
var set_sorting_state = sorting_states.CENTER

var dice_types = [
	BASIC_DIE,
	EIGHTER_DIE,
	ODD_DIE,
	EVEN_DIE,
	LOW_FOUR,
	HIGH_FOUR,
	GOLDEN_3_DIE,
	PIE_DIE
	#EVEN_DIE,
	#HIGHFOUR_DIE,
	#LOWFOUR_DIE,
	#ODD_DIE,
	#WEIGHTTHREE_DIE
]

enum player_states {IDLE, DRAW, DISCARD, ROLL, SELECTION, SCORING, FARKLE, BUST }
var current_state
var dragging_dice : bool = false

@onready var draw_butt: Button = $draw/draw
@onready var discard_butt: Button = $rollanddiscard/discard
@onready var roll_butt: Button = $rollanddiscard/roll
@onready var score_butt: Button = $score_options/score
@onready var score_and_pass: Button = $score_options/scoreANDpass

@onready var draw: HBoxContainer = $draw
@onready var score_options: HBoxContainer = $score_options
@onready var rollanddiscard: HBoxContainer = $rollanddiscard


@onready var score_board: Control = $Score_Board

@onready var score_label: Label = $score/scoreCon/scoreLabel
@onready var selectedscore_label: Label = $score/selectedscoreCon/selectedscoreLabel

@onready var update_timer: Timer = $update_timer
var pending_rules = []


func _ready() -> void:
	set_state(player_states.IDLE)
	initialize_dice_bag()
	ScoringScript.set_up_rules()

func initialize_dice_bag():
	for n in 12:
		var die = dice_types.pick_random().instantiate()
		dice_bag.add_child(die)
		dice_pouch.append(die)
		
		#die.call_deferred("animate_idle", die.dice_animations)
		
		die.dice_animations.scale = Vector2(0,0)
		
	set_state(player_states.DRAW)
			
func set_state(new_state):
	current_state = new_state
	
	match current_state:
		player_states.DRAW:
			print("IN DRAW STATE")
			
			draw_butt.disabled = false
			discard_butt.disabled = true
			roll_butt.disabled = true
			score_butt.disabled = true
			
			await toggle_draw(false)

		player_states.DISCARD:
			print("IN DISCARD STATE")
			
			discard_butt.disabled = false
			draw_butt.disabled = true
			roll_butt.disabled = false
			score_butt.disabled = true
			
			toggle_draw(true)
			await toggle_score_options(true)
			
			await toggle_roll_and_discard(false)

		player_states.ROLL:
			print("IN ROLL STATE")
			
			discard_butt.disabled = true
			draw_butt.disabled = true
			roll_butt.disabled = true
			score_butt.disabled = true
			
		player_states.SELECTION:
			print("IN SELECT STATE")
			

			
			#for d in held_dice:
				#d.check_coll()
				
			score_and_pass.disabled = false
			score_butt.disabled = false
			
			discard_butt.disabled = true
			draw_butt.disabled = true
			roll_butt.disabled = true
			score_butt.disabled = false
			
			await toggle_roll_and_discard(true)
			
			await toggle_score_options(false)

		player_states.SCORING:
			print("IN SCORING STATE")
			
			score_butt.disabled = true
			score_and_pass.disabled = true
			
			pass
		
		player_states.FARKLE:
			pass
						
		player_states.BUST:
			pass

func _on_draw_pressed() -> void: #Draw Dice
	draw_butt.disabled = true
	await draw_dice()
	set_state(player_states.DISCARD)
func draw_dice():
	var index = 0  
	while held_dice.size() < hand_size and dice_pouch.size() > 0:
		var die : Control = dice_pouch[0]
		dice_pouch.erase(die)
		
		die.reparent(dice_hand.get_child(index))
		
		
		
		die.position = Vector2.ZERO
		die.dice_animations.global_position = Vector2(die.global_position.x + 24,die.global_position.y + 24)
		
		#die.visible = true
		
		#die.dice_animations.scale = Vector2(1,1)
		
		call_deferred("pop_in", die)
		#pop_in(die)
				
		held_dice.append(die)
		
		index += 1
		
		await get_tree().create_timer(.125).timeout
		
	#print(held_dice.size())
		
func draw_dice_at_index(indexs):
	indexs.sort()
	
	while held_dice.size() < hand_size and dice_pouch.size() > 0:
		var die : Control = dice_pouch.pick_random()
		dice_pouch.erase(die)
		
		die.reparent(dice_hand.get_child(indexs[0]))
		
		die.position = Vector2.ZERO
		die.dice_animations.global_position = Vector2(die.global_position.x + 24,die.global_position.y + 24)
		
		#die.visible = true
		
		#die.dice_animations.scale = Vector2(1,1)
		
		call_deferred("pop_in", die)
		#pop_in(die)
		
		held_dice.append(die)
		
		indexs.remove_at(0)
		
		await get_tree().create_timer(.125).timeout
		
	#print(held_dice.size())
	
func _on_discard_pressed() -> void: #Discard Dice
	if selected_for_discard.size() > 0:
		discard_dice()	
func discard_dice():
	var indexs : Array
	
	selected_for_discard = sort_index(selected_for_discard)
	
	while selected_for_discard.size() > 0:
		var die = selected_for_discard[0]
		
		indexs.append(die.get_parent().get_index())
		
		#
		
		#die.dice_animations.scale = Vector2(0,0)
		
		call_deferred("pop_out", die)
		#pop_out(die)
		
		#held_dice.erase(die)
		#dice_pouch.append(die)
		#
		##die.visible = false
		#
		#die.reparent(dice_bag)
				
		selected_for_discard.remove_at(0)
		
		await get_tree().create_timer(.125).timeout
	
	await get_tree().create_timer(.5).timeout
	
	draw_dice_at_index(indexs)

func sort_index(array : Array):
	var sorted_nodes = array.duplicate()
	sorted_nodes.sort_custom(func(a: Node, b: Node) -> bool:
		return a.get_parent().get_index() < b.get_parent().get_index()
	)
	
	return sorted_nodes
	
func discard_dice_no_redraw_reroll():
	selected_for_discard = sort_index(selected_for_discard)
		
	while selected_for_discard.size() > 0:
		var die = selected_for_discard[0]	

		pop_out(die)

		selected_for_discard.remove_at(0) # remove from selected
		
		await get_tree().create_timer(.125).timeout
	
	await get_tree().create_timer(.25).timeout
	
	roll_dice()

func discard_dice_full_redraw():

	selected_for_discard = sort_index(selected_for_discard)
	
	while selected_for_discard.size() > 0:
		var die = selected_for_discard[0]
		
		call_deferred("pop_out", die)
		
		selected_for_discard.remove_at(0)
		
		await get_tree().create_timer(.125).timeout
	
	await get_tree().create_timer(.25).timeout
	
	draw_dice()

func add_discard_list(die):
	selected_for_discard.append(die)	
func remove_discard_list(die):
	selected_for_discard.erase(die)

func pop_in(die):
	
	die.animate_idle()
	
	die.dice_animations.scale = Vector2(0,0)
	
	var tween = create_tween()
	tween.tween_property(die.dice_animations, "scale", Vector2(1.5,1.5), 0.35).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	
func pop_out(die):

	var tween = create_tween()
	tween.parallel().tween_property(die.dice_animations, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	
	held_dice.erase(die)
	dice_pouch.append(die)
	die.reparent(dice_bag)
	die.reset_die()	

func _on_roll_pressed() -> void:
	selected_for_discard.clear()
	selected_for_scoring.clear()
	set_state(player_states.ROLL)
	roll_dice()

func roll_dice():
	
	held_dice = sort_index(held_dice)
	
	for dice in held_dice:
		dice.selected = false
		#dice.animate_deselect(dice.dice_animations)
		dice.animate_roll(dice.dice_animations, dice, dice.face_values)
		dice.roll(dice.face_values, dice.weighted_value)
		
		await get_tree().create_timer(.25).timeout
		
	await get_tree().create_timer(.25).timeout
	
	ScoringScript.check_bust(held_dice)
		
	set_state(player_states.SELECTION)

func updateScore(score):
	
	score_label.text = " Score : " + str(score)

func _on_score_pressed() -> void:
	if selected_for_scoring.size() > 0 and hovered_score > 0 and not ScoringScript.cant_score:
		
		set_state(player_states.SCORING)
		
		for r in ScoringScript.saved_score_sets:
			print("Rules : " , r)
			var rule = r[0]
			var score = [r[2], r[3]]
			var mult = r[3]
			var dice_list = sort_index(r[4])
			for d in dice_list:
				score = await d.score(rule, score[0], mult)
				
			ScoringScript.update_round_score(score[0] * score[1])
						
				#await get_tree().create_timer(.15).timeout
		
		await get_tree().create_timer(1).timeout
				
		await score_board.collapse_scores()		
		
			
			#print("Score : ", score[0] * score[1])
			#
			#await get_tree().create_timer(.15).timeout
						#
			#ScoringScript.update_round_score(score[0] * score[1])
			#
			#score_board.update_round_score()
			#
			#await get_tree().create_timer(.25).timeout
			#
		#
		#
		#score_board.clear()
		#
		selected_for_discard = selected_for_scoring.duplicate()
		selected_for_scoring.clear()
			#
		if selected_for_discard.size() == held_dice.size():
			set_state(player_states.DISCARD)
			discard_dice_full_redraw()
		else:
			set_state(player_states.ROLL)
			discard_dice_no_redraw_reroll()
			
func add_score_list(die):
	selected_for_scoring.append(die)
	
	hovered_score = ScoringScript.find_best_outcome(selected_for_scoring)
	#print(hovered_score)	
func remove_score_list(die):
	selected_for_scoring.erase(die)
	
	hovered_score = ScoringScript.find_best_outcome(selected_for_scoring)
	#print(hovered_score)	
func update_selectedscore_label(score):
	hovered_score += score
	selectedscore_label.text = " + Score : " + str(score)

func update_score_board(rules):
	#await score_board.clear()
	
	pending_rules = rules

	update_timer.start(0.3)
	
func _on_update_timer_timeout() -> void:
	var loading_rules : Array
	var used_dice : Array
	var unused_dice : Array = selected_for_scoring.duplicate()

	#([rule.name, r.score, r.base_score, r.base_mult, r.used_dice])
	for r in pending_rules:
		loading_rules.append(r[0])
		for d in r[4]:
			used_dice.append(d)
			
			if unused_dice.has(d):
				unused_dice.erase(d)
				
	if unused_dice.size() > 0:
		update_selectedscore_label(0)	
	
	for r in pending_rules:
		score_board.update_board(r[0],r[2],r[3],loading_rules, r[4], used_dice, unused_dice)
		pass
	
	if pending_rules.size() == 0:
		var empty_array : Array
		score_board.update_board(null, null,empty_array, empty_array, empty_array, used_dice, unused_dice)

func toggle_roll_and_discard(hide : bool):
	if hide:
		var tween = create_tween()
		
		tween.tween_property($rollanddiscard, "scale", Vector2(0,0), .25).set_trans(Tween.TRANS_CIRC)
		
		await tween.finished
		
		$rollanddiscard.visible = false
	else:
		
		$rollanddiscard.visible = true
		
		var tween = create_tween()
		
		tween.tween_property($rollanddiscard, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)

func toggle_score_options(hide : bool):
	if hide:
		var tween = create_tween()
		
		tween.tween_property($score_options, "scale", Vector2(0,0), .25).set_trans(Tween.TRANS_CIRC)
		
		await tween.finished
		
		$score_options.visible = false
	else:
		
		$score_options.visible = true
		
		var tween = create_tween()
		
		tween.tween_property($score_options, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)
	
func toggle_draw(hide : bool):
	if hide:
		var tween = create_tween()
		
		tween.tween_property($draw, "scale", Vector2(0,0), .25).set_trans(Tween.TRANS_CIRC)
		
		await tween.finished
		
		$draw.visible = false
	else:
		
		$draw.visible = true
		
		var tween = create_tween()
		
		tween.tween_property($draw, "scale", Vector2(1,1), .35).set_trans(Tween.TRANS_BACK)

func _on_bytype_pressed() -> void:
	sort_by_type(held_dice, 0)	

func sort_by_type(to_be_sorted, starting):
	
	await push_left()
			
	to_be_sorted = sort_index(to_be_sorted)
	
	var temp_held_dice = to_be_sorted.duplicate()
	
	var sorting_by : String = "null"
	var index : int = starting
	
	for d in temp_held_dice:
		if sorting_by == "null":
			sorting_by = d.dice_name
			to_be_sorted.erase(d)
		elif d.dice_name == sorting_by:
			
			to_be_sorted.erase(d)
			index += 1
			
			d.get_parent().get_parent().get_child(index).get_child(1).reparent(d.get_parent())
			d.reparent(d.get_parent().get_parent().get_child(index))

		elif d.dice_name != sorting_by:
			pass
		
	index += 1
	
	if to_be_sorted.size() > 0:
		sort_by_type(to_be_sorted, index)

func push_left():
	held_dice = sort_index(held_dice)
	
	var index = 0
	for d in held_dice:
		d.reparent(dice_hand.get_child(index))
		
		index += 1

func _on_byvalue_pressed() -> void:
	sort_by_value(held_dice, 0)
	
func sort_by_value(to_be_sorted, starting):
	
	await push_left()
			
	to_be_sorted = sort_index(to_be_sorted)
	
	var temp_held_dice = to_be_sorted.duplicate()
	
	var sorting_by : int = 0
	var index : int = starting
	
	for d in temp_held_dice:
		if sorting_by == 0:
			sorting_by = d.rolled_value
			to_be_sorted.erase(d)
		elif d.rolled_value == sorting_by:
			
			to_be_sorted.erase(d)
			index += 1
			
			d.get_parent().get_parent().get_child(index).get_child(1).reparent(d.get_parent())
			d.reparent(d.get_parent().get_parent().get_child(index))

		elif d.rolled_value != sorting_by:
			pass
		
	index += 1
	
	if to_be_sorted.size() > 0:
		sort_by_value(to_be_sorted, index)

func _on_left_pressed() -> void:
	push_left()

func bust():
	set_state(player_states.BUST)
	$BUST.visible = true
