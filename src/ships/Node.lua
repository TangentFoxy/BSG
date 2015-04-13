return function(x, y, rotation)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.rotation = rotation or 0

    self.docked = false

    return self
end
