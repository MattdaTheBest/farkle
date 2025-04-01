extends Resource
class_name DiceBase

@export var name: String
@export var sides: int = 6
@export var special_rule: String = ""

func print_name():
	print(name)
