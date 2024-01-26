extends Node

signal life_decreased;
signal life_increased;

var MAX_LIFE: int = 5;
var remainingLife: int;


# Called when the node enters the scene tree for the first time.
func _ready():
	remainingLife = MAX_LIFE;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func decrease_life(value: int):
	pass

func increase_life():
	pass
