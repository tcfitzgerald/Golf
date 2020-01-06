extends Node2D

# onready
onready var cardHolder = $Cards

# signals


func _ready():
	pass

func get_top_card():
	var cards_count = cardHolder.get_child_count()
	var top_card = cardHolder.get_child(cards_count - 1)
	
	return top_card
	
func move_card_to_waste_pile(card):
	var parent = card.get_parent()
	parent.remove_child(card)
	cardHolder.add_child(card)
	card.set_owner(cardHolder)
	card.position = cardHolder.get_parent().position
	card.stack = cardHolder
	var cardButton = card.get_node("Button")
	cardButton.disabled = true