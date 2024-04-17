extends Control

func _on_play_button_pressed():
	var game_scene = load("res://scenes/game/game.tscn")
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed():
	get_tree().quit()

