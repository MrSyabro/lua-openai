package = "cardwallet_tbot"
version = "dev-1"
source = {
   url = "git+https://git@github.com/MrSyabro/lua-openai.git",
   branch = "master",
}
description = {
   homepage = "Простая библиотека для доступа к OpenAI API",
   license = "MIT/X11",
   maintainer = "MrSyabro",
}
dependencies = {
   "lua >= 5.2",
   "luafilesystem",
   "luasocket",
   "luasec",
   "dkjson"
}
build = {
   type = "builtin",
   modules = {openai = "openai.lua"},
}
