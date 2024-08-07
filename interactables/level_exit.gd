extends Area2D

@export_file("*.tscn") var scene: String = "res://scenes/level_select.tscn"
@export var level_number: int = 0

var active := false
var outlined := false

func _ready():
	$Exit.modulate = Color(1, 1, 1, 0)

func _process(delta):
	if not $Timer.is_stopped():
		var timer_percentage: float = 1 - ($Timer.time_left / $Timer.wait_time)
		$Exit.modulate = Color(1, 1, 1, timer_percentage)

func interact(_node):
	if active:
		Transitions.transition_to(scene)
		if LevelProgress.current_level < LevelProgress.total_levels and LevelProgress.current_level == level_number:
			LevelProgress.avaible_levels[LevelProgress.current_level] = true
			LevelProgress.current_level += 1
		active = false

func set_outline(enabled: bool):
	outlined = enabled
	check_outline()

func check_outline():
	$Outline.visible = active && outlined

func _on_timer_timeout():
	active = true
	check_outline()

func activate():
	$Timer.start()
