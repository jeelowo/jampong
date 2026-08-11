extends State
class_name AttackCrouch

var player : CharacterBody2D
var finished_attacking : bool

@onready var standing_collision: CollisionShape2D = $"../../Standing Collision"
@onready var crouch_collision: CollisionShape2D = $"../../Crouch Collision"
@onready var slide_collision: CollisionShape2D = $"../../Slide Collision"
@onready var roll_collision: CollisionShape2D = $"../../Roll Collision"
@onready var timer: Timer = $"../Timer"
@onready var animation_player: AnimatedSprite2D
@onready var crouch: PlayerCrouch = $"../Crouch"

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

func Exit():
	if animation_player.frame_changed.is_connected(_on_animation_player_frame_changed):
		animation_player.frame_changed.disconnect(_on_animation_player_frame_changed)

func Physics_Update(_delta: float):
	# fall if on air
	if !player.is_on_floor():
		Transitioned.emit(self, "Fall")

	if Input.is_action_just_pressed("attack") and timer.time_left <= 0.3:
		timer.start(timer.time_left + 0.3)

	if timer.is_stopped() and Input.is_action_pressed("crouch"):
		Transitioned.emit(self, "Crouch")

	if Input.is_action_pressed("crouch"):
		animation_player.play("Crouch Attack")
	else:
		Transitioned.emit(self,"Idle")

func _on_animation_player_frame_changed() -> void:
	if animation_player.frame in [3, 6]:
		crouch.direction = Input.get_axis("move_left", "move_right")
		if crouch.direction == -1:
			animation_player.flip_h = true
		elif crouch.direction == 1:
			animation_player.flip_h = false

	if animation_player.frame in [1, 4]:
		player.velocity.x = 30 * crouch.direction

	if animation_player.frame in [2, 5]:
		player.velocity.x = 0
