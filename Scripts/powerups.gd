extends Control


var invi_level = 0
var dash_level = 0
var amount = [200, 300, 400, 500, 600]

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.shop_load()
	invi_level = Globals.save_shop.powerup1
	dash_level = Globals.save_shop.powerup2
	#print(invi_level)
	$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = str(amount[invi_level])
	$ScrollContainer/Control/VBoxContainer/Panel/ProgressBar.value = invi_level
	$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = str(amount[dash_level])
	$ScrollContainer/Control/VBoxContainer/Panel2/ProgressBar.value = dash_level
	pass # Replace with function body.

func _on_Button1_pressed():
	invi_level += 1
	if invi_level <= 4:
		$ScrollContainer/Control/VBoxContainer/Panel/Button1.disabled = false
		$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = str(amount[invi_level])
		$ScrollContainer/Control/VBoxContainer/Panel/ProgressBar.value = invi_level
		Globals.invi_level = invi_level
		Globals.save_shop.powerup1 = invi_level
		Globals.shop_save()
	else:
		$ScrollContainer/Control/VBoxContainer/Panel/Button1.disabled = true
		$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = " fully Upgraded "
	
	#globals.meat - amount[level]
	#
	pass # Replace with function body.

func _on_Button2_pressed():
	dash_level += 1
	if dash_level <= 4:
		$ScrollContainer/Control/VBoxContainer/Panel2/Button1.disabled = false
		$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = str(amount[dash_level])
		$ScrollContainer/Control/VBoxContainer/Panel2/ProgressBar.value = dash_level
		Globals.dash_level = dash_level
		Globals.save_shop.powerup2 = dash_level
		Globals.shop_save()
	else:
		$ScrollContainer/Control/VBoxContainer/Panel2/Button1.disabled = true
		$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = " fully Upgraded "
	
	pass # Replace with function body.
