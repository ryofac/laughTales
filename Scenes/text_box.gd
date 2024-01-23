extends MarginContainer
class_name TextBox
var textureHappy = preload("res://Assets/Image/speech_box.png")
var textureSad = preload("res://Assets/Image/speech_box_sad.png")


@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
