extends Control

func _ready() -> void:
	
	for c in self.get_children():
		var tween = create_tween()
		
		#tween.set_parallel().tween_property(c.get_child(0), "offset:y", -5, .35)
		#tween.set_parallel().tween_property(c.get_child(0), "rotation_degrees", -5, .15).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		
		
		#tween.set_parallel().tween_property(c.get_child(0), "offset:y", 0, .35).set_delay(.35)
		#tween.set_parallel().tween_property(c.get_child(0), "rotation_degrees", 5, .15).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(.35)
		
		
		# Float down (to +10 from original Y)
		
		tween.tween_property(c.get_child(0), "offset:y", -5.0, .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

		tween.tween_property(c.get_child(0), "offset:y", 0, .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		
		tween.tween_interval(.25)
		
		tween.set_loops()
	
		await get_tree().create_timer(.5).timeout
