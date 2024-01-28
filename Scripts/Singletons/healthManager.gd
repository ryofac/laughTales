extends Node

signal life_decreased;
signal life_increased;

var current_amount_life;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_initial_life(value: int):
	current_amount_life = value;
	print_rich("[color=blue] AGORA A VIDA É " + str(current_amount_life))

func increase_life(amount: int):
	if current_amount_life < 5:
		print_rich("[color=green]GANHOU")
		life_increased.emit();
		current_amount_life += amount;

func decrease_life(amount: int):
	print("decreaseando vida")
	if current_amount_life > 0:
		print_rich("[color=red]PERDEU PLAYBOY")
		life_decreased.emit();
		current_amount_life -= amount;
