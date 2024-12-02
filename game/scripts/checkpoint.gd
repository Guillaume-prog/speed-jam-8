extends Area2D

var finish=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AnimatedSprite2D.play("portal-ing")


func _on_body_entered(body):
	if finish:
		ScoreManager.stop_timer()
	
	if body.is_in_group("player"):
		body.last_checkpoint = self
		print("Score : " + str(ScoreManager.get_time_score()))
		print("Warp Flow : " + str(ScoreManager.get_warpflow_score()))
		print("TOTAL SCORE : "+ str(ScoreManager.get_total_score()))
		finish =true
	
	
