extends Area2D

@export var minions: Node2D
@export var control_labels: Node2D

@export var move_cursor: CompressedTexture2D
@export var summon_cursor: CompressedTexture2D

var minion_load := preload("res://players/minion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(summon_cursor, 0, Vector2(24, 24))
	control_labels.show_summon = true

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(move_cursor, 0, Vector2(24, 24))
	control_labels.show_summon = false

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx):
	if (event.is_action_pressed("spawn_minion")):
		var mouse_pos = minions.get_local_mouse_position()
		
		var minion = minion_load.instantiate()
		minions.add_child(minion)
		minion.position = mouse_pos - Vector2(19, 4)
