extends State
class_name PlayerIdle

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var character: Knight = $"../.."

func _ready() -> void:
	animated_sprite_2d.play("PlayerIdle")
	
func Physic_Update(delta: float):
	pass
