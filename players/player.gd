extends CharacterBody2D

@export var sounds: Array[AudioStreamWAV]

@export var sprite: AnimatedSprite2D
@export var interact_damage: float = 5

@export var worm_skin: SkinResource
@export var millipede_skin: SkinResource

var movement_speed := 150.0

var current_interactables: Array[Node2D] = []

signal interact_change(state)

func _ready():
	SelectedSkin.skin_changed.connect(_skin_changed)
	$Healthbar.visible = false
	_skin_changed()

func _process(delta):
	if Input.is_action_pressed("interact"):
		if ($Timer.is_stopped()):
			on_interact()
			$Timer.start()

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x = Input.get_axis("move_left", "move_right")
	var y = Input.get_axis("move_up", "move_down")
	var move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move:
		if (absf(x) < 0.025): 
			move.x = 0.0
		if (absf(y) < 0.025): 
			move.y = 0.0
		velocity = move * movement_speed
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

func eat_sound():
	var sound: AudioStreamWAV = sounds.pick_random()
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()

func on_interact():
	if not current_interactables.is_empty():
		for interactable in current_interactables:
			interactable.interact(self)

func damage(amount: float):
	if not $Healthbar.visible:
		$Healthbar.visible = true
	$Healthbar.decrement(amount)

func heal(amount: float) -> bool:
	if not $Healthbar.is_max_health():
		$Healthbar.increment(amount)
		return true
	return false

func _on_area_2d_area_entered(area):
	if (area.has_method("interact") && !current_interactables.has(area)):
		if (current_interactables.is_empty()):
			interact_change.emit(true)
		current_interactables.append(area)
		if (area.has_method("set_outline")):
			area.set_outline(true)

func _on_area_2d_area_exited(area):
	current_interactables.erase(area)
	if (current_interactables.is_empty()):
		interact_change.emit(false)
	if (area.has_method("set_outline")):
		area.set_outline(false)

func _input(event):
	if (event.is_action_pressed("skin_worm")):
		SelectedSkin.selected_skin = worm_skin
	if (event.is_action_pressed("skin_millipede")):
		SelectedSkin.selected_skin = millipede_skin
		
func _skin_changed():
	var health_percent: float = $Healthbar.percent_health
	var skin: SkinResource = SelectedSkin.selected_skin
	sprite.sprite_frames = skin.player_sprite
	sprite.play()
	_check_sprite()
	$Healthbar.set_max_health(skin.stats.player_health)
	movement_speed = skin.stats.player_speed
	interact_damage = skin.stats.player_damage
	$Healthbar.percent_health = health_percent

func _on_healthbar_health_empty():
	queue_free()
	get_tree().get_first_node_in_group("lose_menu").trigger()
	#Transitions.transition_to("res://scenes/level_select.tscn")
