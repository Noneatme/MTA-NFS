-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Traffic Lights Class##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

TrafficLights = {};
TrafficLights.__index = TrafficLights;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function TrafficLights:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Set Of of Order 	//////
-- ///////////////////////////////

function TrafficLights:ToggleOutOfOrder(state)
	if(state == true) then
		assert(self.state == false);
		self.state = true;
		self.outOfOrdnerTimer = setTimer(self.outOfOrderFunction, 500, -1);
	else
		assert(self.state == true);
		self.state = false;
		killTimer(self.outOfOrdnerTimer);
	end
end

-- ///////////////////////////////
-- ///// OutOfOrder 		//////
-- ///////////////////////////////

function TrafficLights:OutOfOrder()
	if(getTrafficLightState() == 9) then
		setTrafficLightState(6)
	else
		setTrafficLightState(9)
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function TrafficLights:Constructor(...)
	self.outOfOrderFunction = function()
		self:OutOfOrder();
	end
	self.state = true;
	self.outOfOrdnerTimer = setTimer(self.outOfOrderFunction, 500, -1);
	logger:OutputInfo("[CALLING] TrafficLights: Constructor");
end

-- EVENT HANDLER --
