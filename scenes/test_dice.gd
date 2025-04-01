extends Control

@onready var value_label: Label = $PanelContainer/value_label
@onready var panel_container: PanelContainer = $PanelContainer

var style_a
var style_b

var value : int = 0
var values : Array = [1, 2, 3, 4, 5, 6]
enum dice_states {idle, selected, scored}
var curr_state = dice_states.idle

var hovering_dice : bool = false
var selected : bool = false
var scored : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_styles()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouseLeft") and hovering_dice and not get_parent().name == "readyDice" and not scored:
		selected = !selected
		if selected:
			DiceBag.selected_dice.append(self)
		else:
			DiceBag.selected_dice.erase(self)
			update_style()
			
		ScoreManager.find_best_outcome(DiceBag.selected_dice, DiceBag.rules)
		
		#print("~~~~~~~~~~~~~~~~~~~~")
		
		GlobalCanvasLayer.score_selected.text = "Selected Score : " + str(GlobalCanvasLayer.scoreSelected)
		
			#
		#var matches = ScoreManager.get_all_rule_matches(DiceBag.selected_dice, DiceBag.rules)
		#var result = ScoreManager.get_best_non_overlapping_combo(DiceBag.selected_dice, matches)
#
		#print("Best score:", result.score)
		#for combo in result.combos:
			#print(" - Used:", combo.used_dice, " Score:", combo.score)
		
		#GlobalCanvasLayer.scoreSelected = DiceCombos.calculate_best_score(DiceBag.selected_dice, DiceBag.rules)
		#GlobalCanvasLayer.score_selected.text = "Selected Score : " + str(GlobalCanvasLayer.scoreSelected)

func roll():
	reset_select_status()
	value = values.pick_random()
	value_label.text = str(value)

func set_value(val):
	reset_select_status()
	value = val
	value_label.text = str(value)

func create_styles():
	style_a = StyleBoxFlat.new()
	style_a.set_border_width_all(2)
	style_a.border_color = Color.RED
	style_a.bg_color = Color.WHITE
	style_a.set_corner_radius_all(4)
	
	style_b = StyleBoxFlat.new()
	style_b.set_border_width_all(2)
	style_b.border_color = Color.WHITE
	style_b.bg_color = Color.WHITE
	style_b.set_corner_radius_all(4)

func reset_select_status():
	for dice in DiceBag.selected_dice:
		if not scored:
			dice.selected = false
			update_style()

func update_style():
	if not selected:
		panel_container.add_theme_stylebox_override("panel", style_b)

func _on_panel_container_mouse_entered() -> void:
	hovering_dice = true
	
	panel_container.add_theme_stylebox_override("panel", style_a)

func _on_panel_container_mouse_exited() -> void:
	hovering_dice = false
	
	if not selected:
		panel_container.add_theme_stylebox_override("panel", style_b)
