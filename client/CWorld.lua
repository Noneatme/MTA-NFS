-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: World Class			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

World = {};
World.__index = World;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function World:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Start		 		//////
-- ///////////////////////////////

function World:Start() -- Wird aufgerufen bei verlassen der Garage
	loadingScreen:EnableRandom();
	vehicleSelector:Stop();
	vehicleSelector = nil;
	cameraMover:StopCam();
	vehicleControls = VehicleControls:New();
	renderHUD = RenderHUD:New();
	
	localPlayer:JoinWorld();
	gameSettings = GameSettings:New();
	
	renderGarage:Destructor();
	renderGarage = nil;

	
	local ssm = SoundSettingsManager:New(true);
	
	ssm.vol1 = ssm.vol1 or 100
	ssm.vol2 = ssm.vol2 or 100
	soundManager:SetCategoryVolume("sounds", (ssm.vol1/100 or 1))
	soundManager:SetCategoryVolume("music", (ssm.vol2/100 or 1))
	
	rtm = RenderTrackPlayer:New();
	rtm:GiveTable(ssm.songstable)
	--rtm:PlayRandom();
	
	ssm:Destructor();
	
	ssm = nil;
	
	
	setTimer(function()
		loadingScreen:Disable();
		
		showPlayerHudComponent("all", false);
		
		rtm:PlayRandom();
		rtm:Show();
	end, 1000, 1)
end

-- ///////////////////////////////
-- ///// Stop		 		//////
-- ///////////////////////////////

function World:Stop() -- Wird aufgerufen bei betreten der Garage
	loadingScreen:EnableRandom();
	
	vehicleControls:Destructor();
	gameSettings:Destructor();
	renderHUD:Destructor();
	
	destroyElement(localPlayer:GetVehicle());
	
	localPlayer:JoinGarage();
	renderGarage = RenderGarage:New();
	garage = nil;
	garage = Garage:New();
	
	setTimer(function()
		loadingScreen:Disable();
		garage:Start(true);

	end, 2000, 1)
	
	rtm:Destructor();
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function World:Constructor(...)
	
	
	logger:OutputInfo("[CALLING] World: Constructor");
end

-- EVENT HANDLER --
