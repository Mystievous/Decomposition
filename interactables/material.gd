extends Area2D

@export var max_health: float = 30
@export var curr_health: float = max_health
@export var progress_bar: Node2D

func _ready():
	progress_bar.visible = false

func interact(node: Node2D):
	node.eat_sound()
	$Healthbar.decrement(node.interact_damage)

func _on_healthbar_health_empty():
	queue_free()
