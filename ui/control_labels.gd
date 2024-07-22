extends Node2D

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
		
func _ready():
	$Summon.visible = show_summon
	$Interact.visible = show_interact
	player.interact_change.connect(interact_change)

func interact_change(state):
	show_interact = state
