extends Area2D

@export var damage_given: float = 40
var damage_nodes: Array[Node2D] = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in damage_nodes:
		node.damage(damage_given * delta)

func _on_body_entered(body):
	if body.has_method("damage"):
		damage_nodes.append(body)

func _on_body_exited(body):
	damage_nodes.erase(body)
