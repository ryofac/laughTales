extends MarginContainer
class_name TextBox

var textureHappy = preload("res://Assets/Image/other/speech_box.png")
var textureSad = preload("res://Assets/Image/other/speech_box_sad.png")


@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

var text := "" 
var letter_index = 0
# Controla o tamanho máximo do balão de fala
const MAX_WIDTH = 256 

var letterTimer = 0.01
var punctuationTimer = 0.05
var spaceTimer = 0.06

signal finished_typing


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func showText(textToDisplay):
	text = textToDisplay
	label.text = textToDisplay
	
	# Esperar até tudo estar resizado
	await resized
	# Setando o tamanho pro que for menor o tamanho máximo ou o atual..
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # para o x da label
		await resized # para o y da label ( estranho né, também achei )
		custom_minimum_size.y = size.y
	
	# Mantendo sempre centralizado no local onde nasceu o balão de fala
	global_position.x -= size.x/2
	global_position.y -= size.y + 24
	label.text = ""
	_display_letter()

func _display_letter():
	$LetterDisplayTimer.stop();
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		finished_typing.emit()
		return;
		
	match text[letter_index]:
		"!", ",", ".", ";":
			timer.start(punctuationTimer)
		" ": 
			timer.start(spaceTimer)
		_:
			timer.start(letterTimer)
			
func _on_letter_display_timer_timeout():
	_display_letter()
