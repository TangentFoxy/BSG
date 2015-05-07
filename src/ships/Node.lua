local class = require "lib.middleclass"

local Node = class('Node')

function Node:initialize(x, y, rotation)
    self.x = x or 0
    self.y = y or 0
    self.rotation = rotation or 0

    self.dockedShip = false
end

--TODO docking needs to check distance between ships and only allow
--     docking when close enough
function Node:dock(Ship)
    if self.dockedShip or Ship.dockedTo then
        error("Attempted to dock to Node with something already docked to it!")
    else
        self.dockedShip = Ship
        Ship.dockedTo = self

        Ship:setPosition(self.x, self.y, self.rotation)
    end
end

function Node:undock()
    if not self.dockedShip then
        error("Attempted to undock a ship from a Node with no docked ship.")
    else
        self.dockedShip.dockedTo = false
        self.dockedShip = false
    end
end

return Node
