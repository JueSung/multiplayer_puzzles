extends CanvasLayer
class_name HUD

func _ready():
	$Host_Game.visible = true
	$Join_Game.visible = true
	$Start_Game.visible = false
	$ReturnToTitlePage.visible = false
	$IP.visible = false
	$Port.visible = false
	$WaitingToStart.visible = false

#called by main from host_game button
func host_game():
	$Host_Game.visible = false
	$Join_Game.visible = false
	$Start_Game.visible = true
	$ReturnToTitlePage.visible = true
	$IP.visible = false
	$Port.visible = false
	$WaitingToStart.visible = false
	
#called by main from join_game button where need to input IP and port still
func enter_ip_info():
	$Host_Game.visible = false
	$Join_Game.visible = true
	$Start_Game.visible = false
	$ReturnToTitlePage.visible = true
	$IP.visible = true
	$Port.visible = true
	$WaitingToStart.visible = false

func join_game():
	$Host_Game.visible = false
	$Join_Game.visible = false
	$Start_Game.visible = false
	$ReturnToTitlePage.visible = true
	$IP.visible = false
	$Port.visible = false
	$WaitingToStart.visible = true

func start_game():
	visible = false

#return to title page from hosting/joining/waiting to start
func return_to_title_page():
	visible = true
	$Host_Game.visible = true
	$Join_Game.visible = true
	$Start_Game.visible = false
	$ReturnToTitlePage.visible = false
	$IP.visible = false
	$Port.visible = false
	$WaitingToStart.visible = false
	
	$IP.text = ""
	$Port.text = ""
