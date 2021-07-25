extends KinematicBody2D

const aceleration = 1024*2
const max_speed = 128*2
const jump_force = 240*1.5
const gravity = 400*2

onready var motion = Vector2()
var x_input 
onready var target = Vector2()
onready var click_input
var clickcooldown = false
export (PackedScene) var Pollo 

func _ready():
	target = global_position
	motion.y = -jump_force
	click_input = 1

func _input(event):
	if event is InputEventScreenTouch and event.pressed and clickcooldown == false:
		clickcooldown = true
		target = event.position
		$AnimatedSprite.animation = "egg"
		if target.y - global_position.y > 0:
			motion.y = -jump_force
		else:
			motion.y = jump_force 
		if target.x - global_position.x > 0:
			click_input = lerp(click_input, -1, 1)
			$AnimatedSprite.flip_h = true
		else:
			click_input = lerp(click_input, 1, 1)
			$AnimatedSprite.flip_h = false
		yield(get_tree().create_timer(.25),"timeout")
		if $AnimatedSprite.animation == "egg":
			$AnimatedSprite.animation = "default"
		clickcooldown = false

func _physics_process(delta):
	x_input = click_input
	if x_input != 0:
		motion.x += x_input * aceleration * delta 
		motion.x = clamp(motion.x, -max_speed, max_speed)
	else:
		motion.x = lerp(motion.x, 0, .02)
	
	motion.y += gravity * delta
	
	position.x = clamp(position.x, 0, 720)
	position.y = clamp(position.y, 0, 480)
	
	motion = move_and_slide(motion, Vector2.UP)
