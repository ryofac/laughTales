extends Node

var audioStream = AudioStreamPlayer2D.new() as AudioStreamPlayer2D;
func _ready():
	add_child(audioStream)
	audioStream.stream = preload("res://Assets/Audio/Background/background.mp3");
	audioStream.play();

func _process(delta):
	if !audioStream.playing:
		audioStream.play();
