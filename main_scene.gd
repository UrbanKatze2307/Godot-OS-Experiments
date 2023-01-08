extends Control


var max_offset := Vector2(100, 75)
var shake: float = 0.5
var shake_power: int = 2
var window_original_position: Vector2

var shake_window: bool = false
var passthrough: bool = false



func _ready() -> void:
	randomize()


func _process(_delta: float) -> void:
	$LabelScreenSize.text = "Screen Size: " + var_to_str(DisplayServer.screen_get_size().x) + "x" + var_to_str(DisplayServer.screen_get_size().y) + "\n" + "Window Size: " + var_to_str(DisplayServer.window_get_size().x) + "x" + var_to_str(DisplayServer.window_get_size().y)
	
	if shake_window:
		var amount = pow(shake, shake_power)
		DisplayServer.window_set_position(Vector2(window_original_position.x + max_offset.x * amount * randf_range(-1, 1), window_original_position.y + max_offset.y * amount * randf_range(-1, 1)))



func _on_button_shake_pressed() -> void:
	$TimerShake.start()
	shake_window = true
	window_original_position = DisplayServer.window_get_position()
	


func _on_timer_shake_timeout() -> void:
	shake_window = false
	DisplayServer.window_set_position(window_original_position)


func _on_button_transparency_pressed() -> void:
	get_tree().get_root().transparent = !get_tree().get_root().transparent
	get_tree().get_root().transparent_bg = !get_tree().get_root().transparent_bg


func _on_button_passthrough_pressed() -> void:
	match passthrough:
		true:
			DisplayServer.window_set_mouse_passthrough([])
		false:
			DisplayServer.window_set_mouse_passthrough([$ButtonPassthrough.position, Vector2($ButtonPassthrough.position.x + $ButtonPassthrough.size.x, $ButtonPassthrough.position.y), $ButtonPassthrough.position + $ButtonPassthrough.size, Vector2($ButtonPassthrough.position.x, $ButtonPassthrough.position.y + $ButtonPassthrough.size.y)])
	passthrough = !passthrough
