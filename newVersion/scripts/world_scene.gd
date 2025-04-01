extends Node2D

@onready var temp_dice_holder: HBoxContainer = $ui/Control/temp_dice_holder

@onready var mult_label: Label = $ui/Control/HBoxContainer/VBoxContainer/mult/multLabel
@onready var score_label: Label = $ui/Control/HBoxContainer/VBoxContainer/value/scoreLabel
@onready var round_score: Label = $ui/Control/HBoxContainer/value/roundScore
@onready var farkle_label: Label = $ui/Control/HBoxContainer/farkles/farkleLabel
@onready var overallscorel_label: Label = $ui/Control/HBoxContainer/VBoxContainer2/overallScore/overallscorelLabel

var score_goal : int = 500
var won : bool = false

func set_score_goal(score):
	score_goal = score
	
	$ui/Control/HBoxContainer/VBoxContainer2/goalScore2/goalscorelLabel.text = "Goal : " + str(score_goal)
	
func _on_draw_hand_pressed() -> void:
	Player.draw_dice()

func _on_roll_hand_pressed() -> void:
	Player.roll_hand()

func add_dice_to_scene(die):
	die.reparent(temp_dice_holder)
	#temp_dice_holder.add_child(die)

func _on_discard_pressed() -> void:
	if Player.selected_hand.size() <= Player.available_discards:
		Player.available_discards -= Player.selected_hand.size()
		set_discards(Player.available_discards)
		Player.discard_dice()
	else:
		print("Not enough Discards!")

func _on_score_pressed() -> void:
	Player.score_selected_hand()
	
func set_score(mult, score):
	mult_label.text = "Mult : " + str(mult)
	score_label.text = "Score : " + str(score)

func set_round_score(score):
	round_score.text = ("R Score : " + str(score))
	
func set_farkle(value):
	farkle_label.text = "Farkles : " + str(value)

func _on_scoreandpass_pressed() -> void:
	ScoringScript.end_round_scoring()
	
	pass_round()

func bust():
	$ui/Control/HBoxContainer2.visible = true
	
	await get_tree().create_timer(1).timeout
	
	$ui/Control/HBoxContainer2.visible = false
	
	pass_round()

func pass_round():
	var final_score = ScoringScript.round_score * ScoringScript.round_farkles
	
	Player.available_rounds -= 1
	
	set_rounds(Player.available_rounds)
	
	if Player.available_rounds <= 0 or ScoringScript.overall_score > score_goal:
		
		$ui/Control/HBoxContainer4.visible = true
		if ScoringScript.overall_score > score_goal:
			$ui/Control/HBoxContainer4/PanelContainer.visible = true
			won = true
		else:
			$ui/Control/HBoxContainer4/PanelContainer.visible = false
			won = false
			
		print("Game Over. Final Score : ", ScoringScript.overall_score)
	else:
		Player.reset()
				
func set_overall_score(score):
	overallscorel_label.text = "Overall Score : " + str(score)

func _on_reset_pressed() -> void:
	Player.full_reset()
	
	if won:
		set_score_goal(score_goal * 2)
	else:
		set_score_goal(score_goal)
		
	won = false
		
	$ui/Control/HBoxContainer4.visible = false

func set_discards(discards):
	$ui/Control/HBoxContainer3/discards/discards_label.text = "Discards : " + str(discards)
	
func set_rounds(rounds):
	$ui/Control/HBoxContainer3/handsplayed/handsplayedLabel.text = "Rounds : " + str(rounds)
