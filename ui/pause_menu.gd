extends Node2D

@export_file("*.tscn") var level_select: String

func toggle_pause():
	var paused = !get_tree().paused
	$CanvasLayer.visible = paused
	get_tree().paused = paused

func _input(event):
	if (event.is_action_pressed("pause")):
		if not Transitions.transitioning:
			toggle_pause()

func _on_pause_mouse_entered():
	$CanvasLayer/Pause/PauseOutline.visible = true

func _on_pause_mouse_exited():
	$CanvasLayer/Pause/PauseOutline.visible = false

func _on_pause_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("spawn_minion"):
		toggle_pause()

func _on_exit_mouse_entered():
	$CanvasLayer/Exit/ExitOutline.visible = true

func _on_exit_mouse_exited():
	$CanvasLayer/Exit/ExitOutline.visible = false

func _on_exit_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("spawn_minion"):
		toggle_pause()
		Transitions.transition_to("res://scenes/level_select.tscn")

func _on_replay_mouse_entered():
	$CanvasLayer/Replay/ReplayOutline.visible = true

func _on_replay_mouse_exited():
	$CanvasLayer/Replay/ReplayOutline.visible = false

func _on_replay_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("spawn_minion"):
		toggle_pause()
		Transitions.transition_to(get_tree().current_scene.scene_file_path)
