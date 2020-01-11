extends Node2D

# onready
onready var cardHolder = $Cards
onready var tween = $Tween
onready var board = get_parent()

# signals
signal check_win

func _ready():
	pass

func get_top_card():
	var cards_count = cardHolder.get_child_count()
	var top_card = cardHolder.get_child(cards_count - 1)
	
	return top_card
	
func move_card_to_waste_pile(card, play_tween = true, play_flip = false):
	var parent = card.get_parent()
	parent.remove_child(card)
	cardHolder.add_child(card)
	card.set_owner(cardHolder)
	if play_tween:
		tween.interpolate_property(card, "position", card.position, cardHolder.get_parent().position, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		tween.start()
	elif play_flip:
		tween.interpolate_property(card, "position", parent.get_parent().position, cardHolder.get_parent().position, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		tween.start()
		#card.position = cardHolder.get_parent().position

	else:
		card.position = cardHolder.get_parent().position
	var cardButton = card.get_node("Button")
	cardButton.disabled = true
	emit_signal("check_win")