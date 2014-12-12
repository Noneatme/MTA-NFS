-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderSoundSettings	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderSoundSettings = {};
RenderSoundSettings.__index = RenderSoundSettings;

--[[

GUIEditor.edit[1] = guiCreateEdit(526, 550, 267, 25, "", false)


GUIEditor.edit[2] = guiCreateEdit(527, 577, 267, 25, "", false)


GUIEditor.scrollbar[1] = guiCreateScrollBar(507, 277, 212, 24, true, false)
guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 100.0)


GUIEditor.scrollbar[2] = guiCreateScrollBar(507, 370, 212, 24, true, false)
guiScrollBarSetScrollPosition(GUIEditor.scrollbar[2], 100.0)


GUIEditor.scrollbar[3] = guiCreateScrollBar(507, 460, 212, 24, true, false)
guiScrollBarSetScrollPosition(GUIEditor.scrollbar[3], 100.0)

	dxDrawRectangle(450, 239, 697, 459, tocolor(0, 0, 0, 130), false)
	dxDrawRectangle(801, 283, 342, 408, tocolor(0, 0, 0, 121), true)

	dxDrawImage(450, 209, 698, 29, ":nfs/files/images/aero-title.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawText("Audio Settings", 450, 209, 1148, 238, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Sound effects:", 528, 248, 693, 276, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("100%", 513, 301, 719, 327, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Music volume:", 526, 342, 691, 370, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("100%", 513, 394, 719, 420, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawLine(505, 334, 728, 334, tocolor(255, 255, 255, 255), 1, true)
	dxDrawText("Soundtrack volume:", 525, 430, 690, 458, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("100%", 510, 484, 716, 510, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawLine(504, 427, 727, 427, tocolor(255, 255, 255, 255), 1, true)
	dxDrawLine(454, 524, 789, 524, tocolor(255, 255, 255, 255), 1, true)
	dxDrawText("Select the songs you want to hear:", 805, 244, 1141, 279, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Or add a custom song:", 460, 532, 602, 548, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Song URL:", 456, 556, 529, 571, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false, false)
	dxDrawText("Name:", 456, 582, 529, 597, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false, false)
	dxDrawRectangle(454, 611, 151, 30, tocolor(0, 0, 0, 121), true)
	
	dxDrawText("Add song", 453, 612, 605, 641, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawRectangle(458, 648, 333, 40, tocolor(0, 0, 0, 121), true)
	
	dxDrawText("Save all settings", 458, 648, 791, 688, tocolor(61, 255, 9, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	
	dxDrawText("1. Black Betty", 805, 287, 1075, 311, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawRectangle(805, 288, 271, 24, tocolor(0, 0, 0, 114), true)
	dxDrawImage(1111, 287, 28, 24, ":guieditor/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(1079, 287, 28, 24, ":guieditor/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderSoundSettings:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render 			//////
-- ///////////////////////////////

function RenderSoundSettings:Render()
	if(self.state == true) then
		self.renderManager:dxDrawRectangle(450, 239, 697, 459, tocolor(0, 0, 0, 130), false)
		self.renderManager:dxDrawRectangle(801, 283, 342, 408, tocolor(0, 0, 0, 121), true)
	
		self.renderManager:dxDrawImage(450, 209, 698, 29, ":nfs/files/images/aero-title.png", 0, 0, 0, tocolor(0, 255, 255, 200), true)
		self.renderManager:dxDrawText("Audio Settings", 450, 209, 1148, 238, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Sound effects:", 528, 248, 693, 276, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(guiScrollBarGetScrollPosition(self.guiEle.sb1).."%", 513, 301, 719, 327, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Music volume:", 526, 342, 691, 370, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(guiScrollBarGetScrollPosition(self.guiEle.sb2).."%", 513, 394, 719, 420, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawLine(505, 334, 728, 334, tocolor(255, 255, 255, 255), 1, true)
		self.renderManager:dxDrawText("Other volume:", 525, 430, 690, 458, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText(guiScrollBarGetScrollPosition(self.guiEle.sb3).."%", 510, 484, 716, 510, tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawLine(504, 427, 727, 427, tocolor(255, 255, 255, 255), 1, true)
		self.renderManager:dxDrawLine(454, 524, 789, 524, tocolor(255, 255, 255, 255), 1, true)
		self.renderManager:dxDrawText("Select the songs you want to hear:", 805, 244, 1141, 279, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Or add a custom song:", 460, 532, 602, 548, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		self.renderManager:dxDrawText("Name:", 456, 556, 529, 571, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false, false)
		self.renderManager:dxDrawText("Song URL:", 456, 582, 529, 597, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false, false)
		
		local r, g, b = 0, 0, 0;
		if(getElementData(self.guiEle.btnAddSong, "hover")) then r, g, b = 100, 100, 100 end
		
		self.renderManager:dxDrawRectangle(454, 611, 151, 30, tocolor(r, g, b, 121), true)
		self.renderManager:dxDrawText("Add song", 453, 612, 605, 641, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		r, g, b = 0, 0, 0;
		if(getElementData(self.guiEle.btnSave, "hover")) then r, g, b = 100, 100, 100 end
		
		self.renderManager:dxDrawRectangle(458, 648, 333, 40, tocolor(r, g, b, 121), true)
		self.renderManager:dxDrawText("Save all settings", 458, 648, 791, 688, tocolor(61, 255, 9, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	
		local add = 0
		local increment = 31
	
		if(self.renderTable) then
			for i = self.drawPos, self.drawPos+12, 1 do
				if(self.renderTable[i]) then
					self.renderManager:dxDrawRectangle(805, 287+add, 271, 24, tocolor(100, 100, 100, 114), true)
					self.renderManager:dxDrawText(self.renderTable[i]["title"], 805, 287+add, 1075, 311+add, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
					
					local a = 255
					if not(self.renderTable[i]["url"]) then
						a = 100
					end
					self.renderManager:dxDrawImage(1111, 287+add, 28, 24, "files/images/icons/trash.png", 0, 0, 0, tocolor(255, 255, 255, a), true);
					
					local fav = tonumber(self.ssm.favtable[i]);
					
					
					if(fav == 1) then
						if(getElementData(self.guiSel[i]["fav"], "hover")) then
							self.renderManager:dxDrawImage(1079, 287+add, 28, 24, "files/images/icons/x.png", 0, 0, 0, tocolor(255, 255, 255, 255), true);
						else
							self.renderManager:dxDrawImage(1079, 287+add, 28, 24, "files/images/icons/accept.png", 0, 0, 0, tocolor(255, 255, 255, 255), true);
						end
					else
						if(getElementData(self.guiSel[i]["fav"], "hover")) then
							self.renderManager:dxDrawImage(1079, 287+add, 28, 24, "files/images/icons/accept.png", 0, 0, 0, tocolor(255, 255, 255, 255), true);
						end
					end
					self.renderManager:dxDrawImage(1079, 287+add, 28, 24, "files/images/icons/square.png", 0, 0, 0, tocolor(255, 255, 255, 255), true);
					add = add+increment;
				end
			end
		end
	--[[
	dxDrawText("1. Black Betty", 805, 287, 1075, 311, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawRectangle(805, 288, 271, 24, tocolor(0, 0, 0, 114), true)
	dxDrawImage(1111, 287, 28, 24, ":guieditor/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(1079, 287, 28, 24, ":guieditor/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)]]
	
	end
end

-- ///////////////////////////////
-- /////	BuildGui		//////
-- ///////////////////////////////


function RenderSoundSettings:BuildGui()
	self.guiEle.edit1 = self.renderManager:guiCreateEdit(526, 550, 267, 25, "", false);
	self.guiEle.edit2 = self.renderManager:guiCreateEdit(527, 577, 267, 25, "", false);
	
	self.guiEle.sb1 = self.renderManager:guiCreateScrollBar(507, 277, 212, 24, true, false);
	self.guiEle.sb2 = self.renderManager:guiCreateScrollBar(507, 370, 212, 24, true, false);
	self.guiEle.sb3 = self.renderManager:guiCreateScrollBar(507, 460, 212, 24, true, false);
	
	self.guiEle.btnAddSong = self.renderManager:guiCreateButton(454, 611, 151, 30, "addSong", false, nil, true, true);
	self.guiEle.btnSave = self.renderManager:guiCreateButton(458, 648, 333, 40, "save", false, nil, true, true);
	
	self.alphaTeile = {self.guiEle.btnAddSong, self.guiEle.btnSave};
	
	
	for index, btn in pairs(self.alphaTeile) do
		guiSetAlpha(btn, 0);
	end
	
end

-- ///////////////////////////////
-- ///// DestroyGui		 	//////
-- ///////////////////////////////


function RenderSoundSettings:DestroyGui()
	for index, ele in pairs(self.guiEle) do
		if(isElement(ele)) then
			destroyElement(ele)
		end
	end
	
	for index, _ in pairs(self.guiSel) do
		if(isElement(self.guiSel[index]["fav"])) then
			destroyElement(self.guiSel[index]["fav"]);
		end
		
		if(isElement(self.guiSel[index]["trash"])) then
			destroyElement(self.guiSel[index]["trash"]);
		end
	end
end

-- ///////////////////////////////
-- ///// UpdateGui	 		//////
-- ///////////////////////////////

function RenderSoundSettings:UpdateGui()
	for index, btn in pairs(self.guiSel) do
		if(isElement(btn["fav"])) then
			destroyElement(btn["fav"]);
		end
		
		if(isElement(btn["trash"])) then
			destroyElement(btn["trash"]);
		end
	end
	local add = 0
	local increment = 31
		
	for i = self.drawPos, self.drawPos+12, 1 do
		if(self.renderTable) and (self.renderTable[i]) then
			self.guiSel[i] = {};
			
			self.guiSel[i]["fav"] = self.renderManager:guiCreateButton(1079, 287+add, 28, 24, i, false, nil, true, true);
			guiSetAlpha(self.guiSel[i]["fav"], 0)
			
			addEventHandler("onClientGUIClick", self.guiSel[i]["fav"], function()
				local fav = tonumber(self.ssm.favtable[i]);
				
				if(fav == 1) then
					fav = 0;
				else
					fav = 1;
				end
				self.ssm.favtable[i] = fav;
				
				self.ssm:SaveSettings(self.ssm.songstable, self.ssm.vol1, self.ssm.vol2, self.ssm.vol3)
			end, false)
			if(self.renderTable[i]["url"]) then
				self.guiSel[i]["trash"] = self.renderManager:guiCreateButton(1111, 287+add, 28, 24, i, false, nil, true, true);
				guiSetAlpha(self.guiSel[i]["trash"], 0)
				
				addEventHandler("onClientGUIClick", self.guiSel[i]["trash"], function()
					table.remove(self.ssm.songstable, i);
					
					self.ssm:SaveSettings(self.ssm.songstable, self.ssm.vol1, self.ssm.vol2, self.ssm.vol3)
				end, false)
			end
					
			add = add+increment;
		end
	end
end

-- ///////////////////////////////
-- ///// MoveChatboxUp	 	//////
-- ///////////////////////////////

function RenderSoundSettings:MoveUp()
	if(self.drawPos > 1) then
		self.drawPos = self.drawPos-1
	end
	self:UpdateGui();
end

-- ///////////////////////////////
-- ///// MoveChatboxDown	//////
-- ///////////////////////////////

function RenderSoundSettings:MoveDown()
	if(self.drawPos < #self.renderTable-12) then
		self.drawPos = self.drawPos+1
	end
	self:UpdateGui();
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderSoundSettings:Constructor(...)
	self.renderFunc = function() self:Render() end
	self.moveUpFunc = function() self:MoveUp() end;
	self.moveDownFunc = function() self:MoveDown() end;
	
	self.state = true;
	self.guiEle = {};
	
	self.guiSel = {};
	
	self.drawPos = 1;
	
	self.renderManager = RenderManagerCenter:New(1600, 900);
	self:BuildGui();
	
	
	bindKey("mouse_wheel_up", "down", self.moveUpFunc);
	bindKey("mouse_wheel_down", "down", self.moveDownFunc);
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);	
	outputDebugString("[CALLING] RenderSoundSettings: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function RenderSoundSettings:Destructor(...)
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	self:DestroyGui();
	self.state = false;
	
	unbindKey("mouse_wheel_up", "down", self.moveUpFunc);
	unbindKey("mouse_wheel_down", "down", self.moveDownFunc);
	outputDebugString("[CALLING] RenderSoundSettings: Destructor");
end


-- EVENT HANDLER --

