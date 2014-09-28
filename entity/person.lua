local Person = Class{
	__includes = Entity,
	init = function(self, x, y, type)
		Entity.init(self, "person", x, y)
		local thetype = type or ""
		self:add(Sprite("assets/img/human"..thetype..".png"))
		self:add(Collide())
		self:add(Sex("house"))
		self:add(Move("brownian"))
		self:add(Profile({}))
	end
}

return Person