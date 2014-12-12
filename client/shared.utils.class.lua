--// shared.utils.class
--||	@type:	Shared
--||	@desc:	A library providing several tools to enhance OOP with Lua
--||	@info:  Registers itself into the global namespace
--||	@license:
--||		Copyright (c) 2013 MrX / sbx320
--||		
--||		Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
--||		files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, 
--||		modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
--||		is furnished to do so, subject to the following conditions:
--||		
--||		The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--||		
--||		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
--||		OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
--||		LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
--||		IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--||		
--\\
utils = utils or {}
utils.class = {}
utils.class.elementClasses = {}
utils.class.elementIndex = {}

--// utils.class.new(class, ...)
--||	@desc:	Creates an instance of 'class' and calls the constructor
--||			and all derived_constructors
--||	@param:	table 'class' -	The class which should be instanciated
--||	@param: vararg        - Parameters passed to the constructor and derived_constructors
--||	@return:table 		  - The newly created instance 
--\\
function utils.class.new(class, ...)
	assert(type(class) == "table", "first argument provided to new is not a table")
	local instance = setmetatable( { },
		{
			__index = class;
			__super = { class };
			__newindex = class.__newindex;
			__call = class.__call;
		})
	
	-- Call derived constructors
	-- Weird Lua behaviour requires forwarding of recursive local functions...?
	local callDerivedConstructor;
	callDerivedConstructor = function(self, instance, ...)
		for k, v in pairs(super(self)) do
			if rawget(v, "derived_constructor") then
				rawget(v, "derived_constructor")(instance, ...)
			end
			local s = super(v)
			if s then callDerivedConstructor(s, instance, ...) end
		end
	end
		
	callDerivedConstructor(class, instance, ...) 
	
	-- Call constructor
	if rawget(class, "constructor") then
		rawget(class, "constructor")(instance, ...)
	end
	instance.constructor = true

	-- Add a change handler for all ._changeVARIABLE methods
	for k, v in pairs(class) do
		if k:sub(1, 7) == "_change" then
			utils.class.addChangeHandler(instance, k:sub(8), v)
		end
	end

	return instance
end

--// utils.class.enew(element, class, ...)
--||	@desc:	Makes an element an instance of 'class' and calls the constructor
--||	@param:	table 'class' -	The class which should be instanciated
--||	@param: vararg        - Parameters passed to the constructor and derived_constructors
--||	@return:element 	  - The element passed
--\\
function utils.class.enew(element, class, ...)
	local instance = setmetatable( { element = element },
		{
			__index = class;
			__super = { class };
			__newindex = class.__newindex;
			__call = class.__call;
		})
		
	utils.class.elementIndex[element] = instance
	
	-- Weird Lua behaviour requires forwarding of recursive local functions...?
	local callDerivedConstructor;
	callDerivedConstructor = function(self, instance, ...)
		for k, v in pairs(super(self)) do
			if rawget(v, "derived_constructor") then
				rawget(v, "derived_constructor")(instance, ...)
			end
			local s = super(v)
			if s then callDerivedConstructor(s, instance, ...) end
		end
	end
		
	callDerivedConstructor(class, element, ...) 
	
	-- Call constructor
	if rawget(class, "constructor") then
		rawget(class, "constructor")(element, ...)
	end
	element.constructor = true

	-- Add a change handler for all ._changeVARIABLE methods
	for k, v in pairs(class) do
		if k:sub(1, 7) == "_change" then
			utils.class.addChangeHandler(instance, k:sub(8), v)
		end
	end
	
	-- Add the destruction handler
	addEventHandler(
		triggerClientEvent ~= nil and 
		"onElementDestroy" or
		"onClientElementDestroy", element, utils.class.__removeElementIndex, false, "low-999999")

	return element
end

--// utils.class.registerElementClass(elementType, class)
--||	@desc:	Registers a class to be used upon element index operations like e.g.
--||			getPlayerFromName("MrX"):hello() would search in the class assigned to "player"
--||	@param:	string 'elementType'- The element type the class is supposed to be assigned to
--||	@param: table 'class'       - The class which is assigned
--\\
function utils.class.registerElementClass(elementType, class)
	utils.class.elementClasses[elementType] = class
end

