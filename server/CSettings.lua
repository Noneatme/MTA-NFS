-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Settings			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

Settings = {}
Settings.__index = Settings


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Settings:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Settings:Constructor(...)
	setFPSLimit(60)
	outputDebugString("SERVER: Settings Constructor called")
end

-- EVENT HANDLER --


function outputChatBox(text, player, r, g, b, channel)
	return triggerClientEvent(player, "ChatBox:SendTextBack", player, (channel or "System"), text, r, g, b);
end
