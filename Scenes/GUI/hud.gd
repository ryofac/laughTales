extends CanvasLayer

const PARTICLES_BALLOON = preload("res://Scenes/GUI/particles_balloon.tscn");

var origin: Vector2 = Vector2(15, 15);
var balloonsArr: Array;
var poppedBalloons: Array;
var padding: int = 2;
var spriteSize = 18;
var colors: Array[Color] = [ 
	Color("ff0000"),
	Color("15ff00"),
	Color("0b00ff"),
	Color("eaff00"),
	Color("ff00ec")];
	
var counter: int = 4;

func _ready():
	$Control.visible = true
	
	balloonsArr = get_node("Control").get_children()
	for i in range(balloonsArr.size()):
		balloonsArr[i].position = origin + Vector2( (spriteSize + padding) * i, 0);
		balloonsArr[i].play("filling");
	
	HealthManager.life_increased.connect(_on_increased_life)
	HealthManager.life_decreased.connect(_on_decreased_life)

func _on_increased_life():
	if !poppedBalloons.is_empty():
		var _lastBall = poppedBalloons.pop_back() as AnimatedSprite2D;
		
		 #animação dela voltando
		_lastBall.play("filling");
		counter += 1;
		#_lastBall.visible = true;
		balloonsArr.append(_lastBall);
		

func _on_decreased_life():
	if !balloonsArr.is_empty():
		var _lastBall = balloonsArr.pop_back() as AnimatedSprite2D;
		
		#animação dela explodindo
		_lastBall.play("popping");
		spawnParticles(_lastBall);
		
		counter -= 1;
		#_lastBall.visible = false;
		poppedBalloons.append(_lastBall);

func spawnParticles(lastBall):
	var _p = PARTICLES_BALLOON.instantiate() as Node2D;
	get_node("Control").add_child(_p)
	
	var particles = _p.get_node("particles");
	
	particles.position = lastBall.position;
	particles.set_modulate(colors[counter]);
	particles.emitting = true
