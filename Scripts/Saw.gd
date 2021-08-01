extends StaticBody2D

func _on_Timer_timeout():
	global_rotation_degrees += 22.5/4

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
