local controller = _f.object(_f.class)

function controller:initialize(observing, uniqueName)
	self.observing = observing
	self.name = uniqueName

	self:init()

	self.observing:on("init", function()
		self:entityInit()
	end)

	self.observing:on("update", function(dt)
		self:update()
	end)

	self.observing:on("draw", function()
		self:draw()
	end)
end

function controller:init() end

function controller:entityInit() end

function controller:update(dt) end

function controller:draw() end

return controller