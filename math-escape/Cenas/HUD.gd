extends CanvasLayer

signal time_up


@export var tempo_da_fase_em_segundos: int = 60


@onready var level_timer: Timer = $LevelTimer
@onready var time_label: Label = $TimeLabel
@onready var problem_label: Label = $ProblemLabel
@onready var count_label: Label = $CountLabel



func _ready() -> void:
	level_timer.wait_time = tempo_da_fase_em_segundos
	level_timer.timeout.connect(_on_LevelTimer_timeout)
	atualizar_label_tempo(level_timer.wait_time)
	level_timer.start()

func _process(delta: float) -> void:
	var tempo_restante: float = level_timer.time_left
	atualizar_label_tempo(tempo_restante)

func atualizar_label_tempo(tempo: float) -> void:
	var tempo_total_segundos: int = int(ceil(tempo))
	var minutos: int = tempo_total_segundos / 60
	var segundos: int = tempo_total_segundos % 60
	
	if time_label:
		time_label.text = "%02d:%02d" % [minutos, segundos]

func _on_LevelTimer_timeout() -> void:
	if time_label:
		time_label.text = "00:00"
	time_up.emit() 


func update_problem(num1: int, num2: int, operation_symbol: String) -> void:
	if problem_label:
		problem_label.text = "%d %s %d = ?" % [num1, operation_symbol, num2]

func update_count(current_count: int, target_count: int) -> void:
	if count_label: 
		count_label.text = "Coletados: %d / %d" % [current_count, target_count]
