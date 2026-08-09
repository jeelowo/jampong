extends State
class_name AttackJumping

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var timer: Timer = $"../Timer"

var player : CharacterBody2D

func Enter():
	print("State: " + self.name)
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	player.velocity += player.get_gravity() * delta * 1.8
	player.velocity.x /= 1.08
	
	if player.is_on_floor():
		player.velocity.x = 0
		
		if timer.is_stopped():
			timer.start(0.1)
			animation_player.play("Attack From Air Landed")
			await timer.timeout

			if player.velocity.x == 0:
				Transitioned.emit(self, "Idle")
			elif player.velocity.x != 0:
				Transitioned.emit(self, "Run")
	else:
		animation_player.play("Attack From Air")
