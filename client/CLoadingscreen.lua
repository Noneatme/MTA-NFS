-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: 	Loadingscreen	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Loadingscreen = {};
Loadingscreen.__index = Loadingscreen;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Loadingscreen:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Loadingscreen:Constructor(...)
	
	self.maxWallpapers = 5;
	self.state = false;
	self.wallpaper = math.random(1, self.maxWallpapers);
	
	logger:OutputInfo("[CALLING] Loadingscreen: Constructor");
end

-- ///////////////////////////////
-- ///// UpdatePunkt		//////
-- ///////////////////////////////

function Loadingscreen:UpdatePunkt()
	if(self.punktString == "...") then
		self.punktString = ".";
	elseif(self.punktString == ".") then
		self.punktString = "..";
	elseif(self.punktString == "..") then
		self.punktString = "...";
	end
end

-- ///////////////////////////////
-- ///// Render Dingens		//////
-- ///////////////////////////////

function Loadingscreen:RenderLoadingScreen()
	-- RENDERING --
	
	dxDrawImage(0, 0, sx, sy, "files/images/wallpaper-"..self.wallpaper..".jpg");

	dxDrawText("LOADING"..self.punktString, 240/aesx*sx, 584/aesy*sy, 1077/aesx*sx, 827/aesy*sy, tocolor(0, 0, 0, 255), 2, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false);
	dxDrawText("LOADING"..self.punktString, 236/aesx*sx, 580/aesy*sy, 1077/aesx*sx, 827/aesy*sy, tocolor(255, 255, 255, 255), 2, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false);

	-- Tacho --
	dxDrawImage((1050/aesx*sx)-(153/aesx*sx)/2, (650/aesy*sy)-(147/aesy*sy)/2, 250/aesx*sx, 240/aesy*sy, "files/images/ls-tacho.png", 0, 0, 0, tocolor(255, 255, 255, 200), true);
	-- Zaehler --
	dxDrawText(math.floor(self.needleGrad/360), 1054/aesx*sx, 756/aesy*sy, 1139/aesx*sx, 792/aesy*sy, tocolor(255, 255, 255, 255), 0.9, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
	
	-- Nadel --
	dxDrawImage((1060/aesx*sx)-(133/aesx*sx)/2, (660/aesy*sy)-(127/aesy*sy)/2, 210/aesx*sx, 200/aesy*sy, "files/images/ls-nadel.png", self.needleGrad, 0, 0, tocolor(255, 255, 255, 200), true);
	
	self.needleGrad = self.needleGrad+5;
end

-- ///////////////////////////////
-- ///// Enable		 		//////
-- ///////////////////////////////

function Loadingscreen:Enable()
	assert(self.state ~= true);
	self.oldInt = getElementInterior(localPlayer);
	self.state = true;
	self.needleGrad = 0;
	self.punktString = "...";
	setElementInterior(localPlayer, 1);
	self.punktFunc = 
		function() 
			self:UpdatePunkt();
		end
	
	self.updatePunktTimer = setTimer(self.punktFunc, 500, -1);
	self.renderFunc = 
		function() 
			self:RenderLoadingScreen();
		end
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	
	showChat(false);
	toggleAllControls(false);
	showPlayerHudComponent("all", false);
	
	logger:OutputInfo("Loadingscreen Enabled");
end

-- ///////////////////////////////
-- ///// EnableRandom		//////
-- ///////////////////////////////

function Loadingscreen:EnableRandom()
	assert(self.state ~= true);
	self:Enable();
	self.wallpaper = math.random(1, self.maxWallpapers);
end

-- ///////////////////////////////
-- ///// Disable			//////
-- ///////////////////////////////

function Loadingscreen:Disable()
	assert(self.state ~= false);
	self.state = false
	setElementInterior(localPlayer, self.oldInt)
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);

	killTimer(self.updatePunktTimer);
	
	logger:OutputInfo("Loadingscreen Disabled");
end


-- EVENT HANDLER --
