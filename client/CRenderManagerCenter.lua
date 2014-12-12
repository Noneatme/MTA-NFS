-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: CRenderManagerCenter##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderManagerCenter = {};
RenderManagerCenter.__index = RenderManagerCenter;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderManagerCenter:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// dxDrawRectangle	//////
-- ///////////////////////////////

function RenderManagerCenter:dxDrawRectangle(x, y, w, h, color)
	return dxDrawRectangle(self.sx-(self.aesx-x), self.sy-(self.aesy-y), w, h, color, false);
end

-- ///////////////////////////////
-- ///// dxDrawText			//////
-- ///////////////////////////////

function RenderManagerCenter:dxDrawText(text, x1, y1, x2, y2, color, size, font, ax, ay, clip, brea, postgui, ...)
	return dxDrawText(text, self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), self.sx-(self.aesx-x2), self.sy-(self.aesy-y2), color, size, font, ax, ay, clip, brea, false, ...);
end

-- ///////////////////////////////
-- ///// dxDrawImage		//////
-- ///////////////////////////////

function RenderManagerCenter:dxDrawImage(x1, y1, x2, y2, image, rx, ry, rz, color, postgui)
	return dxDrawImage(self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), x2, y2, image, rx, ry, rz, color, false);
end

-- ///////////////////////////////
-- ///// dxDrawLine			//////
-- ///////////////////////////////


function RenderManagerCenter:dxDrawLine(x1, y1, x2, y2, ...)
	return dxDrawLine(self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), self.sx-(self.aesx-x2), self.sy-(self.aesy-y2),...);
end

-- ///////////////////////////////
-- ///// guiCreateButton	//////
-- ///////////////////////////////

function RenderManagerCenter:guiCreateButton(x1, y1, width, height, text, relative, parent, data, hoversound)
	local btn = guiCreateButton(self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), width, height, text, relative, parent);
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
-- ///// guiCreateButton2	//////
-- ///////////////////////////////

function RenderManagerCenter:guiCreateButton2(x1, y1, width, height, text, relative, parent, data, hoversound)
	local btn = guiCreateButton(x1, y1, width, height, text, relative, parent);
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
-- ///// guiCreateScrollBar	//////
-- ///////////////////////////////

function RenderManagerCenter:guiCreateScrollBar(x1, y1, ...)
	return guiCreateScrollBar(self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), ...);
end

-- ///////////////////////////////
-- ///// guiCreateEdit		//////
-- ///////////////////////////////

function RenderManagerCenter:guiCreateEdit(x1, y1, ...)
	return guiCreateEdit(self.sx-(self.aesx-x1), self.sy-(self.aesy-y1), ...);
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderManagerCenter:Constructor(aesx, aesy)
	self.aesx = aesx;
	self.aesy = aesy;
	
	self.sx, self.sy = guiGetScreenSize();
	
	outputDebugString("[CALLING] RenderManagerCenter: Constructor");
end

-- EVENT HANDLER --