--// utils.class.__removeElementIndex()
--||	@desc:	This function calls delete on the hidden source parameter to invoke the destructor
--||			!!! Avoid calling this function manually unless you know what you're doing! !!!
--\\
function utils.class.__removeElementIndex()
	utils.class.delete(source)
end

--// utils.class.delete(self, ...)
--||	@desc:	Deletes an instance and calls the destructor
--||			and all derived_destructors
--||	@param:	table 'self' -	The instance to be deleted
--||	@param: vararg        - Parameters passed to the destructor and derived_destructors
--\\
function utils.class.delete(self, ...)
	if self.destructor then
		self.destructor(self, ...)
	end

	-- Prevent the destructor to be called twice 
	self.destructor = false
	
	-- Cleanup
	utils.class.elementIndex[self] = nil
end

--// utils.class.super(self)
--||	@desc:	Gets the superclasses of an instance or class
--||	@param:	table 'self' -	The instance / class to get the parent class of
--||	@return:table<table> - The superclasses
--\\
function utils.class.super(self)
	local metatable = getmetatable(self)
	if metatable then return metatable.__super 
	else return {}
	end
end

--// utils.class.instanceof(self, class, direct = false)
--||	@desc:	Returns if 'self' is an instance of 'class'. If 'direct' is set to true it enforces 'self'
--||			to be a direct descendant of 'class' (new(self, class)). If 'direct' is set to false 
--||			(default) 'self' is allowed to be a instance with any kind of link to 'class' even with 
--||			multiple levels of inheritance or similar polymorphic connections.
--||	@param:	table 'self' 			  -	The instance to check
--||	@param:	table 'class' 			  -	The class to check
--||	@optparam:	bool 'direct' (false) -	Whether to check for direct inheritance
--||	@return:bool - the result of the check
--\\
function utils.class.instanceof(self, class, direct)
	for k, v in pairs(super(self)) do
		if v == class then return true end
	end
	
	if direct then return false end
		
	local check = false
	-- Check if any of 'self's base classes is inheriting from 'class'
	for k, v in pairs(super(self)) do
		check = utils.class.instanceof(v, class, false)
	end	
	return check
end

--// utils.class.bind(func, self)
--||	@desc:	Wraps the function(...) return function(self, ...) end idiom
--||	@param:	table 'func' 			  -	The function to bind
--||	@param:	table 'self' 			  -	The instance to bind to
--||	@return:function - the bound function
--\\
function utils.class.bind(func, self)
	return function(...) return func(self, ...) end 
end

--// utils.class.load(class, ...)
--||	@desc:	Creates an instance of 'class' and call the 'load' method
--||	@param:	table 'class' -	The class which should be instanciated
--||	@param: vararg        - Parameters passed to the 'load' method
--||	@return:table 		  - The newly created instance 
--\\
function utils.class.load(class, ...)
	assert(type(class) == "table", "first argument provided to load is not a table")
	local instance = setmetatable( { },
		{
			__index = class;
			__super = { class };
			__newindex = class.__newindex;
			__call = class.__call;
		})
	
	-- Call constructor
	if rawget(class, "load") then
		rawget(class, "load")(instance, ...)
	end
	instance.load = true

	return instance
end

