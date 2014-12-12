-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: ObjectCreator		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- SERVER SERVER SERVER SERVER SERVER SERVER SERVER SERVER --
-- SERVER SERVER SERVER SERVER SERVER SERVER SERVER SERVER --
-- SERVER SERVER SERVER SERVER SERVER SERVER SERVER SERVER --
-- SERVER SERVER SERVER SERVER SERVER SERVER SERVER SERVER --


-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings



cFunc["create_objects"] = function()
	logger = Logger:New();
	gameSettings = Settings:New();
	antiInjection = AntiInjection:New();
	connectionManager = ConnectionManager:New();
	joinHandler = JoinHandler:New();
	registerManager = RegisterManager:New();
	world = World:New();
	vehicleCosts = VehicleCosts:New();
	vehicleClasses = VehicleClasses:New();
	objectRemover = ObjectRemover:New();
	server = Server:New();
	compiled = Compiled:New();
	
	-- --
	
	connectionManager:Open();
	objectRemover:RemoveObjects();
	
	for index, player in pairs(getElementsByType("player")) do
		enew(player, Player);
	end
end

-- EVENT HANDLER --

addEventHandler("onResourceStart", getResourceRootElement(), cFunc["create_objects"])
