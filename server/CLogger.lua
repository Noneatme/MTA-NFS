-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Logger				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

Logger = {}
Logger.__index = Logger


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Logger:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Logger:Constructor(...)
	
	outputDebugString("[CALLING] Logger: Constructor")
end


-- ///////////////////////////////
-- ///// outputs	 		//////
-- ///////////////////////////////

function Logger:OutputError(text)
	text = string.gsub(text, "'", "");

	if (connectionManager) and (connectionManager.connection) then
		connectionManager:Query("INSERT INTO tblLogger(Type, Message) VALUES ('Error', '" .. text .. "');", true);
	end
	return outputDebugString(text, 1);
end

function Logger:OutputWarning(text)
	text = string.gsub(text, "'", "");

	if(connectionManager) and (connectionManager.connection) then
		connectionManager:Query("INSERT INTO tblLogger(Type, Message) VALUES ('Warning', '" .. text .. "');", true);
	end
	return outputDebugString(text, 2);
end

function Logger:OutputInfo(text)
	text = string.gsub(text, "'", "");

	if(connectionManager) and (connectionManager.connection) then
		connectionManager:Query("INSERT INTO tblLogger(Type, Message) VALUES ('Information', '" .. text .. "');", true);
	end
	return outputDebugString(text, 3);
end

function Logger:OutputMySQL(typ, text)
	text = string.gsub(text, "'", "");

	if(connectionManager) and (connectionManager.connection) then
		connectionManager:Query("INSERT INTO tblLogger(Type, Message) VALUES ('"..typ.."', '" .. text .. "');", true);
	end
end


-- EVENT HANDLER --