--// utils.class.inherit(from, what)
--||	@desc:	Creates a new class inheriting from 'from' or sets 'what' to inherit from 'from'
--||	@param:	table 'from' 		-	The class to inherit from
--||	@optparam:	table 'what' 	-	The class which should inherit, optional
--||	@return:table - The now inheriting class
--\\
function utils.class.inherit(from, what)
	if not from then return {} end
	
	if not what then return setmetatable({}, { __index = utils.class._inheritIndex, __super = { from } }) end
	
	local metatable = getmetatable(what) or {}
	local oldsuper = metatable and metatable.__super or {}
	oldsuper[#oldsuper+1] = from
	metatable.__super = oldsuper
	metatable.__index = utils.class._inheritIndex
	return setmetatable(what, metatable)
end

function utils.class._inheritIndex(self, key)
	for k, v in pairs(utils.class.super(self) or {}) do
		if v[key] then return v[key] end
	end
	return nil
end

--// utils.class.pure_virtual()
--||	@desc:	Yields an error on call. Use like: class.memberfunction = pure_virtual to enforce 
--||			implementation in derived classes
--\\
function utils.class.pure_virtual()
	error("Function implementation missing")
end

--// utils.class.fetchRemote_s(url, cb, ...)
--||	@desc:	fetchRemote with safe handling of metatables
--||	@param:	See mta wiki
--\\
utils.class.fetchRemoteList = {}
function utils.class.fetchRemote_s(url, cb, ...)
	local index = #utils.class.fetchRemoteList+1
	utils.class.fetchRemoteList[index] = { cb, ... }
	return callRemote(url, utils.class._fetchRemote_Callback, index)
end

function utils.class.fetchRemote_Callback(response, err, index)
	if not utils.class.fetchRemoteList[index] then return end
	
	assert(err == 0, "fetchRemote Error "..tostring(err))
	
	local callback = utils.class.fetchRemoteList[index][1]
	table.remove(utils.class.fetchRemoteList[index], 1)
	callback(response, unpack(utils.class.fetchRemoteList[index]))
	utils.class.fetchRemoteList[index] = nil
end

--// utils.class.addChangeHandler(instance, key, func)
--||	@desc:	addChangeHandler calls 'func' whenever 'key' is changed on 'instance'
--||	@param:	table instance  - any table to watch for changes
--||	@param: string key		- the key to watch
--||	@param:	function func	- the function to call when the value of instance[key] is changed
--||							  return anything but nil to override the value. Do not attempt to
--||							  change instance[key] directly within 'func' as it will cause a 
--||							  stack overflow
--\\
function utils.class.addChangeHandler(instance, key, func)
	local metatable = getmetatable(instance) or {}
	if not metatable.__changeHandler then
		metatable.__changeHandler = {}
		metatable.__changeData = {}

		metatable.__realNewindexFunction = metatable.__newindex

		-- This saves us from checking on each call		
		if type(metatable.__index) == "table" then
			metatable.__realIndexTable = metatable.__index
		elseif type(metatable.__index) == "function" then
			metatable.__realIndexFunction = metatable.__index
		end

		metatable.__index = utils.class.__changeHandlerIndex
		metatable.__newindex = utils.class.__changeHandlerNewindex
	end
	metatable.__changeHandler[key] = func
	return setmetatable(instance, metatable)
end

function utils.class.__changeHandlerIndex(self, key)
	local metatable = getmetatable(self)
	if metatable.__changeData[key] then return metatable.__changeData[key] end
	
	return (
		-- If we have a __index function use it
		metatable.__realIndexFunction and
			metatable.__realIndexFunction(rawget(self, "element") or self, key) or
			
		-- If we have a __index table use it
		metatable.__realIndexTable and
			metatable.__realIndexTable[key] or

		-- Else rawget
		rawget(self, key)
	)
end


function utils.class.__changeHandlerNewindex(self, key, value)
	local metatable = getmetatable(self)
	if metatable.__changeHandler[key] then 
		local ret = metatable.__changeHandler[key](rawget(self, "element") or self, value)
		if ret ~= nil then
			value = ret
		end
		metatable.__changeData[key] = value
		setmetatable(self, metatable)
	end
	
	return (
		-- If we have a __newindex function use it
		metatable.__realNewindexFunction and
			metatable.__realNewindexFunction(rawget(self, "element") or self, key, value) or

		-- Else rawset
		rawset(self, key, value)
	)
end


-- -- Magic happens here. -- -- 
-- Lua's lightuserdatas (which MTA uses for Elements) can have on global shared metatable. This blocks
-- the possibility to do debug.setmetatable(element, class), therefore we redirect all class on elements
-- to a table. This allows full control about the metaactions on any lightuserdata.
-- The debug.setmetatable is applied to root as it will always be an existing element. It could be applied
-- to any other element and have the same effect
debug.setmetatable(root,
	{
		__index = function(self, key)
			if utils.class.elementIndex[self] then 	
				return utils.class.elementIndex[self][key]
			elseif utils.class.elementClasses[getElementType(self)] then
				utils.class.enew(self, utils.class.elementClasses[getElementType(self)])
				return self[key]
			end
		end,
		__newindex = function(self, key, value) 
			if not utils.class.elementIndex[self] then
				utils.class.enew(self, utils.class.elementClasses[getElementType(self)] or {})
			end
			utils.class.elementIndex[self][key] = value
		end,
	}
)


-- Load into global namespace
for k, v in pairs(utils.class) do
	_G[k] = v
end
