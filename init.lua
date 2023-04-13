local OAI = require "openai"

local oai = OAI("org_key", "sec_key")

local out = oai.models()

print(#out.data)