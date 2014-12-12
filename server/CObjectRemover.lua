-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: ObjectRemover		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

ObjectRemover = {};
ObjectRemover.__index = ObjectRemover;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function ObjectRemover:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// RemoveObjects 		//////
-- ///////////////////////////////

function ObjectRemover:RemoveObjects()
	logger:OutputInfo("Removing Objects...");
	
	-- SPAWN --
	removeWorldModel(10368, 50, -2655.125, -15.421875, 23.8125);
	removeWorldModel(10317, 50, -2655.125, -15.421875, 23.8125);
	removeWorldModel(1308, 100, -2655.125, -15.421875, 23.8125);
	
	-- OCCLUSIONS --
	setOcclusionsEnabled(false);
	
	logger:OutputInfo("Objects Removed!");
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function ObjectRemover:Constructor(...)
	
	
	logger:OutputInfo("[CALLING] ObjectRemover: Constructor");
end

-- EVENT HANDLER --
