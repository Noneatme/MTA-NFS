-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Splatter			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

VehicleObjectDestroyer = {};
VehicleObjectDestroyer.__index = VehicleObjectDestroyer;

--[[
3057 -- Barrel
2912 - Temp Crate

3046 -- Barrel 2
1222 - barrel 3

1252 -- Bombe

--]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function VehicleObjectDestroyer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// CreateObjects 		//////
-- ///////////////////////////////

function VehicleObjectDestroyer:CreateObject()
	if(self.state == false) then
		local veh = self.vehicle;
		if(veh) then
	 		local x, y, z = getElementPosition(veh);
			
			self.barrel = {createObject(1337, x, y, z), createObject(1337, x, y, z), createObject(1337, x, y, z), createObject(1337, x, y, z)}
	
			
			local dis = getElementDistanceFromCentreOfMassToBaseOfModel(veh);
			attachElements(self.barrel[1], veh, 0.5, dis*4, 0, 90, 0, 90);
			attachElements(self.barrel[2], veh, -0.5, dis*4, 0, 90, 0, 90);
			
			attachElements(self.barrel[3], veh, 0.5, -dis*4, 0, 90, 0, 90);
			attachElements(self.barrel[4], veh, -0.5, -dis*4, 0, 90, 0, 90);
	
			self.state = true;
			
			
			for i = 1, #self.barrel, 1 do
				setElementAlpha(self.barrel[i], 0)
				setElementDimension(self.barrel[i], veh:GetDim() or 0);
				
				setObjectMass(self.barrel[i], 999999);
			end
		end
	end
end

-- ///////////////////////////////
-- ///// DestroyObjects 	//////
-- ///////////////////////////////

function VehicleObjectDestroyer:DestroyObject()
	if(self.state == true) then
		for i = 1, #self.barrel, 1 do
			destroyElement(self.barrel[i]);
		end
		self.state = false;
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function VehicleObjectDestroyer:Constructor(vehicle)

	if(isElement(vehicle)) then
		self.destroyObjectFunc = function()
			self:DestroyObject();
		end
		
		self.state = false;
		self.vehicle = vehicle;
		self:CreateObject();
		
		addEventHandler("onClientPlayerWasted", getLocalPlayer(), self.destroyObjectFunc);
		addEventHandler("onClientElementDestroy", vehicle, self.destroyObjectFunc);
		
		outputDebugString("[CALLING] VehicleObjectDestroyer: Constructor");
	end

end

-- EVENT HANDLER --



local obj = VehicleObjectDestroyer:New();