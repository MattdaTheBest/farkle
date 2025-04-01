extends Node2D

var selected_hand : Array # Selected Dice from Roll
var drawn_dice : Array # Current Hand
var dice_list : Array # Total Dice

var hand_size : int = 6 # Hand Size

var max_rounds : int = 3 # AKA max amount of passes, or busts
var max_discards : int = 5 # How many singular dice player can discard

var available_rounds : int = 3 # Live values
var available_discards : int = 5 # Live values

const BASIC_DICE = preload("res://newVersion/basic_dice.tscn")
const ODD_DIE = preload("res://newVersion/odd_die.tscn")

func _ready() -> void: # Adding Dice
	for n in 11:
		var die = BASIC_DICE.instantiate()
		add_dice(die)
		add_child(die)
		
	var die = ODD_DIE.instantiate()
	add_dice(die)
	add_child(die)
	
	dice_list.shuffle()
	
	ScoringScript.set_up_rules()
	
func add_dice(dice): # Adds dice to dice pool
	dice_list.append(dice)
	
	print(dice.name, " : Added!")
	
func select_die(die): # Selects Die, adds to pool
	selected_hand.append(die)
	
	ScoringScript.find_best_outcome(selected_hand)
	
func deselect_die(die): # Deselects Die, removes from pool
	selected_hand.erase(die) 
	
	ScoringScript.find_best_outcome(selected_hand)

func score_selected_hand(): # Calls Calculations for dice hand
	ScoringScript.score_hand()

func score_dice(): # Removes Dice from board center, called after math
	var discard_count = 0
	
	for d in Player.selected_hand.size():
		discard_count += 1
		
		var die = selected_hand[0]
		
		dice_list.append(die)
		selected_hand.erase(die)
		drawn_dice.erase(die)
		
		die.reparent(Player)
		
		die.reset_die()
		
		var tween : Tween
		tween = create_tween()
		tween.tween_property(die, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_BACK)	

func draw_dice(amount := hand_size - drawn_dice.size()): # Draws dice to hand, defaults to fill
	var hand_drawn : Array
	var to_draw = amount
	for d in to_draw:
		await get_tree().create_timer(.25).timeout
		var die = dice_list[0]
		dice_list.erase(die)
		
		hand_drawn.append(die.name)
		drawn_dice.append(die)
		
		die.animate_dice()
		
		get_tree().get_nodes_in_group("world")[0].add_dice_to_scene(die)

func draw_dice_roll_dice(amount := hand_size - drawn_dice.size()): # Draws dice to hand and rolls them, defaults to fill
	var hand_drawn : Array
	var to_draw = amount
	for d in to_draw:
		var die = dice_list[0]
		dice_list.erase(die)
		
		hand_drawn.append(die.name)
		drawn_dice.append(die)
		
		get_tree().get_nodes_in_group("world")[0].add_dice_to_scene(die)
		
		die.animate_dice()
		
		die.roll()
		
		ScoringScript.check_bust(drawn_dice)

func roll_hand(): # Rolls all dice in hand
	for d in drawn_dice:
		d.roll()
		
	ScoringScript.check_bust(drawn_dice)

func discard_dice(dice : Array = Player.selected_hand): # Discards, and draws new dice and rolls them
	var discard_count = 0
	for d in dice.size():
		discard_count += 1
		
		var die = dice[0]
		
		dice_list.append(die)
		dice.erase(die)
		drawn_dice.erase(die)
		
		die.reparent(Player)
		
		die.reset_die()
		
		var tween : Tween
		tween = create_tween()
		tween.tween_property(die, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_BACK)
	
	await get_tree().create_timer(1).timeout
	
	draw_dice_roll_dice(discard_count)
	
func discard_dice_reset(dice : Array = Player.selected_hand): # Discard full hand, and draw new full hand - doesnt roll
	var discard_count = 0
	for d in dice.size():
		discard_count += 1
		
		var die = dice[0]
		
		dice_list.append(die)
		dice.erase(die)
		drawn_dice.erase(die)
		
		die.reparent(Player)
		
		die.reset_die()
		
		var tween : Tween
		tween = create_tween()
		tween.tween_property(die, "scale", Vector2(0,0), .35).set_trans(Tween.TRANS_BACK)
	
	await get_tree().create_timer(1).timeout
	
	draw_dice()

func bust(): # When best score is 0
	await get_tree().create_timer(.5).timeout
		
	get_tree().get_nodes_in_group("world")[0].bust()
	
	await get_tree().create_timer(1).timeout
	
	reset()

func reset(): # Resets board
	Player.discard_dice_reset(drawn_dice)

func full_reset(): # Board and Score
	reset()
	
	available_rounds = max_rounds
	available_discards = max_discards
	
	get_tree().get_nodes_in_group("world")[0].set_rounds(available_rounds)
	get_tree().get_nodes_in_group("world")[0].set_discards(available_discards)
	
	ScoringScript.reset()
		
