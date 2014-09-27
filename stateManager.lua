local stateManager = _f.object(_f.class, _f.evt)

function stateManager:construct(observing, startState)
	self.observing = observing
	if startstate then self.state = startState end

	self:registerEvents()
end

function stateManager:registerEvents()
	self.observing:on("change-state", function(e)
		self:setState(e)
	end)

	self.observing:on("start", function()
		self:start()
	end)

	self.observing:on("stop", function()
		self:stop()
	end)
end

function stateManager:setState(state, keep)
	if self.state and self.state.started then 
		self.state:stop()
		self.state.fire("stop")
		if !keep then self.state.destroy() end
	end
end

function stateManager:start()
	self.state:start()
	self.state:fire("start")
end

function stateManager:stop()
	self.state:stop()
	self.state:fire("stop")
end

return stateManager