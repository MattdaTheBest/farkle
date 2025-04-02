extends Control

func _ready() -> void:
	
	for c in self.get_children():
		var tween = create_tween()
		
		tween.tween_property(c.get_child(0), "offset:y", -5, .35)
		tween.tween_property(c.get_child(0), "offset:y", 0, .35)
		
		tween.tween_interval(.125)
		
		tween.set_loops()
	
		await get_tree().create_timer(.5).timeout
