-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Anti Injection Class##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

AntiInjection = {};
AntiInjection.__index = AntiInjection;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function AntiInjection:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// CheckString 		//////
-- ///////////////////////////////

function AntiInjection:CheckString(s)
	for _, key in pairs(self.badWords) do
		if(string.find(string.lower(s), string.lower(key), 0, true)) then
			-- Injection Found
			return true;
		end
	end
	return false;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function AntiInjection:Constructor(...)
	self.badWords = {
		"DROP",
		"TRUNCATE",
		"DELETE",
		"UPDATE",
		"ALTER",
	};
	
	logger:OutputInfo("[CALLING] AntiInjection: Constructor");
end

-- EVENT HANDLER --
