extends Area2D

@export var speed: int = 100
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
	if Input.is_action_pressed("right"):
		position.x += speed * delta

func change_frame():
	sprite.frame = (sprite.frame + 1) % 2
