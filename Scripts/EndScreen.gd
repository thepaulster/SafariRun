extends CanvasLayer

onready var endScreen = get_node("Ui1")
onready var endmeat = $Ui1/Control/Currentmeat/totalmeatcollected
onready var meat = get_node("Ui1/Control/VBoxContainer/coinscollected/meat_display")
onready var score = get_node("Ui1/Control/HBoxContainer/scoreDisplay")
onready var distance =  get_node("Ui1/Control/VBoxContainer/Distance/DistanceDisplay")
onready var prey = get_node("Ui1/Control/VBoxContainer/PreyCaught/PreyDisplay")
onready var newhighscoregraphic = get_node("Ui1/Control/New")
onready var newbestdistancegraphic = get_node("Ui1/Control/New2")

var value = 0

func _ready():
	get_tree().set_auto_accept_quit(true)
	Signals.connect("on_resume_timeout", self, "player_dead")
	Globals.connect("newhighscore", self, "newhighscore")
	player_dead()

func player_dead():
	Globals.best_score(Globals.score)
	Globals.final_score(value)
	#Globals.total_meat_collected(Globals.meat)
	#Globals.best_score(Globals.score)
	Globals.data_save()
	
	endmeat.text = str(Globals.save_data.total_meat)
	print(Globals.save_data.total_meat)
	meat.text = str(Globals.meat)
	score.text = str(Globals.score)
	distance.text = str(Globals.distance_covered)
	prey.text = str(Globals.prey_dead)
	endScreen.visible = true
	#print(Globals.save_data.total_distance)


func _on_Home_pressed():
	Globals.meat = 0
	Globals.keep_distance = 0
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
	#interstitail ad
	pass # Replace with function body.


func _on_Retry_pressed():
	Globals.meat = 0
	Globals.keep_distance = 0
	get_tree().reload_current_scene()
	pass # Replace with function body.

func newhighscore():
	newhighscoregraphic.visible = true
	pass

func newbestdistance():
	newbestdistancegraphic.visible = true
	pass
