local Entity = Class{
	init = function(self, name, x, y, ...)
		self.x = x
		self.y = y
		self.controllers = {}
		self:add(...)
	end
}

function Entity:add(...)
	for i, v in ipairs{...} do
		table.insert(self.controllers, v)
		v.parent = self
		v:added()
	end
end

function Entity:remove(...)
	for i, v in ipairs{...} do
		for i2, v2 in ipairs(self.controllers) do
			if v2.name = v then
				v2:destroy()
				self.controllers[i2] = nil
			end
		end
	end
end

function Entity:added() end --called when added to gamestate and parent is availible!

function Entity:update(dt) 
	for i, v in ipairs(self.controllers) do
		v:update(dt)
	end
end

function Entity:destroy() 
	for i, v in ipairs(self.controllers) do
		self:remove(v.name)
	end
end

return Entity