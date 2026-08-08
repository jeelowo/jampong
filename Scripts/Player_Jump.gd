extends State
class_name PlayerJump 

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

var player : CharacterBody2D
var direction : float

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	player.velocity.y = player.JUMP_VELOCITY

func Physics_Update(delta: float):
	player.velocity += player.get_gravity() * delta
	
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
