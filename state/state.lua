local State = Class{
	init = function(self)
		self.entities = {}
	end
}

function State:addEntity(entity)
	table.insert(self.entities)
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

function State:update(dt)
	for i, v in ipairs(self.entities) do
		v:update(dt)
	end
end

return State