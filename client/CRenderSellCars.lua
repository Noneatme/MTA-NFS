-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: SellCarsRender		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SellCarsRender = {};
SellCarsRender.__index = SellCarsRender;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function SellCarsRender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function SellCarsRender:Constructor(...)
	
	logger:OutputInfo("[CALLING] SellCarsRender: Constructor");
end

-- EVENT HANDLER --
