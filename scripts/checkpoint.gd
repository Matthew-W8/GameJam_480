extends Area2D

@onready var animated_sprite: Sprite2D = $Sprite2D
var is_activated: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_checkpoint") and not is_activated:
		is_activated = true
		
		body.set_checkpoint(global_position)
