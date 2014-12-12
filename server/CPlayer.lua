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
-- ///// getIP          	//////
-- ///////////////////////////////

function Player:GetIP()
	return getPlayerIP(self);
end


-- ///////////////////////////////
-- ///// getSerial         	//////
-- ///////////////////////////////

function Player:GetSerial()
	return getPlayerSerial(self);
end

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
-- ///// getEMail	    	//////
-- ///////////////////////////////

function Player:GetEMail()
	assert(self["ElementTree"] ~= nil);
	return self:GetData("account", "EMail");
end

-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////



-- ///////////////////////////////
-- ///// WarpInto         	//////
-- ///////////////////////////////

function Player:WarpInto(vehicle, ...)
	self.vehicle = vehicle
	return warpPedIntoVehicle(self, vehicle, ...);
end

-- ///////////////////////////////
-- ///// TriggerEvent       //////
-- ///////////////////////////////

function Player:TriggerEvent(eventname, ...)
	return triggerClientEvent(self, eventname, self, ...);
end

-- ///////////////////////////////
-- ///// ShowMessageBox 	//////
-- ///////////////////////////////

function Player:ShowMessageBox(...)
	return self:TriggerEvent("Player:ShowMessageBox", ...);
end
-- ///////////////////////////////
-- ///// spawn         	//////
-- ///////////////////////////////

function Player:Spawn(...)
	return spawnPlayer(self, ...);
end


-- ///////////////////////////////
-- ///// ElementTree    	//////
-- ///////////////////////////////

function Player:NewElementTree()
	if(self["ElementTree"]) then
		for index, data in pairs(self["ElementTree"]) do
			setElementData(self, index, nil);
		end
	end
	self["ElementTree"] = {};
	logger:OutputInfo("Element Tree for player: "..self:GetName().." deleted");
end


-- ///////////////////////////////
-- ///// SaveData	    	//////
-- ///////////////////////////////

function Player:SaveData(typ, index, key)
	if(typ == "account") then
		connectionManager:Query("UPDATE tblAccounts SET "..index.." = '"..key.."' WHERE EMail = '"..self:GetEMail().."';", true)
	end
end

-- ///////////////////////////////
-- ///// SetData	    	//////
-- ///////////////////////////////

function Player:SetData(typ, index, key, doNotSave)
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

function Player:GetData(typ, index)
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
-- ///// IsLoggedIn     	//////
-- ///////////////////////////////

function Player:IsLoggedIn()
	if(self:GetData(nil, "loggedIn") == true) then
		return true;
	else
		return false;
	end
end
-- ///////////////////////////////
-- /////checkForNoVehicle  	//////
-- ///////////////////////////////

function Player:CheckForNoVehicle()
	local result, numrows = connectionManager:Query("SELECT * FROM tblautos WHERE Owner = '"..self:GetEMail().."';");
	
	if(numrows < 1) then -- No Vehicle
		connectionManager:Query("INSERT INTO tblautos(Owner) VALUES ('"..self:GetEMail().."');");
		local lid = connectionManager:Query("SELECT ID FROM tblautos WHERE Owner = '"..self:GetEMail().."'");
		self:ShowMessageBox("Your first car!", "You got a new car:\nClover!\nYou can select the car in your garage.", "Okay", "sucess");
		logger:OutputInfo("Inserting the first car for player: "..self:GetEMail());
		self:SetData("account", "Car", lid[1]['ID'])
		self:UpdateCarTable();
	end
end

-- ///////////////////////////////
-- ///// LogIn		     	//////
-- ///////////////////////////////

function Player:LogIn(accountResult, carResult)
	-- RESULT SET --
	for key, value in pairs(accountResult) do
		if(key ~= 'Password') then
			self:SetData("account", key, value, true);
		end
	end	
	self:SetData("account", "CarResultSet", carResult, true);
		
	self:SetData(nil, "loggedIn", true)
	return true;
end

-- ///////////////////////////////
-- ///// UpdateSelectedCar	//////
-- ///////////////////////////////

