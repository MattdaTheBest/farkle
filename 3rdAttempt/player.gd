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

const EIGHTER_DIE = preload("res://3rdAttempt/dice/dice/eighterDie.tscn")
const EVEN_DIE = preload("res://3rdAttempt/dice/dice/evenDie.tscn")
const HIGHFOUR_DIE = preload("res://3rdAttempt/dice/dice/highfourDie.tscn")
const LOWFOUR_DIE = preload("res://3rdAttempt/dice/dice/lowfourDie.tscn")
const ODD_DIE = preload("res://3rdAttempt/dice/dice/oddDie.tscn")
const WEIGHTTHREE_DIE = preload("res://3rdAttempt/dice/dice/weightthreeDie.tscn")

var dice_types = [
	EIGHTER_DIE,
	EVEN_DIE,
	HIGHFOUR_DIE,
	LOWFOUR_DIE,
	ODD_DIE,
	WEIGHTTHREE_DIE
]

enum player_states {IDLE, DRAW, DISCARD, ROLL, SELECTION, FARKLE, BUST }
var current_state
var dragging_dice : bool = false

@onready var options: VBoxContainer = $options
@onready var draw_butt: Button = $options/draw
@onready var discard_butt: Button = $options/discard
@onready var roll_butt: Button = $options/roll
@onready var score_butt: Button = $options/score
@onready var score_board: Control = $Score_Board


@onready var score_label: Label = $score/scoreCon/scoreLabel
@onready var selectedscore_label: Label = $score/selectedscoreCon/selectedscoreLabel

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

		player_states.DISCARD:
			print("IN DISCARD STATE")
			
			discard_butt.disabled = false
			draw_butt.disabled = true
			roll_butt.disabled = false
			score_butt.disabled = true

		player_states.ROLL:
			print("IN ROLL STATE")
			
			discard_butt.disabled = true
			draw_butt.disabled = true
			roll_butt.disabled = false
			score_butt.disabled = true
			
		player_states.SELECTION:
			print("IN SELECT STATE")
			
			#for d in held_dice:
				#d.check_coll()
			
			discard_butt.disabled = true
			draw_butt.disabled = true
			roll_butt.disabled = true
			score_butt.disabled = false

		player_states.FARKLE:
			pass
						
		player_states.BUST:
			pass

func _on_draw_pressed() -> void: #Draw Dice
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
		
	print(held_dice.size())
		
func draw_dice_at_index(indexs):
	indexs.sort()
	print(indexs)
	
	while held_dice.size() < hand_size and dice_pouch.size() > 0:
		var die : Control = dice_pouch.pick_random()
		dice_pouch.erase(die)
		
		print(indexs)
		print(dice_hand.get_child(indexs[0]))
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
		
	print(held_dice.size())
	
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
	
	die.dice_animations.scale = Vector2(0,0)
	
	var tween = create_tween()
	tween.tween_property(die.dice_animations, "scale", Vector2(1,1), 0.35).set_trans(Tween.TRANS_BACK)
	
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
	set_state(player_states.ROLL)
	roll_dice()

func roll_dice():
	
	held_dice = sort_index(held_dice)
	
	for dice in held_dice:
		
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
	if selected_for_scoring.size() > 0:
		actual_score += hovered_score		
		updateScore(actual_score)
		
		selected_for_discard = selected_for_scoring.duplicate()
		selected_for_scoring.clear()
			
		if selected_for_discard.size() == held_dice.size():
			print("a")
			set_state(player_states.DISCARD)
			discard_dice_full_redraw()
		else:
			print("b")
			set_state(player_states.ROLL)
			discard_dice_no_redraw_reroll()
	
	hovered_score = ScoringScript.find_best_outcome(selected_for_scoring)
	
func add_score_list(die):
	selected_for_scoring.append(die)
	
	hovered_score = ScoringScript.find_best_outcome(selected_for_scoring)
	print(hovered_score)	
func remove_score_list(die):
	selected_for_scoring.erase(die)
	
	hovered_score = ScoringScript.find_best_outcome(selected_for_scoring)
	print(hovered_score)	
func update_selectedscore_label(score):
	selectedscore_label.text = " + Score : " + str(score)

func update_score_board(rules):
	await score_board.clear()
	
	for r in rules:
		score_board.add_panel(r[0], r[1])
