extends Resource

class_name Shake

@export var bypass: bool = false
@export var oneshot: bool = false
@export var duration: float = 1.0
@export var fade_in_curve: Curve
@export var fade_in_time: float
@export var fade_out_curve: Curve
@export var fade_out_time: float

var start_time: float = 0.0

var current_time: float:
	get:
		return (Time.get_ticks_usec() / 1000000.0) - start_time

func get_1d_value() -> float:
	return 0.0

func get_2d_value() -> Vector2:
	return Vector2.ZERO

func get_3d_value() -> Vector3:
	return Vector3.ZERO

func init_shake() -> void:
	start_time = Time.get_ticks_usec() / 1000000.0
	if fade_in_curve != null: fade_in_curve.bake()
	if fade_out_curve != null: fade_out_curve.bake()

func _curves_multiplier() -> float:
	var alpha: float = 1.0
	if (current_time <= fade_in_time) and fade_out_curve != null:
		alpha = fade_in_curve.sample_baked(clampf(inverse_lerp(0, fade_in_time, current_time), 0, 1))
	elif (current_time >= duration - fade_out_time) and fade_out_curve != null:
		alpha = fade_out_curve.sample_baked(clampf(inverse_lerp(duration - fade_out_time, duration, current_time), 0, 1))
	return alpha
