extends State
class_name PlayerRun

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

@export var speed = 100
var direction : float

var player : CharacterBody2D

func Enter():
	print("State: " + self.name)
	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	# fall if on air
	if !player.is_on_floor():
		Transitioned.emit(self, "Fall")

	animation_player.play("Run")

	direction = Input.get_axis("move_left", "move_right")

	player.velocity.x = player.SPEED * direction

	if direction == 0.0:
		Transitioned.emit(self, "Idle")
	elif direction == 1:
		animation_player.flip_h = false
	elif direction == -1:
		animation_player.flip_h = true

	# transitions
	if Input.is_action_pressed("jump"):
		Transitioned.emit(self, "jump")

	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, "crouch")

	if Input.is_action_pressed("attack"):
		Transitioned.emit(self, "Attack Standing")

	if Input.is_action_just_pressed("roll") and !player.is_on_wall():
		Transitioned.emit(self, "Roll")
