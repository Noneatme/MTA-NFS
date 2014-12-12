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
-- ///// GetHandling		//////
-- ///////////////////////////////

function Vehicle:GetHandling()
	return getVehicleHandling(self);
end

-- ///////////////////////////////
-- ///// SetHandling		//////
-- ///////////////////////////////

function Vehicle:SetHandling(...)
	return setVehicleHandling(self, ...);
end

-- ///////////////////////////////
-- ///// GetOriginalHandling//////
-- ///////////////////////////////

function Vehicle:GetOriginalHandling()
	return getOriginalHandling(self);
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
-- ///// reset				//////
-- ///////////////////////////////

function Vehicle:Reset()
	local x, y, z = getElementPosition(self);
	setElementPosition(self, x, y, z-50);
	setElementVelocity(self, 0, 0, -50);
	
	self:ToggleGhostmode(5000);
end

-- ///////////////////////////////
-- ///// toggleGhostmode	//////
-- ///////////////////////////////

function Vehicle:ToggleGhostmode(seconds)
	triggerClientEvent(getRootElement(), "Vehicle:ToggleGhostmode", self, seconds);
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
-- ///// GetID		   		//////
-- ///////////////////////////////

function Vehicle:GetID()
	return tonumber(self:GetData(nil, "ID"));
end

-- ///////////////////////////////
-- ///// ElementTree    	//////
-- ///////////////////////////////

function Vehicle:NewElementTree()
	if(self["ElementTree"]) then
		for index, data in pairs(self["ElementTree"]) do
			setElementData(self, index, nil);
		end
	end
	self["ElementTree"] = {};
	logger:OutputInfo("Element Tree for vehicle: "..self:GetName().." deleted");
end


-- ///////////////////////////////
-- ///// SaveData	    	//////
-- ///////////////////////////////

function Vehicle:SaveData(typ, index, key)
	if(typ == "account") then
		connectionManager:Query("UPDATE tblCarData SET "..index.." = '"..key.."' WHERE ID = '"..self:GetID().."';", true)
	end
end

-- ///////////////////////////////
-- ///// SetData	    	//////
-- ///////////////////////////////

function Vehicle:SetData(typ, index, key, doNotSave)
	assert(self["ElementTree"] ~= nil);
	if(typ) then
		typ = string.lower(typ);
		if not(self["ElementTree"][typ]) then
			self["ElementTree"][typ] = {};
		end
		self["ElementTree"][typ][index] = key;
		setElementData(self, typ..":"..index, key);
		if(doNotSave ~= true) then
			self:SaveData(typ, index, key);
		end
	else
		self["ElementTree"][index] = key;
		setElementData(self, index, key);
	end
end

-- ///////////////////////////////
-- ///// GetData	    	//////
-- ///////////////////////////////

function Vehicle:GetData(typ, index)
	if not(self["ElementTree"]) then
		return false;
	end
	if(typ) then
		typ = string.lower(typ);
		if not(self["ElementTree"][typ]) then
			self["ElementTree"][typ] = {};
		end
		return self["ElementTree"][typ][index];
	else
		return self["ElementTree"][index];
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Vehicle:constructor(...)
	self["ElementTree"] = {};

	self:SetHandling("mass", tonumber(self:GetHandling()["mass"]));
	self:SetHandling("turnMass", tonumber(self:GetHandling()["turnMass"]));
	
	self.resetVehicleFunc = function() self:Reset() end;
	
	addEvent("Vehicle:Reset", true)
	addEventHandler("Vehicle:Reset", self, self.resetVehicleFunc);
	
	--logger:OutputInfo("[CALLING] Vehicle: Constructor");
end

registerElementClass("vehicle", Vehicle);
-- EVENT HANDLER --
