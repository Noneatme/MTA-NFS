-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: FontManager			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

FontManager = {};
FontManager.__index = FontManager;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function FontManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GetNFSFont 		//////
-- ///////////////////////////////

function FontManager:GetNFSFont()
	return self.nfsFont;
end

-- ///////////////////////////////
-- ///// GetDT Font 		//////
-- ///////////////////////////////

function FontManager:GetDTFont()
	return self.dtFont;
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function FontManager:Constructor(...)
	self.nfsFont = dxCreateFont("files/fonts/nfs_font.ttf", 32);
	self.dtFont = dxCreateFont("files/fonts/dt_font.ttf", 32);
	logger:OutputInfo("[CALLING] FontManager: Constructor");
end

-- EVENT HANDLER --
