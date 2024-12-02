extends Node2D

const WARPFLOW_MULTIPLIER = 0.0001
var time_score:float = 0
var warpflow_score:float = 0.0
var total_score = 0.0

var is_timer_up = false
# TIME SCORE
func start_timer():
	is_timer_up = true

func stop_timer():
	is_timer_up = false

func get_time_score() -> float: 
	return _round_to_dec(time_score,3)

func _round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _process(delta):
	if is_timer_up:
		time_score += delta



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
	return _round_to_dec(warpflow_score,3)
	
func get_total_score()->float :
	return _round_to_dec(warpflow_score/time_score,3)
