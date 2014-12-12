-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RegisterBoxGUI		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

CG.RegisterBox = {};
CG.RegisterBox.__index = CG.RegisterBox;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function CG.RegisterBox:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///////////////////////////////

function CG.RegisterBox:RenderGui()
	local sx, sy = guiGetScreenSize();
	self.renderManager:dxDrawImage(613, 212, 388, 26, "files/images/aero-title.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	self.renderManager:dxDrawText("Login/Register to MTA:Speedrace", 612, 211, 1001, 238, tocolor(0, 0, 0, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	
	local width, height;
	if(self.closed ~= true) then
		width, height = self.renderManager:interpolateBetween(388, 0, 0, 388, 402, 0, (getTickCount()-self.tickStart)/1000, self.easingFunc);
	else
		width, height = self.renderManager:interpolateBetween(388, 402, 0, 388, 0, 0, (getTickCount()-self.tickStart)/1000, self.easingFunc);
	
	end
	self.renderManager:dxDrawRectangle(613, 238, width, height, tocolor(127, 127, 127, 98), false)
	local r, g, b = 255, 255, 255;
	if(getTickCount()-self.tickStart > 1000) then
		local text = "Register";
		if(self.selectedPage == 2) then
			text = "Login";
		end
		if(getElementData(self.btnToggle, "hover")) then
			r, g, b = 0, 0, 0;
		end
		self.renderManager:dxDrawRectangle(619, 243, 91, 27, tocolor(255, 255, 255, 121), true)
		self.renderManager:dxDrawText(text, 619, 242, 709, 269, tocolor(r, g, b, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		
		if(self.selectedPage == 1) then
			self.renderManager:dxDrawText("Welcome to MTA:Speedrace!\nThis server is in early development.\nIf you have an account,\nyou can login now.", 618, 278, 995, 383, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
			self.renderManager:dxDrawText("E-Mail:", 614, 402, 741, 434, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
			self.renderManager:dxDrawText("Password:", 614, 442, 741, 474, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
			self.renderManager:dxDrawText("Click on 'Login' to login to your account.\n\nIf you have any problems, please\nask for help.", 622, 518, 997, 581, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "left", "top", false, false, true, false, false)
			r, g, b = 255, 255, 255;
			if(getElementData(self.page1.btnLogin, "hover")) then
				r, g, b = 0, 0, 0;
			end
			self.renderManager:dxDrawRectangle(621, 596, 147, 35, tocolor(255, 255, 255, 121), true)
			self.renderManager:dxDrawText("Login", 621, 595, 767, 631, tocolor(r, g, b, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		else
			self.renderManager:dxDrawText("Please fill out the missing Informations.", 618, 276, 994, 314, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("E-Mail: ", 619, 318, 752, 347, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("Password:", 619, 351, 752, 380, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("Password(2x):", 619, 382, 752, 411, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("Callsign: ", 619, 414, 752, 443, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("Sex: ", 619, 447, 752, 476, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("Date of birth:", 619, 478, 752, 507, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
	        self.renderManager:dxDrawText("If you have problems while registering an account,\nplease contact an administrator.", 627, 511, 995, 593, tocolor(255, 255, 255, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, false, false, false)
	        self.renderManager:dxDrawRectangle(625, 600, 110, 30, tocolor(255, 255, 255, 123), true)
	      	 r, g, b = 255, 255, 255;
			if(getElementData(self.page2.btnRegister, "hover")) then
				r, g, b = 0, 0, 0;
			end
	        self.renderManager:dxDrawText("Register", 625, 599, 735, 631, tocolor(r, g, b, 255), 0.3, fontManager:GetDTFont(), "center", "center", false, false, true, false, false)
		end
	end
	
	
end

-- ///////////////////////////////
-- ///// DestroyGui		 	//////
-- ///////////////////////////////

function CG.RegisterBox:DestroyGui()
	for index, ele in pairs(self.page1) do
		if(isElement(ele)) then
			destroyElement(ele);
		end
	end
	
	for index, ele in pairs(self.page2) do
		if(isElement(ele)) then
			destroyElement(ele);
		end
	end
	
	destroyElement(self.btnToggle);
end
-- ///////////////////////////////
-- ///// TogglePage 	 	//////
-- ///////////////////////////////

function CG.RegisterBox:TogglePage(id, state)
	if(id == 1) then
		for index, ele in pairs(self.page1) do
			if(isElement(ele)) then
				if(state == true) then
					if(getElementType(ele) ~= "gui-button") then
						guiSetAlpha(ele, 255);
					end
					guiSetEnabled(ele, true);
				else
					guiSetAlpha(ele, 0);
					guiSetEnabled(ele, false);
				end
			end
		end
	else
		for index, ele in pairs(self.page2) do
			if(isElement(ele)) then
				if(state == true) then
					if(getElementType(ele) ~= "gui-button") then
						guiSetAlpha(ele, 255);
					end
					guiSetEnabled(ele, true);
				else
					guiSetAlpha(ele, 0);
					guiSetEnabled(ele, false);
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// BuildGui		 	//////
-- ///////////////////////////////

function CG.RegisterBox:BuildGui()
	guiSetInputMode("no_binds_when_editing");
	self.btnToggle = guiCreateButton(619/aesx*sx, 243/aesy*sy, 91/aesx*sx, 27/aesy*sy, "Toggle", false);
	guiSetAlpha(self.btnToggle, 0);
		
	addEventHandler("onClientMouseEnter", self.btnToggle, function()
		playSoundFrontEnd(42);
		setElementData(source, "hover", true, false);
	end)
		
	addEventHandler("onClientMouseLeave", self.btnToggle, function()
		setElementData(source, "hover", false, false);
	end)
	
	-- PAGE 1 --
		self.page1.btnLogin = guiCreateButton(621/aesx*sx, 596/aesy*sy, 147/aesx*sx, 35/aesy*sy, "Login", false);
		guiSetAlpha(self.page1.btnLogin, 0);
		
		self.page1.edit1 = guiCreateEdit(748/aesx*sx, 402/aesy*sy, 245/aesx*sx, 32/aesy*sy, "", false)
		self.page1.edit2 = guiCreateEdit(747/aesx*sx, 442/aesy*sy, 246/aesx*sx, 32/aesy*sy, "", false)
		guiEditSetMasked(self.page1.edit2, true);
		
		self.page1.checkbox = guiCreateCheckBox(626/aesx*sx, 481/aesy*sy, 235/aesx*sx, 24/aesy*sy, "Save Password(This checkbox is useless)", true, false)
		
			-- EVENT HANDLER --
		addEventHandler("onClientMouseEnter", self.page1.btnLogin, function()
			playSoundFrontEnd(42);
			setElementData(source, "hover", true, false);
		end)
			
		addEventHandler("onClientMouseLeave", self.page1.btnLogin, function()
			setElementData(source, "hover", false, false);
		end)
	-- PAGE 2 --
		self.page2.edit1 = guiCreateEdit(754/aesx*sx, 317/aesy*sy, 241/aesx*sx, 31/aesy*sy, "", false);
		
		self.page2.edit2 = guiCreateEdit(754/aesx*sx, 349/aesy*sy, 241/aesx*sx, 31/aesy*sy, "", false);
		
		self.page2.edit3 = guiCreateEdit(754/aesx*sx, 380/aesy*sy, 241/aesx*sx, 31/aesy*sy, "", false);
		
		self.page2.edit4 = guiCreateEdit(754/aesx*sx, 412/aesy*sy, 241/aesx*sx, 31/aesy*sy, "", false);
		
		guiEditSetMasked(self.page2.edit2, true);
		guiEditSetMasked(self.page2.edit3, true);
		
		self.page2.combobox1 = guiCreateComboBox(757/aesx*sx, 448/aesy*sy, 118/aesx*sx, 63/aesy*sy, "Male", false);
		guiSetFont(self.page2.combobox1, "default-bold-small");
		guiComboBoxAddItem(self.page2.combobox1, "Male");
		guiComboBoxAddItem(self.page2.combobox1, "Female");
		
		self.page2.combobox2 = guiCreateComboBox(761/aesx*sx, 479/aesy*sy, 48/aesx*sx, 155/aesy*sy, "01", false);
		guiSetFont(self.page2.combobox2, "default-bold-small");
		guiComboBoxAddItem(self.page2.combobox2, "01");
		guiComboBoxAddItem(self.page2.combobox2, "02");
		guiComboBoxAddItem(self.page2.combobox2, "03");
		guiComboBoxAddItem(self.page2.combobox2, "04");
		guiComboBoxAddItem(self.page2.combobox2, "05");
		guiComboBoxAddItem(self.page2.combobox2, "06");
		guiComboBoxAddItem(self.page2.combobox2, "07");
		guiComboBoxAddItem(self.page2.combobox2, "08");
		guiComboBoxAddItem(self.page2.combobox2, "09");
		guiComboBoxAddItem(self.page2.combobox2, "10");
		guiComboBoxAddItem(self.page2.combobox2, "11");
		guiComboBoxAddItem(self.page2.combobox2, "12");
		guiComboBoxAddItem(self.page2.combobox2, "13");
		guiComboBoxAddItem(self.page2.combobox2, "14");
		guiComboBoxAddItem(self.page2.combobox2, "15");
		guiComboBoxAddItem(self.page2.combobox2, "16");
		guiComboBoxAddItem(self.page2.combobox2, "17");
		guiComboBoxAddItem(self.page2.combobox2, "18");
		guiComboBoxAddItem(self.page2.combobox2, "19");
		guiComboBoxAddItem(self.page2.combobox2, "20");
		guiComboBoxAddItem(self.page2.combobox2, "21");
		guiComboBoxAddItem(self.page2.combobox2, "22");
		guiComboBoxAddItem(self.page2.combobox2, "23");
		guiComboBoxAddItem(self.page2.combobox2, "24");
		guiComboBoxAddItem(self.page2.combobox2, "25");
		guiComboBoxAddItem(self.page2.combobox2, "26");
		guiComboBoxAddItem(self.page2.combobox2, "27");
		guiComboBoxAddItem(self.page2.combobox2, "28");
		guiComboBoxAddItem(self.page2.combobox2, "29");
		guiComboBoxAddItem(self.page2.combobox2, "30");
		guiComboBoxAddItem(self.page2.combobox2, "31");
		
		self.page2.combobox3 = guiCreateComboBox(813/aesx*sx, 479/aesy*sy, 48/aesx*sx, 155/aesy*sy, "01", false);
		guiSetFont(self.page2.combobox3, "default-bold-small");
		guiComboBoxAddItem(self.page2.combobox3, "01");
		guiComboBoxAddItem(self.page2.combobox3, "02");
		guiComboBoxAddItem(self.page2.combobox3, "03");
		guiComboBoxAddItem(self.page2.combobox3, "04");
		guiComboBoxAddItem(self.page2.combobox3, "05");
		guiComboBoxAddItem(self.page2.combobox3, "06");
		guiComboBoxAddItem(self.page2.combobox3, "07");
		guiComboBoxAddItem(self.page2.combobox3, "08");
		guiComboBoxAddItem(self.page2.combobox3, "09");
		guiComboBoxAddItem(self.page2.combobox3, "10");
		guiComboBoxAddItem(self.page2.combobox3, "11");
		guiComboBoxAddItem(self.page2.combobox3, "12");
		
		
		self.page2.combobox4 = guiCreateComboBox(866/aesx*sx, 480/aesy*sy, 118/aesx*sx, 153/aesy*sy, "1996", false);
		guiSetFont(self.page2.combobox4, "default-bold-small");
		for i = 2013, 1950, -1 do
			guiComboBoxAddItem(self.page2.combobox4, tostring(i));
		end
				
		self.page2.btnRegister = guiCreateButton(625/aesx*sx, 600/aesy*sy, 110/aesx*sx, 30/aesy*sy, "", false);
		addEventHandler("onClientMouseEnter", self.page2.btnRegister, function()
			playSoundFrontEnd(42);
			setElementData(source, "hover", true, false);
		end)
			
		addEventHandler("onClientMouseLeave", self.page2.btnRegister, function()
			setElementData(source, "hover", false, false);
		end)
end
-- ///////////////////////////////
-- ///// Register Sucess 	//////
-- ///////////////////////////////

function CG.RegisterBox:RegisterSucess(...)
	guiSetText(self.page2.edit1, "");
	guiSetText(self.page2.edit2, "");
	guiSetText(self.page2.edit3, "");
	guiSetText(self.page2.edit4, "");
end

-- ///////////////////////////////
-- ///// Open		 		//////
-- ///////////////////////////////

function CG.RegisterBox:Open()
	assert(self.state == false);
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self.state = true;
	self.tickStart = getTickCount();
	self.selectedPage = 1;
	self.toggleKnopf = false;
	self.easingFunc = "OutBounce";
	
	setTimer(self.BuildGuiFunction, 1000, 1);
end

-- ///////////////////////////////
-- ///// Close		 		//////
-- ///////////////////////////////

function CG.RegisterBox:Close()
	assert(self.state == true);
	self.tickStart = getTickCount();
	self.closed = true;
	setTimer(function()
		removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
		self.state = false;
	end, 1000, 1)
	self:DestroyGui();
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function CG.RegisterBox:Constructor(...)
	self.renderFunc = function()
		self:RenderGui();
	end
	self.page1 = {};
	self.page2 = {};
	
	self.BuildGuiFunction = function()
		self:BuildGui();
		
		self:TogglePage(1, true);
		self:TogglePage(2, false);
	end
	self.state = false;
		
	self.RegisterSucessFunc = function()
		self:RegisterSucess();
	end
	self.renderManager = RenderManager:New(aesx, aesy);
	-- EVENTS --
	addEvent("onAccountRegSucess", true);
	addEventHandler("onAccountRegSucess", getLocalPlayer(), self.RegisterSucessFunc);
	
	logger:OutputInfo("[CALLING] CG.RegisterBox: Constructor");
end

-- EVENT HANDLER --
