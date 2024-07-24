extends CharacterBody2D

@export var move_vertical = false
@export var damage_amount = 2

var attack_player = null
var player = null

var movement_speed = 45

func _process(delta):
	if attack_player and $Timer.is_stopped():
		#player in range to damage
		attack_player.damage(damage_amount)
		$Timer.start()

func _physics_process(delta):
	if player:
		self.position += ((player.position - self.position)/movement_speed) * delta * 50
	move_and_slide()

func _on_dectetion_area_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_dectetion_area_body_exited(body):
	if body == player:
		player = null

func _on_damage_zone_body_entered(body):
	if body.is_in_group("player"):
		attack_player = player

func _on_damage_zone_body_exited(body):
	if body == attack_player:
		attack_player = null

func damage(amount: float):
	if not $Healthbar.visible:
		$Healthbar.visible = true
	$Healthbar.decrement(amount)

func _on_healthbar_health_empty():
	queue_free()
