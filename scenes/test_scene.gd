extends Node2D

const TEST_DICE = preload("res://scenes/test_dice.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_dice(6)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_dice(num):
	for n in num:
		var dice = TEST_DICE.instantiate()
		DiceBag.add_dice(dice)
