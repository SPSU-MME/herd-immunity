local state = _f.object(_f.class, _f.evt)

function state:construct(observing)
	self.entities = {}
	self.started = false
	self.visible = true

	self.observing = observing
	self:registerEvents()
end

function state:registerEvents()
	self.observing:on("start", function()
		self.started = true
		self:start()
		self:fire("start")
	end)


	self.observing:on("stop", function()
		self:fire("stop")
		self:stop()
		self.started = false
	end)


	self.observing:on("update", function(dt)
		if self.started then
			self:update(dt)
			self:fire("update", dt)
		end
	end)

	self.observing:on("draw", function()
		-- to be honest, game states shouldn't need to draw anything themselves.
		if self.visible then
			self:fire("draw")
		end
	end)

	self.observing:on("change", self.destroy)
end

function state:start() end -- override this

function state:stop() end -- and this

function state:update(dt) end -- this too

-- well you don't really have to. You could just hook state:on("start/stop/update")
-- muh convenience

function state:destroy() -- don't override please
	if self.started then
		self:stop()
	end

	self:fire("destroy") -- hook instead.
end

return state