extends Area2D

# Customizable launch force in the Inspector
@export var bounce_force: float = -600.0

@onready var animated_sprite: Sprite2D = $Sprite2D
@onready var jump_sfx = $AudioStreamPlayer


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	jump_sfx.play()
	if "velocity" in body:
		
		body.velocity.y = bounce_force
		
		
