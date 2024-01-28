extends Node2D

@onready var particles = $CPUParticles2D as CPUParticles2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	particles.emitting = true;



func _on_cpu_particles_2d_finished():
	queue_free();
