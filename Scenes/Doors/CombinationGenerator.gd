extends Node

func generate_combination(_length) -> Array :
	var _combination = []
	for _number in range(_length):
		_combination.append(randi()%10)
	return _combination
