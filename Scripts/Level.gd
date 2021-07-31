extends Node2D

export (PackedScene) var Log 
export (PackedScene) var Sierra
var wating 
var coin = 0
var gameo = false
var aceleration = .75
var ss = false
var timeraceleration = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$HuevoSprite.hide()

# warning-ignore:unused_argument
func _process(delta):
	if gameo == false:
		$InGameUi/CoinLabel.text = str(coin)
		$HuevoSprite.global_position = $Huevoman.global_position

func _on_LogTimer_timeout():
	var chance = rand_range(1, 10)
	var logg = Log.instance()
	$Obstacles.add_child(logg)
	logg.aceleration = aceleration
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
	$Obstacles.add_child(saw1)
	saw1.global_position.x = 760
	saw1.aceleration = aceleration
	var saw2 = Sierra.instance()
	$Obstacles.add_child(saw2)
	saw2.global_position.x = 760
	saw2.aceleration = aceleration
	if chance > 5:
		wating = rand_range(1.5, 2.5)
		$LogTimer.wait_time = wating * timeraceleration
		$SierraTimer.wait_time = wating * timeraceleration
		$LogTimer.start()
	else:
		wating = rand_range(1.5, 1.5)
		$LogTimer.wait_time = wating * timeraceleration
		$SierraTimer.wait_time = wating * timeraceleration
		$SierraTimer.start()

func game_over():
	if gameo == false:
		ss = true
		$SShakeT.start()
		cameradown()
		gameo = true
		$InGameUi/PauseButton.disabled = true
		$LogTimer.stop()
		$SierraTimer.stop()
		$Huevoman.hide()
		$HuevoSprite.show()
		$Music.stop()
		$HitSound.play()
		get_tree().call_group("mob","hide")
		yield(get_tree().create_timer(1),"timeout")
		$HuevoSprite.hide()
		$Ground.hide()
		get_tree().call_group("mob","queue_free")
		$InGameUi.game_over()
		$InGameUi/CoinLabel/Sprite.hide()


func _on_Huevoman_coin():
	coin += 1

func _on_AcelerationTimer_timeout():
	if aceleration <= 1.5:
		aceleration += 0.05
	if $AcelerationTimer.wait_time == 2:
		$AcelerationTimer.wait_time = 1
	else:
		$AcelerationTimer.wait_time += .2
	if timeraceleration >= 0.65:
		timeraceleration -= .05
	$AcelerationTimer.start()

func cameraup():
	if ss == true:
		$Camera2D.position.y = 245
		$Camera2D.global_rotation_degrees = 5
		yield(get_tree().create_timer(0.05),"timeout")
		$CanvasModulate.color = Color(1, 1, 1, 1)
		cameradown()

func cameradown():
	if ss == true:
		$Camera2D.position.y = 235
		$Camera2D.global_rotation_degrees = -5
		yield(get_tree().create_timer(0.05),"timeout")
		$CanvasModulate.color = Color(.8, .75, 1, 1)
		cameraup()

func _on_SShakeT_timeout():
	ss = false
	$CanvasModulate.color = Color(1, 1, 1, 1)
	$Camera2D.position.y = 240
	$Camera2D.global_rotation_degrees = 0
