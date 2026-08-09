extends State
class_name AttackStanding

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"

@onready var animation_player: AnimatedSprite2D
@onready var timer: Timer = $"../Timer"

var player = CharacterBody2D
var finished_attacking : bool

func Enter():
	print("State: " + self.name)
	
	standing_collision.disabled = false
	crouch_collision.disabled = true
	slide_collision.disabled = true
	roll_collision.disabled = true	

	player = get_tree().get_first_node_in_group("Player")
	animation_player = player.get_node("AnimationPlayer")
	animation_player.frame_changed.connect(_on_animation_player_frame_changed)
	
	finished_attacking = false
	timer.start(0.5)

func Physics_Update(delta: float):
	animation_player.play("Attack Right")
	
	if Input.is_action_just_pressed("attack") and timer.time_left <= 0.25:
		timer.start(timer.time_left + 0.5)
	
	# Transitions
	if Input.is_action_pressed("jump") and timer.is_stopped():
		Transitioned.emit(self, "Jump")

	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and timer.is_stopped():
		Transitioned.emit(self, "Run")

	if finished_attacking:
		print("finished")
		finished_attacking = false
		Transitioned.emit(self, "Idle")

func Exit():
	if animation_player.frame_changed.is_connected(_on_animation_player_frame_changed):
		animation_player.frame_changed.disconnect(_on_animation_player_frame_changed)

func _on_animation_player_animation_finished() -> void:
	finished_attacking = true

var direction = 0

func _on_animation_player_frame_changed() -> void:
	if animation_player.frame in [2, 6, 10, 15]:
		direction = Input.get_axis("move_left", "move_right")
		if direction == -1:
			animation_player.flip_h = true
		elif direction == 1:
			animation_player.flip_h = false
	
	if animation_player.frame in [3, 7, 11, 16]:
		player.velocity.x = 70 * direction
	
	if animation_player.frame in [4, 8, 12, 17]:
		player.velocity.x = 0
