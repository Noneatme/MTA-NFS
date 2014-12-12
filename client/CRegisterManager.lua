-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RegisterManager		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RegisterManager = {};
RegisterManager.__index = RegisterManager;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RegisterManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Save Settings		//////
-- ///////////////////////////////

function RegisterManager:SaveSettings(email, pass, hashed)
	if not(hashed) then
		if(fileExists("savedFiles/login.csv")) then
			fileDelete("savedFiles/login.csv");
		end
		local file = fileCreate("savedFiles/login.csv");
		if(file) then
			fileWrite(file, email..","..sha256(pass));
			fileFlush(file);
			fileClose(file);
		else
			logger:OutputInfo("Login thing cannot be created");
		end
	end
end

-- ///////////////////////////////
-- ///// Load Settings		//////
-- ///////////////////////////////

function RegisterManager:LoadSettings()
	if(fileExists("savedFiles/login.csv")) then
		local file = fileOpen("savedFiles/login.csv");
		if(file) then
			local strings = fileRead(file, fileGetSize(file));
			local email, hashedpassword = gettok(strings, 1, ","), gettok(strings, 2, ",");
			
			if(email and hashedpassword) then
				guiSetText(self.RegisterBox.page1.edit1, email);
				guiSetText(self.RegisterBox.page1.edit2, hashedpassword);
				self.passwordInputHashed = true;
			end
			
			fileClose(file);
		end
	end -- Else do nothing
end

-- ///////////////////////////////
-- ///// Open		 		//////
-- ///////////////////////////////

function RegisterManager:Open(...)
	assert(self.state == false);
	local sx, sy = guiGetScreenSize()
	if(sx <= 1024) and (sy <= 768) then
		localPlayer:KickMe();
		return
	end

	self.RegisterBox = CG.RegisterBox:New();
	
	self.RegisterBox:Open();
	
	-- EVENT HANDLER --
	setTimer(function()
		addEventHandler("onClientGUIClick", self.RegisterBox.btnToggle, function()
			playSoundFrontEnd(41);
			self.RegisterBox:TogglePage(self.RegisterBox.selectedPage, false);
			guiSetEnabled(self.RegisterBox.btnToggle, false);
			self.RegisterBox.easingFunc = "OutBounce";
			self.RegisterBox.tickStart = getTickCount();
			if(self.RegisterBox.selectedPage == 1) then
				self.RegisterBox.selectedPage = 2;
			else
				self.RegisterBox.selectedPage = 1;
			end
			setTimer(function()
				self.RegisterBox:TogglePage(self.RegisterBox.selectedPage, true);
				guiSetEnabled(self.RegisterBox.btnToggle, true);
			end, 1000, 1)
		end, false)
		
		-- EVENT HANDLER --
		
		-- REGISTER --
		addEventHandler("onClientGUIClick", self.RegisterBox.page2.btnRegister, function()
			local email = guiGetText(self.RegisterBox.page2.edit1);
			local pass1 = guiGetText(self.RegisterBox.page2.edit2);
			local pass2 = guiGetText(self.RegisterBox.page2.edit3);
			local callsign = guiGetText(self.RegisterBox.page2.edit4);
			
			local sex = guiComboBoxGetItemText(self.RegisterBox.page2.combobox1, guiComboBoxGetSelected(self.RegisterBox.page2.combobox1));
			
			local date = guiComboBoxGetItemText(self.RegisterBox.page2.combobox4, guiComboBoxGetSelected(self.RegisterBox.page2.combobox4)).."-"..guiComboBoxGetItemText(self.RegisterBox.page2.combobox3, guiComboBoxGetSelected(self.RegisterBox.page2.combobox3)).."-"..guiComboBoxGetItemText(self.RegisterBox.page2.combobox2, guiComboBoxGetSelected(self.RegisterBox.page2.combobox2));
			
			playSoundFrontEnd(41);
			if(gettok(email, 1, "@") and gettok(email, 2, "@") and gettok(gettok(email, 2, "@"), 2, ".")) then
				if(sha256(pass1) == sha256(pass2)) then
					if(string.len(callsign) > 3) then
						triggerServerEvent("CRegisterManager:RegisterServer", localPlayer, email, sha256(pass1), callsign, sex, date);
					else
						messageBox:Show("Warning", "Please enter a valid callsign with more than 3 characters.", "Okay", tocolor(255, 0, 0, 255), true);
			
					end
				else
					messageBox:Show("Warning", "Your password does not match your other password.", "Okay", tocolor(255, 0, 0, 255), true);
			
				end
			else
				messageBox:Show("Warning", "Please enter a valid E-Mail adress.\n\nThe E-Mail adress is used, to identify your account.", "Okay", tocolor(255, 0, 0, 255), true);
			end
		end, false)
		
		-- LOGIN --
		addEventHandler("onClientGUIClick", self.RegisterBox.page1.btnLogin, function()
			local email = guiGetText(self.RegisterBox.page1.edit1);
			local pass = guiGetText(self.RegisterBox.page1.edit2);
			if(string.len(email) > 3) then
				if(string.len(pass) > 3) then
					self:SaveSettings(email, pass, self.passwordInputHashed);
					
					if(self.passwordInputHashed == false) then
						pass = sha256(pass);
					end
					triggerServerEvent("CRegisterManager:LoginServer", localPlayer, email, pass);
					
				else
					messageBox:Show("Warning", "Please enter a valid Password.", "Okay", tocolor(255, 0, 0, 255), true);
				end
			else
				messageBox:Show("Warning", "Please enter a valid E-Mail adress.", "Okay", tocolor(255, 0, 0, 255), true);
			end
		end, false)
		
		-- HASH DINGENS --
		addEventHandler("onClientGUIChanged", self.RegisterBox.page1.edit2, function()
			if(self.passwordInputHashed == true) then
				guiSetText(source, "");
				self.passwordInputHashed = false;
			end
		end, false)
		
		self:LoadSettings();
	end, 1000, 1)
end
-- ///////////////////////////////
-- ///// AccountSucess		//////
-- ///////////////////////////////

function RegisterManager:LoginSucess()
	self.RegisterBox:Close();
	setTimer(function()
		renderGarage:OpenPage("main");
	end, 1000, 1)
	
	vehicleSelector = VehicleSelector:New(933.58520507813, 2063.6616210938, 10.8203125, 542)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RegisterManager:Constructor(...)
	self.state = false;
	self.passwordInputHashed = false;
	
	self.accountLoginFunc = function()
		self:LoginSucess();
	end
	
	logger:OutputInfo("[CALLING] RegisterManager: Constructor");

	-- EVENTS --
	addEvent("onAccountLogin", true);
	addEventHandler("onAccountLogin", getLocalPlayer(), bind(self.accountLoginFunc, self));
end

-- EVENT HANDLER --
