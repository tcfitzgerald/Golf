extends Control

onready var queens_on_kings = $MarginContainer/VBoxContainer/ToggleContainer/QueensOnKingsToggle
onready var turn_corner = $MarginContainer/VBoxContainer/ToggleContainer/TurnCornerToggle
onready var jokers = $MarginContainer/VBoxContainer/ToggleContainer/JokersToggle
onready var empty_foundation = $MarginContainer/VBoxContainer/ToggleContainer/EmptyFoundationToggle
onready var play_sfx = $MarginContainer/VBoxContainer/ToggleContainer/PlaySoundEffectsToggle
onready var collect_data = $MarginContainer/VBoxContainer/ToggleContainer/DataCollectionToggle

func _ready():

	queens_on_kings.pressed = Settings.get_setting("variations", "queens_on_kings")
	turn_corner.pressed = Settings.get_setting("variations", "turn_corners")
	jokers.pressed = Settings.get_setting("variations", "jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("variations", "empty_foundation")
	play_sfx.pressed = Settings.get_setting("sound", "play_sfx")
	collect_data.pressed = Settings.get_setting("data", "collect_data")

func load_options():
	queens_on_kings.pressed = Settings.get_setting("variations", "queens_on_kings")
	turn_corner.pressed = Settings.get_setting("variations", "turn_corners")
	jokers.pressed = Settings.get_setting("variations", "jokers_wildcard")
	empty_foundation.pressed = Settings.get_setting("variations", "empty_foundation")
	play_sfx.pressed = Settings.get_setting("sound", "play_sfx")
	collect_data.pressed = Settings.get_setting("data", "collect_data")

func _on_MainMenuButton_pressed() -> void:
# warning-ignore:return_value_discarded
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


func _on_DataCollectionToggle_toggled(button_pressed: bool) -> void:
	Settings.save_setting("data", "collect_data", button_pressed)
