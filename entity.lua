local entity = _f.object(_f.class, _f.evt)

function entity:construct(observing)
	self.observing = observing
end

function entity:registerEvents()
	self.observing:on()
end

function entity:init() end

function entity:update(dt) end

function entity:destroy() end

return state