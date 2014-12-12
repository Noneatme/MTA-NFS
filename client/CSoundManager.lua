-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: SoundManager		##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SoundManager = {};
SoundManager.__index = SoundManager;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function SoundManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// AddCategory	 	//////
-- ///////////////////////////////

function SoundManager:AddCategory(name)
	assert(self["kat"..name] == nil, "Category '"..name.."' allready exists");

	self["kat"..name] = {};
	
	outputDebugString("SoundManager: Category "..name.." added");
	
	return self["kat..name"];
end

-- ///////////////////////////////
-- ///// RemoveCategory	 	//////
-- ///////////////////////////////

function SoundManager:RemoveCategory(name)
	assert(self["kat"..name] ~= nil, "Category '"..name.."' does not exists");

	local sounds = 0;
	for sound, bool in pairs(self["kat"..name]) do
		if(isElement(sound) and bool) then
			self:DestroySound(sound);
			sounds = sounds+1;
		end
	end
	
	self["kat"..name] = nil;
	
	outputDebugString("SoundManager: Category "..name.." deleted, "..sounds.." sounds destroyed");
	
	return true;
end

-- ///////////////////////////////
-- ///// SetCategoryVolume	//////
-- ///////////////////////////////

function SoundManager:SetCategoryVolume(name, value)
	assert(value >= 0 and value <= 1, "Bad Value (2) @ SetCategoryVolume, min. 0, max. 1");
	
	for sound, bool in pairs(self["kat"..name]) do
		if(isElement(sound) and bool) then
			setSoundVolume(sound, value);
		end
	end
	
	self["kat"..name..":volume"] = value;
	
	return true;
end

-- ///////////////////////////////
-- ///// GetCategorySounds	//////
-- ///////////////////////////////

function SoundManager:GetCategorySounds(name)
	return self["kat"..name] or false;
end

-- ///////////////////////////////
-- ///// PlaySound	 		//////
-- ///////////////////////////////

function SoundManager:PlaySound(url, looped, kat)
	local s = playSound(url, looped);
	
	if(isElement(s) and kat and type(kat) == "string") then
		assert(self["kat"..kat] ~= nil, "Category '"..kat.."' does not exists");
		self["kat"..kat][s] = true;
		
		setElementData(s, "sound:category", kat, false);
		
		if(self["kat"..kat..":volume"]) then
			setSoundVolume(s, self["kat"..kat..":volume"]);
		end
	end
	
	return s;
end

-- ///////////////////////////////
-- ///// PlaySound3D	 	//////
-- ///////////////////////////////

function SoundManager:PlaySound3D(url, x, y, z, looped, kat)
	local s = playSound3D(url, x, y, z, looped);
	
	if(isElement(s) and kat and type(kat) == "string") then
		assert(self["kat"..kat] ~= nil, "Category '"..kat.."' does not exists");
		self["kat"..kat][s] = true;
		
		setElementData(sound, "sound:category", kat, false);
		
		if(self["kat"..kat..":volume"]) then
			setSoundVolume(s, self["kat"..kat..":volume"]);
		end
	end
	
	return s;
end

-- ///////////////////////////////
-- //// ModifySoundCategory //////
-- ///////////////////////////////

function SoundManager:ModifySoundCategory(sound, newkat)
	assert(isElement(sound) and getElementData(sound, "sound:category"), "Bad Argument (1)@ModifySoundCategory, invalid sound");
	
	assert(self["kat"..newkat] ~= nil, "Category '"..newkat.."' does not exists");
	
	local oldkat = getElementData(sound, "sound:category");
	
	self["kat"..oldkat][s] = nil;
	
	self["kat"..newkat][s] = true;
	
	setElementData(sound, "sound:category", newkat, false);
	
	return true;
end

-- ///////////////////////////////
-- ///// DestroySound	 	//////
-- ///////////////////////////////

function SoundManager:DestroySound(sound)
	if(isElement(sound)) then
		local kat = getElementData(sound, "sound:category");
		if(kat) then
			self["kat"..kat][sound] = nil;
		end
	end
	return destroyElement(sound);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function SoundManager:Constructor(...)

	outputDebugString("[CALLING] SoundManager: Constructor");
end


-- EVENT HANDLER --
