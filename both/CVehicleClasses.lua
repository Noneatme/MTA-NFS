-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: VehicleClasses		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

VehicleClasses = {};
VehicleClasses.__index = VehicleClasses;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function VehicleClasses:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function VehicleClasses:Constructor(...)
	
	self.classS = {
		494, -- Hotring
		503,
		502, -- Hotring
	}
	
	self.classLegendary = {
		601,
		528,
		444,
		406,
		407,
		408,
		416,
		423,
		427,
		403,
	}
	
	self.classA = {
		411, 
		451,
		602,
		603,
	}
	
	self.classB = {
		477,
		480,
		415,
		429,
		506,
		--522, -- NRG 500
		541,
		559,
		560,
		589,
		
	}
	
	self.classC = {
		400,
		401,
		402,
		405,
		410,
		412,
		419,
		--420, -- Taxi
		421,
		--424, -- BF Injection
		426,
		--434, -- Hotknife
		436,
		--438 -- Cabbie
		439,
		445,
		--463 -- Freeway
		458,
		--461 -- PCJ 600
		467,
		--468 -- Sanchez
		475,
		479,
		491,
		492,
		--495 -- Sandking
		--504 -- Blooding Banger
		507
	}
	
	self.classD = {
		496,
		542,
		543,
		554,
		600,
	}
	
	self.classE = {
		440,
		478,
		518,
	}
	
	self.classLimitedTime = {
		539,
		
	}
	
	outputDebugString("[CALLING] VehicleClasses: Constructor");
end

-- EVENT HANDLER --
