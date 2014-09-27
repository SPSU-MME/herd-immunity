local sprite = _f.object(game.util.controller, _f.class)

function sprite:construct(observing, imagePath)
	self:initialize(observing, "sprite")
	self.image = love.graphics.newImage(imagePath)
end

function sprite:draw()
	love.graphics.draw(self.image, self.observing.x, self.observing.y)
end

return sprite