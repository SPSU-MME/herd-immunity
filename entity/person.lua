local Person = Class{
	__includes = Entity,
	init = function(self, x, y)
		Entity.init(self, "person", x, y)
		self:add(Sprite("assets/img/human.png"))
		self:add(Collide())
		self:add(Sex("host"))
	end
}

return Person