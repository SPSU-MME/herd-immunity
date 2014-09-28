local Controller = Class{
	init = function(self, name)
		self.name = name
		self.enabled = true
		self.visible = true
	end
}

function Controller:disable()
	self.enabled = false
end

function Controller:enable()
	self.enabled = true
end

function Controller:show()
	self.visible = true
end

function Controller:hide()
	self.visible = false
end

function Controller:added(toWhat) end

function Controller:update(dt) end

function Controller:draw() end

function Controller:destroy() end

function Controller:mousepressed(x, y, button) end

return Controller