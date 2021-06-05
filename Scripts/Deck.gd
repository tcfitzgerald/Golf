extends Node2D
class_name Deck
# onready
onready var cardHolder = $Cards

# preload
var cardScene = preload("res://Scenes/Card.tscn")

# signals
# warning-ignore:unused_signal
signal top_card_clicked

var cards = [
{"int_value": 13, "suit": "Spades", "face": "King", "texture": "cardSpadesK.png"},
{"int_value": 12, "suit": "Spades", "face": "Queen", "texture": "cardSpadesQ.png"},
{"int_value": 11, "suit": "Spades", "face": "Jack", "texture": "cardSpadesJ.png"},
{"int_value": 10, "suit": "Spades", "face": "Ten", "texture": "cardSpades10.png"},
{"int_value": 9, "suit": "Spades", "face": "Nine", "texture": "cardSpades9.png"},
{"int_value": 8, "suit": "Spades", "face": "Eight", "texture": "cardSpades8.png"},
{"int_value": 7, "suit": "Spades", "face": "Seven", "texture": "cardSpades7.png"},
{"int_value": 6, "suit": "Spades", "face": "Six", "texture": "cardSpades6.png"},
{"int_value": 5, "suit": "Spades", "face": "Five", "texture": "cardSpades5.png"},
{"int_value": 4, "suit": "Spades", "face": "Four", "texture": "cardSpades4.png"},
{"int_value": 3, "suit": "Spades", "face": "Three", "texture": "cardSpades3.png"},
{"int_value": 2, "suit": "Spades", "face": "Two", "texture": "cardSpades2.png"},
{"int_value": 1, "suit": "Spades", "face": "Ace", "texture": "cardSpadesA.png"},
{"int_value": 13, "suit": "Hearts", "face": "King", "texture": "cardHeartsK.png"},
{"int_value": 12, "suit": "Hearts", "face": "Queen", "texture": "cardHeartsQ.png"},
{"int_value": 11, "suit": "Hearts", "face": "Jack", "texture": "cardHeartsJ.png"},
{"int_value": 10, "suit": "Hearts", "face": "Ten", "texture": "cardHearts10.png"},
{"int_value": 9, "suit": "Hearts", "face": "Nine", "texture": "cardHearts9.png"},
{"int_value": 8, "suit": "Hearts", "face": "Eight", "texture": "cardHearts8.png"},
{"int_value": 7, "suit": "Hearts", "face": "Seven", "texture": "cardHearts7.png"},
{"int_value": 6, "suit": "Hearts", "face": "Six", "texture": "cardHearts6.png"},
{"int_value": 5, "suit": "Hearts", "face": "Five", "texture": "cardHearts5.png"},
{"int_value": 4, "suit": "Hearts", "face": "Four", "texture": "cardHearts4.png"},
{"int_value": 3, "suit": "Hearts", "face": "Three", "texture": "cardHearts3.png"},
{"int_value": 2, "suit": "Hearts", "face": "Two", "texture": "cardHearts2.png"},
{"int_value": 1, "suit": "Hearts", "face": "Ace", "texture": "cardHeartsA.png"},
{"int_value": 13, "suit": "Diamonds", "face": "King", "texture": "cardDiamondsK.png"},
{"int_value": 12, "suit": "Diamonds", "face": "Queen", "texture": "cardDiamondsQ.png"},
{"int_value": 11, "suit": "Diamonds", "face": "Jack", "texture": "cardDiamondsJ.png"},
{"int_value": 10, "suit": "Diamonds", "face": "Ten", "texture": "cardDiamonds10.png"},
{"int_value": 9, "suit": "Diamonds", "face": "Nine", "texture": "cardDiamonds9.png"},
{"int_value": 8, "suit": "Diamonds", "face": "Eight", "texture": "cardDiamonds8.png"},
{"int_value": 7, "suit": "Diamonds", "face": "Seven", "texture": "cardDiamonds7.png"},
{"int_value": 6, "suit": "Diamonds", "face": "Six", "texture": "cardDiamonds6.png"},
{"int_value": 5, "suit": "Diamonds", "face": "Five", "texture": "cardDiamonds5.png"},
{"int_value": 4, "suit": "Diamonds", "face": "Four", "texture": "cardDiamonds4.png"},
{"int_value": 3, "suit": "Diamonds", "face": "Three", "texture": "cardDiamonds3.png"},
{"int_value": 2, "suit": "Diamonds", "face": "Two", "texture": "cardDiamonds2.png"},
{"int_value": 1, "suit": "Diamonds", "face": "Ace", "texture": "cardDiamondsA.png"},
{"int_value": 13, "suit": "Clubs", "face": "King", "texture": "cardClubsK.png"},
{"int_value": 12, "suit": "Clubs", "face": "Queen", "texture": "cardClubsQ.png"},
{"int_value": 11, "suit": "Clubs", "face": "Jack", "texture": "cardClubsJ.png"},
{"int_value": 10, "suit": "Clubs", "face": "Ten", "texture": "cardClubs10.png"},
{"int_value": 9, "suit": "Clubs", "face": "Nine", "texture": "cardClubs9.png"},
{"int_value": 8, "suit": "Clubs", "face": "Eight", "texture": "cardClubs8.png"},
{"int_value": 7, "suit": "Clubs", "face": "Seven", "texture": "cardClubs7.png"},
{"int_value": 6, "suit": "Clubs", "face": "Six", "texture": "cardClubs6.png"},
{"int_value": 5, "suit": "Clubs", "face": "Five", "texture": "cardClubs5.png"},
{"int_value": 4, "suit": "Clubs", "face": "Four", "texture": "cardClubs4.png"},
{"int_value": 3, "suit": "Clubs", "face": "Three", "texture": "cardClubs3.png"},
{"int_value": 2, "suit": "Clubs", "face": "Two", "texture": "cardClubs2.png"},
{"int_value": 1, "suit": "Clubs", "face": "Ace", "texture": "cardClubsA.png"}

]

var jokers = [
{"int_value": 0, "suit": "Joker", "face": "Joker", "texture": "cardJoker.png"},
{"int_value": 0, "suit": "Joker", "face": "Joker", "texture": "cardJoker.png"}
]

func _ready() -> void:
	
	build_deck()

func build_deck():
	Settings.load_settings()
	randomize()
	if Settings.jokers_wildcard:
		cards.append(jokers[0])
		cards.append(jokers[1])
	cards.shuffle()
	for card in cards:
		var newCard = cardScene.instance()
		newCard.suit = card["suit"]
		newCard.int_value = card["int_value"]
		newCard.face_value = card["face"]
		newCard.card_front_texture = load("res://Graphics/" + card["texture"])
		cardHolder.add_child(newCard)
		var cardButton = newCard.get_node("Button")
		cardButton.disabled = true

func get_top_card():
	var cards_count = cardHolder.get_child_count()
	var top_card = cardHolder.get_child(cards_count - 1)
	
	return top_card
