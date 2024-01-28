extends CanvasLayer

@onready var title = get_node("Control/Title")
@onready var options: Array[Node] = get_node("Control").get_children()
@onready var currentOption = options[0];


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
