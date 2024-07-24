extends Area2D

@export var required_bodies: int = 5

signal triggered

var bodies: Array[Node]
var is_active = false

func _ready():
	refresh_bodies()

func refresh_bodies():
	$AnimatedSprite2D.frame = maxi(required_bodies - bodies.size(), 0)
	if is_active:
		return
	if (bodies.size() >= required_bodies):
		triggered.emit()
		is_active = true

func _on_body_entered(body):
	if not bodies.has(body):
		bodies.append(body)
		refresh_bodies()
	
func _on_body_exited(body):
	bodies.erase(body)
	refresh_bodies()
