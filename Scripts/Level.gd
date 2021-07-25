extends Node2D

export (PackedScene) var Log 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LogTimer_timeout():
	var logg = Log.instance()
	add_child(logg)
	logg.global_position.x = 760
	$LogTimer.wait_time = rand_range(1.5, 2.5)
	$LogTimer.start()
