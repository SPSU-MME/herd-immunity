local Sprite = Class{
	__includes = Controller,

	init = function(self, imagePath)
		Controller.init(self, "sprite")
		self.image = love.graphics.newImage(imagePath)
	end
}

function Sprite:draw()
	love.graphics.draw(self.image, self.parent.x, self.parent.y)
end

return Sprite