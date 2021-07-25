extends RigidBody2D

var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	rotation_degrees = rand_range(0, 360)
