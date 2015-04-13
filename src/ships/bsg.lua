local Node = require "ships.Node"

local ninety = 90 * math.pi / 180

return function(x, y, rotation)
    local self = {}

    self.img = "bsg"
    self.ox = 31.5
    self.oy = 67

    self.x = x or 0
    self.y = y or 0
    self.rotation = rotation or 0

    --[[
    self.selection = {
        w = 54,
        h = 130
    }
    --]]
    self.selection = {
        r = 27
    }

    self.node = {
        Node(23, -16.5, ninety),
        Node(23, -5.5, ninety),
        Node(23, 5.5, ninety),
        Node(23, 16.5, ninety),
        Node(-23, -16.5, -ninety),
        Node(-23, -5.5, -ninety),
        Node(-23, 5.5, -ninety),
        Node(-23, 16.5, -ninety)
    }

    self.dock = function(self, ship, node)
        if self.node[node].docked or ship.isDocked then return false end

        ship.x = self.node[node].x
        ship.y = self.node[node].y
        ship.rotation = self.node[node].rotation

        self.node[node].docked = ship
        ship.isDocked = true
        ship.dockedTo = self
        ship.dockedNode = node
        return true
    end

    self.undock = function(self, node)
        if not self.node[node].docked then return false end

        local ship = self.node[node].docked
        ship.isDocked = false
        ship.dockedTo = false
        ship.dockedNode = false
        self.node[node].docked = false

        return ship
    end

    return self
end
