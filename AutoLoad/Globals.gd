extends Node

#save paths
var file_path = "user://gamedata.dat"
const settings_file_path = "user://settingsdata.dat"
const shop_file_path = "user://shopdata.dat"

signal prey_done
signal distance_changed(value)
signal meat_collected(value)
signal keep_distance(value)
signal newhighscore
signal newbestdistance
signal distance_new


var invul =  true #invulnerability variable

var player_distance = Vector2() setget player_distance #distance run in current run
var best_distance = 0 #best distance run by player

var playerSpeed = 0

var score = 0 setget final_score# score calculated from current run
var best_score = 0 #best score from other scores

var prey_dead = 0 setget prey_killed
var flip = true

var meat = 0 setget collect_meat #this is for meat that has been collected in one run
var meat_count
var meat_total = 0 setget total_meat_collected#this is for the total meat collected


var value_for_resume = 1
var store = {
			'bought' : [true, false, false, false],
			'selected' : 0
}

var distance_covered = 0 setget _distance_run
var keep_distance = 0 setget _kept_distance

#power_ups
var invi_level = 0
var dash_level = 0

#sounds and music
var sounds = true
var music = true
var mute = false setget sound_status
var sound_db

#save data
var save_data = {"best_distance":best_distance, "total_meat":meat_total, "best_score":best_score}
var save_settings = {"sounds": sounds, "music":music}
var save_shop = {"store": store, "powerup1": invi_level, "powerup2": dash_level}

#passing data to the powerUp bar

var powerUp_bar_value = 0 setget bar_value

func bar_value(value):
	powerUp_bar_value = value
	#print(powerUp_bar_value)
	pass

func player_distance(value : Vector2):
	player_distance = value
	#print(player_distance)

func prey_killed(value):
	prey_dead = value
	emit_signal("prey_done", 0)

func collect_meat(meat_count):
	meat = meat_count
	emit_signal("meat_collected", meat_count)

func _distance_run(value):
	#distance_covered = 0
	distance_covered = value
	#print(distance_covered)
	emit_signal("distance_changed", value)

func _kept_distance(value):
	keep_distance = value
	emit_signal("keep_distance", value)

func total_meat_collected(value):
	meat_total += value
	save_data.total_meat = meat_total
	#print(save_data.total_meat)
	#emit a signal for the endscreens
func final_score(value):
	score = (prey_dead * 200) + distance_covered + (meat * 10)
	pass

func best_score(value):
	if value > best_score:
		best_score = value
		emit_signal("newhighscore")
		save_data.best_distance = best_score

func best_distance(value):
	if value > best_distance:
		best_distance = value
		emit_signal("newbestdistance")
		save_data.best_distance = best_distance
	pass

func data_save():
	var save_file = File.new()
	save_file.open(file_path, File.WRITE)
	
	save_file.store_var(save_data)
	save_file.close()

func data_load():
	var save_file = File.new()
	if save_file.file_exists(file_path):
		save_file.open(file_path, File.READ)
		save_data = save_file.get_var()
		save_file.close()

func settings_save():
	var save_file = File.new()
	save_file.open(settings_file_path, File.WRITE)
	
	save_file.store_var(save_settings)
	save_file.close()

func settings_load():
	var save_file = File.new()
	if save_file.file_exists(settings_file_path):
		save_file.open(settings_file_path, File.READ)
		save_settings = save_file.get_var()
		save_file.close()

func shop_save():
	var save_file = File.new()
	save_file.open(shop_file_path, File.WRITE)
	save_file.store_var(save_shop)
	save_file.close()

func shop_load():
	var save_file = File.new()
	if save_file.file_exists(shop_file_path):
		save_file.open(shop_file_path, File.READ)
		save_shop = save_file.get_var()
		save_file.close()
		store = save_shop.store
	#print(invi_level)

func sound_status(value):
	mute = value
	save_settings.sounds = value
	if value == false:
		sound_db = -20
	else:
		sound_db = -70
