-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: PurchaseCarRender	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

PurchaseCarRender = {};
PurchaseCarRender.__index = PurchaseCarRender;

--[[


GUIEditor.combobox[1] = guiCreateComboBox(1338, 159, 245, 223, "'S' Class - Hightest", false)
guiSetFont(GUIEditor.combobox[1], "default-bold-small")
guiSetProperty(GUIEditor.combobox[1], "NormalEditTextColour", "FF002B00")
guiComboBoxAddItem(GUIEditor.combobox[1], "'S' Class - Hightest")
guiComboBoxAddItem(GUIEditor.combobox[1], "'A' Class")
guiComboBoxAddItem(GUIEditor.combobox[1], "'B' Class")
guiComboBoxAddItem(GUIEditor.combobox[1], "'C' Class")
guiComboBoxAddItem(GUIEditor.combobox[1], "'C' Class")
guiComboBoxAddItem(GUIEditor.combobox[1], "'D' Class")
guiComboBoxAddItem(GUIEditor.combobox[1], "'E' Class - Lowest")
guiComboBoxAddItem(GUIEditor.combobox[1], "Limited time")
guiComboBoxAddItem(GUIEditor.combobox[1], "Gifts")
guiComboBoxAddItem(GUIEditor.combobox[1], "Premium")
]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function PurchaseCarRender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render 			//////
-- ///////////////////////////////

function PurchaseCarRender:Render()
	local width, height;
	if(self.closed ~= true) then
		width, height = self.renderManager:interpolateBetween(512, 0, 0, 512, 692, 0, (getTickCount()-self.startTick)/1000, self.easingFunc);
	else
		width, height = self.renderManager:interpolateBetween(512, 692, 0, 512, 0, 0, (getTickCount()-self.startTick)/1000, self.easingFunc);
	
	end
	
	self.renderManager:dxDrawRectangle(1082, 142, width, height, tocolor(0, 0, 0, 132), false)
	if(getTickCount()-self.startTick > 1000) then
		self.renderManager:dxDrawImage(1082, 97, 512, 45, "files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 200), true)
		self.renderManager:dxDrawText("Purchase Cars", 1082, 96, 1594, 142, tocolor(255, 255, 255, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, false, true, false, false)
		       
		self.renderManager:dxDrawText("Select Class:", 1086, 150, 1334, 194, tocolor(255, 255, 255, 255), 0.5, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawRectangle(1092, 200, 493, 456, tocolor(0, 0, 0, 120), false)
		
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
				self.renderManager:dxDrawText(getVehicleNameFromModel(self.carTable[i]), 1092, 207+add*2, 1582, 257, tocolor(255, 255, 255, 255), 0.6, fontManager:GetNFSFont(), "center", "center", false, false, false, false, true)
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
		self.renderManager:dxDrawRectangle(1273, 659, 150, 51, tocolor(0, 0, 0, 150), true)
		self.renderManager:dxDrawText("Buy this car using", 1273, 657, 1423, 709, tocolor(r, g, b, 255), 0.5, fontManager:GetNFSFont(), "center", "center", false, true, true, false, false)
	end
end

-- ///////////////////////////////
-- ///// buildGui 			//////
-- ///////////////////////////////

function PurchaseCarRender:BuildGui()
	self.guiEle.cb = self.renderManager:guiCreateComboBox(1338, 159, 245, 223, "'S' Class - Hightest", false)
	guiSetFont(self.guiEle.cb, "default-bold-small")
	guiSetProperty(self.guiEle.cb, "NormalEditTextColour", "FF002B00")
	guiComboBoxAddItem(self.guiEle.cb, "'S' Class - Hightest")
	guiComboBoxAddItem(self.guiEle.cb, "'A' Class")
	guiComboBoxAddItem(self.guiEle.cb, "'B' Class")
	guiComboBoxAddItem(self.guiEle.cb, "'C' Class")
	guiComboBoxAddItem(self.guiEle.cb, "'D' Class")
	guiComboBoxAddItem(self.guiEle.cb, "'E' Class - Lowest")
	guiComboBoxAddItem(self.guiEle.cb, "Limited time")
	--guiComboBoxAddItem(self.guiEle.cb, "Gifts")
	guiComboBoxAddItem(self.guiEle.cb, "Premium")
	
	addEventHandler("onClientGUIComboBoxAccepted", self.guiEle.cb, function(element) 
		local item = guiComboBoxGetSelected(self.guiEle.cb);
		self.selectedValue = -1;
		if(item == 0) then
			self.carTable = vehicleClass.classS;
			
		elseif(item == 1) then
			self.carTable = vehicleClass.classA;
			
		elseif(item == 2) then
			self.carTable = vehicleClass.classB;
			
		elseif(item == 3) then
			self.carTable = vehicleClass.classC;
			
		elseif(item == 4) then
			self.carTable = vehicleClass.classD;
			
		elseif(item == 5) then
			self.carTable = vehicleClass.classE;
			
		elseif(item == 6) then
			self.carTable = vehicleClass.classLimitedTime;
			
		elseif(item == 7) then
			self.carTable = vehicleClass.classLegendary;
		end
		self.startCar = 1;
		self:RefreshSelectionButtons()
	end)
	
	-- BUY --
	
	self.guiEle.radio1 = self.renderManager:guiCreateRadioButton(1430, 659, 156, 23, "Tokens", false)
	guiSetFont(self.guiEle.radio1, "default-bold-small")
	guiSetProperty(self.guiEle.radio1, "NormalTextColour", "FFFFBF0000")


	self.guiEle.radio2 = self.renderManager:guiCreateRadioButton(1430, 684, 156, 23, "Dollar", false)
	guiSetFont(self.guiEle.radio2, "default-bold-small")
	
	self.guiEle.btnBuyCar = self.renderManager:guiCreateButton(1273, 659, 150, 51, "Hi", false, nil, true, true);
	guiSetAlpha(self.guiEle.btnBuyCar, 0)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnBuyCar, function()
		local rad1, rad2 = guiRadioButtonGetSelected(self.guiEle.radio1), guiRadioButtonGetSelected(self.guiEle.radio2)
		if(rad1) or (rad2) then
			localPlayer:BuyCar(self.carTable[self.selectedValue], rad1, rad2); -- Tokens
		else
			messageBox:Show("Error", "Please select a method to buy this vehicle.", "Okay", tocolor(255, 0, 0, 255), true);
		end
	end, false)
end

-- ///////////////////////////////
-- ////refreshSelectionButtons////
-- ///////////////////////////////

function PurchaseCarRender:RefreshSelectionButtons()
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
				
				vehicleSelector:SetModel(self.carTable[i]);
				
					
				guiRadioButtonSetSelected(self.guiEle.radio1, false);
				guiRadioButtonSetSelected(self.guiEle.radio2, false);
				
				
				local money, tokens = vehicleSelector.vehicle:GetPrice();
				
				if(money ~= 0) and (money) then
					guiSetEnabled(self.guiEle.radio2, true);
					guiSetText(self.guiEle.radio2, "Dollar($"..setDotsInNumber(tostring(money))..")");
				else
					guiSetEnabled(self.guiEle.radio2, false);
					guiSetText(self.guiEle.radio2, "Dollar");
				end
				
				if(tokens ~= 0) and (tokens) then
					guiSetEnabled(self.guiEle.radio1, true);
					guiSetText(self.guiEle.radio1, "Tokens("..setDotsInNumber(tostring(tokens))..")");
				else
					guiSetEnabled(self.guiEle.radio1, false);
					guiSetText(self.guiEle.radio1, "Tokens");
				end
			end, false)
		end
	end
end


-- ///////////////////////////////
-- ///// destroyGui 		//////
-- ///////////////////////////////

function PurchaseCarRender:DestroyGui()
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

function PurchaseCarRender:ScrollDown()
	if(self.startCar < #self.carTable) then
		self.startCar = self.startCar+1;
	else
		self.startCar = #self.carTable+1;
	end
	
	self:RefreshSelectionButtons();
end

function PurchaseCarRender:ScrollUp()
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

function PurchaseCarRender:Start()
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

function PurchaseCarRender:Stop()
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

function PurchaseCarRender:Constructor(...)
	local x1, y1, z1, x2, y2, z2 = cameraMover:GetCamPos();
	cameraMover:SmoothMoveCamera(x1, y1, z1, x2, y2, z2, 942.32696533203, 2077.1623535156, 12.802765846252, 873.59478759766, 2004.798828125, 6.5248990058899, 3000, "OutBack");
	
	self.renderManager = RenderManager:New(aesx, aesy); 
	
	self.easingFunc = "OutQuad";
	
	self.startCar = 1;
	
	self.endCar = 10;
	
	self.state = false;
	
	self.guiEle = {};
	self.guiEle.selButtons = {};
	
	self.carTable = vehicleClass.classS;
	
	
	logger:OutputInfo("[CALLING] PurchaseCarRender: Constructor");


end

-- EVENT HANDLER --
