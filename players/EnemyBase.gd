extends CharacterBody2D

@export var move_vertical = false
@export var damage_distance = 5
@export var damage_amount = 5

var player_dectected = false
var player = null

var movement_speed = 5
var vel_x = 0
var vel_y = 0
var flip_direction = false

func _ready():
	if move_vertical:
		vel_y = movement_speed
	else:
		vel_x = movement_speed

func _process(delta):
	if player_dectected:
		if (player.has_method("damage")) and ($Timer.is_stopped()) and ((player.position - self.position).length() < damage_distance):
			#player in range to damage
			player.damage(damage_amount)
			$Timer.start()

func _physics_process(_delta):
	if player_dectected:
		self.position += (player.position - self.position)/(movement_speed*10)
	else:
		if move_vertical:
			vel_y = vel_y if !flip_direction else -1*vel_y
		else:
			vel_x = vel_x if !flip_direction else -1*vel_x

		var move = Vector2(vel_x, vel_y)
		velocity = move * movement_speed
		
		move_and_slide()


func _on_dectetion_area_body_entered(body):
	player = body
	player_dectected = true

func _on_dectetion_area_body_exited(body):
	player = null
	player_dectected = false

#TODO add enemy flip on contact with static2d
func _on_dectetion_area_area_entered(area):
	if area.is_in_group("damage_area"):
		flip_direction = true

func _on_dectetion_area_area_exited(area):
	if flip_direction:
		flip_direction = false
