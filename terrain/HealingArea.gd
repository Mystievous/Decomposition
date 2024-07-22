extends Area2D

@export var heal_amount: float = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Removes Healing area to increase diffcult
func heal():
	queue_free()
	pass
