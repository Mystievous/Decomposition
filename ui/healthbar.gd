extends Node2D

@export var max_health: float = 100
var curr_health: float = max_health

var percent_health: float :
	get:
		return curr_health / max_health
	set(value):
		curr_health = max_health * value
		_refresh_health()

signal health_empty

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_health = max_health
	_refresh_health()

func set_max_health(amount: float):
	max_health = amount
	_refresh_health()

func is_max_health() -> bool:
	return curr_health >= max_health

func increment(amount: float):
	curr_health = minf(curr_health + amount, max_health)
	_refresh_health()
	
func decrement(amount: float):
	curr_health -= amount
	if curr_health <= 0:
		health_empty.emit()
	_refresh_health()
	
func _refresh_health():
	_set_progress(curr_health / max_health)

# Takes in float 0-1 of progress percentage
func _set_progress(progress: float):
	#visible = true
	$Polygon2D.scale.x = progress
