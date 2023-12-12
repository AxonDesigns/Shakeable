extends Shake

class_name ComposedShake

@export var shakes: Array[Shake]


func get_1d_value() -> float:
	if shakes.size() < 1 or bypass: return 0.0
	var temp: float = 0
	for shake: Shake in shakes:
		temp += shake.get_1d_value()
	
	return temp * _curves_multiplier()

func get_2d_value() -> Vector2:
	if shakes.size() < 1 or bypass: return Vector2.ZERO
	var temp: Vector2 = Vector2.ZERO
	for shake: Shake in shakes:
		temp += shake.get_2d_value()
	
	return temp * _curves_multiplier()

func get_3d_value() -> Vector3:
	if shakes.size() < 1 or bypass: return Vector3.ZERO
	var temp: Vector3 = Vector3.ZERO
	for shake: Shake in shakes:
		temp += shake.get_3d_value()
	
	return temp * _curves_multiplier()

func init_shake() -> void:
	super.init_shake()
	for i: int in range(shakes.size()):
		if shakes[i].oneshot:
			shakes[i] = shakes[i].duplicate(true)
		shakes[i].init_shake()
