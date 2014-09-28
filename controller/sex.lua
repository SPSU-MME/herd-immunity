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
				if v.name == self.hostname and not v:get("host").filled then
					self:enter(v)
				end
			end
		end)
	end
end

function Sex:enter(target)
	self.sexed = false
	local host = target:get("host")

	self.residing = target -- for external calls

	print("entering house")

	self.parent.x = target.x
	self.parent.y = target.y

	self.occupantIndex = host:addOccupant(self.parent)
	
	
	host.signals:register("filled", function()	
		print("house filled")
		Timer.add(1, function()
			if self:kinseyTest(self.parent, host:getOther(self)) then
				host:consent(self.occupantIndex)

				Timer.add(2, function() --in case consent can't be met
					if not self.sexed then self:leave(host) end
				end)
			else
				self:leave(host) --nah fuck this
			end
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
		print("doesn't matter had sex")
	end
	self.sexed = true
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
		consent = Random:random() <= math.sqrt(kinsey/6)
	else
		consent = Random:random() <= -(kinsey/6)^3 + 1
	end
	print((consent and "Yep, I like this" or "Nah not my thing"))
	return consent
end

function Sex:leave(from)
	
	from:removeOccupant(self.occupantIndex)

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