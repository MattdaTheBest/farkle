extends Node2D

#var dice_list : Array 
#var selected_dice : Array
#var rules : Array[ScoringRule]
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#
	#rules = [
		#SingleOneRule.new(),
		#ThreeOfAKindRule.new(),
		#SingleFiveRule.new(),
		#FullHouseRule.new()
	#]
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#func add_dice(dice):
	#dice_list.append(dice)
	#GlobalCanvasLayer.v_box_container.add_child(dice)
	#
#func remove_dice(dice):
	#dice_list.erase(dice)
	#
#func draw_die():
	#return dice_list.pick_random()
	#
#func print_dice():
	#print(dice_list)
