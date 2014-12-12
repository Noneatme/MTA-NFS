-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: TuneCarsRender		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

TuneCarsRender = {};
TuneCarsRender.__index = TuneCarsRender;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function TuneCarsRender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function TuneCarsRender:Constructor(...)
	
	logger:OutputInfo("[CALLING] TuneCarsRender: Constructor");
end

-- EVENT HANDLER --
