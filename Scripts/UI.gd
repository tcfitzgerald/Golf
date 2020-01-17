extends Control

onready var scoreLabel = $MarginContainer/VBoxContainer/ScoreLabel

signal new_game

func _ready():
	pass

func _on_NewGameButton_pressed() -> void:
	emit_signal("new_game")
