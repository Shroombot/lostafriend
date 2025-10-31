extends LineEdit
var commands = {
	"clear" : empty,
	"code" : get_code,
	"shooter" : shooter
}

func _on_text_submitted(new_text: String) -> void:
	for i in commands:
		if new_text.contains(i):
			var command: Callable = commands[i]
			command.call()
			#if is_int(new_text):
				#print(get_int(new_text))
				#command.call(get_int(new_text))
	clear()

func is_int(string: String):
	for i: String in string:
		if i.is_valid_int():
			return true
	return false

func get_int(string: String):
	var temp : String = ""
	for i: String in string:
		if i.is_valid_int():
			temp += i
	return int(temp)

#Commands
func empty():
	$"../page/TextEdit".clear()

func get_code():
	$"../page/TextEdit".text += "\n" + $"..".peer.online_id
	#$"../page/TextEdit".text = ""

func shooter():
	if multiplayer.is_server():
		$"../page/TextEdit".text = "Shooter game activated"
		for i in $"../players".get_children():
				i.set_ship()
	else:
		$"../page/TextEdit".text += "\n" + "Start a session before playing"
