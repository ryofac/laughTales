extends Node
class_name State
# Classe de Estado: essa classe encapsula os métodos que um estado deve ter:
# Ele deve ser agnóstico ao seu funcionamento, tem que ter só entrada, saída, update
# e nesse caso, physics update

# Emitido quando um estado é trocado, ele é tratado no nó da máquina de estados
signal Transitioned 

# A função enter substitui a ready para estados
func enter():
	pass

# Subistitiu o process para estados
func update(delta: float):
	pass

# Substitui o physic_process para estados
func physics_update(delta: float):
	pass
