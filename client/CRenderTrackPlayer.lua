-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: RenderTrackPlayer	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

RenderTrackPlayer = {};
RenderTrackPlayer.__index = RenderTrackPlayer;


--[[


]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderTrackPlayer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Render 			//////
-- ///////////////////////////////

function RenderTrackPlayer:Render()
	if(self.state == true) then
		local w1, h1;
		
		if(self.inverted == true) then
			w1, h1 = interpolateBetween(489, 121, 0, 0, 121, 0, (getTickCount()-self.startTick)/500, self.easingFunc)

		else
			w1, h1 = interpolateBetween(0, 121, 0, 489, 121, 0, (getTickCount()-self.startTick)/500, self.easingFunc)

		end


		dxDrawRectangle(37, 51, w1, h1, tocolor(255, 255, 255, 85), false)
		dxDrawImage(37, 19, w1, 32, ":nfs/files/images/aero-title.png", 0, 0, 0, tocolor(0, 0, 0, 170), false)
		
		if(getTickCount()-self.startTick > 500) then
		
			
			if(self.playing == true) then
				dxDrawImage(45, 55, 114, 109, ":nfs/files/images/sound/speaker"..self.imgID..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			else
				dxDrawImage(45, 55, 114, 109, ":nfs/files/images/sound/speaker0.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			
			end
			dxDrawText("Track Player", 38, 19, 526, 51, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
			
			
			dxDrawText(self.artist, 172, 57, 520, 81, tocolor(0, 0, 0, 255), 2, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(self.title, 172, 85, 520, 109, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
			
			
			dxDrawLine(176, 114, 516, 114, tocolor(255, 255, 255, 255), 1, false)
			
			local name
			local a = 155
			if(getElementData(self.guiEle.btnPrevoius, "hover")) then
				a = 255
			end
			dxDrawImage(182, 118, 68, 49, ":nfs/files/images/sound/previous.png", 0, 0, 0, tocolor(255, 255, 255, a), false)
			
			a = 155
			if(getElementData(self.guiEle.btnPause, "hover")) then
				a = 255
			end
			if(self.playing == true) then
				name = "pause";
			else
				name = "play";
			end
			dxDrawImage(268, 118, 50, 50, ":nfs/files/images/sound/"..name..".png", 0, 0, 0, tocolor(255, 255, 255, a), false)
			
			a = 155
			if(getElementData(self.guiEle.btnStop, "hover")) then
				a = 255
			end
			dxDrawImage(339, 119, 50, 50, ":nfs/files/images/sound/stop.png", 0, 0, 0, tocolor(255, 255, 255, a), false)
			a = 155
			if(getElementData(self.guiEle.btnNext, "hover")) then
				a = 255
			end
			dxDrawImage(406, 118, 71, 49, ":nfs/files/images/sound/next.png", 0, 0, 0, tocolor(255, 255, 255, a), false)
		end
	end
end

-- ///////////////////////////////
-- ///// WaitForExit	 	//////
-- ///////////////////////////////

function RenderTrackPlayer:WaitForExit()
	if(self.mouseEntered == false) then
		if(isTimer(self.waitForExitTimer)) then killTimer(self.waitForExitTimer); end
		self:Hide();
	end
end

-- ///////////////////////////////
-- ///// Show	 			//////
-- ///////////////////////////////

function RenderTrackPlayer:Show()
	if(self.state == false) and not(isTimer(self.closeTimer))  then
		self.startTick = getTickCount();
		if(isTimer(self.updateImgTimer)) then
			killTimer(self.updateImgTimer);
		end
		
		self.inverted = false;
		
		self.updateImgTimer = setTimer(self.updateImgFunc, 350, -1);
		
		self.state = true;
		
		self.waitForExitTimer = setTimer(self.waitForExitFunc, 3000, -1);
		
		self:BuildGui();
	end
end

-- ///////////////////////////////
-- ///// Hide	 			//////
-- ///////////////////////////////

function RenderTrackPlayer:Hide()
	if(self.state == true) and not(isTimer(self.closeTimer)) then
		self.inverted = true;

		self.startTick = getTickCount();
		--self.easingFunc = "OutQuad";
		
		self.closeTimer = setTimer(function()
			self.state = false;
		end, 500, 1)
		
		killTimer(self.updateImgTimer);
		
		if(isTimer(self.waitForExitTimer)) then
			killTimer(self.waitForExitTimer)
		end
		
		self:DestroyGui();
	end
end

-- ///////////////////////////////
-- ///// DestroyGui	 		//////
-- ///////////////////////////////

function RenderTrackPlayer:DestroyGui()
	for index, ele in pairs(self.guiEle) do
		if(isElement(ele)) then
			destroyElement(ele)
		end
	end
end

-- ///////////////////////////////
-- ///// BuildGui	 		//////
-- ///////////////////////////////

function RenderTrackPlayer:BuildGui()
	self:DestroyGui();
	
	self.guiEle.btnGlobal = guiCreateButton(37, 51, 489, 121, "Okay", false);
	
	self.guiEle.btnPrevoius = self.renderManager:guiCreateButton2(182, 118, 68, 49, "prv", false, nil, true, true);
	self.guiEle.btnPause = self.renderManager:guiCreateButton2(268, 118, 50, 50, "pause", false, nil, true, true);
	self.guiEle.btnStop = self.renderManager:guiCreateButton2(339, 119, 50, 50, "stop", false, nil, true, true);
	self.guiEle.btnNext = self.renderManager:guiCreateButton2(406, 118, 71, 49, "next", false, nil, true, true);
	
	for index, ele in pairs(self.guiEle) do
		if(isElement(ele)) then
			guiSetAlpha(ele, 0);
			addEventHandler("onClientMouseEnter", ele, function()
				self.mouseEntered = true;
			end, false)
		end
	end
	
	guiMoveToBack(self.guiEle.btnGlobal);
	guiSetEnabled(self.guiEle.btnGlobal, true);
	-- EVENT HANDLER --
	
	addEventHandler("onClientMouseLeave", self.guiEle.btnGlobal, function()
		self.mouseEntered = false;
	end, false)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnGlobal, function()
		guiMoveToBack(source);
	end, false)
	
	
	addEventHandler("onClientGUIClick", self.guiEle.btnPrevoius, function()
		if(self.songID <= 1) then
			self.songID = #self.table;
		else
			self.songID = self.songID-1
		end
		self:UpdateVariablen(self.table[self.songID]);
		
		local dingens = self.playing;
		
		self:TriggerStop();
		
		if(dingens  == true) then
			self:TriggerPlayBTN();
		end
	end, false)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnNext, function()
		if(self.songID >= #self.table) then
			self.songID = 1
		else
			self.songID = self.songID+1
		end
		self:UpdateVariablen(self.table[self.songID]);
		
		local dingens = self.playing;
		
		self:TriggerStop();
		
		if(dingens  == true) then
			self:TriggerPlayBTN();
		end
	end, false)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnPause, function()
		self:TriggerPlayBTN();
	end, false)
	
	addEventHandler("onClientGUIClick", self.guiEle.btnStop, function()
		self:TriggerStop();
	end, false)
end


-- ///////////////////////////////
-- ///// UpdateImg	 		//////
-- ///////////////////////////////

function RenderTrackPlayer:UpdateImg()
	if(self.imgID == 3) then
		self.imgID = 1;
	else
		self.imgID = self.imgID+1;
	end
end

-- ///////////////////////////////
-- ///// TriggerOpen		//////
-- ///////////////////////////////

function RenderTrackPlayer:TriggerOpen()
	if(self.state == true) and not(isTimer(self.closeTimer)) then
		self:Hide();
	elseif(self.state == false) and not(isTimer(self.closeTimer)) then
		self:Show();
	end
end


-- ///////////////////////////////
-- ///// Play				//////
-- ///////////////////////////////

function RenderTrackPlayer:TriggerPlayBTN()
	setRadioChannel(0)
	if(self.playing == true) then
		if(isElement(self.sound)) then
			setSoundPaused(self.sound, true);
		end
		
		self.playing = false;
	else
		if(isElement(self.sound)) then
			setSoundPaused(self.sound, false);
		else
			local rand = self.songID
			local url = self.table[rand]["url"];
			if not(url) then
				url = gameSettings.soundStreamURL..self.staticPlayList[self.table[rand]["title"]]..".mp3";
			end
			
			self.sound = soundManager:PlaySound(url, false, "music");
	
		end
		self.playing = true;
	end
end

-- ///////////////////////////////
-- ///// PlayRandom			//////
-- ///////////////////////////////

function RenderTrackPlayer:PlayRandom()
	setRadioChannel(0)
	if(self.playing == false) then
		if(isElement(self.sound)) then
			self.soundpos = getSoundPosition(self.sound);
			soundManager:DestroySound(self.sound);
		end
		
		self.playing = true;
		
		local rand = math.random(1, #self.table);
		
		
		local url = self.table[rand]["url"];
		if not(url) then
			url = gameSettings.soundStreamURL..self.staticPlayList[self.table[rand]["title"]]..".mp3";
		end
		
		self.sound = soundManager:PlaySound(url, false, "music");
		self:UpdateVariablen(self.table[rand]);
	end
end


-- ///////////////////////////////
-- ///// TriggerStop		//////
-- ///////////////////////////////

function RenderTrackPlayer:TriggerStop()
	if(isElement(self.sound)) then
		soundManager:DestroySound(self.sound);
	end
	
	self.playing = false;
end

-- ///////////////////////////////
-- ///// UpdateVariablen	//////
-- ///////////////////////////////

function RenderTrackPlayer:UpdateVariablen(table)

		self.artist, self.title = gettok(table["title"], 1, "-") or table["title"], gettok(table["title"], 2, "-") or "";

end

-- ///////////////////////////////
-- ///// GiveTable			//////
-- ///////////////////////////////

function RenderTrackPlayer:GiveTable(tbl)
	if(tbl) then
	
		local lastsong = 0;		
		local newtable = {};
		
		local index = 1
		
		for i, key in pairs(tbl) do
			if(tonumber(key["fav"]) == 1) then
				newtable[index] = key;
				lastsong = index;
				
				index = index+1;
			end
		end
		
		self.table = newtable;
		self.songID = lastsong;
		self:UpdateVariablen(self.table[lastsong])
		
	end
	
--[[
	local lai = 0;
	for index, tab in pairs(tbl) do
		if(tonumber(tab["fav"]) ~= 0) then
			table.insert(self.table, index, tab);
			lai = index;
		end
	end
	
	if(lai ~= 0) then
		if not(self.table[self.songID]) then
			self.songID = lai;
		end
		self:UpdateVariablen(tbl[self.songID]);
	end]]
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////


function RenderTrackPlayer:Constructor(...)
	self.renderFunc = function() self:Render() end;
	self.updateImgFunc = function() self:UpdateImg() end;
	
	self.triggerFunc = function() self:TriggerOpen() end;
	
	self.closeFunc = function() self:Hide() end;
	
	self.waitForExitFunc = function() self:WaitForExit() end;

	self.renderManager = RenderManagerCenter:New(1600, 900);
	self.state = false;
	
	self.mouseEntered = false;
	
	self.easingFunc = "InQuad";
	self.imgID = 3;	

	self.guiEle = {};
	
	self.artist = "Sample Artist";
	self.title = "Sample title";
	
	self.playing = false;
	self.songID = 1;
	
	addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), cancelEvent);
	
	self.staticPlayList = {
		["Cirrus - Nothing But You"] = 1,
		["Capone - I Need Speed"] = 2,
		["Chingy - I Do"] = 3,
		["Christopher Lawrence - Rush Hour"] = 4,
		["Cirrus - Back on a Mission"] = 5,
		["Felix da Housecat - Rocket Ride"] = 6,
		["Fluke - Switch Twitch"] = 7,
		["Freeland - Mind Killer"] = 8,
		["Killing Joke - The Death ..."] = 9,
		["Queens Of the Stone Age - In My Face"] = 10,
		["Rise Against - Give It All"] = 11,
		["Septembre - I am Weightless"] = 12,
		["Sin - Hard EBM"] = 13,
		["Skindred - Nobody"] = 14,
		["Snapcase - Skeptic"] = 15,
		["Snoop Dog ft. TD - Riders On The Storm"] = 16,
		["Sonic Animation - E-Ville"] = 17,
		["Terror Squad ft Fat Joe - Lean Black"] = 18,
		["The Bronx - Notice Of Eviction"] = 19,
		["Unwritten Law - The Celebration"] = 20,
		["Xzibit - LAX"] = 21,
	};
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	outputDebugString("[CALLING] RenderTrackPlayer: Constructor");
	
	bindKey("t", "down", self.triggerFunc);
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function RenderTrackPlayer:Destructor(...)
	self:TriggerStop()

	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	unbindKey("t", "down", self.triggerFunc);
end

-- EVENT HANDLER --
