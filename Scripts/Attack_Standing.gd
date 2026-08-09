extends State
class_name AttackStanding

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var timer: Timer = $"../Timer"

var player = CharacterBody2D
var finished_attacking : bool

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	finished_attacking = false
	timer.start(1.0)

func Physics_Update(delta: float):
	animation_player.play("Attack Right")
	print(timer.time_left)
	
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") and timer.is_stopped():
		Transitioned.emit(self, "Run")

	if finished_attacking:
		print("finished")
		finished_attacking = false
		Transitioned.emit(self, "Idle")


func _on_animation_player_animation_finished() -> void:
	finished_attacking = true
