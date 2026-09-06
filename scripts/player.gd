extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var spawn_position: Vector2 = global_position
@onready var death_sfx = $"../AudioStreamPlayer"
@onready var checkpoint_sfx = $"../AudioStreamPlayer2"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation(direction)

func update_animation(direction: float) -> void:
	if direction > 0:
		animated_sprite.flip_h = true
	elif direction < 0:
		animated_sprite.flip_h = false

	if direction != 0:
		animated_sprite.play("Move")
	else:
		animated_sprite.play("Idle")
		
func set_checkpoint(new_position: Vector2) -> void:
	spawn_position = new_position
	print("New checkpoint set at: ", spawn_position)
	checkpoint_sfx.play()

func die_and_respawn() -> void:
	death_sfx.play()
	global_position = spawn_position
	velocity = Vector2.ZERO
