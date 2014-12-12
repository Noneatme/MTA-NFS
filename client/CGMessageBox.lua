-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: CGMessageBox	    ##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

CG.MessageBox = {}
CG.MessageBox.__index = CG.MessageBox


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function CG.MessageBox:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end

-- ///////////////////////////////
-- ///// Render Func		//////
-- ///////////////////////////////

function CG.MessageBox:RenderMessage()
	self.renderManager:dxDrawImage(640, 346, 336, 32, "files/images/aero-title.png", 0, 0, 0, tocolor(1, 251, 219, 120), true)
	
	self.renderManager:dxDrawText(self.title, 639, 346, 976, 377, tocolor(0, 0, 0, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)

	local width, height;
	if(self.disabled ~= true) then
		width, height = interpolateBetween(336, 0, 0, 336, 204, 0, (getTickCount()-self.startTick)/500, self.easingFunc);
	else
		width, height = interpolateBetween(336, 204, 0, 336, 0, 0, (getTickCount()-self.startTick)/500, self.easingFunc);
	
	end
	self.renderManager:dxDrawRectangle(640, 377, width, height, tocolor(0, 0, 0, 200), true)
	if(getTickCount()-self.startTick > 500) then
		if(self.double) then
			self.renderManager:dxDrawText(self.message, 642, 378, 974, 529, tocolor(0, 0, 0, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, true, true, false, false)
		end
		self.renderManager:dxDrawText(self.message, 640, 376, 974, 529, self.msgcolor, 0.3, fontManager:GetDTFont(), "center", "center", false, true, true, false, false)
	
		local a = 50
		if(self.hover) then
			a = 200;
		end
		self.renderManager:dxDrawRectangle(740, 539, 136, 33, tocolor(0, 0, 0, a), true)
	    self.renderManager:dxDrawText(self.option1, 740, 538, 875, 572, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false) 
	    
    end
end

-- ///////////////////////////////
-- /////CreateGui			//////
-- ///////////////////////////////

function CG.MessageBox:CreateGui()
	self.btn1 = guiCreateButton(740/aesx*sx, 538/aesy*sy, 136/aesx*sx, 33/aesy*sy, "hi", false);
	guiSetAlpha(self.btn1, 0);
	--
	addEventHandler("onClientMouseEnter", self.btn1, function()
		playSoundFrontEnd(42);
		self.hover = true;
	end)
	addEventHandler("onClientMouseLeave", self.btn1, function()
		self.hover = false;
	end)
	addEventHandler("onClientGUIClick", self.btn1, function()
		guiSetEnabled(source, false);
		playSoundFrontEnd(41);
		self.startTick = getTickCount();
		self.easingFunc = "InQuad";
		self.disabled = true;
		setTimer(function()
			self:Hide();
		end, 500, 1)
	end, false)
	--
end

-- ///////////////////////////////
-- /////DestroyGui			//////
-- ///////////////////////////////

function CG.MessageBox:DestroyGui()
	destroyElement(self.btn1);
end

-- ///////////////////////////////
-- ///// Show				//////
-- ///////////////////////////////
function CG.MessageBox:Show(title, message, option1, messagecolor, double)
	assert(self.state ~= true);
	-- 
	self.message = message;
	self.title = title;
	self.option1 = option1;
	self.double = double;
	self.startTick = getTickCount();
	self.easingFunc = "InBounce";
	self.disabled = false;
	--
	if(messagecolor) then
		if(type(messagecolor) == "string") then
			if(messagecolor == "error") then
				messagecolor = tocolor(255, 0, 0, 255);
			elseif(messagecolor == "sucess") then
				messagecolor = tocolor(0, 255, 0, 255);
			else
				messagecolor = tocolor(255, 255, 255, 255);
			end
		end
		self.msgcolor = messagecolor;
		
		if(messagecolor == tocolor(255, 0, 0, 255)) then
			playSound("files/sounds/meep.mp3", false);
		elseif(messagecolor == tocolor(0, 255, 0, 255)) then
			playSound("files/sounds/sucess.mp3", false);
		
		end
	else
		self.msgcolor = tocolor(255, 255, 255, 255);
	end
	self.state = true;
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	
	-- GUIS --
	setTimer(function()
		self:CreateGui();
	end, 500, 1)
end


-- ///////////////////////////////
-- ///// Hide				//////
-- ///////////////////////////////

function CG.MessageBox:Hide()
	assert(self.state == true);

	self.state = false;
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	-- GUIS --
	
	self:DestroyGui();

end
-- ///////////////////////////////
-- ///// Constructor		//////
-- ///////////////////////////////

function CG.MessageBox:Constructor()
	self.state = false;
	-- -- --
	self.renderFunc = function()
		self:RenderMessage();
	end;
	
	self.openFunc = function(...)
		self:Show(...);
	end;
	self.renderManager = RenderManager:New(aesx, aesy);
	
	addEvent("Player:ShowMessageBox", true);
	addEventHandler("Player:ShowMessageBox", getLocalPlayer(), self.openFunc);
end

-- EVENT HANDLER --

