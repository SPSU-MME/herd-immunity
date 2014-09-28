local Entity = Class{
	init = function(self, name, x, y, ...)
		self.name = name
		self.x = x
		self.y = y
		self.controllers = {}
		self:add(...)
	end
}

function Entity:getX()
	return self.x
end

function Entity:getY()
	return self.y
end

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

function Entity:freeze(hide, ...)
	local disabled = {}
	local hidden = {}
	local skip = {...}
	for i, v in ipairs(skip) do
		print(i, v)

	end

	local function Set (list)
  		local set = {}
  		for _, l in ipairs(list) do 
  			set[l] = true 
  		end
  		return set
	end

	local skipSet = Set(skip)

	for k, v in pairs(skipSet) do
		print(k, v)
	end

	for i, v in ipairs(self.controllers) do
		if v.enabled and not skipSet[v.name] then
			v:disable()
			table.insert(disabled, v)
		end

		if hide and v.visible and not skipSet[v.name] then
			v:hide()
			table.insert(hidden, v)
		end
	end

	return function() 
		for i, v in ipairs(disabled) do
			v:enable()
		end

		if hide then
			for i, v in ipairs(hidden) do
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

function Entity:mousepressed(x, y, button)
	Entity:entitymousepressed(x, y, button)
	for i, v in ipairs(self.controllers) do
		v:mousepressed(x, y, button)
	end
end

function Entity:entitymousepressed(x, y, button) end

return Entity