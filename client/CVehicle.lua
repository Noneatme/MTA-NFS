-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: CVehicle.lua		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Vehicle = {};
Vehicle.__index = Vehicle;



-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////

-- ///////////////////////////////
-- ///// GetPowerLevel		//////
-- ///////////////////////////////

function Vehicle:GetPowerLevel(basis)
	local pl = 0;
	if not (basis) then 
		local handling = self:GetHandling();
		
		pl = math.floor(handling['engineAcceleration']*handling['maxVelocity']*handling['tractionMultiplier']+handling['numberOfGears']);
		
	end
	return pl;
end

-- ///////////////////////////////
-- ///// GetAcceleration	//////
-- ///////////////////////////////

function Vehicle:GetAccelerationToNumber()
	local handling = self:GetHandling();
	
	return math.floor((handling['engineAcceleration']*3)*10);
end

-- ///////////////////////////////
-- ///// GetMaxSpeed		//////
-- ///////////////////////////////

function Vehicle:GetMaxSpeedToNumber()
	local handling = self:GetHandling();
	
	return math.floor(handling['maxVelocity']*3);
end

-- ///////////////////////////////
-- ///// GetGear			//////
-- ///////////////////////////////

function Vehicle:GetGear()
	return getVehicleCurrentGear(self);
end

-- ///////////////////////////////
-- ///// GetHandling		//////
-- ///////////////////////////////

function Vehicle:GetHandlingToNumber()
		
	local handling = self:GetHandling();
	
	return math.floor((handling['steeringLock']+handling['brakeBias']+handling['engineInertia']*3)*10);
end

-- ///////////////////////////////
-- ///// GetRPM				//////
-- ///////////////////////////////

-- Made by Sam@ke
function Vehicle:GetRPM()
	local selfRPM = 0;
	if(isVehicleOnGround(self))then
		if(getVehicleEngineState(self)==true)then
			if(getVehicleCurrentGear(self)>0)then
				selfRPM=math.floor(((self:GetSpeed()/getVehicleCurrentGear(self))*220)+0.5)
				if(selfRPM<650)then
					selfRPM=math.random(650,750)
				elseif(selfRPM>=9800)then
					selfRPM=9800
				end
			else
				selfRPM=math.floor(((self:GetSpeed()/1)*220)+0.5)
				if(selfRPM<650)then
					selfRPM=math.random(650,750)
				elseif(selfRPM>=9800)then
					selfRPM=9800
				end
			end
		else
			selfRPM=0
		end
	else
		if(getVehicleEngineState(self)==true)then
			selfRPM=selfRPM-150
			if(selfRPM<650)then
				selfRPM=math.random(650,750)
			elseif(selfRPM>=9800)then
				selfRPM=9800
			end
		else
			selfRPM=0
		end
	end
	return tonumber(selfRPM)
end

-- ///////////////////////////////
-- ///// GetSpeed			//////
-- ///////////////////////////////

