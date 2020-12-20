extends Node
###############################################
#### NullNeskes's Network Singleton 1.0.2 #####
###############################################

# Client Class
# vars:#
#   id: id of the client
#   clientname: name of the client
#   state: state of the client, one of the followings PREGAME_UNREADY, PREGAME_READY, GAME, SPECTATOR.

#Functions
# host_server(port,maxpeers,hostname,pass)
# accept_new_connections() #run on host to accept new connections
# refuse_new_connections() #run on host to deny new connections
# join_server(ip,port,clientname,pass) 
# ready_up() #run locally on a client you want to ready up
# cancel_ready_up() #run locally on a client you want to cancel a ready up
# set_as_spectator() #run locally on a client you want to make a non-participating player
# set_as_ingame() #run locally on a client you want's state to change to GAME
# check_players_ready() #checks if all clients are ready
# start_game() #run this on the host to start the game after the ready phase
# end_connection(reason) ##Remotely run this on the client you want to kick

#Signals
# server_startup_ok() Emits to host when the server has started up sucessfully
# server_startup_failed() Emits to host when the server has failed to startup 
# client_authorized(id) Emits to only the host, when a client is authorized()
# client_connected(id) Emits to other host/clients (not self) when a client has connected, sending its ID as a argument
# client_disconnected(id) Emits to other host/clients (not self) when a client has disconnected, sending its ID as a argument
# client_ready_change(id) Emits to other host/clients (not self) when a client has toggled ready/unready
# connection_ok() Emits to client (not host, not other clients) when they connect successfully
# connection_authorized() Emits to client (not host, not other clients) when they are authorized
# connection_success() Emits to client (not host, not other clients) when they are fully authorized, and have made a client node
# connection_lost() Emits to client (not host, not other clients) when they fail to connect
# server_disconnected() Emits to clients (not host) when the server is disconnected
# client_list_updated() Emits to everyone when the client list is updated


#Defaults
const DEFAULT_PORT = 7777
const DEFAULT_MAX_PEERS = 4
const DEFAULT_PASSWORD = ""

#Variables
enum SERVERSTATE {SETUP,PREGAME,INGAME}
var clients = {}
var name
var server_password = DEFAULT_PASSWORD
sync var state = SETUP

#Classes
class client extends Node:
	enum CLIENTSTATE {PREGAME_UNREADY, PREGAME_READY, GAME, SPECTATOR}
	var id
	var clientname
	slave var state
	
	func _init(_id,_name):
		set_network_master(_id)
		set_name(str(_id))
		id = _id
		clientname = _name
		state = PREGAME_UNREADY
		
	func ready():
		state = PREGAME_READY
		rset("state",PREGAME_READY)
		rpc("emit_state_change")
	func unready():
		state = PREGAME_UNREADY
		rset("state",PREGAME_UNREADY)
		rpc("emit_state_change")
	func set_as_spectator():
		state = SPECTATOR
		rset("state",SPECTATOR)
		rpc("emit_state_change")
	func set_as_ingame():
		state = GAME
		rset("state",GAME)
		rpc("emit_state_change")
		
	func refresh_state():
		rset("state",state)
	
	sync func emit_state_change():
		NET.emit_signal("client_ready_change")

#Signals
signal server_startup_ok()
signal server_startup_failed()
signal client_authorized(id)
signal client_connected(id) 
signal client_created(id)
signal client_disconnected(id) 
signal client_ready_change(id)
signal connection_ok()
signal connection_authorized()
signal connection_success()
signal connection_lost()
signal server_disconnected()
signal client_list_updated()

## Functions
func host_server(port=DEFAULT_PORT,max_peers=DEFAULT_MAX_PEERS,hostname="",password=null):
	if (state != SETUP):
		print("Error setting up server. Server is already setup")
		return
	#Make the server
	name = hostname
	server_password = password
	var host = NetworkedMultiplayerENet.new()
	host.create_server(port, max_peers)
	get_tree().set_network_peer(host)
	_make_client(1,name)
	if(get_tree().is_network_server()):
		rset("state",PREGAME)
		server_password = password
		emit_signal("server_startup_ok")
		print("Server: Server has started")
	else:
		emit_signal("server_startup_failed")
		get_tree().set_network_peer(null)

