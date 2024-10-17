extends Button


var exe_link: String = ""
var pck_link: String = ""
var version_link: String = ""

var exe_path: String = ""
var pck_path: String = ""
var version_path: String = ""

var http_request: HTTPRequest

func _ready() -> void:
	self.disabled = true


func file_exists(path: String) -> bool:
	var dir = 2 #Directory.new()
	return dir.file_exists(path)


func verify_gamefiles():
	# Check if files are complete 
	if file_exists(exe_path) && file_exists(pck_path) && file_exists(version_path):
		# Update
		pass
	else: 
		# download
		pass


func download_files(link: String, path: String, just_version: bool):
	# Create an HTTPRequest node and connect its completion signal
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	self.text = "Downloading " + str(path.get_file())
	http_request.connect("request_completed", _install_file) # [path, just_version])
	
	# Handle errors
	var error = http_request.request_raw(link)
	if error != OK:
		self.text = "Download error: " + str(error)
		
# Is called when download is complete
func _install_file(_result, _response_code, _headers, body, path, just_version: bool):
	if just_version:
		var new_version = str(body.get_string_from_utf8())
		 ## compare version
		return
		
	var dir = 2 # Directory.new()
	dir.remove(path)
	
	var file = 2 # File.new()
	# file.open(path, File.WRITE)
	file.store_buffer(body)
	file.close()
	## Check integrity

func check_integrity():
	if !file_exists(exe_path):
		download_files(exe_link, exe_path, false)
		print("no exe")
		return
	
	
	
