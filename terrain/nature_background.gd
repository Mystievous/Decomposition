extends AnimatedSprite2D

func trigger():
	play()

func _on_animation_finished():
	var exits := get_tree().get_nodes_in_group("level_exit")
	for exit in exits:
		exit.activate()
		#exit.visible = true
