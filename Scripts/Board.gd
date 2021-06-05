extends Control

var cardMove = preload("res://Scripts/Move.gd")
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
onready var wastePileCards = $WastePile/Cards
onready var deckButton = $DeckPile
onready var gameOver = $GameOverMenu
onready var scoreLabel = $GameOverMenu.scoreLabel
onready var boardScoreLabel = $UI/MarginContainer/VBoxContainer/BoardScoreLabel
onready var gameOverTimer = $GameOverTimer
onready var winMenu = $WinMenu
onready var winTimer = $WinTimer
onready var audioPlayer = $AudioStreamPlayer
onready var boardTimeLabel = $UI/MarginContainer/VBoxContainer/BoardTimeLabel
onready var timeLabel = $GameOverMenu.timeLabel

onready var undoButton = $UI/MarginContainer/HBoxContainer/UndoButton
onready var hintButton = $UI/MarginContainer/HBoxContainer/HintButton
onready var newGameButton = $UI/MarginContainer/HBoxContainer/NewGameButton
onready var mainMenuButton = $UI/MarginContainer/HBoxContainer/MainMenu

onready var mainMenuConfirmation = $UI/ConfirmationDialog
onready var newGameConfirmation = $UI/NewGameConfirmationDialog

onready var undoTween = $UndoTween

var card_offset = 30
var tableau_count = 7
var cards_per_tableau = 5
var score = 0 setget set_score
var time = 0
var time_mult = 1
var str_elapsed = ""
var current_chain = 0
var longest_chain = Stats.longest_chain
var best_time = Stats.best_time
var deckcard_data = []
var valid_moves = []

var card_data: Dictionary = {"data": {"tableaus": [], "deck": {}, "moves": [], "settings": {}}}
var GameCenter = null

var url = "https://www.joustingknightgames.com/api/v1/gamedata/"
var api_key = "9e3afbbc1e01b8596077cae553ab4372d77338a2"

var moves = []
var moves_data = []
onready var tableaus = [tableau1, tableau2, tableau3, tableau4, tableau5, tableau6, tableau7]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_score(35)
	deal_cards()
	get_card_data()
	call_deferred("set_process", true)
	Stats.set_num_games_played()
	enable_ui()
	#set_process(false)

func _process(delta: float) -> void:
	time += delta * time_mult
# warning-ignore:integer_division
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	update_time_label(seconds, minutes)

func enable_ui():
	undoButton.disabled = false
	hintButton.disabled = false
	newGameButton.disabled = false
	mainMenuButton.disabled = false

func disable_ui():
	undoButton.disabled = true
	hintButton.disabled = true
	newGameButton.disabled = true
	mainMenuButton.disabled = true

func update_time_label(seconds, minutes):
	str_elapsed = "%02d:%02d" % [minutes, seconds]
	boardTimeLabel.text = "Time: " + str(str_elapsed)

func set_score(value):
	score = value
	update_score_label()
	
func update_score_label():
	boardScoreLabel.text = "Score: " + str(score)

func get_deck_card_data():
	for i in range(0,deckCards.get_child_count()):
		var deckcard_data_point = {"int_value": deckCards.get_child(i).int_value, "suit": deckCards.get_child(i).suit, "face": deckCards.get_child(i).face_value}
		deckcard_data.append(deckcard_data_point)
		deckcard_data.invert()

func get_card_data():
	# data structure should be
	# {"data": tableaus: [{"tableau1": [{"int_value": 1, "suit": "clubs", "face": "ace"}]}], "deck": [{"int_value": 1, "suit": "clubs", "face": "ace"}]}
	var tableaus_array = []
	for tableau in tableaus:
		tableaus_array.append(tableau.get_cards())

	get_deck_card_data()
	card_data["data"]["tableaus"] = tableaus_array
	card_data["data"]["deck"] = deckcard_data

func deal_cards():
	Settings.load_settings()
	
	# loop through deck and re-parent cards
	var duration = 1
	
	for i in range(0,cards_per_tableau):
		for j in range(0,tableau_count):
			var selected_card = deck.get_top_card()
			deckCards.remove_child(selected_card)
			duration += .5
			tableaus[j].add_card_to_tableau(selected_card, i * card_offset, duration * .05)

		
				
#	for tableau in tableaus:
#		for j in cards_per_tableau:
#			var selected_card = deck.get_top_card()
#			deckCards.remove_child(selected_card)
#			duration += 1
#			tableau.add_card_to_tableau(selected_card, j * card_offset, duration * .05)


	if not Settings.empty_foundation:		
		var last_card = deck.get_top_card()
		wastePile.move_card_to_waste_pile(last_card, false)


func refresh_waste_pile():
	if deckCards.get_child_count() > 0:
		var card = deck.get_top_card()
		var move = CardMove.new(card, card.get_parent(), card.position)
		moves.append(move)
		moves_data.append(move.to_json())
		# set current_chain back to zero
		current_chain = 0
		#audioPlayer.play(0.310)
		wastePile.move_card_to_waste_pile(card, false, true)
		
