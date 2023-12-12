extends Shake

class_name NoiseShake

@export var noise: FastNoiseLite
@export var amplitude: Vector3
@export var random_seed: bool = true

var current_noise: FastNoiseLite

func get_1d_value() -> float:
	if current_noise == null or bypass: return 0.0
	
	return (current_noise.get_noise_1d(current_time) * amplitude.x) * _curves_multiplier()

func get_2d_value() -> Vector2:
	if current_noise == null or bypass: return Vector2.ZERO
	
	return Vector2(current_noise.get_noise_1d(current_time) * amplitude.x,
	current_noise.get_noise_1d(current_time + 5) * amplitude.y) * _curves_multiplier()

func get_3d_value() -> Vector3:
	if current_noise == null or bypass: return Vector3.ZERO
	
	return Vector3(current_noise.get_noise_1d(current_time) * amplitude.x,
	current_noise.get_noise_1d(current_time + 5) * amplitude.y,
	current_noise.get_noise_1d(current_time + 10) * amplitude.z) * _curves_multiplier()

func init_shake() -> void:
	super.init_shake()
	current_noise = noise.duplicate(true)
	if random_seed: current_noise.seed = randi() % 500
