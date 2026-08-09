extends State
class_name AttackStanding

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"

@onready var animation_player: AnimatedSprite2D = $"../../AnimationPlayer"
@onready var timer: Timer = $"../Timer"

var player = CharacterBody2D
var finished_attacking : bool

func Enter():
	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true	

	player = get_tree().get_first_node_in_group("Player")
	finished_attacking = false
	timer.start(0.5)

func Physics_Update(delta: float):
	animation_player.play("Attack Right")
	
	if Input.is_action_just_pressed("attack") and timer.time_left <= 0.25:
		timer.start(timer.time_left + 0.5)
		
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and timer.is_stopped():
		Transitioned.emit(self, "Run")

	if finished_attacking:
		print("finished")
		finished_attacking = false
		Transitioned.emit(self, "Idle")


func _on_animation_player_animation_finished() -> void:
	finished_attacking = true
