extends Node

class_name ShakeableNode

@export var shake: Shake
@export var target: Node3D

var current_shake: Shake

func _ready():
	current_shake = shake.duplicate(true)
	current_shake.init_shake()

func _process(delta):
	target.position.y = current_shake.get_1d_value()
