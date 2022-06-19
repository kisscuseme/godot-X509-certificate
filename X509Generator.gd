extends Node

var base_path = "user://Certificate/"
var X509_cert_filename = "X509_Certificate.crt"
var X509_key_filename = "X509_Key.key"
onready var X509_cert_path = base_path + X509_cert_filename
onready var X509_key_path = base_path + X509_key_filename

var CN = "Simple Game Wannabe"
var O = "Simple Game Wannabe"
var C = "KR"
var not_before = "20220619000000"
var not_after = "20220618235900"

func _ready():
	var directory = Directory.new()
	if directory.dir_exists(base_path):
		pass
	else:
		directory.make_dir(base_path)
	CreateX509Cert()
	print("Certificate Created")


func CreateX509Cert():
	var CNOC = "CN=" + CN + ",O=" + O + ",C=" + C
	var crypto = Crypto.new()
	var crypto_key = crypto.generate_rsa(4096)
	var X509_cert = crypto.generate_self_signed_certificate(crypto_key, CNOC, not_before, not_after)
	X509_cert.save(X509_cert_path)
	crypto_key.save(X509_key_path)
