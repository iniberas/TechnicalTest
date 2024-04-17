extends Node

var save_path = "user://score.save"
var score = 0
var highscore = 0

func _ready():
	load_score()

func add_score():
	score += 1

func reset_score():
	score = 0

func save_score():
	# Only save if score is higher than highscore
	if score < highscore:
		return
	# Update the highscore and save to file
	highscore = score
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highscore)

func load_score():
	# Check if the save file exists and get highscore from file
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
	# If the file doesn't exist, set the high score to 0
	else:
		highscore = 0
