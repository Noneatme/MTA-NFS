-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: ObjectCreator		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT --
-- CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT --
-- CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT --
-- CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT CLIENT --


-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings



cFunc["create_objects"] = function()
	logger = Logger:New();
	loadingScreen = Loadingscreen:New();
	
	-- START OF LOADING --
	--loadingScreen:EnableRandom();
	fontManager = FontManager:New();
	garage = Garage:New();
	--setTimer(function()
	-- CREATE OBJECTS
		cameraMover = CameraMover:New();
		registerManager = RegisterManager:New();
		messageBox = CG.MessageBox:New();
		optionBox = CG.OptionBox:New();
		soundManager = SoundManager:New();
		world = World:New();
		trafficLights = TrafficLights:New();
		renderGarage = RenderGarage:New();
		rbb = RenderBackButton:New();
		
		vehicleClass = VehicleClasses:New();
		vehicleCosts = VehicleCosts:New();
		
		renderCursor = RenderCursor:New();
		
		local ssm = SoundSettingsManager:New(true);
		
		
		-- DINGENS --
		
		soundManager:AddCategory("music");
		soundManager:AddCategory("sounds");
		soundManager:SetCategoryVolume("music", 1);
		
		chatBox = ChatBox:New()
		
		chatBox:AddGroup("Freeroam");
		chatBox:AddGroup("System", true);
		
		chatBox:SelectGroup("System");

				

		outputChatBox("Welcome to MTA:Speedrace", 255, 255, 0);
		outputChatBox("Current status: #FFFFFFAlpha #FFFF00version", 255, 255, 0);
		outputChatBox("", 255, 255, 255);
		outputChatBox("Press #00FFFF'T' #FFFFFFto activate the Track Player.")
		outputChatBox("If you doesn't hear music, switch back to your save house (h)")
		outputChatBox("and enter the world again.")
		chatBox:Hide();

	--end, 2000, 1)
	-- END OF LOADING
	--setTimer(function() loadingScreen:Disable() garage:Start() end, 5000, 1);

	garage:Start();
	
	setTimer(function()
		ssm:Destructor();
		ssm = nil;
	end, 2000, 1)
end

-- EVENT HANDLER --

addEventHandler("onClientResourceStart", getResourceRootElement(), cFunc["create_objects"])

		
-- FUNKTIONEN --


function outputChatBox(text, r, g, b, dingens)
	if(dingens) then
		return chatBox:SendTextBack(dingens, text, r, g, b);
	else
		return chatBox:SendTextBack("System", text, r, g, b);
	end
end
		
		