extends Control

func _ready():
	pass


func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
