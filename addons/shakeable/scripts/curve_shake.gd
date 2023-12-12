extends Shake

class_name CurveShake

@export var x_curve: Curve
@export var y_curve: Curve
@export var z_curve: Curve

func get_1d_value() -> float:
	if x_curve == null or bypass: return 0.0
	
	return x_curve.sample_baked(wrapf(current_time, 0.0, duration) / duration) * _curves_multiplier()

func get_2d_value() -> Vector2:
	if bypass: return Vector2.ZERO
	
	var time = wrapf(current_time, 0.0, duration) / duration
	return Vector2(
		0.0 if x_curve == null else x_curve.sample(time),
		0.0 if y_curve == null else y_curve.sample(time)
	) * _curves_multiplier()

func get_3d_value() -> Vector3:
	if bypass: return Vector3.ZERO
	
	var time = wrapf(current_time, 0.0, duration) / duration
	return Vector3(
		0.0 if x_curve == null else x_curve.sample(time),
		0.0 if y_curve == null else y_curve.sample(time),
		0.0 if z_curve == null else z_curve.sample(time)
	) * _curves_multiplier()

func init_shake() -> void:
	super.init_shake()
	if x_curve != null: x_curve.bake()
	if y_curve != null: y_curve.bake()
	if z_curve != null: z_curve.bake()
