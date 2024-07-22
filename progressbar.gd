extends Node2D

@export var fill: Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Takes in float 0-1 of progress percentage
func set_progress(progress: float):
	visible = true
	if (fill):
		fill.scale.x = progress