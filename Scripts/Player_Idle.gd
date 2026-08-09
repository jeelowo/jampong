extends State
class_name PlayerIdle

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

var player : CharacterBody2D
	
func Enter():
	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta: float):
	animation_player.play("Idle")
	
	# transitions
	if Input.get_axis("move_left","move_right") != 0:
		Transitioned.emit(self, "run")

	if Input.is_action_pressed("jump"):
		Transitioned.emit(self, "jump")

	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, "crouch")
	
	if Input.is_action_pressed("attack"):
		Transitioned.emit(self, "Attack Standing")
