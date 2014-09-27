local person = _f.object(game.util.entity, _f.class)

function person:construct(observing, x, y)
	if x and y then
		self:initialize(observing, x, y)
	else
		self:initialize(observing)
	end

	--self:addController(game.controller.sprite:new(self, "assets/img/human.png"))
	--local sprite = game.controller.sprite:new(person, "assets/img/human.png")
	table.insert(self.controllers, _f.object(game.controller.sprite:new(self, "assets/img/human.png")))
end

return person