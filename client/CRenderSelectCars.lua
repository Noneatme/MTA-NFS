-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: SelectCarRender		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SelectCarRender = {};
SelectCarRender.__index = SelectCarRender;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function SelectCarRender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render 			//////
-- ///////////////////////////////

function SelectCarRender:Render()
	local width, height;
	if(self.closed ~= true) then
		width, height = self.renderManager:interpolateBetween(512, 0, 0, 512, 692, 0, (getTickCount()-self.startTick)/1000, self.easingFunc);
	else
		width, height = self.renderManager:interpolateBetween(512, 692, 0, 512, 0, 0, (getTickCount()-self.startTick)/1000, self.easingFunc);
	
	end
	
	self.renderManager:dxDrawRectangle(1082, 142, width, height, tocolor(0, 0, 0, 132), false)
	if(getTickCount()-self.startTick > 1000) then
		self.renderManager:dxDrawImage(1082, 97, 512, 45, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 200), true)
		self.renderManager:dxDrawText("Select Car", 1082, 96, 1594, 142, tocolor(255, 255, 255, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
		       

		-- RENDER CAR DINGENS --
		
		local add = 0;
		
		local increment = 57/aesx*sx;
		

		for i = self.startCar, 7+self.startCar, 1 do
			if(self.carTable[i]) then
				local r, g, b, a = 50, 255, 50, 77;
				
				if(getElementData(self.guiEle.selButtons[i], "hover")) or (self.selectedValue == i) then
					r, g, b, a = 50, 255, 50, 150;
				end
				self.renderManager:dxDrawImage(1093, 208+add, 490, 48, "files/images/aero-title.png", 0, 0, 0, tocolor(r, g, b, a), false)
				self.renderManager:dxDrawText(getVehicleNameFromModel(self.carTable[i]['Modell']), 1092, 207+add*2, 1582, 257, tocolor(255, 255, 255, 255), 0.6, fontManager:GetNFSFont(), "center", "center", false, false, false, false, true)
				add = add+increment;
			end
		end
		
		--[[
		self.renderManager:dxDrawImage(1093, 208, 490, 51, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 200), true)
		self.renderManager:dxDrawText("Car 1", 1092, 207, 1582, 260, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, true, false, false)
		--]]
		self.renderManager:dxDrawText("Power level: "..vehicleSelector.vehicle:GetPowerLevel(), 1095, 654, 1272, 704, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Acceleration: ", 1097, 706, 1271, 746, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Top speed:", 1097, 748, 1271, 788, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Handling:", 1097, 791, 1271, 831, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		
		self.renderManager:dxDrawRectangle(1274, 716, 308, 21, tocolor(255, 255, 255, 46), true)
		self.renderManager:dxDrawRectangle(1275, 757, 308, 21, tocolor(255, 255, 255, 46), true)
		self.renderManager:dxDrawRectangle(1275, 800, 308, 21, tocolor(255, 255, 255, 46), true)
		
		-- SPEED --
		local width = 308
		width = width/360*vehicleSelector.vehicle:GetAccelerationToNumber();
		self.renderManager:dxDrawImage(1274, 716, width, 21, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 100), true)
		
		width = 308
		width = width/720*vehicleSelector.vehicle:GetMaxSpeedToNumber();
		self.renderManager:dxDrawImage(1274, 757, width, 21, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 100), true)
		
		width = 308
		width = width/1200*vehicleSelector.vehicle:GetHandlingToNumber();
		self.renderManager:dxDrawImage(1274, 800, width, 21, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 100), true)
		
		self.renderManager:dxDrawText(vehicleSelector.vehicle:GetAccelerationToNumber(), 1274, 715, 1582, 737, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(vehicleSelector.vehicle:GetMaxSpeedToNumber(), 1274, 757+42, 1582, 737, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(vehicleSelector.vehicle:GetHandlingToNumber(), 1274, 800+42*2, 1582, 737, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	

		local r, g, b = 255, 255, 255
		if(getElementData(self.guiEle.btnBuyCar, "hover")) then
			r, g, b = 0, 255, 0
		end
		self.renderManager:dxDrawRectangle(1273, 659, 150, 51, tocolor(0, 0, 0, 116), true)
		
		self.renderManager:dxDrawText("Use Car!", 1273, 657, 1423, 709, tocolor(r, g, b, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, true, true, false, false)
	
		r, g, b = 255, 255, 255
		if(getElementData(self.guiEle.btnSellCar, "hover")) then
			r, g, b = 0, 255, 0
		end
		self.renderManager:dxDrawRectangle(1428, 660, 150, 51, tocolor(0, 0, 0, 116), true)
		
		self.renderManager:dxDrawText("Sell Car!", 1428, 660, 1573, 709, tocolor(r, g, b, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, true, true, false, false)
	
	end
end

-- ///////////////////////////////
-- ///// buildGui 			//////
-- ///////////////////////////////

function SelectCarRender:BuildGui()
	self.guiEle.btnBuyCar = self.renderManager:guiCreateButton(1273, 659, 150, 51, "Hi", false, nil, true, true);
	guiSetAlpha(self.guiEle.btnBuyCar, 0)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnBuyCar, function()
		local veh = self.selectedValue;
		if(veh) then
			localPlayer:UpdateSelectedCar(tonumber(self.carTable[veh]['ID']));
			playSoundFrontEnd(42);
		end
	end, false)
	
	self.guiEle.btnSellCar = self.renderManager:guiCreateButton(1428, 660, 150, 51, "Hi", false, nil, true, true);
	guiSetAlpha(self.guiEle.btnSellCar, 0)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnSellCar, function()
		local veh = self.selectedValue;
		if(veh) then
			optionBox:Show("Warning", "Are you sure you want to sell this vehicle?\n\nYou will get: $"..setDotsInNumber(tostring(vehicleCosts:GetSellValue(self.carTable[veh]['Modell']))).." for this vehicle.\n\nThis Action cannot be undo'd!", "Yes", "No");
			addEventHandler("onClientGUIClick", optionBox.btn1, function()
				localPlayer:SellVehicle(veh);
				self.carTable = {};
				self:RefreshSelectionButtons();
				setTimer(function()
					self.carTable = localPlayer:GetCarsAsTable();
					self:RefreshSelectionButtons();
				end, 1000, 1)
			end, false)
		end
	end, false)
end

-- ///////////////////////////////
-- ////refreshSelectionButtons////
-- ///////////////////////////////

function SelectCarRender:RefreshSelectionButtons()
	for _, e in pairs(self.guiEle.selButtons) do
		if(isElement(e)) then
			destroyElement(e);
		end
	end
	
	local add = 0;
		
	local increment = 57/aesx*sx;
		

	for i = self.startCar, 7+self.startCar, 1 do
		if(self.carTable[i]) then
			self.guiEle.selButtons[i] = self.renderManager:guiCreateButton(1093, 208+add, 490, 48, i, false, nil, true, true);
			guiSetAlpha(self.guiEle.selButtons[i], 0);
			add = add+increment;
			guiMoveToBack(self.guiEle.selButtons[i])
			
			addEventHandler("onClientGUIClick", self.guiEle.selButtons[i], function()
				self.selectedValue = i;
				playSoundFrontEnd(41);
				
				vehicleSelector:UpdateCar(self.carTable[i]);
			end, false)
		end
	end
end


-- ///////////////////////////////
-- ///// destroyGui 		//////
-- ///////////////////////////////

function SelectCarRender:DestroyGui()
	for _, e in pairs(self.guiEle.selButtons) do
		if(isElement(e)) then
			destroyElement(e);
		end
	end
	
	for _, e in pairs(self.guiEle) do
		if(isElement(e)) then
			destroyElement(e);
		end
	end
	self.guiEle = nil;
	
	
end


-- ///////////////////////////////
-- //Scroll Up and Scroll Down////
-- ///////////////////////////////

function SelectCarRender:ScrollDown()
	if(self.startCar < #self.carTable) then
		self.startCar = self.startCar+1;
	else
		self.startCar = #self.carTable+1;
	end
	
	self:RefreshSelectionButtons();
end

function SelectCarRender:ScrollUp()
	if(self.startCar > 2) then
		self.startCar = self.startCar-1;
	else
		self.startCar = 1;
	end
	self:RefreshSelectionButtons();
end

-- ///////////////////////////////
-- ///// Start 				//////
-- ///////////////////////////////

function SelectCarRender:Start()
	assert(self.state == false);
	self.renderFunc = function()
		self:Render();
	end
	
	self.scrollDownFunc = function()
		self:ScrollDown()
	end
	
	self.scrollUpFunc = function()
		self:ScrollUp();
	end
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self.state = true;
		
	self.startTick = getTickCount();
	
	setTimer(function()
		rbb:Start();
		
		addEventHandler("onClientGUIClick", rbb.backButton, function()
			renderGarage:OpenPage("modcars");
			self:Stop();
		end, false)
		
		self:BuildGui();
		
		self:ScrollUp();
	end, 1000, 1)
	
	bindKey("mouse_wheel_down", "down", self.scrollDownFunc);
	bindKey("mouse_wheel_up", "down", self.scrollUpFunc);
	
end

-- ///////////////////////////////
-- ///// Stop 				//////
-- ///////////////////////////////

function SelectCarRender:Stop()
	assert(self.state == true);
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self.state = false;
	self:DestroyGui();
	self.startTick = getTickCount();
	
	unbindKey("mouse_wheel_down", "down", self.scrollDownFunc);
	unbindKey("mouse_wheel_up", "down", self.scrollUpFunc);
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function SelectCarRender:Constructor(...)
	local x1, y1, z1, x2, y2, z2 = cameraMover:GetCamPos();
	cameraMover:SmoothMoveCamera(x1, y1, z1, x2, y2, z2, 942.32696533203, 2077.1623535156, 12.802765846252, 873.59478759766, 2004.798828125, 6.5248990058899, 3000, "OutBack");
	
	self.renderManager = RenderManager:New(aesx, aesy); 
	
	self.easingFunc = "OutQuad";
	
	self.startCar = 1;
	
	self.endCar = 10;
	
	self.state = false;
	
	self.guiEle = {};
	self.guiEle.selButtons = {};
	
	self.carTable = localPlayer:GetCarsAsTable();
	
	
	logger:OutputInfo("[CALLING] SelectCarRender: Constructor");


end

-- EVENT HANDLER --
