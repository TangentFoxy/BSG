local class = require "lib.middleclass"

local Resources = require "ships.Resources"

local Ship = class('Ship')

function Ship:initialize(x, y, rotation)
    self.img = ""
    --offsets
    self.ox = 0
    self.oy = 0

    self.x = x or 0
    self.y = y or 0
    self.destination = {
        x = x or 0,
        y = y or 0
    }
    self.rotation = rotation or 0

    self.selection = {}

    self.node = {}

    self.dockedTo = false

    self.Resources = Resources()
end

function Ship:dock(targetShip, nodeIndex)
    if self.node[nodeIndex] then
        self.node[nodeIndex]:dock(targetShip)
    else
        error("Ship attempted to dock to non-existent Node.")
    end
end

function Ship:undock(nodeIndex)
    if self.node[nodeIndex] then
        self.node[nodeIndex]:undock()
    else
        --find which node "nodeIndex" is docked to
        for i=1,#self.node do
            if self.node[i].dockedShip == nodeIndex then
                self.node[i]:undock()
                return
            end
        end
        error("Ship attempted to undock from non-existent Node.")
    end
end

function Ship:dockTo(targetShip, nodeIndex)
    if targetShip.node[nodeIndex] then
        targetShip.node[nodeIndex]:dock(self)
    else
        error("Ship attempted to dock to non-existent Node.")
    end
end

function Ship:undockFromParent()
    self.dockedTo:undock(self)
end

function Ship:setPosition(x, y, rotation)
    self.x = x or self.x
    self.y = y or self.y
    self.rotation = rotation or self.rotation
end

function Ship:moveTo(x, y)
    if self.dockedTo then
        self:undockFromParent()
    end
    self.destination.x = x
    self.destination.y = y
end

function Ship:update(dt)
    --check our speed, see how far along the "line" we can go, go there
    -- if reached destination ... WELL SHIT DEST NEEDS TO BE ABLE TO KNOW IF IS SHIP OR WHATEVER
end

return Ship
