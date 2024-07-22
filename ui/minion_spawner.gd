extends Node2D

var minion_load := preload("res://players/minion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event.is_action_pressed("spawn_minion")):
		var minion_position: Vector2 = Vector2(0, 0)
		if event is InputEventMouseButton:
			minion_position = get_local_mouse_position()
		
		var minion = minion_load.instantiate()
		add_child(minion)
		minion.position = minion_position - Vector2(19, 4)
		pass
