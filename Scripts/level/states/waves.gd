extends LevelState;

var enemysSpawnPoints;
var enemiesScenes: Array[PackedScene]

var spawnCount;

func _ready():
	levelController.canEnd.connect(_on_end_level)

func enter():
	spawnCount = randi_range(3, 4);
	for sP in levelController.enemySpawnPoints:
		for i in spawnCount:
			levelController.instantiateEnemy(sP.global_position);

func _on_end_level():
	Transitioned.emit(self, "end");
