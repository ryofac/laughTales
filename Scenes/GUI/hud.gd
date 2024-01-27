extends CanvasLayer

var origin: Vector2 = Vector2(10, 10);
var balloonsArr: Array;
var poppedBalloons: Array;
var padding: int = 2;

func _ready():
	balloonsArr = get_node("Control").get_children()
	for i in range(balloonsArr.size()):
		balloonsArr[i].position = origin + Vector2( (10 + padding) * i, 0);
	
	HealthManager.life_increased.connect(_on_increased_life)
	HealthManager.life_decreased.connect(_on_decreased_life)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_increased_life():
	if !poppedBalloons.is_empty():
		var _lastBall = poppedBalloons.pop_back() as AnimatedSprite2D;
		
		 #animação dela voltando
		#_lastBall.play("")
		
		_lastBall.visible = true;
		
		balloonsArr.append(_lastBall);

func _on_decreased_life():
	if !balloonsArr.is_empty():
		var _lastBall = balloonsArr.pop_back() as AnimatedSprite2D;
		
		#animação dela explodindo
		#_lastBall.play("default");
		_lastBall.visible = false;
		poppedBalloons.append(_lastBall);
