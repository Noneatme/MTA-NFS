-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: 					##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

RegisterManager = {}
RegisterManager.__index = RegisterManager


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RegisterManager:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end


-- ///////////////////////////////
-- ///// RegisterPlayer 	//////
-- ///////////////////////////////

function RegisterManager:RegisterPlayer(email, password, callsign, sex, date)
	local result, numrows = connectionManager:Query("SELECT * FROM tblAccounts WHERE EMail = '"..email.."';");
	if(numrows < 1) then
		result, numrows = connectionManager:Query("INSERT INTO tblAccounts(EMail, Password, Callsign, IP, Serial, Sex, Birthday) VALUES ('"..email.."', '"..password.."', '"..callsign.."', '"..source:GetIP().."', '"..source:GetSerial().."', '"..sex.."', '"..date.."');");
		if(numrows > 0) then
			source:ShowMessageBox("Sucess!", "Account sucessfull registered!\n\nYou can now login.", "Fuck yea", "sucess", true)
			source:TriggerEvent("onAccountRegSucess");
		else
			source:ShowMessageBox("Error", "An Error occured while creating your account.\nPlease contact an administrator. This is a MySQL Problem.", "Shit", "error", true)
	
		end
	else
		source:ShowMessageBox("Error", "An account with this E-Mail adress is allready registered!", "Shit", "error", true)
	end
end

-- ///////////////////////////////
-- ///// Login   Player 	//////
-- ///////////////////////////////

function RegisterManager:LoginPlayer(email, password)
	local result, numrows = connectionManager:Query("SELECT ID FROM tblAccounts WHERE EMail = '"..email.."' AND Password = '"..password.."';");
	if(numrows > 0) and (source:IsLoggedIn() == false) then
		source:NewElementTree();
		-- GET THE DATAS --
		local tblAccountResult = connectionManager:Query("SELECT * FROM tblAccounts WHERE EMail = '"..email.."';");
		local tblCarResult = connectionManager:Query("SELECT * FROM tblautos WHERE Owner = '"..email.."'");
		
		local s = source:LogIn(tblAccountResult[1], tblCarResult);
		if(s) then
			source:TriggerEvent("onAccountLogin");
			source:CheckForNoVehicle();
		else
			source:ShowMessageBox("Error", "An error occurred while loggin in.", "Fuck", "error", true);
	
		end
	else
		source:ShowMessageBox("Error", "This account doesn't exists.\nIf you lost your account, please contact an admin.\n\nOr you are allready logged in!", "Okay", "error", true);
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RegisterManager:Constructor()
	self.RegisterFunc = function(...)
		self:RegisterPlayer(...);
	end
	
	self.LoginFunc = function(...)
		self:LoginPlayer(...);
	end
	-- Events --
	addEvent("CRegisterManager:RegisterServer", true)
	addEventHandler("CRegisterManager:RegisterServer", getRootElement(), self.RegisterFunc);
	
	addEvent("CRegisterManager:LoginServer", true)
	addEventHandler("CRegisterManager:LoginServer", getRootElement(), self.LoginFunc);
end

-- EVENT HANDLER --
