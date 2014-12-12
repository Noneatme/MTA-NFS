-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderManager		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderManager = {};
RenderManager.__index = RenderManager;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// dxDrawText 		//////
-- ///////////////////////////////


--[[
	width/self.ScreenWidth*self.sx
	height/self.ScreenHeight*self.sy

	width/self.ScreenWidth*self.sx
	height/self.ScreenHeight*self.sy
	
	x1/self.ScreenWidth*self.sx
	y1/self.ScreenHeight*self.sy
	
	x1/self.ScreenWidth*self.sx
	y1/self.ScreenHeight*self.sy
]]
function RenderManager:dxDrawText(text, x, y, width, height, color, size, font, ax, ay, clip, brea, postgui, ...)
	return dxDrawText(text, x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, color, size/(self.ScreenWidth+self.ScreenHeight)*(self.sx+self.sy), font, ax, ay, clip, brea, false, ...)
end


-- ///////////////////////////////
-- ///// dxDrawImage 		//////
-- ///////////////////////////////

function RenderManager:dxDrawImage(x, y, width, height, image, rx, ry, rz, color, postgui)
	return dxDrawImage(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, image, rx, ry, rz, color, false)
end

-- ///////////////////////////////
-- ///// dxDrawImageSection //////
-- ///////////////////////////////

function RenderManager:dxDrawImageSection(x, y, width, height, u, v, usize, vsize, image, rx, ry, rz, color, postgui)
--u/self.ScreenHeight*self.sy, v/self.ScreenHeight*self.sy, usize/self.ScreenHeight*self.sy, vsize/self.ScreenHeight*self.sy
	return dxDrawImageSection(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, u, v, usize, vsize, image, rx, ry, rz, color, false)
end

-- ///////////////////////////////
-- ///// dxDrawRectangle 	//////
-- ///////////////////////////////

function RenderManager:dxDrawRectangle(x, y, width, height, color)
	return dxDrawRectangle(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, color, false)
end

-- ///////////////////////////////
-- ///// Interpolate	 	//////
-- ///////////////////////////////

function RenderManager:interpolateBetween(...)
	return interpolateBetween(...);
end

-- ///////////////////////////////
-- ///// GuiCreateButton	//////
-- ///////////////////////////////

function RenderManager:guiCreateButton(x, y, width, height, text, relative, parent, data, hoversound)
	local btn = guiCreateButton(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, text, relative, parent);
	if(data == true) then
		addEventHandler("onClientMouseEnter", btn, function()
			setElementData(source, "hover", true, false)
			
			if(hoversound == true) then
				playSoundFrontEnd(42);
			elseif(type(hoversound) == "string") then
				playSound(hoversound, false);
			end
		end, false)
		
		addEventHandler("onClientMouseLeave", btn, function()
			setElementData(source, "hover", false, false)
		end, false)
	end
	return btn;
end

-- ///////////////////////////////
-- ///// GuiCreateComboBox	//////
-- ///////////////////////////////

function RenderManager:guiCreateComboBox(x, y, width, height, text, relative)
	local btn = guiCreateComboBox(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, text, relative);
	
	return btn;
end

-- ///////////////////////////////
-- /////GuiCreateRadioButton//////
-- ///////////////////////////////

function RenderManager:guiCreateRadioButton(x, y, width, height, text, relative)
	local btn = guiCreateRadioButton(x/self.ScreenWidth*self.sx, y/self.ScreenHeight*self.sy, width/self.ScreenWidth*self.sx, height/self.ScreenHeight*self.sy, text, relative);
	
	return btn;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderManager:Constructor(x, y)
	self.ScreenWidth = x;
	self.ScreenHeight = y;
	self.sx, self.sy = guiGetScreenSize();
	logger:OutputInfo("[CALLING] RenderManager: Constructor");
end

-- EVENT HANDLER --
