extends Node2D

# onready
onready var cards = $Cards
onready var wastePile = get_parent().get_node("WastePile")
onready var board = get_parent()
onready var tween = $Tween
var cardScene = preload("res://Scenes/Card.tscn")
var cardMove = preload("res://Scripts/Move.gd")

func _ready():
	get_node("Cards").connect("card_clicked", self, "_on_tableau_card_clicked")

func has_cards():
	return cards.get_child_count() > 0

func add_card_to_tableau(selected_card, card_offset, duration = 1):
	cards.add_child(selected_card)
	selected_card.set_owner(cards)
	tween.interpolate_property(selected_card, "position", selected_card.position, 
			Vector2(cards.get_parent().position.x, cards.get_parent().position.y + card_offset), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	#selected_card.position = cards.get_parent().position
	#selected_card.position.y += card_offset
	var cardButton = selected_card.get_node("Button")
	selected_card.connect("card_clicked", self, "_on_tableau_card_clicked")
	cardButton.disabled = false

func is_top_tableau_card(card):
	var tableau_children_count = cards.get_child_count()
	return (card == cards.get_child(tableau_children_count - 1))

func get_top_tableau_card():
	var tableau_children_count = cards.get_child_count()
	return cards.get_child(tableau_children_count - 1)

func _on_tableau_card_clicked(card):
	if is_top_tableau_card(card):
		var wasteCard = wastePile.get_top_card()
		var cardMinusOne = wasteCard.int_value - 1
		var cardPlusOne = wasteCard.int_value + 1
		if wasteCard.int_value == 13:
			return
			
		if card.int_value == cardMinusOne or card.int_value == cardPlusOne:
			var move = CardMove.new(card, card.get_parent(), card.position)
			board.moves.append(move)
			wastePile.move_card_to_waste_pile(card)
			
		board.check_game_over()
