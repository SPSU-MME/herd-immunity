local House = Class{
	__includes = Entity,
	init = function(self, x, y)
		Entity.init(self, "house", x, y)
		self:add(Sprite("assets/img/house.png"))
		self:add(Collide())
		self:add(Host("person"))
	end
}



return House