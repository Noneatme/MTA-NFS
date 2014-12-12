-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: JoinHandler			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

JoinHandler = {};
JoinHandler.__index = JoinHandler;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function JoinHandler:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// OnPlayerJoin 		//////
-- ///////////////////////////////

function JoinHandler:OnPlayerJoin(player)
	if(antiInjection:CheckString(getPlayerName(player)) == true) then
		cancelEvent(true, "This name is blocked.\n(Injection warning)\nPlease use another name.");
		if (isElement(player)) then
			kickPlayer(player);
		end
		return
	end
	setCameraMatrix(player, -2671.9375, 840.68511962891, 74.607749938965, -2611.0517578125, 766.18762207031, 47.348754882813)
	fadeCamera(player, true)
	enew(player, Player);
	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function JoinHandler:Constructor(...)
	self.joinFunc = function() 
		self:OnPlayerJoin(source);
	end
	
	addEventHandler("onPlayerJoin", getRootElement(), self.joinFunc);
	logger:OutputInfo("[CALLING] JoinHandler: Constructor");
end

-- EVENT HANDLER --
