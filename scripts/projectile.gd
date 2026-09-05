extends Area2D

@export var speed: float = 250.0
@onready var despawn_timer: Timer = $DespawnTimer

var direction: Vector2 = Vector2.LEFT

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	despawn_timer.timeout.connect(_on_despawn_timeout)
	despawn_timer.start()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die_and_respawn"):
		body.die_and_respawn()
		queue_free()
		return

	if body is TileMapLayer:
		var local_pos: Vector2 = body.to_local(global_position)
		var tile_coords: Vector2i = body.local_to_map(local_pos)
		var tile_data: TileData = body.get_cell_tile_data(tile_coords)
		
		if tile_data and tile_data.get_custom_data("destroys_projectiles"):
			queue_free()

	elif body is TileMap:
		var local_pos: Vector2 = body.to_local(global_position)
		for layer in range(body.get_layers_count()):
			var tile_coords: Vector2i = body.local_to_map(local_pos)
			var tile_data: TileData = body.get_cell_tile_data(layer, tile_coords)
			if tile_data and tile_data.get_custom_data("destroys_projectiles"):
				queue_free()
				break

func _on_despawn_timeout() -> void:
	queue_free()
