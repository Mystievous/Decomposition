extends Area2D

@export var outline: Node2D

@export_file("*.tscn") var scene: String

func interact(_node):
	Transitions.transition_to(scene)

func set_outline(enabled: bool):
	outline.visible = enabled
