extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game/scenes/level1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
