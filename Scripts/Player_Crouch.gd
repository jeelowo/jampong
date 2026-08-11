extends State
class_name PlayerCrouch

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"

var player : CharacterBody2D
var direction : float

func Enter():
	print("State: " + self.name)
	player = get_tree().get_first_node_in_group("Player")
	standing_collision.disabled = true
	crouch_collision.disabled = false
	slide_collision.disabled = true
	roll_collision.disabled = true

	player.velocity.x = 0

func Physics_Update(_delta: float):
	# fall if on air
	if not player.is_on_floor():
		Transitioned.emit(self, "Fall")

	direction = Input.get_axis("move_left", "move_right")
	if direction == -1:
			animation_player.flip_h = true
	elif direction == 1:
			animation_player.flip_h = false

	if Input.is_action_pressed("crouch"):
		animation_player.play("Crouch Idle")
		if Input.is_action_just_pressed("attack"):
			Transitioned.emit(self, "Attack Crouch")
		if Input.is_action_just_pressed("jump"):
			Transitioned.emit(self, "Jump")
	else:
		Transitioned.emit(self, "idle")
