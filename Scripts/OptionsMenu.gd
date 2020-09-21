extends Control

onready var queens_on_kings = $MarginContainer/VBoxContainer/ToggleContainer/QueensOnKingsToggle
onready var turn_corner = $MarginContainer/VBoxContainer/ToggleContainer/TurnCornerToggle
onready var jokers = $MarginContainer/VBoxContainer/ToggleContainer/JokersToggle
onready var empty_foundation = $MarginContainer/VBoxContainer/ToggleContainer/EmptyFoundationToggle
onready var play_sfx = $MarginContainer/VBoxContainer/ToggleContainer/PlaySoundEffectsToggle

func _ready():

	queens_on_kings.pressed = Settings.get_setting("variations", "queens_on_kings")
	turn_corner.pressed = Settings.get_setting("variations", "turn_corners")
	jokers.pressed = Settings.get_setting("variations", "jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("variations", "empty_foundation")
	play_sfx.pressed = Settings.get_setting("sound", "play_sfx")

func load_options():
	queens_on_kings.pressed = Settings.get_setting("variations", "queens_on_kings")
	turn_corner.pressed = Settings.get_setting("variations", "turn_corners")
	jokers.pressed = Settings.get_setting("variations", "jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("variations", "empty_foundation")
	play_sfx.pressed = Settings.get_setting("sound", "play_sfx")

func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_QueensOnKingsToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("variations", "queens_on_kings", button_pressed)


func _on_TurnCornerToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("variations", "turn_corners", button_pressed)


func _on_JokersToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("variations", "jokers_wildcard", button_pressed)


func _on_EmptyFoundationToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("variations", "empty_foundation", button_pressed)


func _on_PlaySoundEffectsToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("sound", "play_sfx", button_pressed)
