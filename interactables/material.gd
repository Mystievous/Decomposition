extends Area2D

@export var progress_bar: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	#queue_free()
	progress_bar.set_progress(0.5)
	pass
