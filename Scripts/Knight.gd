extends CharacterBody2D
class_name Knight

const SPEED = 200.0
const MAX_JUMP_VELOCITY = -250.0

func _ready() -> void:
	add_to_group("Player")

func _physics_process(_delta: float) -> void:
	move_and_slide()
