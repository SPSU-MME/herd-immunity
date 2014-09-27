local worldState = State()

function worldState:enter()
	print("entered")
	local rand = love.math.newRandomGenerator()
	for i=1,2 do
		self:addEntity(Person(4*i, 4*i))
	end
end

function worldState:stateDraw()
	for i, v in ipairs(self.entities) do
		v:draw(dt)
	end
	love.graphics.setBackgroundColor(100, 170, 100)
end

return worldState