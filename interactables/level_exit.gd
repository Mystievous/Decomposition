extends Area2D

@export_file("*.tscn") var scene: String = "res://scenes/level_select.tscn"

func _ready():
	visible = false

func interact(_node):
	Transitions.transition_to(scene)

func set_outline(enabled: bool):
	$Outline.visible = enabled
