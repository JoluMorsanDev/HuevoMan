extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Pause")
	$Credits.modulate.a = 0
	$HowToPlay.modulate.a = 0
	if AudioServer.is_bus_mute(1):
		$ColorRect2/MusicButton.pressed = true
	else:
		$ColorRect2/MusicButton.pressed = false
	if AudioServer.is_bus_mute(2):
		$ColorRect2/SfxButton.pressed = true
	else:
		$ColorRect2/SfxButton.pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	$ButtonSound.play()
	$AnimationPlayer.play("Play")

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Play":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Level.tscn")

func _on_CreditsButton_pressed():
	$ButtonSound.play()
	$AnimationPlayer.play("Credits")

func _on_TextureButton_pressed():
	$ButtonSound.play()
	$AnimationPlayer.play("Pause")

func _on_HowToPlayButton_pressed():
	$ButtonSound.play()
	$AnimationPlayer.play("HowToPlay")

func _on_CloseButton_pressed():
	$ButtonSound.play()
	get_tree().quit()


func _on_MusicButton_pressed():
	$ButtonSound.play()
	if $ColorRect2/MusicButton.pressed == false:
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)

func _on_SfxButton_pressed():
	$ButtonSound.play()
	if $ColorRect2/SfxButton.pressed == false:
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)
