extends LevelState;

var enemysSpawnPoints;
var enemiesScenes: Array[PackedScene]
var timer;

@export var spawnCount: int;
@export var duraction: int


func _ready():
	levelController.canEnd.connect(_on_end_level)
	timer = levelController.get_node("SpawnDelay") as Timer;

func enter():
	player = get_tree().get_first_node_in_group("player")
	player.canMove = true;
	spawnCount = randi_range(3, 4);
	
	spawnEnemies();
	timer.start(duraction)
	

func _on_end_level():
	Transitioned.emit(self, "end");
	
func spawnEnemies():
	for sP in levelController.enemySpawnPoints:
		for i in spawnCount:
			levelController.instantiateEnemy(sP.global_position);
	
func _on_spawn_delay_timeout():
	spawnEnemies();
	timer.start(duraction);
