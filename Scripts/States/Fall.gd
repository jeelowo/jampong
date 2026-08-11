extends State
class_name PlayerFall

@onready var player: CharacterBody2D = $"../.."
@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

const GRAVITY = 1200.0

func Enter():
	print("State: " + self.name)

	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true

func Physics_Update(delta: float):
	animation_player.play("Fall")

	# Gravity
	player.velocity.y += GRAVITY * delta

	# Horizontal movement while falling
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * 200.0

	# Landed
	if player.is_on_floor():
		Transitioned.emit(self, "Idle")
		return
