extends Node2D

export (PackedScene) var Log 
export (PackedScene) var Sierra
var wating 
var coin = 0
var gameo = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# warning-ignore:unused_argument
func _process(delta):
	if gameo == false:
		$InGameUi/CoinLabel.text = str(coin)

func _on_LogTimer_timeout():
	var chance = rand_range(1, 10)
	var logg = Log.instance()
	add_child(logg)
	logg.global_position.x = 760
	wating = rand_range(1.5, 2.5)
	$LogTimer.wait_time = wating
	$SierraTimer.wait_time = wating
	if chance > 5:
		wating = rand_range(1.5, 2.5)
		$LogTimer.wait_time = wating
		$SierraTimer.wait_time = wating
		$LogTimer.start()
	else:
		wating = rand_range(.5, 1.5)
		$LogTimer.wait_time = wating
		$SierraTimer.wait_time = wating
		$SierraTimer.start()

func _on_SierraTimer_timeout():
	var chance = rand_range(1, 10)
	var saw1 = Sierra.instance()
	add_child(saw1)
	saw1.global_position.x = 760
	var saw2 = Sierra.instance()
	add_child(saw2)
	saw2.global_position.x = 760
	if chance > 5:
		wating = rand_range(1.5, 2.5)
		$LogTimer.wait_time = wating
		$SierraTimer.wait_time = wating
		$LogTimer.start()
	else:
		wating = rand_range(5, 1.5)
		$LogTimer.wait_time = wating
		$SierraTimer.wait_time = wating
		$SierraTimer.start()

func game_over():
	$LogTimer.stop()
	$SierraTimer.stop()
	$Huevoman.hide()
	$Ground.hide()
	get_tree().call_group("mob","queue_free")
	gameo = true
	$InGameUi/CoinLabel.text = "Game\nOver"
	$InGameUi/CoinLabel/Sprite.hide()


func _on_Huevoman_coin():
	coin += 1
