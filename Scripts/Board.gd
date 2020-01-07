extends Control

# onready
onready var deck = $Deck
onready var deckCards = $Deck/Cards
onready var tableau1 = $Tableau1
onready var tableau2 = $Tableau2
onready var tableau3 = $Tableau3
onready var tableau4 = $Tableau4
onready var tableau5 = $Tableau5
onready var tableau6 = $Tableau6
onready var tableau7 = $Tableau7

onready var wastePile = $WastePile
onready var deckButton = $TextureButton

var card_offset = 30
var tableau_count = 7
var cards_per_tableau = 5
var score = 35

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deal_cards()
	
func deal_cards():
	var tableaus = [tableau1, tableau2, tableau3, tableau4, tableau5, tableau6, tableau7]
	# loop through deck and re-parent cards
	for tableau in tableaus:
		for j in cards_per_tableau:
			var selected_card = deck.get_top_card()
			deckCards.remove_child(selected_card)
			tableau.add_card_to_tableau(selected_card, j * card_offset)

			
	var last_card = deck.get_top_card()
	wastePile.move_card_to_waste_pile(last_card, false)

func refresh_waste_pile():
	if deckCards.get_child_count() > 0:
		var card = deck.get_top_card()
		wastePile.move_card_to_waste_pile(card, false, true)
		

func _on_TextureButton_pressed() -> void:
	refresh_waste_pile()
	if deckCards.get_child_count() == 0:
		deckButton.hide()
		check_game_over()

func check_valid_moves():
	var tableaus = [tableau1, tableau2, tableau3, tableau4, tableau5, tableau6, tableau7]
	for tableau in tableaus:
		if tableau.has_cards():
			var top_card = tableau.get_top_tableau_card()
			var wasteCard = wastePile.get_top_card()
			var cardMinusOne = wasteCard.int_value - 1
			var cardPlusOne = wasteCard.int_value + 1
			if wasteCard.int_value == 13:
				return false
			
			if top_card.int_value == cardMinusOne or top_card.int_value == cardPlusOne:
				return top_card

func check_game_over():
	# is the deck empty?
	if deckCards.get_child_count() == 0:
		# go through tableaus to see if any of the last cards can be used
		if check_valid_moves():
			pass
		else:
			print("game over")	
	
	
	