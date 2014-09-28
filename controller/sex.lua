local Sex = Class{
	__includes = Controller,
	init = function(self, host)
		Controller.init(self, "sex")
		self.hostname = host
	end
}

function Sex:added(to)
	local collide = self.parent:get("collide")

	if not collide then
		print("parent entity needs to have collide. Failing.")
		self.parent.remove(self.name);
	else
		collide.signals:register("colliding", function(e)
			for i, v in ipairs(e) do
				if v.name == self.hostname then
					self:enter(v)
				end
			end
		end)
	end
end

function Sex:enter(target)
	local host = target:get("host")

	self.residing = target -- for external calls

	print("entering house")

	self.parent.x = target.x
	self.parent.y = target.y

	self.occupantIndex = host:addOccupant(self.parent)
	
	
	host.signals:register("filled", function()	
		print("house filled")
		Timer.add(3, function()
			if self:kinseyTest(self.parent, host:getOther(self)) then
				host:consent(self.occupantIndex) 
			end
			print("leaving house")
		end)
	end)

	host.signals:register("ready", function()
		self:doIt(host, host:getOther(self))
	end)

	self.unfreezeParent = self.parent:freeze(true, self.name, "profile")
end

function Sex:doIt(host, other)
	local profile = self.parent:get("profile")
	if not profile then 
		print("This sex is off the record...") 
	else
		self:applySex("anal", profile)
		if profile.info.gender == "female" or other:get("profile").info.gender == "female" then
			self:applySex("vaginal", profile)
		end
		self:applySex("oral", profile)
		profile.info.encounters = profile.info.encounters + 1
	end

	self:leave(host)
end

function Sex:applySex(type, profile)
	if Random:random(1,4) <= profile.info.chance[type] then
		profile.info.sex[type] = profile.info.sex[type] + Random:random(1, profile.info.chance[type])
	end
end

function Sex:kinseyTest(me, other)
	local kinsey = me:get("profile").info.kinsey
	local myGender = me:get("profile").info.gender
	local otherGender = other:get("profile").info.gender
	local consent = false
	if myGender == otherGender then
		consent = Random:random() <= kinsey/6
	else
		consent = Random:random() <= -(kinsey/6) + 1
	end
	return consent
end

function Sex:leave(from)
	
	table.remove(from.occupants, self.occupantIndex)

	self.residing = nil
	self.parent.x = from.parent.x
	self.parent.y = from.parent.y

	self.unfreezeParent()

	self.parent:get("collide"):disable()

	Timer.add(2, function() 
		self.parent:get("collide"):enable() 
	end)

	print("Left.")
end

return Sex