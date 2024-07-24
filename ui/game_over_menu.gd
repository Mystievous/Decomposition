extends Node2D

@export_file("*.tscn") var level_select: String

func trigger():
	$CanvasLayer.visible = true
	get_tree().paused = true

func unpause():
	$CanvasLayer.visible = false
	get_tree().paused = false
	

func _on_exit_mouse_entered():
	$CanvasLayer/Exit/ExitOutline.visible = true

func _on_exit_mouse_exited():
	$CanvasLayer/Exit/ExitOutline.visible = false

func _on_exit_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("spawn_minion"):
		unpause()
		Transitions.transition_to("res://scenes/level_select.tscn")

func _on_replay_mouse_entered():
	$CanvasLayer/Replay/ReplayOutline.visible = true

func _on_replay_mouse_exited():
	$CanvasLayer/Replay/ReplayOutline.visible = false

func _on_replay_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("spawn_minion"):
		unpause()
		Transitions.transition_to(get_tree().current_scene.scene_file_path)
