extends State
class_name AttackJumping

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"

var player: CharacterBody2D
var landed := false

func Enter():
	print("State: " + self.name)

	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true

	player = get_tree().get_first_node_in_group("Player")
	landed = false


func Physics_Update(delta: float):
	player.velocity += player.get_gravity() * delta * 1.8
	player.velocity.x = 0

	if not landed:
		animation_player.play("Attack From Air")

	if player.is_on_floor():
		landed = true
		animation_player.play("Attack From Air Landed")
		animation_player.animation_finished.connect(_on_landing_animation_finished, CONNECT_ONE_SHOT)

func _on_landing_animation_finished():
	if player.velocity.x == 0:
		Transitioned.emit(self, "Idle")
	else:
		Transitioned.emit(self, "Run")
