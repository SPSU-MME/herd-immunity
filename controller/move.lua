local Move = Class{
	__includes = Controller,
	init = function(self, type)
		Controller.init(self, "move")
		--self.moveFunction = self.types[type]
		self.angle = 0
		self.moving = false
	end
}

function Move:added(to)

end

function Move:update(dt)
	if not self.moving and Random:random(1, 2) == 2 then
		self:autoMove(dt, Random:random(500, 700))
	end
end

function Move:autoMove(dt, speed)

	if Random:random(0, 6) == 5 then
		self.angle = Random:random()*(2*PI)
	end
	local dx, dy = math.cos(self.angle)*speed, math.sin(self.angle)*speed

	
	self:smoothMove(dx, dy, 1, "in-out-quad")

end

function Move:move(dx, dy)
	self.moving = true
	
	local collide = self.parent:get("collide")
	if self.parent.x + dx > 0 and self.parent.x + (collide.width or 0) + dx < love.graphics.getWidth() then
		self.parent.x = self.parent.x + dx
	end

	if self.parent.y + dy > 0 and self.parent.y + (collide.height or 0) + dy < love.graphics.getHeight() then
		self.parent.y = self.parent.y + dy
	end

	self.moving = false
end

function Move:smoothMove(dx, dy, time, type)
	self.moving = true
	local collide = self.parent:get("collide")
	if self.parent.x + dx > 0 and self.parent.x + (collide.width or 0) + dx < love.graphics.getWidth() then
		if self.parent.y + dy > 0 and self.parent.y + (collide.height or 0) + dy < love.graphics.getHeight() then
			Timer.tween(1, self.parent, {x = self.parent.x+dx, y = self.parent.y+dy}, type, function () self.moving = false end)
		end
	else
		self.moving = false -- AND THEN, YA GET OUTTA THERE
	end
end


--[[
Move.types = {
	brownian = function (self, x, y, speed, dt)
		if Random:random(0, 6) == 5 then
			self.angle = Random.random()*(2*PI)
		end
		local oldX, oldY = x, y
		local dx, dy = math.cosh(self.angle)*speed*dt,math.sinh(self.angle)*speed*dt
		x = oldX + dx
		y = oldY + dy

		return x, y
	end
}
]]

return Move