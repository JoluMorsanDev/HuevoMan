extends Node2D

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(2.5, 4)
	global_position.y = rand_range(-120, 120)


# warning-ignore:unused_argument
func _process(delta):
	global_position.x -= speed


func _on_VisibilityNotifier2D_screen_entered():
	queue_free()
	