function Player:UpdateSelectedCar(id)
	self:SetData("account", "Car", id);
	self:ShowMessageBox("Sucess!", "You sucessfull selected your car.", "Allright", "sucess");
end

-- ///////////////////////////////
-- ////UpdateCarTable		//////
-- ///////////////////////////////

function Player:UpdateCarTable()
	local tblCarResult = connectionManager:Query("SELECT * FROM tblautos WHERE Owner = '"..self:GetEMail().."'");
	self:SetData("account", "CarResultSet", tblCarResult, true);
	
	for index, row in pairs(tblCarResult) do
		local id = tonumber(row['ID']);
		
		local result, numrows = connectionManager:Query("SELECT * FROM tblCarData WHERE ID = "..id..";");
		if(numrows < 1) then
			connectionManager:Query("INSERT INTO tblCarData (ID) VALUES ("..id..");");
			logger:OutputInfo("Adding car data table for user "..self:GetEMail().." and car ID: "..id);
		end
	end
end

-- ///////////////////////////////
-- ////GetCarResultSetFromID//////
-- ///////////////////////////////

function Player:GetCarResultSetFromID(id)
	local resultSet = self:GetData("account", "CarResultSet");
	
	for index, row in pairs(resultSet) do
		if(tonumber(row['ID']) == tonumber(id)) then
			return row;
		end 
	end
	return resultSet;
end

-- ///////////////////////////////
-- ///// addVehicle			//////
-- ///////////////////////////////

function Player:AddVehicle(id)
	local result, numrows = connectionManager:Query("INSERT INTO tblautos(Owner, Modell) VALUES ('"..self:GetEMail().."', '"..id.."');");
	if(result and numrows > 0) then

		self:ShowMessageBox("Sucess!", "A '"..getVehicleNameFromModel(id).."' has been added to your garage.", "Fuck yea!", "sucess");
		self:UpdateCarTable();
	end
end

-- ///////////////////////////////
-- ///// BuyVehicle			//////
-- ///////////////////////////////

function Player:BuyVehicle(id, rad1, rad2)
	-- rad1 = tokens, rad2 = money;
	
	if(rad2) then
		local aviableMoney = tonumber(self:GetData("account", "Dollar"))
		local needMoney = tonumber(gettok(vehicleCosts.vehicleCosts[id], 1, ","));
		
		if(aviableMoney >= needMoney) then
			self:SetData("account", "Dollar", aviableMoney-needMoney);
			
		else
			self:ShowMessageBox("Error", "You don't have enought Dollars to buy this vehicle.\n\nYou need $"..needMoney-aviableMoney.." more!", "Fuck!", "error");
			return;
		end
	elseif(rad1) then
		local aviableMoney = tonumber(self:GetData("account", "Tokens"))
		local needMoney = tonumber(gettok(vehicleCosts.vehicleCosts[id], 2, ","));
		
		if(aviableMoney >= needMoney) then
			self:SetData("account", "Tokens", aviableMoney-needMoney);
		else
			self:ShowMessageBox("Error", "You don't have enought Tokens to buy this vehicle.\n\nYou need "..needMoney-aviableMoney.." more!\n\nYou can get Tokens from our website.", "Fuck!", "error");
			return;
		end
	else
		return;
	end
	
	self:AddVehicle(id);
	
end

-- ///////////////////////////////
-- ///// SellVehicle		//////
-- ///////////////////////////////

