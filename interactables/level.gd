extends Area2D

@export var scene: PackedScene

func interact(_node):
	get_tree().change_scene_to_packed(scene)
	pass
