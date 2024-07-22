extends CharacterBody2D

@export var sounds: Array[AudioStreamWAV]

@export var sprite: AnimatedSprite2D
@export var interact_damage: float = 5
@export var interact_cooldown := 0.5;
@export var health_bar: Node2D
@export var max_health: float = 100
@export var curr_health: float = max_health

@export var worm_skin: SpriteFrames
@export var millipede_skin: SpriteFrames

var _current_interact_cooldown := 0.0;
var is_in_damage_area = false
var damage_taken: float = 0

const SPEED := 150.0

var current_interactables: Array[Node2D] = []

func _ready():
	health_bar.set_progress(curr_health / max_health)

func _process(delta):
	if (_current_interact_cooldown > 0):
		_current_interact_cooldown = maxf(_current_interact_cooldown - (1 * delta), 0.0)
		
	if Input.is_action_pressed("interact"):
		if (_current_interact_cooldown == 0.0):
			on_interact()
			_current_interact_cooldown += interact_cooldown
		
	#if player is in damage area takes health away
	if is_in_damage_area:
		change_health(damage_taken*delta)

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move:
		velocity = move * SPEED
	else:
		velocity = Vector2(0, 0)
	
	_check_sprite()
	move_and_slide()

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
	if not current_interactables.is_empty():
		var sound: AudioStreamWAV = sounds.pick_random()
		$AudioStreamPlayer2D.stream = sound
		$AudioStreamPlayer2D.play()
		for interactable in current_interactables:
			interactable.interact(interact_damage)

func _on_area_2d_area_entered(area):
	if (area.has_method("interact") && !current_interactables.has(area)):
		current_interactables.append(area)
		
	if (area.has_method("heal") && curr_health < max_health):
		change_health(area.heal_amount)
		area.heal()
		
	if (area.has_method("damage")):
		is_in_damage_area = true
		damage_taken = area.damage_given

func _on_area_2d_area_exited(area):
	if (current_interactables.has(area)):
		current_interactables.erase(area)
		
	if (area.has_method("damage")):
		is_in_damage_area = false
		damage_taken = 0

func _input(event):
	if (event.is_action_pressed("skin_worm")):
		sprite.sprite_frames = worm_skin
		sprite.play()
		_check_sprite()
	if (event.is_action_pressed("skin_millipede")):
		sprite.sprite_frames = millipede_skin
		sprite.play()
		_check_sprite()

func change_health(amount: float):
	curr_health += amount
	if curr_health <= 0:
		#Game over
		pass
	else:
		if curr_health > max_health:
			#prevents health bar over flowing
			health_bar.set_progress(1.0)
			curr_health = max_health
		else:
			health_bar.set_progress(curr_health / max_health);
	pass
