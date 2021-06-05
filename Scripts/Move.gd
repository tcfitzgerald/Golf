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

func to_json():
	return {"int_value": card.int_value, "suit": card.suit, "face": card.face_value, "parent": card.get_parent().get_parent().name}
