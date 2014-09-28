-- okay yes I will admit this one really only works on humans.

local Profile = Class{
	__includes = Controller,

	init = function(self, info)
		Controller.init(self, "profile")
		self.information = self.info = {
			name = "John Doe",
			gender = "male", --or "female"
			arv = false,
			encounters = 0,
			sex = {
				anal = 0,
				vaginal = 0,
				oral = 0
			},
			chance = {
				anal = Random:random(0, 4),
				vaginal = Random:random(0, 4),
				oral = Random:random(0, 4)
			},
			kinsey = Random:random(0, 6)
		}
		self:hide()

		Class.include(info, self.information)
	end
}

function Profile:added(to)
	if not to:get("collide") then
		print("Won't work without collide.")
		to:remove(self.name) -- bye bye!
	end
end

function Profile:update() 

end

function Profile:draw()
	--mess. FCKING MESS

	local placard = {
		x = 10, 
		y = 10, 
		width = 350, 
		height = 150,
		text = {
			offset = {x = 150, y = 10}, 
			lineHeight = 15
		}
	}

	love.graphics.setColor(180, 180, 180)
	love.graphics.rectangle("fill", placard.x , placard.y, placard.width, placard.height)

	love.graphics.setColor(255, 255, 255, 30)
	if (self.parent:get("sex").residing) then
		local house = self.parent:get("sex").residing
		love.graphics.rectangle("fill", house.x, house.y, 
			house:get("sprite").image:getWidth(), house:get("sprite").image:getHeight())
	else
		love.graphics.rectangle("fill", self.parent.x, self.parent.y, 
			self.parent:get("sprite").image:getWidth(), self.parent:get("sprite").image:getHeight())
	end
	

	love.graphics.setColor(0, 0, 0, 255)
	

	love.graphics.setColor(255, 255, 255)

	local displayTable = {}

	table.insert(displayTable, "Name: "..self.information.name)
	table.insert(displayTable, "Gender: "..self.information.gender)
	table.insert(displayTable, "On Antiretrovirals: "..(self.information.arv and "yes" or "no"))
	table.insert(displayTable, "Sexual Activity:")
	table.insert(displayTable, {})
	table.insert(displayTable[5], "Anal: "..self.information.sex.anal)
	table.insert(displayTable[5], "Vaginal: "..self.information.sex.vaginal)
	table.insert(displayTable[5], "Oral: "..self.information.sex.oral)

	local function writeInfoLines(t, xoff, yoff)
		
		xx, yy, ox, oy, lh = placard["x"], placard["y"], placard.text.offset.x+xoff, placard.text.offset.y+yoff, placard.text.lineHeight

		for i, v in ipairs(t) do

			if type(v) ~= "table" then
				love.graphics.print(v, xx + ox, yy + oy + lh*(i-1))
			else
				writeInfoLines(v, 20, lh*i-1)
			end
		end
	end

	writeInfoLines(displayTable, 0, 0)
end

function Profile:mousepressed(x, y, button) 
	if self.parent:get("collide"):pointCollisionTest(x, y) then
		self.visible = (not self.visible) -- toggle!
	end
end

function Profile:hadSex(type)
	self.information.sex[type] = self.information.sex[type] + 1
end

return Profile