function Vehicle:GetSpeed(unit)
	local x,y,z = getElementVelocity(self)
	if (unit=="mph" or unit==1 or unit =='1') then
		return math.round((x^2 + y^2 + z^2) ^ 0.5 * 100)
	else
		return math.round((x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100)
	end
end

-- ///////////////////////////////
-- ///// GetPrice			//////
-- ///////////////////////////////

function Vehicle:GetPrice()
	local priceString = vehicleCosts.vehicleCosts[self:GetModel()];
	
	if(priceString) then
		local money, tokens = gettok(priceString, 1, ","), gettok(priceString, 2, ",");
		
		return tonumber(money), tonumber(tokens);
	end
	return 0, 0
end

-- ///////////////////////////////
-- ///// GetDriver			//////
-- ///////////////////////////////

function Vehicle:GetDriver()
	return getVehicleOccupant(self);
end

-- ///////////////////////////////
-- ///// GetPassengers		//////
-- ///////////////////////////////

function Vehicle:GetPassengers()
	return getVehicleOccupants(self);
end

-- ///////////////////////////////
-- ///// GetColor			//////
-- ///////////////////////////////

function Vehicle:GetColor()
	return getVehicleColor(self);
end

-- ///////////////////////////////
-- ///// SetColor			//////
-- ///////////////////////////////

function Vehicle:SetColor(...)
	return setVehicleColor(self, ...);
end

-- ///////////////////////////////
-- ///// GetType			//////
-- ///////////////////////////////

function Vehicle:GetType()
	return getVehicleType(self);
end

-- ///////////////////////////////
-- ///// GetName			//////
-- ///////////////////////////////

function Vehicle:GetName()
	return getVehicleName(self);
end

-- ///////////////////////////////
-- ///// GetModel			//////
-- ///////////////////////////////

function Vehicle:GetModel()
	return getElementModel(self);
end

-- ///////////////////////////////
-- ///// GetHandling		//////
-- ///////////////////////////////

function Vehicle:GetHandling()
	return getVehicleHandling(self);
end

-- ///////////////////////////////
-- ///// SetDamageProof		//////
-- ///////////////////////////////

function Vehicle:SetDamageProof(bool)
	return setVehicleDamageProof(self, bool);
end

-- ///////////////////////////////
-- ///// SetEngineState		//////
-- ///////////////////////////////

function Vehicle:SetEngineState(bool)
	return setVehicleEngineState(self, bool);
end

-- ///////////////////////////////
-- ///// IsOnGround			//////
-- ///////////////////////////////

function Vehicle:IsOnGround()
	return isVehicleOnGround(self);
end

-- ///////////////////////////////
-- ///// getPos				//////
-- ///////////////////////////////

function Vehicle:GetPos()
	return getElementPosition(self);
end

-- ///////////////////////////////
-- ///// setPos				//////
-- ///////////////////////////////

function Vehicle:SetPos(...)
	return setElementPosition(self, ...);
end

-- ///////////////////////////////
-- ///// setInt				//////
-- ///////////////////////////////

function Vehicle:SetInt(...)
	return setElementInterior(self, ...);
end

-- ///////////////////////////////
-- ///// getInt				//////
-- ///////////////////////////////

function Vehicle:GetInt()
	return getElementInterior(self);
end

-- ///////////////////////////////
-- ///// setDim				//////
-- ///////////////////////////////

function Vehicle:SetDim(...)
	return setElementDimension(self, ...);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Vehicle:GetDim()
	return getElementDimension(self);
end

-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////

-- ///////////////////////////////
-- ///// Reset				//////
-- ///////////////////////////////

function Vehicle:Reset()
	return triggerServerEvent("Vehicle:Reset", self);
end

-- ///////////////////////////////
-- ///// respawn			//////
-- ///////////////////////////////

function Vehicle:Respawn()
	return respawmVehicle(self);
end

-- ///////////////////////////////
-- ///// fix				//////
-- ///////////////////////////////

function Vehicle:Fix()
	return fixVehicle(self);
end

-- ///////////////////////////////
-- ///// blow				//////
-- ///////////////////////////////

function Vehicle:Blow()
	return blowVehicle(self);
end

-- ///////////////////////////////
-- ///// addUpgrade			//////
-- ///////////////////////////////

function Vehicle:AddUpgrade(...)
	return addVehicleUpgrade(self, ...);
end

-- ///////////////////////////////
-- ///// removeUpgrade		//////
-- ///////////////////////////////

function Vehicle:RemoveUpgrade(...)
	return removeVehicleUpgrade(self, ...);
end

-- ///////////////////////////////
-- ///// toggleGhostmode	//////
-- ///////////////////////////////

function Vehicle:ToggleGhostmode(seconds)
	if(isTimer(self.ghostmodeTimer)) then
		killTimer(self.ghostmodeTimer)
	end
	setElementCollidableWith(self, getRootElement(), false);
	setElementAlpha(self, 150);
		
	self.ghostmodeTimer = setTimer(function()
		if(self) then
			setElementAlpha(self, 255);
			setElementCollidableWith(self, getRootElement(), true);
		end
	end, seconds, 1)
end



-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Vehicle:constructor(...)
	logger:OutputInfo("[CALLING] Vehicle: Constructor");
	self.toggleGhostmodeFunc = function(...) self:ToggleGhostmode(...) end;
	
	
	addEvent("Vehicle:ToggleGhostmode", true);
	
	addEventHandler("Vehicle:ToggleGhostmode", self, self.toggleGhostmodeFunc);
end

registerElementClass("vehicle", Vehicle);
-- EVENT HANDLER --
