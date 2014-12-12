-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: VehicleControls		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

VehicleControls = {};
VehicleControls.__index = VehicleControls;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function VehicleControls:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// ToggleMouse 		//////
-- ///////////////////////////////

function VehicleControls:ToggleMouse(_, state)
	if(state == "down") then
		showCursor(false);
	else
		showCursor(true, false);
	end
end

-- ///////////////////////////////
-- ///// ToggleReset 		//////
-- ///////////////////////////////

function VehicleControls:ToggleReset(_, state)
	if not(isTimer(self.vcTimer)) then
	
		if(localPlayer:GetVehicle():GetSpeed() < 10) then
			localPlayer:GetVehicle():Reset();
			
			self.vcTimer = setTimer(function() end, 5000, 1);
		end
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function VehicleControls:Constructor(...)
	self.toggleMouseFunction = function(...)
		self:ToggleMouse(...)
	end
	
	self.toggleResetFunction = function(...)
		self:ToggleReset(...);
	end

	bindKey("mouse2", "both", self.toggleMouseFunction);
	bindKey("backspace", "down", self.toggleResetFunction);
	
	logger:OutputInfo("[CALLING] VehicleControls: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function VehicleControls:Destructor(...)
	unbindKey("mouse2", "both", self.toggleMouseFunction);
	unbindKey("backspace", "down", self.toggleResetFunction);
	
	logger:OutputInfo("[CALLING] VehicleControls: Destructor");
end


-- EVENT HANDLER --
