extends Node
class_name CardMove

var card
var cardParent
var currentPosition

func _init(_card, _cardParent, _currentPosition) -> void:
	card = _card
	cardParent = _cardParent
	currentPosition = _currentPosition

func _ready():
	pass