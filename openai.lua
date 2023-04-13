local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("dkjson")

---@class OpenAI : table<string, OpenAI>
---@field org_key string #Ключ организации
---@field sec_key string #секретный ключ доступа
---@operator call:table #запрос на сервер
local o = {uri = [[https://api.openai.com/v1]]}

function o.__index(self, key)
	if o[key] then return o[key] end
	self.uri = self.uri .. "/" .. key
	return self
end

function o.__call(self, req_data)
	local resq_data = {}
	local req = {
		url = self.uri,
		sink = ltn12.sink.table(resq_data),
		headers = {
			["Authorization"] = "Bearer "..self.sec_key,
			["OpenAI-Organization"] = self.org_key,
		}
	}
	if req_data then
		req["Content-Type"] = "application/json"
		req.method = "POST"
		req.source = ltn12.source.string(json.encode(req_data))
	end
	assert(https.request(req))
	self.uri = o.uri
	return json.decode(table.concat(resq_data))
end

---Создает экземпляр для запросов на сервер
---@param sec string #секретный ключ доступа
---@param org string? #ключ организации
---@return OpenAI
return function(sec, org)
	local newoai = setmetatable({}, o)
	newoai.org_key = org
	newoai.sec_key = sec

	return newoai
end
