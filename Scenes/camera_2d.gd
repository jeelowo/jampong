extends Camera2D

@onready var animation_player: AnimatedSprite2D = $"../AnimationPlayer"

const MAX_POS_LEFT = -60
const MAX_POS_RIGHT = 60
const CAMERA_SPEED = 60.0

func _process(delta: float) -> void:
	if animation_player.flip_h and position.x > MAX_POS_LEFT:
		position.x -= CAMERA_SPEED * sqrt(abs(position.x - MAX_POS_LEFT)) * delta
	elif !animation_player.flip_h and position.x < MAX_POS_RIGHT:
		position.x += CAMERA_SPEED * sqrt(abs(position.x - MAX_POS_RIGHT)) * delta