func accept_new_connections():
	get_tree().set_refuse_new_network_connections(false)
	print("Server: Allowing new connections")
	
func refuse_new_connections():
	get_tree().set_refuse_new_network_connections(true)
	print("Server: Refusing new connections")
	
func join_server(ip="127.0.0.1", port=DEFAULT_PORT,clientname="",password=null):
	name = clientname
	server_password = password
	var client = NetworkedMultiplayerENet.new()
	client.create_client(ip, port)
	get_tree().set_network_peer(client)
	print("connecting to:", ip,":",port)
	
func ready_up():
	clients[get_tree().get_network_unique_id()].ready()
	
func cancel_ready_up():
	clients[get_tree().get_network_unique_id()].unready()
	
func set_as_spectator():
	clients[get_tree().get_network_unique_id()].set_as_spectator()
	
func set_as_ingame():
	clients[get_tree().get_network_unique_id()].set_as_ingame()

func check_players_ready():
	for y in clients:
		var x = clients[y]
		if(x.state == x.SPECTATOR):
			continue
		if(x.state == x.PREGAME_UNREADY):
			return false
	return true

func start_game():
	if(state == SETUP):
		print("Error starting game, server not setup")
		return
	if(state == INGAME):
		print("Error starting game, game already started")
	rset("state",INGAME)

remote func end_connection(reason=""):
	get_tree().set_network_peer(null)
	for x in clients:
		clients[x].queue_free()
	clients = {}
	state = SETUP
	name = null
	server_password = DEFAULT_PASSWORD
	print("disconnected from the server, reason: ",reason)
	##this restores NET.gd to its initial state
	
####
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func _exit_tree():
	get_tree().set_network_peer(null)

func _player_connected(id):
	print(id," has connected")
	emit_signal("client_connected",id)
	
func _player_disconnected(id):
	print(id," has disconnected")
	_remove_client(id)
	emit_signal("client_disconnected",id)

func _connected_ok():
	print("connection successful")
	_check_authorization(get_tree().get_network_unique_id(),server_password,name)
	emit_signal("connection_ok")

func _connected_fail():
	print("connection failed/lost")
	emit_signal("connection_failed")

func _server_disconnected():
	print("server connection failed/lost")
	emit_signal("server_disconnected")
	end_connection()
	
remote func _check_authorization(id,password,name):
	if(!get_tree().is_network_server()): ## Not the host
		rpc_id(1,"_check_authorization",id,password,name)
	else:
		if(server_password == ""):
			_authorize_client(id,name)
			emit_signal("client_authorized",id)
		elif(server_password == password):
			_authorize_client(id,name)
			emit_signal("client_authorized",id)
		else:
			_refuse_client(id)
			
func _authorize_client(id,clientname):
	rpc_id(id,"_connection_authorized")
	print("making client"," ",id," ",clientname)
	_make_client(id,clientname) #Make client for host
	rpc_id(id,"_make_client",1,name) #Make host for client
	rpc_id(id,"_make_client",id,clientname) #Make client for client
	for y in clients:
		var x = clients[y]
		print(x.id)
		if(x.id == 1 || x.id == id): continue #Dont run on host or player
		rpc_id(x.id,"_make_client",id,clientname) #Make client for everyone
		rpc_id(id,"_make_client",x.id,x.clientname) #Make everyone for player

remote func _connection_authorized():
	emit_signal("connection_authorized")

func _refuse_client(id):
	print("refusing client", id)
	rpc_id(id,"disconnect","bad password")
	
remote func _make_client(clientid,clientname):
	var c = client.new(clientid,clientname)
	connect("client_list_updated",c,"refresh_state")
	add_child(c)
	clients[clientid] = c
	print(clients)
	call_deferred("emit_signal","client_list_updated")
	if(clientid == get_tree().get_network_unique_id()): #ifself
		call_deferred("emit_signal","connection_success")
	
remote func _remove_client(clientid):
	var c = clients[clientid]
	clients.erase(clientid)
	c.queue_free()
	print(clients)
	emit_signal("client_list_updated")
