extends Node

signal skin_changed

var selected_skin: SkinResource = load("res://globals/skins/worm_skin.tres") :
	set(value):
		if (selected_skin != value):
			selected_skin = value
			skin_changed.emit()
	get:
		return selected_skin
