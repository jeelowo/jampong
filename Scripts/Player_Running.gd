extends State
class_name PlayerRunning

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

@export var speed = 100
var direction : float

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	animation_player.play("Run")
	
	direction = Input.get_axis("move_left", "move_right")
	
	player.velocity.x = player.SPEED * direction
	
	if direction == 0.0:
		Transitioned.emit(self, "Idle")
	elif direction == 1:
		animation_player.flip_h = false
	elif direction == -1:
		animation_player.flip_h = true
