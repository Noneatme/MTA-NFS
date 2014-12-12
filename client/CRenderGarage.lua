-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderGarage		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderGarage = {};
RenderGarage.__index = RenderGarage;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderGarage:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///////////////////////////////

function RenderGarage:Render()
	local interpolate;
	
	-- DOLLAR & TOKENS --
	if(localPlayer:IsLoggedIn()) and (loadingScreen.state == false) then
		self.RenderManager:dxDrawImage(4, 721, 90, 83, "files/images/tokens.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.RenderManager:dxDrawText(setDotsInNumber(tostring((getElementData(localPlayer, "account:Tokens") or 0))), 101, 736, 281, 794, tocolor(255, 255, 255, 255), 0.6, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.RenderManager:dxDrawImage(3, 808, 87, 81, "files/images/dollar.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.RenderManager:dxDrawText(setDotsInNumber(tostring((getElementData(localPlayer, "account:Dollar") or 0))), 99, 816, 279, 874, tocolor(255, 255, 255, 255), 0.6, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	end
			
	if(self.opened) then
		
			
		if(self.inverted == false) then
			interpolate = {
				{self.RenderManager:interpolateBetween(0, 552, 0, 473, 552, 0, ((getTickCount()-self.startTick)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100*2)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100*3)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100*4)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100*5)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(0, 54, 0, 467, 54, 0, ((getTickCount()-self.startTick-100*6)/500), self.easingFunc)},
			};
		else
			interpolate = {
				{self.RenderManager:interpolateBetween(473, 552, 0, 0, 552, 0, ((getTickCount()-self.startTick)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100*2)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100*3)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100*4)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100*5)/500), self.easingFunc)},
				{self.RenderManager:interpolateBetween(467, 54, 0, 0, 54, 0, ((getTickCount()-self.startTick-100*6)/500), self.easingFunc)},
			};
		end
		if(self.renderedPage == "main") then
	
			
			self.RenderManager:dxDrawText("Save House", 0, 110, 471, 160, tocolor(255, 255, 255, 255), 0.8, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
			
			self.RenderManager:dxDrawRectangle(0, 163, interpolate[1][1], interpolate[1][2], tocolor(0, 0, 0, 117), true)
			
			local color = tocolor(0, 255, 255, 133);
			if(getElementData(self.pgMain.btn1, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 193, interpolate[2][1], interpolate[2][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 155, 133);
			if(getElementData(self.pgMain.btn2, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 257, interpolate[3][1], interpolate[3][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 55, 133);
			if(getElementData(self.pgMain.btn3, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 321, interpolate[4][1], interpolate[4][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(55, 255, 0, 133);
			if(getElementData(self.pgMain.btn4, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 386, interpolate[5][1], interpolate[5][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(155, 255, 0, 133);
			if(getElementData(self.pgMain.btn5, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 654, interpolate[6][1], interpolate[6][2], "files/images/aero-title.png", 0, 0, 0, color, true)
		
			
			self.RenderManager:dxDrawText("Enter World", 0, 193, interpolate[2][1], interpolate[2][2]+193, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Modify Car(s)", 0, 257, interpolate[3][1], interpolate[3][2]+257, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Settings", 0, 321, interpolate[4][1], interpolate[4][2]+321, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Bonus Settings", 0, 386, interpolate[5][1], interpolate[5][2]+386, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Exit Game", 0, 654, interpolate[6][1], interpolate[6][2]+654, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
		
		elseif(self.renderedPage == "modcars") then

			self.RenderManager:dxDrawText("Modify Car(s)", 0, 110, 471, 160, tocolor(255, 255, 255, 255), 0.8, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
			
			self.RenderManager:dxDrawRectangle(0, 163, interpolate[1][1], interpolate[1][2], tocolor(0, 0, 0, 117), true)
			
			local color = tocolor(0, 255, 255, 133);
			if(getElementData(self.pgModCars.btn1, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 193, interpolate[2][1], interpolate[2][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 155, 133);
			if(getElementData(self.pgModCars.btn2, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 257, interpolate[3][1], interpolate[3][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 55, 133);
			if(getElementData(self.pgModCars.btn3, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 321, interpolate[4][1], interpolate[4][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(155, 255, 0, 133);
			if(getElementData(self.pgModCars.btn4, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 654, interpolate[6][1], interpolate[6][2], "files/images/aero-title.png", 0, 0, 0, color, true)
		
			-- TEXT --
			self.RenderManager:dxDrawText("Purchase cars", 0, 193, interpolate[2][1], interpolate[2][2]+193, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Select/sell cars", 0, 257, interpolate[3][1], interpolate[3][2]+257, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Tune car", 0, 321, interpolate[4][1], interpolate[4][2]+321, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Back", 0, 654, interpolate[6][1], interpolate[6][2]+654, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
		elseif(self.renderedPage == "tunecar") then

			self.RenderManager:dxDrawText("Tune Car", 0, 110, 471, 160, tocolor(255, 255, 255, 255), 0.8, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
			
			self.RenderManager:dxDrawRectangle(0, 163, interpolate[1][1], interpolate[1][2], tocolor(0, 0, 0, 117), true)
			
			local color = tocolor(0, 255, 255, 133);
			if(getElementData(self.pgTuneCars.btn1, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 193, interpolate[2][1], interpolate[2][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 155, 133);
			if(getElementData(self.pgTuneCars.btn2, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 257, interpolate[3][1], interpolate[3][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 55, 133);
			if(getElementData(self.pgTuneCars.btn3, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 321, interpolate[4][1], interpolate[4][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(155, 255, 0, 133);
			if(getElementData(self.pgTuneCars.btn4, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 654, interpolate[6][1], interpolate[6][2], "files/images/aero-title.png", 0, 0, 0, color, true)
		
			-- TEXT --
			self.RenderManager:dxDrawText("Tuning Workshop", 0, 193, interpolate[2][1], interpolate[2][2]+193, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Skill Workshop", 0, 257, interpolate[3][1], interpolate[3][2]+257, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Paint Workshop", 0, 321, interpolate[4][1], interpolate[4][2]+321, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Back", 0, 654, interpolate[6][1], interpolate[6][2]+654, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
		
		
		elseif(self.renderedPage == "settings") then
			
			self.RenderManager:dxDrawText("Settings", 0, 110, 471, 160, tocolor(255, 255, 255, 255), 0.8, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
			
			self.RenderManager:dxDrawRectangle(0, 163, interpolate[1][1], interpolate[1][2], tocolor(0, 0, 0, 117), true)
			
			local color = tocolor(0, 255, 255, 133);
			if(getElementData(self.pgSettings.btn1, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 193, interpolate[2][1], interpolate[2][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 155, 133);
			if(getElementData(self.pgSettings.btn2, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 257, interpolate[3][1], interpolate[3][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 55, 133);
			if(getElementData(self.pgSettings.btn3, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 321, interpolate[4][1], interpolate[4][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(155, 255, 0, 133);
			if(getElementData(self.pgSettings.btn4, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 654, interpolate[6][1], interpolate[6][2], "files/images/aero-title.png", 0, 0, 0, color, true)
		
			-- TEXT --
			self.RenderManager:dxDrawText("Audio Settings", 0, 193, interpolate[2][1], interpolate[2][2]+193, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Gameplay Settings", 0, 257, interpolate[3][1], interpolate[3][2]+257, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Shaders", 0, 321, interpolate[4][1], interpolate[4][2]+321, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Back", 0, 654, interpolate[6][1], interpolate[6][2]+654, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
		
		elseif(self.renderedPage == "bonus") then
			
			self.RenderManager:dxDrawText("Bonus Settings", 0, 110, 471, 160, tocolor(255, 255, 255, 255), 0.8, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
			
			self.RenderManager:dxDrawRectangle(0, 163, interpolate[1][1], interpolate[1][2], tocolor(0, 0, 0, 117), true)
			
			local color = tocolor(0, 255, 255, 133);
			if(getElementData(self.pgBonus.btn1, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 193, interpolate[2][1], interpolate[2][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 155, 133);
			if(getElementData(self.pgBonus.btn2, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 257, interpolate[3][1], interpolate[3][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(0, 255, 55, 133);
			if(getElementData(self.pgBonus.btn3, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 321, interpolate[4][1], interpolate[4][2], "files/images/aero-title.png", 0, 0, 0, color, true)
			color = tocolor(155, 255, 0, 133);
			if(getElementData(self.pgBonus.btn4, "hover")) then
				color = tocolor(255, 255, 255, 133);
			end
			self.RenderManager:dxDrawImage(0, 654, interpolate[6][1], interpolate[6][2], "files/images/aero-title.png", 0, 0, 0, color, true)
		
			-- TEXT --
			self.RenderManager:dxDrawText("Reedem Code", 0, 193, interpolate[2][1], interpolate[2][2]+193, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Show Credits", 0, 257, interpolate[3][1], interpolate[3][2]+257, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Server License", 0, 321, interpolate[4][1], interpolate[4][2]+321, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
			
			self.RenderManager:dxDrawText("Back", 0, 654, interpolate[6][1], interpolate[6][2]+654, tocolor(255, 255, 255, 255), 0.8, fontManager:GetDTFont(), "center", "center", true, false, true, false, false)
		
		end
	end
end

-- ///////////////////////////////
-- ///// TriggerEnabled	 	//////
-- ///////////////////////////////

function RenderGarage:OpenPage(page)
	self:DisableGui();
	
	if (isTimer(self.waitOpTimer)) then
		killTimer(self.waitOpTimer); -- Anti Bug
	end
	if(self.opened == false) then
		self.opened = true;
		-- Start einschub
		self.renderedPage = page;
		self.startTick = getTickCount();
		self.inverted = false;
		self.waitOpTimer = setTimer(self.enableGuiFunction, 1000, 1, page);
		
	else
		--self:DisableGui(self.renderedPage);
		self.inverted = true;
		self.easingFunc = "InQuad";
		self.startTick = getTickCount();

		self.waitOpTimer = setTimer(function()
			self.opened = true;
			-- Start einschub
			self.renderedPage = page;
			self.startTick = getTickCount();
			self.inverted = false;
			self.waitOpTimer = setTimer(self.enableGuiFunction, 1000, 1, page);
		end, 1200, 1)
		
		
	end
	if(page == "main") then
		local x, y, z, x2, y2, z2 = cameraMover:GetCamPos()
		cameraMover:SmoothMoveCamera(x, y, z, x2, y2, z2, 945.00122070313, 2057.3049316406, 12.775808334351, 852.44494628906, 2094.228515625, 4.4096307754517, 4000)
		
	elseif(page == "tunecar") then
		local x, y, z, x2, y2, z2 = cameraMover:GetCamPos();
		cameraMover:SmoothMoveCamera(x, y, z, x2, y2, z2, 930.05505371094, 2073.896484375, 11.479271888733, 964.84899902344, 1980.1491699219, 12.389189720154, 3000);
	end
end

-- ///////////////////////////////
-- ///// DisableGui	 		//////
-- ///////////////////////////////

function RenderGarage:DisableGui()
	for index, pages in pairs(self.guiPages) do
		for index2, guiEle in pairs(pages) do
			guiSetEnabled(guiEle, false);
			guiMoveToBack(guiEle);
			guiSetAlpha(guiEle, 0);
		end
	end
end

-- ///////////////////////////////
-- ///// EnableGui	 		//////
-- ///////////////////////////////

function RenderGarage:EnableGui(page)
	if(page == "main") then
		for index2, guiEle in pairs(self.pgMain) do
			guiSetEnabled(guiEle, true);
			guiBringToFront(guiEle);
		end
	end
	
	if(page == "modcars") then
		for index2, guiEle in pairs(self.pgModCars) do
			guiSetEnabled(guiEle, true);
			guiBringToFront(guiEle);
		end
	end
	
	if(page == "settings") then
		for index2, guiEle in pairs(self.pgSettings) do
			guiSetEnabled(guiEle, true);
			guiBringToFront(guiEle);
		end
	end
	
	if(page == "bonus") then
		for index2, guiEle in pairs(self.pgBonus) do
			guiSetEnabled(guiEle, true);
			guiBringToFront(guiEle);
		end
	end
	
	if(page == "tunecar") then
		for index2, guiEle in pairs(self.pgTuneCars) do
			guiSetEnabled(guiEle, true);
			guiBringToFront(guiEle);
		end
	end
end

-- ///////////////////////////////
-- ///// BuildGui	 		//////
-- ///////////////////////////////

function RenderGarage:BuildGui()
	-- PAGE MAIN  --
		self.pgMain.btn1 = self.RenderManager:guiCreateButton(0, 193, 467, 54, "", false, nil, true, true);
	
		self.pgMain.btn2 = self.RenderManager:guiCreateButton(0, 257, 467, 54, "", false, nil, true, true);
		
		self.pgMain.btn3 = self.RenderManager:guiCreateButton(0, 321, 467, 54, "", false, nil, true, true);
		
		self.pgMain.btn4 = self.RenderManager:guiCreateButton(0, 386, 467, 54, "", false, nil, true, true); --654
		
		self.pgMain.btn5 = self.RenderManager:guiCreateButton(0, 654, 467, 54, "exit", false, nil, true, true); --654
		
		
	-- PAGE MOD CARS --
		self.pgModCars.btn1 = self.RenderManager:guiCreateButton(0, 193, 467, 54, "", false, nil, true, true);
	
		self.pgModCars.btn2 = self.RenderManager:guiCreateButton(0, 257, 467, 54, "", false, nil, true, true);
		
		self.pgModCars.btn3 = self.RenderManager:guiCreateButton(0, 321, 467, 54, "", false, nil, true, true);
		
		self.pgModCars.btn4 = self.RenderManager:guiCreateButton(0, 654, 467, 54, "back", false, nil, true, true); --654
		
	-- PAGE Tune CARS --
		self.pgTuneCars.btn1 = self.RenderManager:guiCreateButton(0, 193, 467, 54, "", false, nil, true, true);
	
		self.pgTuneCars.btn2 = self.RenderManager:guiCreateButton(0, 257, 467, 54, "", false, nil, true, true);
		
		self.pgTuneCars.btn3 = self.RenderManager:guiCreateButton(0, 321, 467, 54, "", false, nil, true, true);
		
		self.pgTuneCars.btn4 = self.RenderManager:guiCreateButton(0, 654, 467, 54, "back", false, nil, true, true); --654
		
		
	-- SETTINGS --

		self.pgSettings.btn1 = self.RenderManager:guiCreateButton(0, 193, 467, 54, "", false, nil, true, true);
	
		self.pgSettings.btn2 = self.RenderManager:guiCreateButton(0, 257, 467, 54, "", false, nil, true, true);
		
		self.pgSettings.btn3 = self.RenderManager:guiCreateButton(0, 321, 467, 54, "", false, nil, true, true);
		
		self.pgSettings.btn4 = self.RenderManager:guiCreateButton(0, 654, 467, 54, "back", false, nil, true, true); --654
		
	-- BONUS SETTINGS --
	
		self.pgBonus.btn1 = self.RenderManager:guiCreateButton(0, 193, 467, 54, "", false, nil, true, true);
	
		self.pgBonus.btn2 = self.RenderManager:guiCreateButton(0, 257, 467, 54, "", false, nil, true, true);
		
		self.pgBonus.btn3 = self.RenderManager:guiCreateButton(0, 321, 467, 54, "", false, nil, true, true);
		
		self.pgBonus.btn4 = self.RenderManager:guiCreateButton(0, 654, 467, 54, "back", false, nil, true, true);
end

-- ///////////////////////////////
-- ///// DestroyGui 		//////
-- ///////////////////////////////

function RenderGarage:DestroyGui()
	for index, pages in pairs(self.guiPages) do
		for index2, guiEle in pairs(pages) do
			destroyElement(guiEle);
		end
	end
end

-- ///////////////////////////////
-- ///// 	HideGui 		//////
-- ///////////////////////////////

function RenderGarage:Hide()
	for index, pages in pairs(self.guiPages) do
		for index2, guiEle in pairs(pages) do
			guiSetEnabled(guiEle, false);
			guiSetAlpha(guiEle, 0);
		end
	end
	
	self.inverted = true;
	self.easingFunc = "InQuad";
	self.startTick = getTickCount();
		
	setTimer(function()
		self.opened = false;
	end, 2000, 1)
end

-- ///////////////////////////////
-- ///// 	Show	 		//////
-- ///////////////////////////////

function RenderGarage:Show()
	self:EnableGui(self.renderedPage);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderGarage:Constructor(...)
	self.renderFunc = function()
		self:Render();
	end
	
	self.enableGuiFunction = function(id)
		self:EnableGui(id);
	end
	
	self.RenderManager = RenderManager:New(aesx, aesy);
	self.easingFunc = "OutQuad";
	self.opened = false;
	
	-- GUIS --
	self.pgMain = {};
	self.pgModCars = {};
	self.pgSettings = {};
	self.pgBonus = {};
	self.pgTuneCars = {};
	
	self:BuildGui();
	
	self.guiPages = {self.pgMain, self.pgModCars, self.pgSettings, self.pgBonus, self.pgTuneCars};
	
	self:DisableGui();
	-- EVENTS --
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
		
	logger:OutputInfo("[CALLING] RenderGarage: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function RenderGarage:Destructor(...)
	self:DestroyGui();
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);

end
-- EVENT HANDLER --
