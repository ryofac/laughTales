extends Node

@onready var floatingTextScene = preload("res://Scenes/floating_text.tscn")
@onready var textBoxScene = preload("res://Scenes/text_box.tscn")
var dialogue_lines : Array[String] = []
var currentLineIndex = 0;
var isDialogueActive = false
var canAdvanceLine = false
var level: Node = null;
signal finished_text_showing();

var textBox
var textBoxPosition: Vector2

func startDialogue(position: Vector2, lines: Array[String]):
	if isDialogueActive:
		return
		
	dialogue_lines = lines
	textBoxPosition = position
	showTextBox()
	isDialogueActive = true

func showTextBox():
	textBox = textBoxScene.instantiate() as TextBox
	textBox.finished_typing.connect(_on_finished_typing_text_box)
	get_tree().root.add_child(textBox)
	textBox.global_position = textBoxPosition
	textBox.showText(dialogue_lines[currentLineIndex])
	canAdvanceLine = false

	
func _on_finished_typing_text_box():
	canAdvanceLine = true;

func _unhandled_input(event):
	if event.is_action_pressed("throw_attack") && canAdvanceLine && isDialogueActive:
		textBox.queue_free();
		currentLineIndex += 1
		if currentLineIndex >= dialogue_lines.size():
			# aí fudeu, tem que parar
			isDialogueActive = false
			currentLineIndex = 0
			finished_text_showing.emit();
			return 
		showTextBox();
		
# Spawna textos flutuantes como aquele do Hahahaha
func spawnFloatingText(text: String, color: Color, pos: Vector2, randomlenghtOfChars = false, wave = true):
	var floatingText = floatingTextScene.instantiate()
	floatingText.text = text;
	floatingText.color = color;
	floatingText.pos = pos
	floatingText.randomVisibleAmount = randomlenghtOfChars;
	floatingText.wave = wave
	get_tree().root.add_child(floatingText)
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !level: level = find_child("Level");
