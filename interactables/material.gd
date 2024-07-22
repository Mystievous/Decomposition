extends Area2D

@export var max_health: float = 30
@export var curr_health: float = max_health
@export var progress_bar: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(node: Node2D):
	node.eat_sound()
	curr_health -= node.interact_damage
	if (curr_health <= 0):
		queue_free()
	progress_bar.set_progress(curr_health / max_health);
	pass
