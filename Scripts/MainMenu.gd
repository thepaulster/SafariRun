extends Control

onready var ad_controller = get_node("AdMob")

func _ready():
	MusicController.play_menu_music()
	Globals.data_load()
	#print(Globals.save_data.best_distance)
	get_tree().set_auto_accept_quit(false)
	get_tree().paused = false
	
	#ads
	ad_controller.load_banner()
	ad_controller.load_interstitial()
	ad_controller.load_rewarded_interstitial()
	ad_controller.load_rewarded_video()

func _on_Play_pressed():
	#get_tree().change_scene("res://Scenes/Level/world.tscn")
	#get_tree().change_scene("res://Scenes/simplePlayer.tscn")
	ad_controller.hide_banner()
	get_tree().change_scene("res://Scenes/Level/SceneSwitcher.tscn")
	pass # Replace with function body.

func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/UI/Menu.tscn")
	pass # Replace with function body.


#ads test
func _on_bannerAd_pressed():
	ad_controller.show_banner()
	pass # Replace with function body.

func _on_interstitialAd_pressed():
	ad_controller.hide_banner()
	ad_controller.show_interstitial()
	ad_controller.load_interstitial()
	pass # Replace with function body.

func _on_RewardedAd_pressed():
	ad_controller.hide_banner()
	ad_controller.show_rewarded_video()
	ad_controller.load_rewarded_video()
	pass # Replace with function body.


func _on_RewardedInterstitialAD_pressed():
	ad_controller.hide_banner()
	ad_controller.show_rewarded_interstitial()
	ad_controller.load_rewarded_interstitial()
	pass # Replace with function body.
