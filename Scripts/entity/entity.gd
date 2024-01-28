extends CharacterBody2D

# Encapsula a lógica para as entidades do jogo ( que precisam andar, e afins )
class_name Entity
signal being_attacked();

var particlesScene = preload("res://Scenes/particle.tscn");
var canMove: bool = true
var is_dying: bool = false;
var textFloating: bool = false;

var damagePhrases: Array[String] = ["Outch!"];
@export var colorDamage: Color = Color.WHITE;

@export var speed: float
@export var maxLife: float = 50.0;
var direction: Vector2 = Vector2.ZERO;
var remainingLife: float = 100;


func take_damage(damage: float = 10.0):
	remainingLife -= damage;
	being_attacked.emit()
	if remainingLife <= 0:
		##dropa item
		canMove = false;
		is_dying = true;
		spawn_particles();
	if !textFloating:
		DialogManager.spawnFloatingText(damagePhrases.pick_random(), colorDamage, global_position)
	
func spawn_particles():
	var _p = particlesScene.instantiate();
	get_parent().add_child(_p);
	_p.global_position = global_position;
	_p.modulate = colorDamage


# Função pronta para ser sobreescrita na animação de morte
func death_animation(delta):
	pass;

