extends State
class_name PlayerRoll

@onready var fall: PlayerFall = $"../Fall"
@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var timer: Timer = $"../Timer"

var player = CharacterBody2D

func Enter():
	print("State: " + self.name)
	standing_collision.disabled = true
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = false

	player = get_tree().get_first_node_in_group("Player")
	timer.start(1.0)

func Physics_Update(delta: float):
	# Gravity
	player.velocity.y += fall.GRAVITY * delta

	animation_player.play("Roll")

	if Input.is_action_pressed("roll") and timer.time_left < 0.3:
		timer.start(timer.time_left + 0.3)

	if timer.is_stopped() or player.is_on_wall():
		Transitioned.emit(self, "Run")
