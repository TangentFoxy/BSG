return function(x, y, rotation)
    local self = {}

    self.img = "viper"
    self.ox = 4.5
    self.oy = 7.5

    self.x = x or 0
    self.y = y or 0
    self.rotation = rotation or 0

    self.destination = {
        x = x or 0,
        y = y or 0
    }
    self.isMoving = false

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
    self.isDocked = false
    self.dockedTo = false
    self.dockedNode = false

    self.moveTo = function(self, x, y)
        if self.isDocked then
            self.dockedTo:undock(self.dockedNode)
        end
        self.destination.x = x
        self.destination.y = y
        self.isMoving = true
    end

    self.update = function(self, dt)
        -- check if moving, check our speed, see how far along the "line" we can go, go there
        -- if reached destination ... WELL SHIT DEST NEEDS TO BE ABLE TO KNOW IF IS SHIP OR WHATEVER
    end

    return self
end
