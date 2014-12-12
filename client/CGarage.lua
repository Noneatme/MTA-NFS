-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Garage				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Garage = {};
Garage.__index = Garage;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Garage:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end
	
-- ///////////////////////////////
-- ///// buildGarageKeys    //////
-- ///////////////////////////////

function Garage:BindGarageKeys()
	-- PAGE 1 --
	addEventHandler("onClientGUIClick", renderGarage.pgMain.btn1, function()
		playSoundFrontEnd(41);
		renderGarage:Hide();
		
		setTimer(function()
			world:Start();
		end, 1000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgMain.btn2, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("modcars");
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgMain.btn3, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("settings");
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgMain.btn4, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("bonus");
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgMain.btn5, function()
		playSoundFrontEnd(41);
		messageBox:Show("Warning", "Are you sure you want to exit?", "No", tocolor(255, 0, 0, 255), true);
	end, false)
	-- PAGE MODIFY CARS --
	addEventHandler("onClientGUIClick", renderGarage.pgModCars.btn4, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("main");
	end, false)
	addEventHandler("onClientGUIClick", renderGarage.pgModCars.btn1, function()
		renderGarage:Hide();
		purchaseCarRender = PurchaseCarRender:New();
		
		setTimer(function()
			purchaseCarRender:Start();
		end, 1000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgModCars.btn2, function()
		renderGarage:Hide();
		selectCarRender = SelectCarRender:New();
		
		setTimer(function()
			selectCarRender:Start();
		end, 1000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgModCars.btn3, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("tunecar");
	end, false)
	
	-- SETTINGS --
	addEventHandler("onClientGUIClick", renderGarage.pgSettings.btn1, function()
		playSoundFrontEnd(41);
		renderGarage:Hide();
		setTimer(function()
			SoundSettingsManager:New();
		end, 1000, 1)
	end, false)
	
	-- SoundSettingsManager:New();
	
	addEventHandler("onClientGUIClick", renderGarage.pgSettings.btn4, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("main");
	end, false)
	
	-- BONUS SETTINGS --
	addEventHandler("onClientGUIClick", renderGarage.pgBonus.btn4, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("main");
	end, false)
	
	addEventHandler("onClientGUIClick", renderGarage.pgBonus.btn3, function()
		playSoundFrontEnd(41);
		localPlayer:ShowServerLicense();
	end, false)
	
	-- TUNE CAR --
	addEventHandler("onClientGUIClick", renderGarage.pgTuneCars.btn4, function()
		playSoundFrontEnd(41);
		renderGarage:OpenPage("modcars");
	end, false)
end

	
-- ///////////////////////////////
-- ///// Start      		//////
-- ///////////////////////////////

function Garage:Start(reg)
	setElementDimension(localPlayer, 0);
	setElementInterior(localPlayer, 0);
	setCameraMatrix(941.24737548828, 2079.8078613281, 13.271475791931, 891.98937988281, 1992.9716796875, 7.5161905288696);

	setElementPosition(localPlayer,  907.30853271484,  2081.6411132813, 11);

	cameraMover:SmoothMoveCamera(941.24737548828, 2079.8078613281, 13.271475791931, 891.98937988281, 1992.9716796875, 7.5161905288696, 945.00122070313, 2057.3049316406, 12.775808334351, 852.44494628906, 2094.228515625, 4.4096307754517, 4000)

	showChat(false);
	toggleAllControls(false);
	showPlayerHudComponent("all", false);

		
	if not(reg) then
		renderGarage:Hide();
		registerManager:Open();
	else
		if(vehicleSelector) then
			vehicleSelector:Stop()
			vehicleSelector = nil
		end
		vehicleSelector = VehicleSelector:New(933.58520507813, 2063.6616210938, 10.8203125, 542)
		renderGarage:OpenPage("main");
		
		renderGarage:Show();
	end


	--soundManager:PlaySound("http://www.yourdawi.de/noneatme/mtasr/freeroam.mp3", true, "music");

	self:BindGarageKeys();

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Garage:Constructor(...)
	self.car = nil;
	self.dimension = nil;
	logger:OutputInfo("[CALLING] Garage: Constructor");
end

-- EVENT HANDLER --
