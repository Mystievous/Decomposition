extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var damage: float = 5
@export var attack_cooldown := 1.0;

var _current_attack_cooldown := 0.0;

const SPEED := 150.0

var current_interactables: Array[Node2D] = []

func _process(delta):
	if (_current_attack_cooldown > 0):
		_current_attack_cooldown = maxf(_current_attack_cooldown - (1 * delta), 0.0)
	pass

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move:
		velocity = move * SPEED
	else:
		velocity = Vector2(0, 0)
	
	_check_flip()
	move_and_slide()

func _check_flip():
	if (velocity.x != 0):
		if (velocity.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false

func _input(event):
	if event.is_action_pressed("interact"):
		if (_current_attack_cooldown == 0.0):
			on_interact()
			_current_attack_cooldown += attack_cooldown

func on_interact():
	for interactable in current_interactables:
		interactable.interact(damage)

func _on_area_2d_area_entered(area):
	if (area.has_method("interact") && !current_interactables.has(area)):
		current_interactables.append(area)

func _on_area_2d_area_exited(area):
	if (current_interactables.has(area)):
		current_interactables.erase(area)
