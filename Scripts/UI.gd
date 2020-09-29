extends Control

onready var scoreLabel = $MarginContainer/VBoxContainer/BoardScoreLabel
onready var timeLabel = $MarginContainer/VBoxContainer/BoardScoreLabel

signal new_game

func _ready():
	pass

func _on_NewGameButton_pressed() -> void:
	emit_signal("new_game")
