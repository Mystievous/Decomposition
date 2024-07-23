extends StaticBody2D

@export var trigger: Node2D

func _ready():
	trigger.triggered.connect(open)

func open():
	queue_free()
