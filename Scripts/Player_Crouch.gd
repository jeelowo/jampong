extends State
class_name PlayerCrouch

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	standing_collision.disabled = true
	crouch_collision.disabled = false
	slide_collision.disabled = true
	roll_collision.disabled = true

func Physics_Update(delta: float):
	if Input.is_action_pressed("crouch"):
		animation_player.play("Crouch Idle")
	else:
		Transitioned.emit(self, "idle")
