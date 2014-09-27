local Collide = Class{
	__includes = Controller,
	init = function(self, w, h)

		Controller.init(self, "collide")

		self.signals = Signals.new()
		if w and h then
			self.width, self.height = w, h
			self.auto = false
		else
			self.auto = true
		end

		self:enable()
	end
}

function Collide:added(to)
	if self.auto then
		self:autoInit()
	end
end

function Collide:autoInit()
	local sprite = self.parent:get("sprite")
	if sprite then
		self.width, self.height = sprite.image:getWidth(), sprite.image:getHeight()
	else
		self.width, self.height = 1, 1
	end
end

function Collide:update()
	self.colliding = false
	self.collidingWith = {}

	if (self.enabled) then 
		self.colliding, self.collidingWith = self:collisionTest()

		if self.colliding then 
			self.signals:emit("colliding", self.collidingWith)
		end
	end
end

function Collide:collisionTest()
	local colliding = false
	local with = {}

	local x1, y1 = self.parent.x, self.parent.y
	local x2, y2 = self.parent.x + self.width, self.parent.y + self.height



	for i, v in ipairs(self.parent.parent.entities) do
		other = v:get("collide")
		if other ~= self then
			local otherx1, othery1 = other.parent.x, other.parent.y
			local otherx2, othery2 = other.parent.x + other.width, other.parent.y + other.height
			if x1 < otherx2 and x2 > otherx1 and y1 < othery2 and y2 > othery1 then
				colliding = true
				table.insert(with, other.parent)
			end
		end
	end

	return colliding, with
end

function Collide:draw()
	
end

function Collide:disable()
	self.enabled = false
end

function Collide:enable()
	self.enabled = true
end

return Collide