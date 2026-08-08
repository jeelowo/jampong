extends CharacterBody2D
class_name Knight

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	add_to_group("Knight")

func _physics_process(delta: float) -> void:
	move_and_slide()
