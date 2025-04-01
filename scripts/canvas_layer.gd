extends CanvasLayer

#@onready var roll: Button = $ui/HBoxContainer/roll
#@onready var pass_turn: Button = $ui/HBoxContainer/pass_turn
#@onready var dice_area: Panel = $ui/dice_area
#@onready var v_box_container: VBoxContainer = $ui/readyDice
#@onready var score_round: Label = $ui/HBoxContainer2/score_round
#@onready var score_total: Label = $ui/HBoxContainer2/score_total
#@onready var score_selected: Label = $ui/HBoxContainer2/score_selected
#@onready var scored_dice: VBoxContainer = $ui/scoredDice
#@onready var reset_game: VBoxContainer = $ui/resetGame
#
#var scoreSelected = 0
#var scoreRound = 0
#var scoreTotal = 0
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#func _on_roll_pressed() -> void:
	#for r in 6:
		#var dice = DiceBag.dice_list[r]
		#
		#if dice.scored == false:
			#dice.roll()		
			#dice.reparent(dice_area)
			#dice.position = get_random_point_in_panel()
	#
	#roll.disabled = true	
			#
			#
			#
	##reset_game.visible = DiceCombos.check_bust()
	#
	##print(DiceBag.rules)
	##print()
	###var perms = ScoreManager.get_permutations(DiceBag.rules)
	##ScoreManager.find_best_outcome(DiceBag.selected_dice, DiceBag.rules)
#
	##for p in perms:
		##print(p)
		#
	##ScoreManager.get_permutations(DiceBag.rules)
#
#func _on_pass_turn_pressed() -> void:
	#scoreRound += scoreSelected
	#scoreSelected = 0
	#scoreTotal += scoreRound
	#scoreRound = 0
	#
	#score_total.text = "Total Score : " + str(scoreTotal)
	#score_round.text = "Round Score : " + str(scoreRound)
	#score_selected.text = "Selected Score : " + str(scoreSelected)
	#
	#for dice in DiceBag.dice_list:
		#dice.scored = false
		#dice.reset_select_status()
		#dice.reparent(v_box_container)
		#
	#DiceBag.selected_dice.clear()
	#roll.disabled = false
#
#func _on_print_list_pressed() -> void:
	#for d in DiceBag.dice_list:
		#print(d.name)
		#
#func get_random_point_in_panel() -> Vector2:
	#var size = dice_area.size
	#var local_x = randf_range(0, size.x - 30)
	#var local_y = randf_range(0, size.y - 30)
	#return Vector2(local_x, local_y)
#
#func _on_score_pressed() -> void:
	#if scoreSelected > 0:
		#scoreRound += scoreSelected
		#scoreSelected = 0
		#score_round.text = "Round Score : " + str(scoreRound)
		#score_selected.text = "Selected Score : " + str(scoreSelected)
		#
		#for dice in DiceBag.selected_dice:
			#dice.scored = true
			#dice.reparent(scored_dice)
			#
		#if scored_dice.get_child_count() == 6:
			#for dice in DiceBag.dice_list:
				#dice.scored = false
				#dice.reset_select_status()
				#dice.reparent(v_box_container)
		#else:
			#for dice in DiceBag.dice_list:
				#dice.reset_select_status()
			#DiceBag.selected_dice.clear()
		#
		#_on_roll_pressed()
#
#func _on_reset_pressed() -> void:
	#scoreRound = 0
	#scoreTotal = 0
	#scoreSelected = 0 
#
	#for dice in DiceBag.dice_list:
		#dice.scored = false
		#dice.reset_select_status()
		#dice.reparent(v_box_container)
		#
	#score_total.text = "Total Score : " + str(scoreTotal)
	#score_round.text = "Round Score : " + str(scoreRound)
	#score_selected.text = "Selected Score : " + str(scoreSelected)
		#
	#DiceBag.selected_dice.clear()
	#reset_game.visible = false
	#roll.disabled = false
