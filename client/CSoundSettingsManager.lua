-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: SoundSettingsManager##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################


-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SoundSettingsManager = {};
SoundSettingsManager.__index = SoundSettingsManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function SoundSettingsManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// BindEvents 		//////
-- ///////////////////////////////

function SoundSettingsManager:BindEvents()
	addEventHandler("onClientGUIClick", self.rss.guiEle.btnSave, function()
		self:SaveSettings(self.songstable, guiScrollBarGetScrollPosition(self.rss.guiEle.sb1), guiScrollBarGetScrollPosition(self.rss.guiEle.sb2), guiScrollBarGetScrollPosition(self.rss.guiEle.sb3))
		self:Destructor();
		
		renderGarage:OpenPage("settings");
	end, false)
	
	
	addEventHandler("onClientGUIClick", self.rss.guiEle.btnAddSong, function()
		local title = guiGetText(self.rss.guiEle.edit1);
		local url = guiGetText(self.rss.guiEle.edit2);
		if(string.len(title) > 3) and (string.len(url) > 10) then
			table.insert(self.songstable, {["title"] = title, ["url"] = url});
			self.favtable[#self.songstable] = 1;
			
			outputChatBox("Sucess");
		else
			-- Error HIER
		end
	end, false)
end

-- ///////////////////////////////
-- ///// Save Settings		//////
-- ///////////////////////////////

function SoundSettingsManager:SaveSettings(table1, vol1, vol2, vol3)
	outputDebugString(debug.getinfo(2).short_src..", "..debug.getinfo(2).currentline)
	if(fileExists("savedFiles/soundsettings.csv")) then
		fileDelete("savedFiles/soundsettings.csv");
	end
	local file = fileCreate("savedFiles/soundsettings.csv");
	if(file) then
	
		if not(vol1 and vol2 and vol3) then
			fileWrite(file, "100,100,100\n");
		else
			fileWrite(file, vol1..","..vol2..","..vol3.."\n");
		end
		local index = 1;
		
		for i, tbl in pairs(table1) do
			local favourite = 1
			if(self.favtable[i]) then
				favourite = self.favtable[i];
			end

			if(tbl["url"]) then
				fileWrite(file, tbl["title"]..","..favourite..","..tbl["url"].."\n");
			else
				fileWrite(file, tbl["title"]..","..favourite.."\n");
			end
			
			index = index+1
		end
		
		--[[
		for i, artist in pairs(table1) do
			local favourite = 1
			if(self.favtable[i]) then
				favourite = self.favtable[i];
			end
			fileWrite(file, artist..","..favourite.."\n");
			index = index+1
		end]]
		if(table2) then
			for i, artist in pairs(table2) do
				local favourite = 1
				if(self.favtable[i]) then
					favourite = self.favtable[i];
				end
			
				fileWrite(file, artist..","..favourite.."\n");
				index = index+1
			end
		end
		fileClose(file);
	else

	end
end


-- ///////////////////////////////
-- ///// Load Settings		//////
-- ///////////////////////////////

function SoundSettingsManager:LoadSettings()
	if(fileExists("savedFiles/soundsettings.csv")) then
		local file = fileOpen("savedFiles/soundsettings.csv");
		if(file) then
			fileClose(file);
		else
			self:SaveSettings(self.staticSongsTable);
		end
		
		local file = fileOpen("savedFiles/soundsettings.csv");
		if(file) then
			local lines = {};
			local text = fileRead(file, fileGetSize(file));
			for i = 1, 150, 1 do
				lines[i] = gettok(text, i, "\n"); -- Split the text into lines
			end
			
			local vol1, vol2, vol3 = tonumber(gettok(lines[1], 1, ",")), tonumber(gettok(lines[1], 2, ",")), tonumber(gettok(lines[1], 3, ","));
			local songstable = {};
			
			for i = 1, #lines, 1 do
				if(lines[i+1]) and (string.len(lines[i+1]) > 1) then
					songstable[i-1] = {};
					songstable[i-1]["title"] = (gettok(lines[i+1], 1, ",") or lines[i+1]);
					songstable[i-1]["fav"] = tonumber(gettok(lines[i+1], 2, ",")) or 1;
					songstable[i-1]["url"] = gettok(lines[i+1], 3, ",") or false;
					
					self.favtable[i-1] = tonumber(gettok(lines[i+1], 2, ",")) or 1;
				end
			end

			fileClose(file);

			
			-- SET THE DATA --
			
			self.songstable = songstable;
			
			self.vol1, self.vol2, self.vol3 = vol1, vol2, vol3;
							
							
			if(self.rss) then
				self.rss.renderTable = self.songstable;
				
				self.rss.songstable = songstable;
			
				
				guiScrollBarSetScrollPosition(self.rss.guiEle.sb1, vol1);
				guiScrollBarSetScrollPosition(self.rss.guiEle.sb2, vol2);
				guiScrollBarSetScrollPosition(self.rss.guiEle.sb3, vol3);
			end
		else
			outputChatBox("Can't load settings, please panic", 255, 0, 0);
		end
	else
		self:SaveSettings(self.staticSongsTable);
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function SoundSettingsManager:Constructor(bool)
		self.staticSongsTable = {
			{["title"]="Cirrus - Nothing But You"},
			{["title"]="Capone - I Need Speed"},
			{["title"]="Chingy - I Do"},
			{["title"]="Christopher Lawrence - Rush Hour"},
			{["title"]="Cirrus - Back on a Mission"},
			{["title"]="Felix da Housecat - Rocket Ride"},
			{["title"]="Fluke - Switch Twitch"},
			{["title"]="Freeland - Mind Killer"},
			{["title"]="Killing Joke - The Death ..."},
			{["title"]="Queens Of the Stone Age - In My Face"},
			{["title"]="Rise Against - Give It All"},
			{["title"]="Septembre - I am Weightless"},
			{["title"]="Sin - Hard EBM"},
			{["title"]="Skindred - Nobody"},
			{["title"]="Snapcase - Skeptic"},
			{["title"]="Snoop Dog ft. TD - Riders On The Storm"},
			{["title"]="Sonic Animation - E-Ville"},
			{["title"]="Terror Squad ft Fat Joe - Lean Black"},
			{["title"]="The Bronx - Notice Of Eviction"},
			{["title"]="Unwritten Law - The Celebration"},
			{["title"]="Xzibit - LAX"},
		};

	if(bool ~= true) then
		self.rss = RenderSoundSettings:New();
	
		
		self.favtable = {};
		
		self:BindEvents();
		
		
		self:LoadSettings();
		
		self.rss.renderTable = self.songstable
		
		self.rss:MoveUp();
		
		self.rss.ssm = self;
		
		setTimer(function()
			self:LoadSettings();
			self.rss.renderTable = self.songstable
			self.rss:MoveUp();
		end, 1000, 1)
	else
		self.favtable = {};
		self:LoadSettings();
	end
	outputDebugString("[CALLING] SoundSettingsManager: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function SoundSettingsManager:Destructor(...)
	if(self.rss) then
		self.rss:Destructor();
	end
	outputDebugString("[CALLING] SoundSettingsManager: Destructor");
end



-- EVENT HANDLER --
