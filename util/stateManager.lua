local stateManager = _f.object(_f.class, _f.evt)

function stateManager:construct(observing, startState)

	self.observing = observing
	self.state = {} 
	if startState then 
		self:setState(startState, false)
	end

	self:registerEvents()
end

function stateManager:registerEvents()
	self.observing:on("change-state", function(e)
		self:setState(e.state, e.keep)
	end)

	self.observing:on("start", function()
		self:start()
	end)

	self.observing:on("stop", function()
		self:stop()
	end)

	self.observing:on("update", function(dt)
		self:update(dt)
	end)

	self.observing:on("draw", function()
		self:draw()
	end)
end

function stateManager:setState(state, keep)
	if self.state and self.state.started then 
		self.state:stop()
		self.state:fire("stop")
	
		if not keep then
			self.state:fire("destroy")
			self.state:destroy() 
			self.state = nil
		end
	end
	self.state = state
	self.state.preInit()
	self.state:fire("init")
	self.state:init()
end

function stateManager:start()
	self.state:fire("start")
	self.state:start()
	self.state.started = false
end

function stateManager:stop()
	self.state:stop()
	self.state:fire("stop")
	self.state.started = false
end

function stateManager:update(dt)
	if (self.state.started) then 
		self.state:update(dt)
		self.state:fire("update", dt)
	end
end

function stateManager:draw()
	if self.state.visible then self.state:fire("draw") end
end

return stateManager