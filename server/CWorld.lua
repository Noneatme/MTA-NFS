-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: World Class			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

World = {};
World.__index = World;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function World:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// UpdateTime 		//////
-- ///////////////////////////////

function World:SetTime(hour, mins)
	setTime(hour, mins);
	self.time = {hour, mins};
	return self.time;
end

-- ///////////////////////////////
-- ///// SetWeather 		//////
-- ///////////////////////////////

function World:SetWeather(typ)
	local id = 1;
	local rndtable;
	if(typ == "sunny") then
		rndtable = {1, 2, 3, 5, 6, 7};
	elseif(typ == "rainy") then
		rndtable = {8, 16};
	elseif(typ == "foggy") then
		rndtable = {9, 20};
	elseif(typ == "cloudy") then
		rndtable = {30, 32, 36, 38};
	end
	id = math.random(1, #rndtable);
	self.weather = id;
	setWeather(id);
	logger:OutputInfo("Changing Weather to ID: "..id.." ("..typ..")");
	return id;
end

-- ///////////////////////////////
-- ///// GetTime	 		//////
-- ///////////////////////////////

function World:GetTime()
	return getTime();
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function World:Constructor(...)
	
	self:SetTime(22, 00);
	self:SetWeather("foggy");
	setMinuteDuration (60000);
	
	self.checkPlayerFunc = function()
		for index, player in pairs(getElementsByType("player")) do
			if(player:IsOutOfGarage() == true) then
				if(isPedInVehicle(player) == false) and (isElement(player.vehicle)) and (isPedDead(player) == false) then	-- Warp Ped into Vehicle
					player:WarpInto(player.vehicle);	
					outputDebugString("Warping Player "..player:GetEMail().." into vehicle "..tostring(player.vehicle));
				end
			end
		end
	end
	
	
	self.resetTimeFunction = function()
		self.SetTime(22, 00);
	end
	
	self.checkPlayerTimer = setTimer(self.checkPlayerFunc, 50, -1);
	
	self.resetTimeTimer = setTimer(self.resetTimeFunction, 6*60*60*1000, -1);
	logger:OutputInfo("[CALLING] World: Constructor");
end

-- EVENT HANDLER --
