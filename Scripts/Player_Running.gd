extends State
class_name PlayerRunning

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	animation_player.play("Run")
	
	
	
	if Input.get_axis("move_left", "move_right") == 0:
		Transitioned.emit(self, "Idle")
