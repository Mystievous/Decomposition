extends Node

var total_levels = 5
var current_level = 1
var avaible_levels: Array[bool]

func _ready():
	for i in range(total_levels):
		avaible_levels.append(false)
	avaible_levels[0] = true
