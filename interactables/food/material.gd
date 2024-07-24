extends Area2D

@export var max_health: float = 30
@export var curr_health: float = max_health
@export var progress_bar: Node2D

func _ready():
	progress_bar.visible = false

func interact(node: Node2D):
	node.eat_sound()
	if not $Healthbar.visible:
		$Healthbar.visible = true
	$Healthbar.decrement(node.interact_damage)

func _on_healthbar_health_empty():
	var size = get_parent().get_children().size()
	if (size == 1):
		var background := get_tree().get_first_node_in_group("background")
		background.trigger()
	queue_free()

func set_outline(enabled: bool):
	$Outline.visible = enabled
