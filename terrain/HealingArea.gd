extends Area2D

@export var heal_amount: float = 25

func _on_body_entered(body):
	if body.has_method("heal") and body.heal(heal_amount):
		queue_free();
