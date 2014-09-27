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
		v:added(self)
	end
end

function Entity:remove(...)
	for i, v in ipairs{...} do
		for i2, v2 in ipairs(self.controllers) do
			if v2.name == v then
				v2:destroy()
				self.controllers[i2] = nil
			end
		end
	end
end

function Entity:get(name)
	local gotten = {}
	for i, v in ipairs(self.controllers) do
		if v.name == name then
			table.insert(gotten, v)
		end
	end
	return unpack(gotten)
end

function Entity:getAll()
	local assoc = {}
	for i, v in ipairs(self.controllers) do
		assoc[v.name] = v
	end
	return assoc
end

function Entity:disable(name)
	self:get(name):disable()
end

function Entity:setAll(enabled, visible)
	for i, v in ipairs(self.controllers) do
		if type(enabled) ~= "nil" then 
			if enabled == false then 
				v:disable()
			else
				v:enable()
			end
		end

		if type(visible) ~= "nil" then
			if visible == false then
				v:hide()
			else
				v:show()
			end
		end
	end
end

function Entity:hideAll()
	for i, v in ipairs(self.controllers) do
		v:hide()
	end
end

function Entity:added() end --called when added to gamestate and parent is availible!

function Entity:update(dt) 
	self:entityUpdate()
	for i, v in ipairs(self.controllers) do
		if v.enabled then v:update(dt) end
	end
end

function Entity:entityUpdate() end

function Entity:draw()
	self:entityDraw()
	for i, v in ipairs(self.controllers) do
		if v.visible then v:draw() end
	end
end

function Entity:entityDraw() end

function Entity:destroy() 
	for i, v in ipairs(self.controllers) do
		self:remove(v.name)
	end
end

return Entity