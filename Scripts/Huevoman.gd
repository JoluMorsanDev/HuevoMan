extends KinematicBody2D

const aceleration = 1024*1.5
const max_speed = 128*1.5
const jump_force = 240*1.5

var gravity 
onready var motion = Vector2()
var x_input 
onready var target = Vector2()
onready var click_input
var clickcooldown = false

signal hit
signal coin

func _ready():
	target = global_position
	motion.y = -jump_force/2
	click_input = 0
	gravity = 250

func _input(event):
	if event is InputEventScreenTouch and event.pressed and clickcooldown == false:
		gravity = 400*1.5
		clickcooldown = true
		target = event.position
		$Touch.global_position = target
		$Touch/AnimationPlayer.play("Nueva Animación")
		$AnimatedSprite.animation = "egg"
		if target.y - global_position.y > 0:
			motion.y = -jump_force
			$JumpSound.play()
			$CPUParticles2D.emitting = true
		else:
			motion.y = jump_force
			$"Jumpn'tSound".play() 
		if target.x - global_position.x > 0:
			click_input = lerp(click_input, -1, 1)
			$AnimatedSprite.flip_h = true
		else:
			click_input = lerp(click_input, 1, 1)
			$AnimatedSprite.flip_h = false
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
#
#	position.x = clamp(position.x, 0, 720)
#	position.y = clamp(position.y, 0, 480)
	
	motion = move_and_slide(motion, Vector2.UP)


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("hit")


# warning-ignore:unused_argument
func _on_HitArea_body_entered(body):
	emit_signal("hit")

# warning-ignore:unused_argument
func _on_CoinArea_area_entered(area):
	emit_signal("coin")
