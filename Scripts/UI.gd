extends Control



func _ready():
	pass

func _on_NewGameButton_pressed() -> void:
	emit_signal("new_game")
