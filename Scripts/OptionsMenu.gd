extends Control

onready var queens_on_kings = $MarginContainer/VBoxContainer/ToggleContainer/QueensOnKingsToggle
onready var turn_corner = $MarginContainer/VBoxContainer/ToggleContainer/TurnCornerToggle
onready var jokers = $MarginContainer/VBoxContainer/ToggleContainer/JokersToggle
onready var empty_foundation = $MarginContainer/VBoxContainer/ToggleContainer/EmptyFoundationToggle


func _ready():

	queens_on_kings.pressed = Settings.get_setting("queens_on_kings")
	turn_corner.pressed = Settings.get_setting("turn_corners")
	jokers.pressed = Settings.get_setting("jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("empty_foundation")

func load_options():
	queens_on_kings.pressed = Settings.get_setting("queens_on_kings")
	turn_corner.pressed = Settings.get_setting("turn_corners")
	jokers.pressed = Settings.get_setting("jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("empty_foundation")	

func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_QueensOnKingsToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("queens_on_kings", button_pressed)


func _on_TurnCornerToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("turn_corners", button_pressed)


func _on_JokersToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("jokers_wildcard", button_pressed)


func _on_EmptyFoundationToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("empty_foundation", button_pressed)
