local Person = Class{
	__includes = Entity,
	init = function(self, x, y, type)
		Entity.init(self, "person", x, y)
		local thetype = type or 1
		--self:add(Sprite("assets/img/human"..(self:get("profile").info.gender == "male" and "M" or "F")..thetype..".png"))
		self:add(Sprite("assets/img/human".."M"..thetype..".png"))
		self:add(Collide())
		self:add(Profile({}))
		self:add(Sex("house"))
		self:add(Move("brownian"))
	end
}

return Person