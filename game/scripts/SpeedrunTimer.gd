extends Label

const TIME_PERIOD = 0.001 # 1ms
var time = 0
var total_time = 0

func _process(delta):
	time += delta
	print(delta)
	if time > TIME_PERIOD:
		total_time += delta
		_timeout()
		time = 0

func _round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _timeout():
	self.text = str(_round_to_dec(total_time, 3))
