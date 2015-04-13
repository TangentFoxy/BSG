return function(x, y, rotation)
    local self = {}

    self.img = "viper"
    self.ox = 4.5
    self.oy = 7.5

    self.x = x or 0
    self.y = y or 0
    self.rotation = rotation or 0

    --[[
    self.selection = {
        w = 9,
        h = 15
    }
    --]]
    self.selection = {
        r = 5
    }

    --self.node = false

    return self
end
