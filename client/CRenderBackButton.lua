-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderBackButton	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderBackButton = {};
RenderBackButton.__index = RenderBackButton;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderBackButton:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render				//////
-- ///////////////////////////////

function RenderBackButton:Render()
	local r, g, b, a
	if(getElementData(self.backButton, "hover")) then
		r, g, b = 0, 255, 255
		a = 219
	else
		r, g, b = 255, 255, 255
		a = 119
	end
	
	self.renderManager:dxDrawRectangle(22, 46, 315, 70, tocolor(0, 0, 0, a), true)
	self.renderManager:dxDrawText("Back", 22, 45, 337, 115, tocolor(r, g, b, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
end

-- ///////////////////////////////
-- ///// Start				//////
-- ///////////////////////////////

function RenderBackButton:Start(func)
	assert(self.state == false)
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self.state = true;
	
	self.backButton = self.renderManager:guiCreateButton(22, 46, 315, 70, "hi", false, nil, true, true)
	guiSetAlpha(self.backButton, 0);
	addEventHandler("onClientGUIClick", self.backButton, function()
		self:Stop();
		playSoundFrontEnd(41);
	end, false)
end

-- ///////////////////////////////
-- ///// Stop				//////
-- ///////////////////////////////

function RenderBackButton:Stop()
	assert(self.state == true)
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self.state = false;
	
	destroyElement(self.backButton);
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderBackButton:Constructor(...)
	self.renderFunc = function()
		self:Render();
	end

	self.state = false;
	--self:Start();
	
	
	self.renderManager = RenderManager:New(aesx, aesy);
		
	logger:OutputInfo("[CALLING] RenderBackButton: Constructor");
end

-- EVENT HANDLER --
