name "sw-shoplift"
author "Swompen"
version "v1.0.0"
description "Simple shoplift script"

fx_version 'cerulean'
games { 'gta5' }

shared_scripts {
	'config.lua'
}

client_scripts {
	'cl_shoplift.lua'
}

server_scripts {
	'sv_shoplift.lua'
}