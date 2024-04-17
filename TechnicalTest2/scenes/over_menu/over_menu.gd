extends Control

@onready var score_display = $MarginContainer/HBoxContainer/ScoreContainer/ScoreDisplay
@onready var highscore_display = $MarginContainer/HBoxContainer/ScoreContainer/HighsoreDisplay

func _ready():
	score_display.text = str(Global.score)
	highscore_display.text = str(Global.highscore)

func _on_retry_button_pressed():
	var game_scene = load("res://scenes/game/game.tscn")
	get_tree().change_scene_to_packed(game_scene)

func _on_main_button_pressed():
	var main_scene = load("res://scenes/main_menu/main_menu.tscn")
	get_tree().change_scene_to_packed(main_scene)

func _on_quit_button_pressed():
	get_tree().quit()
