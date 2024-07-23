extends Node

var _transition_scene := preload("res://ui/level_transition.tscn")

var transitioning: bool = false

func transition_to(scene: String):
	if not transitioning:
		var transition = _transition_scene.instantiate()
		transition.scene = scene
		get_tree().root.add_child(transition)

