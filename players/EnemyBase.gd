extends CharacterBody2D

@export var move_vertical = false
@export var damage_amount = 5

var player_dectected = false
var player = null

var movement_speed = 45

func _physics_process(_delta):
	if player_dectected:
		self.position += (player.position - self.position)/movement_speed

func _on_dectetion_area_body_entered(body):
	player = body
	player_dectected = true

func _on_dectetion_area_body_exited(body):
	player = null
	player_dectected = false

func _on_damage_zone_body_entered(body):
	if player_dectected and $Timer.is_stopped():
		if player.has_method("damage"):
			#player in range to damage
			player.damage(damage_amount)
			$Timer.start()

func damage(amount: float):
	if not $Healthbar.visible:
		$Healthbar.visible = true
	$Healthbar.decrement(amount)

func _on_healthbar_health_empty():
	queue_free()
