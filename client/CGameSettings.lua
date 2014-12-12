-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: GameSettings				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

GameSettings = {};
GameSettings.__index = GameSettings;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function GameSettings:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// TriggerBack 		//////
-- ///////////////////////////////

function GameSettings:TriggerBack(url)
	self.soundStreamURL = url;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function GameSettings:Constructor(...)
	self.joinGarageFunc = function()
		world:Stop();
	end
	self.eventFunc = function(...) self:TriggerBack(...); end

	addEvent("Player:GetSoundTrackURLBack", true);

	bindKey("h", "down", self.joinGarageFunc);
	
	localPlayer:TriggerEvent("Player:GetSoundTrackURL");
	
	
	addEventHandler("Player:GetSoundTrackURLBack", getLocalPlayer(), self.eventFunc);
	logger:OutputInfo("[CALLING] GameSettings: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function GameSettings:Destructor()
	unbindKey("h", "down", self.joinGarageFunc);
end

-- EVENT HANDLER --
