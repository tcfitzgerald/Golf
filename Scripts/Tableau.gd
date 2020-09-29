extends Node2D

# onready
onready var cards = $Cards
onready var wastePile = get_parent().get_node("WastePile")
onready var board = get_parent()
onready var tween = $Tween
onready var audioPlayer = $AudioStreamPlayer
var cardScene = preload("res://Scenes/Card.tscn")
var cardMove = preload("res://Scripts/Move.gd")

func _ready():
	cards.connect("card_clicked", self, "_on_tableau_card_clicked")

func has_cards():
	return cards.get_child_count() > 0

func get_card_count():
	return cards.get_child_count()

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
		
		if not wasteCard:
			play_audio()
			var move = CardMove.new(card, card.get_parent(), card.position)
			board.moves.append(move)
			wastePile.move_card_to_waste_pile(card)
			var current_score = 0
			for tableau in board.tableaus:
				current_score += tableau.get_card_count()
			board.set_score(current_score)
			return
			
		if (card.int_value == 0 or wasteCard.int_value == 0):
			play_audio()
			var move = CardMove.new(card, card.get_parent(), card.position)
			board.moves.append(move)
			wastePile.move_card_to_waste_pile(card)
			
		var cardMinusOne = wasteCard.int_value - 1
		var cardPlusOne = wasteCard.int_value + 1
		if wasteCard.int_value == 13 and (Settings.allow_queens_on_kings == false or Settings.turn_corners == false):
			return
		
		if Settings.turn_corners == true:
				if (card.int_value == 1 and wasteCard.int_value == 13 or 
				card.int_value == 13 and wasteCard.int_value == 1):
					play_audio()
					var move = CardMove.new(card, card.get_parent(), card.position)
					board.moves.append(move)
					wastePile.move_card_to_waste_pile(card)
		
		if card.int_value == cardMinusOne or card.int_value == cardPlusOne:
			play_audio()
			var move = CardMove.new(card, card.get_parent(), card.position)
			board.moves.append(move)
			wastePile.move_card_to_waste_pile(card)
		

		board.check_game_over()
		
	var current_score = 0
	for tableau in board.tableaus:
		current_score += tableau.get_card_count()
	board.set_score(current_score)

func play_audio():
	if Settings.play_sfx == true:
		audioPlayer.play()
