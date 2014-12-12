-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderCursor		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderCursor = {};
RenderCursor.__index = RenderCursor;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderCursor:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render 			//////
-- ///////////////////////////////

function RenderCursor:Render(...)
	if(isCursorShowing()) then
		local x, y = getCursorPosition()
		
		local sx, sy = guiGetScreenSize();

		dxDrawImage(sx*x, sy*y, 21, 30, "files/images/cursor.png", 0, 0, 0, tocolor(0, 255, 255, 200), true);
		

	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderCursor:Constructor(...)
	self.renderFunc = function()
		self:Render();
	end

	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	logger:OutputInfo("[CALLING] RenderCursor: Constructor");
end

-- EVENT HANDLER --
