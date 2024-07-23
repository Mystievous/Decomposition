extends Node2D

@export_file("*.tscn") var level_select: String

func _input(event):
	if (event.is_action_pressed("pause")):
		Transitions.transition_to(level_select)
