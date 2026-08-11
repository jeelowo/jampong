extends Node

@onready var footsteps_player: AudioStreamPlayer2D = $"Footsteps Player"

var footsteps: Array[AudioStream] = []

func _ready():
	var dir = DirAccess.open("res://Assets/SFX/Footsteps/")

	for file in dir.get_files():
		if file.ends_with(".wav"):
			var sound = load("res://Assets/SFX/Footsteps/" + file)
			footsteps.append(sound)

func play_footstep():
	footsteps_player.stream = footsteps.pick_random()
	footsteps_player.play()
