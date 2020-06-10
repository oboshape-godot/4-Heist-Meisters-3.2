extends Popup

func set_text(_combination):
	$NinePatchRect/CenterContainer/NinePatchRect/Label.text = (
		"Will you stop forgetting your access code!!\n\n" +
		"I've set it to " + PoolStringArray(_combination).join("") + 
		"\n\n But this is the very last time..")
