extends CanvasLayer

@onready var restart_button: Button = $Control/Button
@onready var quit_button: Button = $Control/Button2

func _ready() -> void:
	hide()
	restart_button.pressed.connect(_on_restart_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func show_game_over() -> void:
	show()
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