func check_valid_moves():
	for tableau in tableaus:
		if tableau.has_cards():
			var top_card = tableau.get_top_tableau_card()
			var wasteCard = wastePile.get_top_card()
			if wasteCard == null:
				valid_moves.append(top_card)
			if (top_card.int_value == 0 or (wasteCard != null and wasteCard.int_value == 0)):
				valid_moves.append(top_card)
			if wasteCard != null:
				var cardMinusOne = wasteCard.int_value - 1
				var cardPlusOne = wasteCard.int_value + 1

				if top_card.int_value == cardMinusOne or top_card.int_value == cardPlusOne:
					if (wasteCard.int_value != 13):
						valid_moves.append(top_card)
				
				if Settings.allow_queens_on_kings == true:
					if (top_card.int_value == 12 and wasteCard.int_value == 13):
						valid_moves.append(top_card)
					
				if Settings.turn_corners == true:
					if (top_card.int_value == 1 and wasteCard.int_value == 13 or 
					top_card.int_value == 13 and wasteCard.int_value == 1):
						valid_moves.append(top_card)


func check_game_over():
	if check_win():
		win()
		return
	# is the deck empty?
	if deckCards.get_child_count() == 0:
		valid_moves = []
		check_valid_moves()
		# go through tableaus to see if any of the last cards can be used
		if valid_moves.empty():	
			gameover()
			
func check_win():
	var tableaus_with_cards = 0
	for tableau in tableaus:
		if tableau.has_cards():
			tableaus_with_cards += 1
			
	return tableaus_with_cards == 0

			
func gameover():
	disable_ui()
	set_process(false)
	gameOverTimer.start()
	card_data["data"]["score"] = score
	card_data["data"]["outcome"] = "lose"
	card_data["data"]["moves"] = moves_data
	card_data["data"]["settings"] = Settings._settings
	if Settings.collect_data:
		_make_post_request(url, card_data, true)
	
func win():
	disable_ui()
	set_process(false)
	winTimer.start()
	card_data["data"]["score"] = score
	card_data["data"]["outcome"] = "win"
	card_data["data"]["moves"] = moves_data
	card_data["data"]["settings"] = Settings._settings
	if Settings.collect_data:
		_make_post_request(url, card_data, true)

func undo():
	if moves.size() > 0:
		var move = moves.back()
		var parent = move.cardParent
		var card = move.card
		var cardPosition = move.currentPosition
		card.get_parent().remove_child(card)
		parent.add_child(card)
		card.set_owner(parent)
		#card.position = cardPosition
		undoTween.interpolate_property(card, "position", card.position, 
			Vector2(cardPosition.x, cardPosition.y), 0.35, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		undoTween.start()
		var cardButton = card.get_node("Button")
		cardButton.disabled = false
		moves.pop_back()
		if deckCards.get_child_count() > 0:
			deckButton.show()
			
		var current_score = 0
		for tableau in tableaus:
			current_score += tableau.get_card_count()
		
		set_score(current_score)
		
		# set current_chain back to zero
		current_chain = 0
	else:
		return

func get_score():

	for tableau in tableaus:
		score += tableau.cards.get_child_count()
	
	return score

func hint():
	check_valid_moves()

	if not valid_moves.empty():
		for card in valid_moves:
			card.shake()

	else:
		deckButton.shake()
		
	valid_moves = []

func _on_GameOverTimer_timeout() -> void:
	var highScore = score
	scoreLabel.text = "Score: " + str(highScore)
	timeLabel.text = "Time: " + str(str_elapsed)
	Stats.set_high_score(score)
	Stats.set_num_games_lost()
	Stats.set_longest_chain(longest_chain)
	gameOver.popup()


func _on_UI_new_game() -> void:
	newGameConfirmation.popup_centered()


func _on_NewGameButton_pressed() -> void:
	newGameConfirmation.popup_centered()	


func _on_UndoButton_pressed() -> void:
	undo()


func _on_WinTimer_timeout() -> void:
	Stats.set_high_score(score)
	Stats.set_num_games_won()
	Stats.set_fewest_moves(moves.size())
	Stats.set_best_time(time)
	winMenu.popup()


func _on_WastePile_check_win() -> void:
	check_win()


func _on_HintButton_pressed() -> void:
	hint()


func _on_DeckPile_pressed() -> void:
	if Settings.play_sfx == true:
		audioPlayer.play()
	refresh_waste_pile()
	if deckCards.get_child_count() == 0:
		deckButton.hide()
		check_win()
		check_game_over()


func _on_MainMenu_pressed() -> void:
	mainMenuConfirmation.popup_centered()


func _on_ConfirmationDialog_confirmed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_NewGameConfirmationDialog_confirmed() -> void:
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

# warning-ignore:shadowed_variable
func _make_post_request(url, data_to_send, use_ssl):
    # Convert data to json string:
    var query = JSON.print(data_to_send)
    # Add 'Content-Type' header:
    var headers = ["Content-Type: application/json", "J-API-KEY: " + api_key]
    $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
