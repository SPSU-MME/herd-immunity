local worldState = State()

function worldState:enter()
	local rand = love.math.newRandomGenerator()
	for i=1,2 do
		self:addEntity(Person(4*i, 4*i))
	end

	debugHuman = Person(500, 500, 2)
	self:addEntity(debugHuman)

end

function worldState:stateDraw()
	for i, v in ipairs(self.entities) do
		v:draw(dt)
	end
	love.graphics.setBackgroundColor(100, 170, 100)
end

return worldState