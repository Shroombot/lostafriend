extends Node2D
 
var peer = NodeTunnelPeer.new()
@export var player_scene: PackedScene

func _ready() -> void:
	multiplayer.multiplayer_peer = peer
	peer.connect_to_relay("relay.nodetunnel.io",9998)
	await peer.relay_connected
	%online_id.text = peer.online_id

func _on_host_pressed():
	peer.host()
	
	await peer.hosting
	$Panel.visible = false
	
	DisplayServer.clipboard_set(peer.online_id)
	
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
 
func _on_join_pressed():
	peer.join(%host_online_id.text)
	await peer.joined
	$Panel.visible = false
