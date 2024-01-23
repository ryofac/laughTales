extends Node2D

@onready var label = $Label as Label
@export var vanishingTime = 1.5
var percentage = randi_range(50, 100)
var text = ""
var color = Color.BLACK
var wave: bool = true
var randomVisibleAmount = false
var pos = Vector2.ZERO


func _ready():
	set_properties()
	randomize()
	if randomVisibleAmount:
		var totalChars = label.get_total_character_count()
		label.visible_characters = totalChars - randi_range(0, int(totalChars/2))

func set_properties():
	label.text = text
	label.modulate = color
	global_position = pos


func _process(delta):
	if wave:
		var angle = Time.get_ticks_msec()
		label.rotation_degrees = sin(deg_to_rad(angle)) * randf_range(10, 12)
	vanishingTime -= delta
	if vanishingTime > 0:
		label.position.y -= 0.5
		label.modulate.a -= 0.01
	else:
		queue_free();
		
