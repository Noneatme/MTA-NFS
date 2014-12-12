-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: ChatBox				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

ChatBox = {};
ChatBox.__index = ChatBox;

--[[
GUIEditor.edit[1] = guiCreateEdit(1, 865, 363, 31, "OK", false)


GUIEditor.combobox[1] = guiCreateComboBox(190, 655, 174, 115, "", false)
guiSetFont(GUIEditor.combobox[1], "default-bold-small")
guiComboBoxAddItem(GUIEditor.combobox[1], "Freeroam")
guiComboBoxAddItem(GUIEditor.combobox[1], "Global")


GUIEditor.combobox[2] = guiCreateComboBox(190, 655, 174, 115, "Global", false)
guiSetFont(GUIEditor.combobox[2], "default-bold-small")
guiComboBoxAddItem(GUIEditor.combobox[2], "Freeroam")
guiComboBoxAddItem(GUIEditor.combobox[2], "Global")

GUIEditor.button[1] = guiCreateButton(368, 649, 15, 29, "", false)
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")


-- ZU --
GUIEditor.button[1] = guiCreateButton(0, 648, 15, 29, "", false)
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function ChatBox:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render				//////
-- ///////////////////////////////


function ChatBox:Render()
	if(self.state == true) then
		dxDrawText("Select channel:", 0, sy-(aesy-650), 190, sy-(aesy-684), tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawRectangle(0, sy-(aesy-649), 368, 251, tocolor(0, 0, 0, 128), false)
		dxDrawRectangle(367, sy-(aesy-649), 0, 27, tocolor(255, 255, 255, 255), true)
		dxDrawRectangle(0, sy-(aesy-649), 368, 36, tocolor(0, 0, 0, 128), false)
		dxDrawRectangle(0, sy-(aesy-862), 368, 36, tocolor(0, 0, 0, 128), false)
		
		local add = 0
		local increment = 17
		--[[
		dxDrawText("Line 1", 3, 687, 363, 705, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, false, false)
		dxDrawText("Line 2", 3, 704, 363, 722, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, false, false)]]
		
		for i = self.drawingPos, self.drawingPos+9, 1 do
			if(self.groupText[self.selectedGroup]) then
				local text = self.groupText[self.selectedGroup][i];
				if(text) then
					local temp = string.gsub(text, '#%x%x%x%x%x%x', '')
					local cc = false;
					
					if(temp ~= text) then	 -- Colorcodes
						cc = true;
					end	
					
					local r, g, b = self.groupTextColor[self.selectedGroup][i]["r"], self.groupTextColor[self.selectedGroup][i]["g"], self.groupTextColor[self.selectedGroup][i]["b"];
					local a = self.groupTextColor[self.selectedGroup][i]["a"];
					
					if(a < 255) then
						a = a+5
					end

					
					self.groupTextColor[self.selectedGroup][i]["a"] = a; -- 705
					dxDrawText(text, 5, sy-(aesy-(687+add-self.add)), 363, sy-(aesy-(705+add-self.add)), tocolor(r or 255, g or 255, b or 255, a), 1, "default-bold", "left", "center", true, false, true, cc, false)
					
					

					add = add+increment;
					
					
					
					if(self.add > 0) then
						self.add = self.add-0.1
					end
					
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// GetTextCount	 	//////
-- ///////////////////////////////

function ChatBox:GetTextCount(text)
	local count = 0;

		if(text) then
			if(string.len(text) > 0) and (string.len(text) < 40) then
				count = count+1;
			elseif(string.len(text) > 40) and (string.len(text) < 80) then
				count = count+2;
			elseif(string.len(text) > 80) and (string.len(text) < 120) then
				count = count+3;
			elseif(string.len(text) > 120) and (string.len(text) < 160) then
				count = count+4;
			elseif(string.len(text) > 160) and (string.len(text) < 200) then
				count = count+5;
			elseif(string.len(text) > 200) and (string.len(text) < 240) then
				count = count+6;
			elseif(string.len(text) > 240) and (string.len(text) < 280) then
				count = count+7;
			else
				count = count+1;
			end
		end
	
	return count;
end


-- ///////////////////////////////
-- ///// CreateGui	 		//////
-- ///////////////////////////////


function ChatBox:CreateGui()
	guiSetInputMode ( "no_binds_when_editing" )
	
	self.guiEle.comboBox = guiCreateComboBox(190, sy-(aesy-655), 174, 115, "", false)
	guiSetFont(self.guiEle.comboBox, "default-bold-small")

	
	self.guiEle.absenden = guiCreateEdit(1, sy-(aesy-865), 363, 31, "Enter your message...", false);
	guiSetFont(self.guiEle.absenden, "default-bold-small")
	
	guiEditSetMaxLength (self.guiEle.absenden, 64);
	
end


-- ///////////////////////////////
-- ///// DestroyGui	 		//////
-- ///////////////////////////////

function ChatBox:DestroyGui()
	for index, guiEle in pairs(self.guiEle) do
		if(isElement(guiEle)) then
			destroyElement(guiEle)
		end
	end
end

-- ///////////////////////////////
-- ///// AcceptText	 		//////
-- ///////////////////////////////

function ChatBox:AcceptText()
	--guiMoveToBack(self.guiEle.absenden);
	
	local text = guiGetText(self.guiEle.absenden);
	
	if(string.len(string.gsub(text, " ", "")) > 0) then
		guiSetText(self.guiEle.absenden, "");
		
	
		
		if(self:IsCommand(text)) then
			local cmd = gettok(text, 1, "/");
			
			local params = split(cmd, " ");
			table.remove(params, 1);
			triggerServerEvent("ChatBox:SendCommand", getLocalPlayer(), cmd, params);
			executeCommandHandler(cmd, unpack(params))
			
		else
			if(self.groupText[self.selectedGroup]["locked"] ~= true) then
				if(self:ContainsBadWords(text) == true) then
				
				else
					triggerServerEvent("ChatBox:SendText", getLocalPlayer(), self.selectedGroup, text);
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// ClickEdit	 		//////
-- ///////////////////////////////

function ChatBox:ClickEdit()
	if(guiGetText(self.guiEle.absenden) == "Enter your message...") then
		guiSetText(self.guiEle.absenden, "");
	end
end

-- ///////////////////////////////
-- ///// ContainsBadWords	//////
-- ///////////////////////////////

function ChatBox:ContainsBadWords()
	
end


-- ///////////////////////////////
-- ///// AddGroup	 		//////
-- ///////////////////////////////


function ChatBox:AddGroup(name, locked)
	if(self.groups[name] == nil) then
		local id = guiComboBoxAddItem(self.guiEle.comboBox, name);
		self.itemIds[name] = id;
		
		self.groups[name] = true;
		self.groupText[name] = {};
		self.groupTextColor[name] = {};
		
		self.groupText[name]["index"] = 1;
		self.groupText[name]["locked"] = locked or false;
	end
end

-- ///////////////////////////////
-- ///// RemoveGroup	 	//////
-- ///////////////////////////////


function ChatBox:RemoveGroup(name)
	if(self.groups[name] ~= nil) then
		guiComboBoxRemoveItem(self.guiEle.comboBox, self.itemIds[name]);
		if(self.selectedGroup == name) then
			self:SelectGroup("System")
		end
	end
end

-- ///////////////////////////////
-- ///// SelectGroup	 	//////
-- ///////////////////////////////

function ChatBox:SelectGroup(name)
	self.selectedGroup = name;
	if(self.groups[name] ~= nil) then
		guiComboBoxSetSelected (self.guiEle.comboBox, self.itemIds[name]);
	end
end

-- ///////////////////////////////
-- ///// SaveToLog		 	//////
-- ///////////////////////////////

function ChatBox:SaveToLog(group, text)
	if(text) then
		local date1 = (getRealTime().monthday).."."..(getRealTime().month+1).."."..(getRealTime().year+1900).." "..getRealTime().hour..":"..getRealTime().minute..":"..getRealTime().second;
		local date2 = (getRealTime().monthday).."."..(getRealTime().month+1).."."..(getRealTime().year+1900);
		local fileString = "savedFiles/logs/"..date2.."/"..group..".log";
		local file;
		
		text = string.gsub(text, '#%x%x%x%x%x%x', '')
		
		if(fileExists(fileString)) then
			file = fileOpen(fileString);
		else
			file = fileCreate(fileString);
		end
		fileSetPos(file, fileGetSize(file));
		fileWrite(file, "["..date1.."]"..text.."\n");
		fileFlush(file);
		fileClose(file);
	end
end


-- ///////////////////////////////
-- ///// SendTextBack	 	//////
-- ///////////////////////////////

function ChatBox:SendTextBack(group, text, r, g, b)

	if not(self.groupText[group]) then
		self.groupText[group] = {}
		self.groupText[group]["index"] = 1;
	end
	self.groupText[group][self.groupText[group]["index"]] = text;
	self.groupTextColor[group][self.groupText[group]["index"]] = {};
	self.groupTextColor[group][self.groupText[group]["index"]]["r"] = r or 255;
	self.groupTextColor[group][self.groupText[group]["index"]]["g"] = g or 255;
	self.groupTextColor[group][self.groupText[group]["index"]]["b"] = b or 255;
	self.groupTextColor[group][self.groupText[group]["index"]]["a"] = 0;
	
	self.groupText[group]["index"] = self.groupText[group]["index"]+1;
	self.drawingPos = #self.groupText[group]-9;
	

	self:SaveToLog(group, text);
end

-- ///////////////////////////////
-- ///// MoveChatboxUp	 	//////
-- ///////////////////////////////

function ChatBox:MoveChatboxUp()
	if(self.drawingPos > 1) then
		self.drawingPos = self.drawingPos-1
	end

end

-- ///////////////////////////////
-- ///// MoveChatboxDown	//////
-- ///////////////////////////////

function ChatBox:MoveChatboxDown()
	if(self.drawingPos < #self.groupText[self.selectedGroup]-9) then
		self.drawingPos = self.drawingPos+1
	end

end


-- ///////////////////////////////
-- ///// IsCommand			//////
-- ///////////////////////////////

function ChatBox:IsCommand(str)
	local start, ende = string.find(str, "/", 0, true);
	if(tonumber(start) == 1 and tonumber(ende) == 1) then
		return true;
	else
		return false;
	end
end

-- ///////////////////////////////
-- ///// Hide		 		//////
-- ///////////////////////////////


function ChatBox:Hide()
	if(self.state == true) then
		for index, guiEle in pairs(self.guiEle) do
			guiSetAlpha(guiEle, 0);
		end
		self.state = false;
		showChat(false);
		
		self.btnShow = guiCreateButton(0, sy-(aesy-649), 15, 29, ">", false)
		guiSetFont(self.btnShow, "default-bold-small");
		addEventHandler("onClientGUIClick", self.btnShow, function()
			destroyElement(source);
			self:Show();
		end, false)
		
		if(isElement(self.btnHide)) then
			destroyElement(self.btnHide);
		end
	end
end

-- ///////////////////////////////
-- ///// Show		 		//////
-- ///////////////////////////////


function ChatBox:Show()
	if(self.state == false) then
		for index, guiEle in pairs(self.guiEle) do
			guiSetAlpha(guiEle, 255);
		end
		self.state = true;
		showChat(false);
		
		self.btnHide = guiCreateButton(368, sy-(aesy-649), 15, 29, "<", false)
		guiSetFont(self.btnHide, "default-bold-small");
		
		addEventHandler("onClientGUIClick", self.btnHide, function()
			destroyElement(source);
			self:Hide();
		end, false)
		
		if(isElement(self.btnShow)) then
			destroyElement(self.btnShow);
		end
	end
end

-- ///////////////////////////////
-- ///// MoveToBack 		//////
-- ///////////////////////////////

function ChatBox:MoveToBack()
	guiMoveToBack(self.guiEle.absenden);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function ChatBox:Constructor(...)
	self.renderFunc = function() self:Render() end
	self.acceptFunc = function() self:AcceptText() end
	self.clickFunc = function() self:ClickEdit() end
	self.selectFunc = function() self:SelectGroup(guiComboBoxGetItemText(self.guiEle.comboBox, guiComboBoxGetSelected(self.guiEle.comboBox))) end
	self.sendTextBackFunc = function(...) self:SendTextBack(...) end;
	self.normalChatFunc = function(text, r, g, b) self:SendTextBack("System", text, r, g, b) end;
	
	self.moveUpFunc = function() self:MoveChatboxUp() end;
	self.moveDownFunc = function() self:MoveChatboxDown() end;
	self.removeChatInput = function(button, state) if(button ~= "left") and (state == "down") then self:MoveToBack() end end;
	
	self.state = false;
	self.guiEle = {};
	
	self.groups = {};
	self.itemIds = {};
	
	self.add = 0;
	
	self.groupText = {};
	self.groupTextColor = {};
	
	
	self.selectedGroup = "none";
	
	self.drawingPos = 0;
	
	self:CreateGui();
	
	self:Show();
	addEvent("ChatBox:SendTextBack", true);
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	addEventHandler("onClientGUIAccepted", self.guiEle.absenden, self.acceptFunc);
	addEventHandler("onClientGUIClick", self.guiEle.absenden, self.clickFunc);
	addEventHandler("onClientGUIComboBoxAccepted", self.guiEle.comboBox, self.selectFunc);
	addEventHandler("ChatBox:SendTextBack", getLocalPlayer(), self.sendTextBackFunc);
	addEventHandler("onClientChatMessage", getRootElement(), self.normalChatFunc);
	addEventHandler("onClientClick", getRootElement(), self.removeChatInput);
	
	bindKey("mouse_wheel_up", "down", self.moveUpFunc);
	bindKey("mouse_wheel_down", "down", self.moveDownFunc);
	
	--logger:OutputInfo("[CALLING] ChatBox: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function ChatBox:Destructor(...)

	self:DestroyGui();
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	removeEventHandler("onClientGUIAccepted", self.guiEle.absenden, self.acceptFunc);
	removeEventHandler("onClientGUIClick", self.guiEle.absenden, self.clickFunc);
	removeEventHandler("onClientGUIComboBoxAccepted", self.guiEle.comboBox, self.selectFunc);
	removeEventHandler("ChatBox:SendTextBack", getLocalPlayer(), self.sendTextBackFunc);
	removeEventHandler("onClientChatMessage", getRootElement(), self.normalChatFunc);
		
	unbindKey("mouse_wheel_up", "down", self.moveUpFunc);
	unbindKey("mouse_wheel_down", "down", self.moveDownFunc);
	--logger:OutputInfo("[CALLING] ChatBox: Denstructor");
end


-- EVENT HANDLER --

		
