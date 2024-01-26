extends Node
class_name StateMachine

# Só pra ter certeza que tudo vai ficar bem caso exista um estado inicial
@export var initialState: State
# fazendo um dicionário para guardar todos os estados possíveis:
var states : Dictionary = {};
var currentState: State;


func _ready():
	# Adicionando logo o estado inicial que é um @export
	if initialState: 
		initialState.enter();
		currentState = initialState
		
	# Analisando o nó inteiro para definir os comportamentos presentes
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child;
			
			# Conecta todos os sinais a função _on_transitioned_state, encarregada 
			# de trocar estados
			child.Transitioned.connect(_on_transitioned_state)

# Executa a process para o estado atual (update)
func _process(delta):
	if currentState:
		currentState.update(delta);

# Executa a physics_process para o estado atual (physics_update)
func _physics_process(delta):
	if currentState:
		currentState.physics_update(delta);

# Função conectada aos sinais transitioned's, encarregada de mudar estados
func _on_transitioned_state(state: State, newStateName: String):
	#print("%s trocando de estado [%s] - [%s]" % [get_parent().name, state.name, newStateName])
	if state != currentState:
		return
		
	var newState = states.get(newStateName.to_lower())
	
	if !newState or newState == currentState:
		return
		
	newState.enter();
	currentState = newState
	
	
