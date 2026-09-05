extends Node2D

@export var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")

@onready var muzzle: Marker2D = $Muzzle
@onready var shoot_timer: Timer = $ShootTimer

@export var fire_direction: Vector2 = Vector2.LEFT

func _ready() -> void:
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)

func _on_shoot_timer_timeout() -> void:
	
	var rot: int = wrapi(roundi(global_rotation_degrees), 0, 360)

	if rot == 0:
		fire_direction = Vector2.DOWN
	elif rot == 90:
		fire_direction = Vector2.LEFT
	elif rot == 180:
		fire_direction = Vector2.UP
	elif rot == 270:
		fire_direction = Vector2.RIGHT

	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
		
		projectile.global_position = muzzle.global_position
		projectile.direction = fire_direction.normalized()
