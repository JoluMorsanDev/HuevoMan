extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if AudioServer.is_bus_mute(1):
		$Pause/ColorRect2/MusicButton.pressed = true
	else:
		$Pause/ColorRect2/MusicButton.pressed = false
	if AudioServer.is_bus_mute(2):
		$Pause/ColorRect2/SfxButton.pressed = true
	else:
		$Pause/ColorRect2/SfxButton.pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PauseButton_pressed():
	$ButtonSound.play()
	if get_tree().paused == false:
		get_tree().paused = true
		if $CoinLabel.text != "Game\nOver":
			$Pause/ColorRect/CoinLabel.text = $CoinLabel.text
		$Pause/AnimationPlayer.play("Pause")
	else:
		get_tree().paused = false
		$Pause/AnimationPlayer.play("Play")


func _on_Restart_pressed():
	$ButtonSound.play()
	if $Pause/ColorRect2/MusicButton.pressed == false:
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)
	if $Pause/ColorRect2/SfxButton.pressed == false:
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func game_over():
	if get_tree() != null:
		if $Pause/ColorRect2/MusicButton.pressed == false:
			AudioServer.set_bus_mute(1, false)
		else:
			AudioServer.set_bus_mute(1, true)
		if $Pause/ColorRect2/SfxButton.pressed == false:
			AudioServer.set_bus_mute(2, false)
		else:
			AudioServer.set_bus_mute(2, true)
		get_tree().paused = true
		$Pause/ColorRect4/Label.text = "Try again"
		$Pause/ColorRect/CoinLabel.text = "Game\nOver"
		$Pause/ColorRect/CoinLabel.rect_position = Vector2(86, 58)
		$Pause/ColorRect/CoinLabel/Sprite.hide()
		$PauseButton.hide()
		$Pause/AnimationPlayer.play("Pause")

# warning-ignore:unused_argument
func _on_MusicButton_toggled(button_pressed):
	$ButtonSound.play()
	if $Pause/ColorRect2/MusicButton.pressed == false:
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)

# warning-ignore:unused_argument
func _on_SfxButton_toggled(button_pressed):
	$ButtonSound.play()
	if $Pause/ColorRect2/SfxButton.pressed == false:
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)

func _on_Home_pressed():
	$ButtonSound.play()
	if $Pause/ColorRect2/MusicButton.pressed == false:
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)
	if $Pause/ColorRect2/SfxButton.pressed == false:
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
