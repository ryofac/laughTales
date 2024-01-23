extends State
class_name EnemyState

@onready var player = get_tree().get_first_node_in_group("player") as Player
@export var enemy: Enemy
