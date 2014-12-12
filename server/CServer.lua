-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: CServer				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Server = {};
Server.__index = Server;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Server:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GetNetworkStats 	//////
-- ///////////////////////////////

function Server:GetNetStats()
	return getNetworkStats();
end

-- ///////////////////////////////
-- ///// GetVersion		 	//////
-- ///////////////////////////////

function Server:GetVersion(...)
	return getVersion(...);
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Server:Constructor(...)
	
	logger:OutputInfo("[CALLING] Server: Constructor");
end

-- EVENT HANDLER --
