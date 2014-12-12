-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderHUD				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderHUD = {};
RenderHUD.__index = RenderHUD;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderHUD:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///////////////////////////////

function RenderHUD:Render()
	if(self.state == true) and (loadingScreen.state == false) and (isPedInVehicle(localPlayer)) then
		self.renderManager:dxDrawImage(1230, 741, 358, 112, "files/images/hud/tacho-none2.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.renderManager:dxDrawImage(1233, 859, 357, 34, "files/images/hud/NOS2.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		
		self.renderManager:dxDrawText(localPlayer:GetVehicle():GetSpeed(), 1120, 718, 1404, 786, tocolor(0, 0, 0, 150), 1, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(localPlayer:GetVehicle():GetSpeed(), 1132, 718, 1404, 786, tocolor(0, 0, 0, 150), 1, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(localPlayer:GetVehicle():GetSpeed(), 1126, 718, 1404, 786, tocolor(0, 255, 255, 255), 1, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
	
		self.renderManager:dxDrawText("KMH", 1326, 718, 1404, 786, tocolor(0, 0, 0, 155), 0.8, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("KMH", 1332, 718, 1404, 786, tocolor(0, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	
		-- TACHO --

		
		
		--outputDebugString(width)
		local percent = (localPlayer:GetVehicle():GetRPM()/9800)*100
		self.renderManager:	dxDrawImageSection(870+percent*3.6, 741, 358, 112,math.floor ( ( percent *665) / 100 ), 282, 665, 282,"files/images/hud/tacho-none.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderHUD:Constructor(...)
	self.state = true;
	self.renderFunc = function()
		self:Render();
	end
	self.renderManager = RenderManager:New(aesx, aesy);
	
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	
	logger:OutputInfo("[CALLING] RenderHUD: Constructor");
end

-- ///////////////////////////////
-- ///// Desstructor 		//////
-- ///////////////////////////////

function RenderHUD:Destructor()
	
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
end


-- EVENT HANDLER --