function Player:SellVehicle(id)
	local dataSet = self:GetData("account", "CarResultSet")

	local dollar = vehicleCosts:GetSellValue(dataSet[id]['Modell']);
	
	if(#dataSet > 1) then
		if(dollar) then
			local result, numrows = connectionManager:Query("DELETE FROM tblautos WHERE Owner = '"..self:GetEMail().."' AND ID = '"..tonumber((dataSet[id]['ID'])).."';", true);
			if(result and numrows > 0) then
				self:SetData("account", "Dollar", tonumber(self:GetData("account", "Dollar"))+dollar);
				self:UpdateCarTable();
				if(tonumber(self:GetData("account", "Car")) == tonumber((dataSet[id]['ID']))) then
					self:SetData("account", "Car", tonumber(self:GetData("account", "CarResultSet")[1]['ID']));
				end
			else
				self:ShowMessageBox("Error", "A unknow error occurred.\nPlease try again later.", "Okay", "error");
			end
			
		else
			self:ShowMessageBox("Error", "You can't sell this car.", "Okay", "error");
		end
	else
		self:ShowMessageBox("Error", "You can't sell your last car!", "Okay", "error");
	end
end

-- ///////////////////////////////
-- ///// ShowLicense		//////
-- ///////////////////////////////

function Player:ShowLicense()
	return self:ShowMessageBox("Information", "Server license:\n\n"..(fromJSON(_G["g_serverLicense"]) or "not available(!)"), "Okay");
end


-- ///////////////////////////////
-- ///// CreateWorldVehicle	//////
-- ///////////////////////////////


function Player:CreateWorldVehicle(id, x, y, z)
	if(isElement(self.vehicle)) then
		destroyElement(self.vehicle);
	end
	local resultSet = self:GetCarResultSetFromID(id);
	local dataSet = resultSet
	self.vehicle = createVehicle(tonumber(resultSet['Modell']), x, y, z);
	-- COLOR --
	self.vehicle:SetColor(tonumber(gettok(dataSet['Farbe'], 1, "|")), tonumber(gettok(dataSet['Farbe'], 2, "|")), tonumber(gettok(dataSet['Farbe'], 3, "|")), tonumber(gettok(dataSet['Farbe'], 4, "|")), tonumber(gettok(dataSet['Farbe'], 5, "|")), tonumber(gettok(dataSet['Farbe'], 6, "|")), tonumber(gettok(dataSet['Farbe'], 7, "|")), tonumber(gettok(dataSet['Farbe'], 8, "|")), tonumber(gettok(dataSet['Farbe'], 9, "|")));
	
	setVehicleDamageProof(self.vehicle, true);

	self.vehicle:SetData(nil, "ID", tonumber(resultSet['ID']));
	
	return self.vehicle;
end

-- ///////////////////////////////
-- /EnableVehicleObjectDestroyer//
-- ///////////////////////////////

function Player:EnableVehicleObjectDestroyer(vehicle)
	return self:TriggerEvent("Player:EnableVehicleObjectDestroyer", vehicle);
end


-- ///////////////////////////////
-- ///// JoinWorld			//////
-- ///////////////////////////////

function Player:JoinWorld()
	local x, y, z, rx, ry, rz

	if(tonumber(self:GetData("account", "lastx")) ~= 0) then
		x, y, z = tonumber(self:GetData("account", "lastx")), tonumber(self:GetData("account", "lasty")), tonumber(self:GetData("account", "lastz"))
		rx, ry, rz = tonumber(self:GetData("account", "lastrx")), tonumber(self:GetData("account", "lastry")), tonumber(self:GetData("account", "lastrz"))
	else
		x, y, z = -2698.5302734375, 0.42308375239372, 3.958123922348
		rx, ry, rz = 0, 0, 0
	end
	
	spawnPlayer(self, x, y, z, 0, 60)
	setElementDimension(self, 0);
	setElementInterior(self, 0);
	
	local vehicle = self:CreateWorldVehicle(tonumber(self:GetData("account", "Car")), x, y, z, rx, ry, rz);
	
	self:SetPos(x, y, z);
	toggleAllControls(self, true);
	setCameraTarget(self, self);
	
	setTimer(function() 
		self:WarpInto(vehicle, 0); 
		self:EnableVehicleObjectDestroyer(vehicle);
		
		toggleControl(self, "enter_exit", false);
	end, 50, 1)

	toggleControl(self, "enter_exit", false);
	setElementFrozen(self, false);

	self:SetData(nil, "outofgarage", true);

	self.vehicle = vehicle;
end

-- ///////////////////////////////
-- ///// JoinGarage			//////
-- ///////////////////////////////

function Player:JoinGarage()
	if(self:GetVehicle()) then
		local x, y, z = getElementPosition(self:GetVehicle());
		
		if not(x or not y or not z) then
			x, y, z = 0, 0, 0
		end
		self:SetData("account", "lastx", x);
		self:SetData("account", "lasty", y);
		self:SetData("account", "lastz", z);
		
		local rx, ry, rz = getElementRotation(self:GetVehicle());
		
		if not(rx or not ry or not rz) then
			x, y, z = 0, 0, 0
		end
		
		self:SetData("account", "lastrx", rx);
		self:SetData("account", "lastry", ry);
		self:SetData("account", "lastrz", rz);
	end
	
	removePedFromVehicle(self, self.vehicle);
	destroyElement(self.vehicle);
	
	--setElementPosition(self, 0, 0, 0);
	setElementFrozen(self, true);
	
	toggleAllControls(self, false);
	
	self:SetData(nil, "outofgarage", false);
	
end

-- ///////////////////////////////
-- ///// IsOutOfGarage		//////
-- ///////////////////////////////

function Player:IsOutOfGarage()
	return self:GetData(nil, "outofgarage");
end

-- ///////////////////////////////
-- ///// DestroyVehicle		//////
-- ///////////////////////////////


function Player:DestroyVehicle()
	destroyElement(self.vehicle);
end

-- ///////////////////////////////
-- ///// GetSoundTrackURL	//////
-- ///////////////////////////////


function Player:GetSoundTrackURL()
	return self:TriggerEvent("Player:GetSoundTrackURLBack", "http://www.yourdawi.de/noneatme/mtasr/");
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Player:constructor()
	self["ElementTree"] = {};
	logger:OutputInfo("[CALLING] Player: Constructor");
	
	self.updateSelectedCarFunc = function(...)	self:UpdateSelectedCar(...); end
	self.buyVehicleFunc = function(...)	self:BuyVehicle(...); end
	self.showLicenseFunc = function(...) self:ShowLicense(...); end
	self.kickMeFunc = function(...) kickPlayer(self, "Your resolution is too low for this server.\n\nPlease buy a flatscreen or die."); end
	self.sellVehicleFunc = function(...) self:SellVehicle(...); end
	
	self.joinWorldFunc = function(...) self:JoinWorld(...); end
	self.joinGarageFunc = function(...) self:JoinGarage(...); end
	
	self.getSoundURLFunc = function() self:GetSoundTrackURL(); end;
	
	addEvent("Player:UpdateSelectedCar", true);
	addEvent("Player:BuyVehicle", true);
	addEvent("Player:ShowLicense", true);
	addEvent("Player:KickMeResolution", true);
	addEvent("Player:SellVehicle", true);
	addEvent("Player:OnWorldJoin", true);
	addEvent("Player:OnGarageJoin", true);
	addEvent("Player:GetSoundTrackURL", true)
	
	addEventHandler("Player:UpdateSelectedCar", self, self.updateSelectedCarFunc);
	addEventHandler("Player:BuyVehicle", self, self.buyVehicleFunc);
	addEventHandler("Player:ShowLicense", self, self.showLicenseFunc);
	addEventHandler("Player:KickMeResolution", self, self.kickMeFunc);
	addEventHandler("Player:SellVehicle", self, self.sellVehicleFunc);
	addEventHandler("Player:OnWorldJoin", self, self.joinWorldFunc);
	addEventHandler("Player:OnGarageJoin", self, self.joinGarageFunc);
	addEventHandler("Player:GetSoundTrackURL", self, self.getSoundURLFunc);

end

-- ///////////////////////////////
-- ///// destructor 		//////
-- ///////////////////////////////

function Player:destructor()
	self:DestroyVehicle();
end

-- EVENT HANDLER --
registerElementClass("player", Player);
