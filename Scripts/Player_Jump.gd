extends State
class_name PlayerJump 

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

var player : CharacterBody2D
var direction : float
var can_jump = true

func Enter():
	print("State: " + self.name)
	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true

	player = get_tree().get_first_node_in_group("Player")
	can_jump = true
	player.velocity.y = -50

func Physics_Update(delta: float):
	player.velocity += player.get_gravity() * delta * 1.3

	if Input.is_action_pressed("jump"):
		if can_jump:
			player.velocity.y -= 100
		if (player.velocity.y <= player.MAX_JUMP_VELOCITY):
			can_jump = false

	if Input.is_action_just_released("jump"):
		can_jump = false

	animation_player.play("Jump")
	
	direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.SPEED * 1.05 * direction
	
	if direction == 1:
		animation_player.flip_h = false
	elif direction == -1:
		animation_player.flip_h = true

	# Transitions
	if player.is_on_floor() and player.velocity.x == 0:
		Transitioned.emit(self, "idle")

	if player.is_on_floor() and player.velocity.x != 0:
		Transitioned.emit(self, "Run")

	if !player.is_on_floor() and Input.is_action_pressed("move_down") and Input.is_action_just_pressed("attack") :
		Transitioned.emit(self, "Attack Jumping")

	if !player.is_on_floor() and Input.is_action_just_pressed("attack") :
		Transitioned.emit(self, "Attack Standing")
