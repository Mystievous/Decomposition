extends Area2D

@export_file("*.tscn") var scene: String

func interact(_node):
	if visible:
		Transitions.transition_to(scene)

func set_outline(enabled: bool):
	$Outline.visible = enabled
