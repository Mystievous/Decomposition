extends Area2D

@export var health: float = 30
@export var progress_bar: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(damage: float):
	health -= damage
	if (health <= 0):
		queue_free()
	progress_bar.set_progress(health / 30);
	pass
