extends CharacterBody2D

@export var sounds: Array[AudioStreamWAV]

@export var sprite: AnimatedSprite2D
@export var navigation_agent: NavigationAgent2D
@export var interact_damage: float = 5

var movement_speed := 75

var current_interactables: Array[Node2D] = []

func _ready():
	$Healthbar.visible = false
	SelectedSkin.skin_changed.connect(_skin_changed)
	_skin_changed()
	
func refresh_target():
	var interactions := get_tree().get_nodes_in_group("minion_interact")
	var closest = null
	var closest_distance = null
	for interaction in interactions:
		var distance := position.distance_squared_to(interaction.position)
		if not closest_distance or distance < closest_distance:
			closest = interaction
			closest_distance = distance
	if (closest):
		navigation_agent.target_position = closest.position

func _process(delta):
	if current_interactables.is_empty():
		refresh_target()
	elif ($Timer.is_stopped() and !current_interactables.is_empty()):
		on_interact()
		$Timer.start()

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		navigation_agent.velocity = Vector2(0, 0)
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var move = current_agent_position.direction_to(next_path_position)
	navigation_agent.velocity = move * movement_speed

func _check_sprite():
	var is_moving := velocity.length_squared() > 0
	if (is_moving):
		if (velocity.x != 0):
			if (velocity.x < 0):
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		if (sprite.animation != "walk"):
			sprite.play("walk")
			sprite.set_frame_and_progress(0, 1)
	else:
		if (sprite.animation != "idle"):
			sprite.play("idle")

func _skin_changed():
	#var health_percent: float = $Healthbar.percent_health
	var skin: SkinResource = SelectedSkin.selected_skin
	sprite.sprite_frames = skin.minion_sprite
	sprite.play()
	_check_sprite()
	#$Healthbar.set_max_health(skin.stats.minion_health)
	movement_speed = skin.stats.minion_speed
	interact_damage = skin.stats.minion_damage
	#$Healthbar.percent_health = health_percent

func eat_sound():
	var sound: AudioStreamWAV = sounds.pick_random()
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()

func on_interact():
	for interactable in current_interactables:
		interactable.interact(self)
		
func damage(amount):
	$Healthbar.decrement(amount)

func _on_area_2d_area_entered(area):
	if (area.is_in_group("minion_interact") && !current_interactables.has(area)):
		current_interactables.append(area)

func _on_area_2d_area_exited(area):
	current_interactables.erase(area)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	
	_check_sprite()
	move_and_slide()
