extends Node2D

var house = load("res://scenes/house/house.tscn")
var over_scene = load("res://scenes/over_menu/over_menu.tscn")

@onready var house_group = $HouseGroup
@onready var player = $Player
@onready var goal = $Goal
@onready var money_particle = $MoneyParticle
@onready var work_particle = $WorkParticle
@onready var money_sound = $MoneySound
@onready var work_sound = $WorkSound
@onready var ground = $Ground
@onready var timer = $Timer
@onready var interface = $Interface

var left_border = 0
var right_border = 640
var recipient_list = []

func _ready():
	# Set the ground to match the border and reset the score
	ground.points[0].x = left_border
	ground.points[1].x = right_border
	Global.reset_score()
	spawn_house()
	# Get the 4 recipient
	get_recipient(4)
	

func _physics_process(_delta):
	# Clamp player's horizontal position within the borders
	player.position.x = clamp(player.position.x, left_border, right_border)
	# Update the timer remaining time on the interface
	interface.update_timer(timer.time_left)

func spawn_house():
	var min_spacing = 32
	# Additional spacing based on random variation
	var random_spacing_range = 8 * (randi() % 3)
	var random_x = 64
	while random_x < right_border:
		# Create a new house instance
		var house_instance = house.instantiate()
		# Set the house's position with random spacing and randomize sprite
		house_instance.position.x = random_x
		house_instance.frame = randi() % 3
		house_group.add_child(house_instance)
		# Calculate the next random position for the next house
		random_x += min_spacing + random_spacing_range

# pick random recipient
func get_recipient(amount):
	var house_list = house_group.get_children()
	while amount > 0:
		var random_house = house_list.pick_random()
		recipient_list.append(random_house)
		house_list.erase(random_house)
		amount -= 1

func get_new_goal():
	# Set the goal's position to the randomly chosen house's position
	var random_recipient = recipient_list.pick_random()
	goal.position.x = random_recipient.position.x

func _on_goal_area_entered(_area):
	# Check if the goal is the truck
	if goal.position.x == 0:
		# Set a new random goal house
		get_new_goal()
		# Play work particle effects, work sound, and reset goal
		work_particle.restart()
		work_sound.play()
		money_particle.position.x = goal.position.x
		# Change player speed and frame
		player.speed = 75
		player.change_frame()
	else:  
		# Play money particle effects, money sound, and reset goal
		money_particle.restart()
		money_sound.play()
		goal.position.x = 0 
		# Change speed and frame
		player.speed = 100
		player.change_frame()
		# Update global score and interface
		Global.add_score()
		interface.update_score(Global.score)

func _on_timer_timeout():
	# Save the score
	Global.save_score()
	# Transition to the game over scene
	get_tree().change_scene_to_packed(over_scene)
