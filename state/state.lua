local State = Class{
	init = function(self)
		self.entities = {}
		self.signals = Signals.new()
	end
}

function State:addEntity(entity)
	table.insert(self.entities, entity)
	entity.parent = self
	entity:added()
end

function State:removeEntity(name)
	for i, v in ipairs(self.entities) do
		if v.name == name then
			v:remove()
			self.entities[i] = nil
		end
	end
end

function State:stateUpdate(dt) end -- hook this

function State:update(dt) 
	self:stateUpdate()
	for i, v in ipairs(self.entities) do
		v:update(dt)
	end
end

function stateDraw() end -- hook this

function State:draw()
	self:stateDraw()
	for i, v in ipairs(self.entities) do
		v:draw(dt)
	end
end

return State