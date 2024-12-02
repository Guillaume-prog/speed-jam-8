extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("flow")


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") :
		$AudioStreamPlayer2D.play()
		ScoreManager.add_warpflow_shard()
		$AnimatedSprite2D.visible=false
		get_tree().create_timer(0.5).timeout.connect(func(): queue_free())
		
