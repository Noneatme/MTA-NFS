-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: ConnectionManager	##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

ConnectionManager = {}
ConnectionManager.__index = ConnectionManager


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function ConnectionManager:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function ConnectionManager:Constructor(...)
	-- Here is the connection to the MySQL Server
	self.connectionString1 = {};
	self.connectionString2 = {};
	
	-- CONNECTION SETTINGS
	self.connectionString1.host = "127.0.0.1";
	self.connectionString1.user = "root";
	self.connectionString1.password = "";
	self.connectionString1.database = "dbsSR";
	
	-- SECOND CONNECTION 
	self.connectionString2.host = "vweb02.nitrado.net";
	self.connectionString2.user = "ni2348_1sql8";
	self.connectionString2.password = "375c0189";
	self.connectionString2.database = "ni2348_1sql8";

	
	self.pollTime = 5000;
	
	logger:OutputInfo("[CALLING] ConnectionManager Constructor");
end

-- ///////////////////////////////
-- ///// Open	 			//////
-- ///////////////////////////////

function ConnectionManager:Open()
	self.connection = dbConnect("mysql", "dbname="..self.connectionString1.database..";host="..self.connectionString1.host, self.connectionString1.user, self.connectionString1.password, "autoreconnect=1");

	if not(self.connection) then
			self.connection = dbConnect("mysql", "dbname="..self.connectionString2.database..";host="..self.connectionString2.host, self.connectionString2.user, self.connectionString2.password, "autoreconnect=1");
		if not(self.connection) then
			logger:OutputError("Can't connect to MySQL Database!");
		end
	end
	logger:OutputInfo("Connection accepted.")
end


-- ///////////////////////////////
-- ///// Close	 			//////
-- ///////////////////////////////

function ConnectionManager:Close()
	destroyElement(self.connection)
	logger:OutputInfo("MySQL Connection closed.")
end
-- ///////////////////////////////
-- ///// Query	 			//////
-- ///////////////////////////////

function ConnectionManager:Query(query, injection)
	assert(self.connection ~= nil);
	if(injection == nil) or (injection == false) then
		assert(antiInjection:CheckString(query) ~= true, "Injection Warning!");
	end
	local qr = dbQuery(self.connection, query);
	local result, numrows, errmsg = dbPoll(qr, self.pollTime);
	
	if(errmsg) then
		outputDebugString(debug.getinfo(4).short_src..", "..debug.getinfo(4).currentline)
	--	logger:OutputInfo(debug.getinfo(4).short_src..", "..debug.getinfo(4).currentline)
	end
	return result, numrows, errmsg;
end

-- EVENT HANDLER --
