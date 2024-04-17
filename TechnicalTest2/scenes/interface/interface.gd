extends CanvasLayer

@onready var score_display = $MarginContainer/ScoreDisplay
@onready var time_display = $MarginContainer/TimeDisplay

func update_score(score):
	score_display.text = str(score)

func update_timer(time):
	time_display.text = str(int(time)+1)
