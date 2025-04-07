extends Node2D

@onready var sprite_2d_3: Sprite2D = $Sprite2D3
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	await get_tree().process_frame  # Wait for the Viewport to render at least once
	var combined_texture = sub_viewport.get_texture()
	sprite_2d_3.texture = combined_texture
