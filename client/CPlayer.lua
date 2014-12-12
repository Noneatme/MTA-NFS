-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: CPlayer				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Player = {};
Player.__index = Player;

-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////


-- ///////////////////////////////
-- ///// getName         	//////
-- ///////////////////////////////

function Player:GetName()
	return getPlayerName(self);
end

-- ///////////////////////////////
-- ///// getPing         	//////
-- ///////////////////////////////

function Player:GetPing()
	return getPlayerPing(self);
end


-- ///////////////////////////////
-- ///// getVehicle         //////
-- ///////////////////////////////

function Player:GetVehicle()
	return getPedOccupiedVehicle(self);
end

-- ///////////////////////////////
-- ///// getPos				//////
-- ///////////////////////////////

function Player:GetPos()
	return gtElementPosition(self);
end

-- ///////////////////////////////
-- ///// setPos				//////
-- ///////////////////////////////

function Player:SetPos(...)
	return setElementPosition(self, ...);
end

-- ///////////////////////////////
-- ///// setInt				//////
-- ///////////////////////////////

function Player:SetInt(...)
	return setElementInterior(self, ...);
end

-- ///////////////////////////////
-- ///// getInt				//////
-- ///////////////////////////////

function Player:GetInt()
	return getElementInterior(self);
end

-- ///////////////////////////////
-- ///// setDim				//////
-- ///////////////////////////////

function Player:SetDim(...)
	return setElementDimension(self, ...);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Player:GetDim()
	return getElementDimension(self);
end

-- ///////////////////////////////
-- ///// GetCurrentVehicle	//////
-- ///////////////////////////////

function Player:GetCurrentVehicle()
	return getElementData(localPlayer, "account:Car");
end

-- ///////////////////////////////
-- ///// GetVehicle	//////
-- ///////////////////////////////

function Player:GetVehicle()
	return getPedOccupiedVehicle(self);
end


-- ///////////////////////////////
-- ////GetCurrentVehicleAsData////
-- ///////////////////////////////

function Player:GetCurrentVehicleAsData()
	local resultSet = getElementData(localPlayer, "account:CarResultSet")
	for index, row in pairs(resultSet) do
		if(tonumber(row['ID']) == tonumber(self:GetCurrentVehicle())) then
			return row;
		end
	end
	return false;
end

-- ///////////////////////////////
-- ///// getEMail	    	//////
-- ///////////////////////////////

function Player:GetEMail()

	return getElementData(localPlayer, "account:EMail");
end

-- ///////////////////////////////
-- ///// getCarsAsTable	   	//////
-- ///////////////////////////////

function Player:GetCarsAsTable()
	local tbl = {}
	local i = 1;
	for index, row in pairs(getElementData(localPlayer, "account:CarResultSet")) do
		tbl[i] = row;
		i = i+1
	end
	return tbl;
end

-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////

-- ///////////////////////////////
-- ///// IsLoggedIn        	//////
-- ///////////////////////////////

function Player:IsLoggedIn()
	if(getElementData(self, "loggedIn") == true) then
		return true;
	else
		return false;
	end
end	
-- ///////////////////////////////
-- ///// UpdateSelectedCar  //////
-- ///////////////////////////////

function Player:UpdateSelectedCar(id)
	return triggerServerEvent("Player:UpdateSelectedCar", self, id);
end

-- ///////////////////////////////
-- ///// BuyCar				//////
-- ///////////////////////////////

function Player:BuyCar(id, rad1, rad2)
	return triggerServerEvent("Player:BuyVehicle", self, id, rad1, rad2);
end

-- ///////////////////////////////
-- ///// SellVehicle		//////
-- ///////////////////////////////

function Player:SellVehicle(id)
	return triggerServerEvent("Player:SellVehicle", self, id);
end

-- ///////////////////////////////
-- ///// ShowServerLicense	//////
-- ///////////////////////////////

function Player:ShowServerLicense()
	return triggerServerEvent("Player:ShowLicense", self);
end

-- ///////////////////////////////
-- ///// KickMe				//////
-- ///////////////////////////////

function Player:KickMe()
	return triggerServerEvent("Player:KickMeResolution", self);
end

-- ///////////////////////////////
-- ///// TriggerEvent		//////
-- ///////////////////////////////

function Player:TriggerEvent(name, ...)
	return triggerServerEvent(name, self, ...);
end

-- ///////////////////////////////
-- ///// JoinWorld			//////
-- ///////////////////////////////

function Player:JoinWorld()
	chatBox:Show();
	
	showCursor(true, false);
	return triggerServerEvent("Player:OnWorldJoin", self);
end

-- ///////////////////////////////
-- ///// JoinGarage			//////
-- ///////////////////////////////

function Player:JoinGarage()
	chatBox:Hide();
	
	showCursor(true, false);
	return triggerServerEvent("Player:OnGarageJoin", self);
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Player:constructor()
	self["ElementTree"] = {};
	outputDebugString("[CALLING] Player: Constructor");
	
	self.enableVehicleObjectFunc = function(veh) VehicleObjectDestroyer:New(veh) end 
	
	addEvent("Player:EnableVehicleObjectDestroyer", true)
	
	addEventHandler("Player:EnableVehicleObjectDestroyer", self, self.enableVehicleObjectFunc);
end

-- EVENT HANDLER --
registerElementClass("player", Player);


enew(getLocalPlayer(), Player);