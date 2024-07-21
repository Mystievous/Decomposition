extends CharacterBody2D

@export var sprite: AnimatedSprite2D

const SPEED := 150.0

var current_interactable: Node2D

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
		on_interact()

func on_interact():
	if (current_interactable):
		current_interactable.interact()

func _on_area_2d_area_entered(area):
	if (area.has_method("interact")):
		current_interactable = area

func _on_area_2d_area_exited(area):
	if (current_interactable == area):
		current_interactable = null
