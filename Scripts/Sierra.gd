extends StaticBody2D

var speed
var aceleration

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(2.25, 2.75)
	global_position.y = rand_range(80, 380)

# warning-ignore:unused_argumeni
func _process(delta):
	global_position.x -= speed  * aceleration

func _on_Timer_timeout():
	global_rotation_degrees += 22.5/4


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
