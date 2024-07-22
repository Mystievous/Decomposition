extends Node2D

var minion_load := preload("res://players/minion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("spawn_minion")):
		var minion_position: Vector2 = Vector2(0, 0)
		minion_position = get_local_mouse_position()
		
		var minion = minion_load.instantiate()
		add_child(minion)
		minion.position = minion_position - Vector2(19, 4)
