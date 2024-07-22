extends CharacterBody2D

@export var sounds: Array[AudioStreamWAV]

@export var sprite: AnimatedSprite2D
@export var navigation_agent: NavigationAgent2D
@export var interact_damage: float = 5
@export var interact_cooldown := 0.5;

var _current_interact_cooldown := 0.0;

const SPEED := 75

var current_interactables: Array[Node2D] = []

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	#refresh_target()
	
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
	if (_current_interact_cooldown > 0):
		_current_interact_cooldown = maxf(_current_interact_cooldown - (1 * delta), 0.0)
	
	if current_interactables.is_empty():
		refresh_target()
	elif (_current_interact_cooldown == 0.0 and !current_interactables.is_empty()):
		on_interact()
		_current_interact_cooldown += interact_cooldown

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		velocity = Vector2(0, 0)
		_check_sprite()
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var move = current_agent_position.direction_to(next_path_position)
	navigation_agent.velocity = move * SPEED

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

func on_interact():
	var sound: AudioStreamWAV = sounds.pick_random()
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()
	for interactable in current_interactables:
		interactable.interact(interact_damage)

func _on_area_2d_area_entered(area):
	if (area.has_method("interact") && !current_interactables.has(area)):
		current_interactables.append(area)

func _on_area_2d_area_exited(area):
	if (current_interactables.has(area)):
		current_interactables.erase(area)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	
	_check_sprite()
	move_and_slide()
