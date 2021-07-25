extends KinematicBody2D

const aceleration = 1024*1.5
const max_speed = 128*1.5
const jump_force = 240*1.5
const gravity = 400*1.5

onready var motion = Vector2()
var x_input 
onready var target = Vector2()
onready var click_input
var clickcooldown = false
export (PackedScene) var Chicken

func _ready():
	target = global_position
	motion.y = -jump_force
	click_input = 0

func _input(event):
	if event is InputEventScreenTouch and event.pressed and clickcooldown == false:
		clickcooldown = true
		var chicken = Chicken.instance()
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
		if $AnimatedSprite.animation == "egg":
			$AnimatedSprite.animation = "default"
		add_child(chicken)
		chicken.linear_velocity = chicken.linear_velocity.rotated($Polygon2D.rotation_degrees)
		clickcooldown = false


func _physics_process(delta):
	$Polygon2D.look_at(target)
	if Input.is_action_pressed("ui_accept"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
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
