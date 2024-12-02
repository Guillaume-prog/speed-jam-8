extends Node2D

const WARPFLOW_MULTIPLIER = 0.0001
var time_score:float = 20.0
var warpflow_score:float = 0.0
var total_score = 0.0

# TIME SCORE
func start_timer():
	pass

func get_time_score() -> float: 
	return time_score
	


# FLOW SCORE
func add_warpflow(flow:float):
	warpflow_score+=flow*WARPFLOW_MULTIPLIER
	
func add_portal_warpflow():
	warpflow_score+=20
	
func add_warpflow_shard():
	warpflow_score+=100
	
func reset_warpflow():
	warpflow_score = 0
	
func get_warpflow_score()-> float : 
	return warpflow_score
	
func get_total_score()->float :
	return warpflow_score/time_score
