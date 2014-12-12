-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Compiled			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Compiled = {};
Compiled.__index = Compiled;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Compiled:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Compiled:Constructor(...)
	_G["g_serverLicense"] = toJSON("MTASR-1000-19-12-16");
	
	logger:OutputInfo("[CALLING] Compiled: Constructor");
end

-- EVENT HANDLER --
