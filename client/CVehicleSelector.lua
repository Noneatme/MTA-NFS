-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: VehicleSelector		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

VehicleSelector = {};
VehicleSelector.__index = VehicleSelector;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function VehicleSelector:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// UpdateCar			//////
-- ///////////////////////////////

function VehicleSelector:UpdateCar(dataSet)
	if(dataSet) then
		self:SetModel(dataSet['Modell']);
	
		
		self.vehicle:SetColor(tonumber(gettok(dataSet['Farbe'], 1, "|")), tonumber(gettok(dataSet['Farbe'], 2, "|")), tonumber(gettok(dataSet['Farbe'], 3, "|")), tonumber(gettok(dataSet['Farbe'], 4, "|")), tonumber(gettok(dataSet['Farbe'], 5, "|")), tonumber(gettok(dataSet['Farbe'], 6, "|")), tonumber(gettok(dataSet['Farbe'], 7, "|")), tonumber(gettok(dataSet['Farbe'], 8, "|")), tonumber(gettok(dataSet['Farbe'], 9, "|")));
	end
	
end
-- ///////////////////////////////
-- ///// Start		 		//////
-- ///////////////////////////////

function VehicleSelector:Start()
	assert(self.state == false);

	self.updateRotState = true;
	self.state = true;
	
	local data = localPlayer:GetCurrentVehicleAsData();
	
	self:UpdateCar(data);
	
	addEventHandler("onClientRender", getRootElement(), self.rotRenderFunc);
	
	addEventHandler("onClientClick", getRootElement(), self.clickFunc);
	

end



-- ///////////////////////////////
-- ///// Stop		 		//////
-- ///////////////////////////////

function VehicleSelector:Stop()
	assert(self.state == true);
	
	self.state = false;
	self.updateRotState = false;
	
	removeEventHandler("onClientRender", getRootElement(), self.rotRenderFunc);
	
	removeEventHandler("onClientClick", getRootElement(), self.clickFunc);
	
	destroyElement(self.vehicle);

end

-- ///////////////////////////////
-- ///// OnClick			//////
-- ///////////////////////////////

function VehicleSelector:OnClick(btn, state, _, _, _, _, _, ele)
	if(btn == "right") then
		if(state == "down") and (ele == self.vehicle) then
			self.updateRotState = false;
		elseif(state == "up") then
			self.updateRotState = true;
		end
	end
end



-- ///////////////////////////////
-- ///// RenderRot			//////
-- ///////////////////////////////

function VehicleSelector:RenderRot()

	local x, y = getCursorPosition()
			
	if(self.updateRotState == false) then
		self.currentRot = (x-self.lastx)*500
		
		local vx, vy, vz = getElementRotation(self.vehicle)
		setElementRotation(self.vehicle, vx, vy, vz+self.currentRot);
		


	else
		local vx, vy, vz = getElementRotation(self.vehicle)
		setElementRotation(self.vehicle, vx, vy, vz+self.currentRot);
	--[[
		local state = getCursorMoveOn();
		if(state == "left") then
			local vx, vy, vz = getElementRotation(self.vehicle)
			setElementRotation(self.vehicle, vx, vy, vz-2);
		end
		
		if(state == "right") then
			local vx, vy, vz = getElementRotation(self.vehicle)
			setElementRotation(self.vehicle, vx, vy, vz+2);
		end]]

	end
			
	if(self.currentRot > 0.1) then
		self.currentRot = self.currentRot-0.1
	elseif(self.currentRot < -0.1) then
		self.currentRot = self.currentRot+0.1
	else
		self.currentRot = 0.1;
	end
		
	self.lastx = x;
end

-- ///////////////////////////////
-- ///// SetVehiclePos		//////
-- ///////////////////////////////

function VehicleSelector:SetVehiclePosition(x, y, z)
	return self.vehicle:SetPos(x, y, z+getElementDistanceFromCentreOfMassToBaseOfModel(self.vehicle));
end

-- ///////////////////////////////
-- ///// SetModell			//////
-- ///////////////////////////////

function VehicleSelector:SetModel(model)
	local x, y, z = self.vehicle:GetPos();
	self.model = model;
	setElementModel(self.vehicle, model);
	self:SetVehiclePosition(x, y, z);
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function VehicleSelector:Constructor(x, y, z, modell)
	self.rotRenderFunc = function()
		self:RenderRot();
	end
	
	self.clickFunc = function(...)
		self:OnClick(...);
	end
	
	self.mouseMoveFunc = function(...)
		self:MouseMove(...);
	end

	self.x, self.y, self.z = x, y, z
	self.model = modell;
	
	self.state = false;
	
	self.vehicle = createVehicle(modell, x, y, z, 0, 0, 0);
	self.vehicle:SetColor(255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
	
	self:SetVehiclePosition(x, y, z);
	
	self.currentRot = 0.1
	self:Start();
	logger:OutputInfo("[CALLING] VehicleSelector: Constructor");
end

-- EVENT HANDLER --
