extends Control

@onready var up: TextureButton = $up

@onready var down: TextureButton = $down




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	print("Up!")
	
	var tween = create_tween()

	tween.tween_property(up, "scale:y", 1.35, .15)
	tween.tween_property(up, "scale", Vector2(1,1), .05)
	
	if get_parent().get_child(1) != null:
		get_parent().get_child(1).change_parent_die_weight_Up()

func _on_texture_button_2_pressed() -> void:
	print("Down!")
	
	var tween = create_tween()
	
	tween.tween_property(down, "scale:y", 1.35, .15)
	tween.tween_property(down, "scale", Vector2(1,1), .05)
