local class = require "lib.middleclass"

local Ship = require "ships.Ship"

local Viper = class('Viper', Ship)

function Viper:initialize(x, y, rotation)
    Ship.initialize(self, x, y, rotation)
    self.img = "viper"
    --offsets
    self.ox = 4.5
    self.oy = 7.5

    --[[
    self.selection = {
        w = 9,
        h = 15
    }
    --]]
    self.selection = {
        r = 5
    }

    self.Resources.maxAmmo = 1800 --10 shots per second? 5s per barrel
    self.Resources.maxFuel = 30000 --86400s = 1day, x = 1/2 day's thrust
    self.Resources.maxCrew = 1

    self.Resources.ammo = math.random(0, 20)
    self.Resources.fuel = math.random(120, 1500)

    self.Resources.fuelUseIdle = 0.09
    self.Resources.fuelUseMoving = 0.76
end

return Viper
