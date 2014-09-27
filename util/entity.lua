local entity = _f.object(_f.class, _f.evt)

function entity:initialize(observing, x, y)

	if x and y then
		self.x = x
		self.y = y
	else
		self.x = 100 --sensible defaults
		self.y = 100
	end

	self.observing = observing
	self.controllers = {}
	self.init()
	self:registerEvents()
end

function entity:registerEvents()
	self.observing:on("initState", function() 
		self:init()
		self:fire("init")
	end)
	self.observing:on("update", function(dt)
		self:update(dt)
		self:fire("update", dt)
	end)
	self.observing:on("destroy", function()
		self:fire("destroy")
		self:destroy()
	end)

	self.observing:on("draw", function() 
		self:draw()
		self:fire("draw")
	end)
end

function entity:addController(controller)
	table.insert(self.controllers, controller)
end

function entity:getController(name)
	for k, v in pairs(self.controllers) do
		if v.name == name then
			return v
		end
	end
end

function entity:init() end

function entity:initState() end

function entity:update(dt) end

function entity:destroy() end

function entity:draw() end

return entity