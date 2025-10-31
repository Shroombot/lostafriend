extends Control
var peer = NodeTunnelPeer.new()
@export var player_scene: PackedScene

func _ready() -> void:
	multiplayer.multiplayer_peer = peer
	peer.connect_to_relay("relay.nodetunnel.io",9998)
	await peer.relay_connected
	$page/TextEdit.text = peer.online_id

func _on_host_pressed():
	peer.host()
	await peer.hosting
	$title.text = "Host Document"
	#$title.editable = false
	$page/TextEdit.clear()
	DisplayServer.clipboard_set(peer.online_id)
	
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	$players.call_deferred("add_child",player)

func _on_join_pressed():
	peer.join($title.text)
	await peer.joined
	$title.text = "Join Document"
	$page/TextEdit.clear()
