extends CanvasLayer

var origin: Vector2 = Vector2(10, 10);

var balloonsArr: Array;
var padding: int = 2;

func _ready():
	balloonsArr = get_node("Control").get_children()
	
	for i in range(balloonsArr.size()):
		balloonsArr[i].position = origin + Vector2( (10 + padding) * i, 0);
	
	HealthManager.life_increased.connect(_on_increased_life)
	HealthManager.life_increased.connect(_on_decreased_life)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_increased_life():
	pass

func _on_decreased_life():
	pass
