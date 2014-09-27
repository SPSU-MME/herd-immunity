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

function Host:update()
	if #self.occupants >= 2 and not self.waiting then
		self.signals:emit("filled")
	end

end

return Host