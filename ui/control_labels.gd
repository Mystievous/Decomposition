extends Node2D

@export var move_cursor: CompressedTexture2D
@export var summon_cursor: CompressedTexture2D

@export var player: Node2D

@export var show_interact: bool :
	get:
		return $Interact.visible
	set(value):
		$Interact.visible = value
		
@export var show_summon: bool :
	get:
		return $Summon.visible
	set(value):
		$Summon.visible = value
		if (value):
			Input.set_custom_mouse_cursor(summon_cursor, 0, Vector2(24, 24))
		else:
			Input.set_custom_mouse_cursor(move_cursor, 0, Vector2(24, 24))
		
func _ready():
	$Summon.visible = show_summon
	$Interact.visible = show_interact
	player.interact_change.connect(interact_change)

func interact_change(state):
	show_interact = state
