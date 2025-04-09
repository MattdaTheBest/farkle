extends Node2D

@onready var sprite_2d_3: Sprite2D = $Sprite2D3
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var placed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not placed:
		
		sprite_2d_2.global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("mouseLeft") and not placed:
		sprite_2d_2.reparent(sub_viewport)
		sub_viewport.move_child(sprite_2d_2, 0)
		#sprite_2d_2.position = Vector2(16,16)
		sprite_2d_2.position = get_local_mouse_position()
		placed = true
		
	if not placed:
		if Input.is_action_pressed("ui_left"):
			$Sprite2D2.rotation_degrees -= 1
		if Input.is_action_pressed("ui_right"):
			$Sprite2D2.rotation_degrees += 1

func _on_button_pressed() -> void:
	await get_tree().process_frame  # Wait for the Viewport to render at least once
	var combined_texture = sub_viewport.get_texture()
	
	print(combined_texture.get_size()	)
	
	sprite_2d_3.texture = combined_texture
	
	animated_sprite_2d.sprite_frames.add_frame("default", combined_texture)
	
	$SubViewportContainer.visible = false
	
