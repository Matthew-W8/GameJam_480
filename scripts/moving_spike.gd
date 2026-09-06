extends Area2D

@export var speed: float = 50.0
@export var move_direction: Vector2 = Vector2.DOWN

@onready var ray_cast: RayCast2D = $RayCast2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

	_set_direction_from_rotation()
	_update_raycast()

func _physics_process(delta: float) -> void:
	if ray_cast.is_colliding():
		move_direction = -move_direction
		_update_raycast()

	global_position += move_direction.normalized() * speed * delta

func _set_direction_from_rotation() -> void:
	var rot: int = wrapi(roundi(global_rotation_degrees), 0, 360)

	if rot == 0:
		move_direction = Vector2.DOWN
	elif rot == 90:
		move_direction = Vector2.LEFT
	elif rot == 180:
		move_direction = Vector2.UP
	elif rot == 270:
		move_direction = Vector2.RIGHT

func _update_raycast() -> void:
	ray_cast.target_position = move_direction.normalized() * 20.0
	ray_cast.force_raycast_update()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die_and_respawn"):
		body.die_and_respawn()
