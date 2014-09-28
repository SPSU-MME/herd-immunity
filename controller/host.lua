local Host = Class{
	__includes = Controller,
	init = function(self, forWhom)
		Controller.init(self, "host")
		self.signals = Signals.new()
		self.forWhom = forWhom
		self.occupants = {}
		self.waiting = false
	end
}

function Host:added(to)

end

function Host:addOccupant(occupant)
	table.insert(self.occupants, occupant)
	self:checkFull()
	return #self.occupants
end

function Host:checkFull()
	if #self.occupants >= 1 and not self.waiting then
		self.signals:emit("filled")
		self.signals:clear("filled")
	end
end

return Host