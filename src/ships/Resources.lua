local class = require "lib.middleclass"

local Resources = class('Resources')

function Resources:initialize()
    self.ammo = 0
    self.fuel = 0
    self.supplies = 0
    self.water = 0
    self.food = 0
    self.metal = 0
    self.ore = 0
    self.crew = 0

    self.missiles = 0
    self.nukes = 0

    self.maxAmmo = 0
    self.maxFuel = 0
    self.maxSupplies = 0
    self.maxWater = 0
    self.maxFood = 0
    self.maxMetal = 0
    self.maxOre = 0
    self.maxCrew = 0

    self.ammoUse = 0
    self.fuelUseIdle = 0
    self.fuelUseMoving = 0
    self.fuelUseJump = 0
    self.suppliesUse = 0
    self.waterUse = 0
    self.foodUse = 0
    self.metalUse = 0
    self.oreUse = 0
    self.crewUse = 0
end

function Resources:update(dt, engineStatus)
    self.ammo = self.ammo - self.ammoUse * dt
    if engineStatus == "idle" then
        self.fuel = self.fuel - self.fuelUseIdle * dt
    elseif engineStatus == "moving" then
        self.fuel = self.fuel - self.fuelUseMoving * dt
    else
        error("Invalid engineStatus!")
    end
    self.supplies = self.supplies - self.suppliesUse * dt
    self.water = self.water - self.waterUse * dt
    self.food = self.food - self.foodUse * dt
    self.metal = self.metal - self.metalUse * dt
    self.ore = self.ore - self.oreUse * dt
    self.crew = self.crew - self.crewUse * dt

    --TODO check if running out of anything, and do whatever is appropriate
end

function Resources:maxEverything()
    self.ammo = self.maxAmmo
    self.fuel = self.maxFuel
    self.supplies = self.maxSupplies
    self.water = self.maxWater
    self.food = self.maxFood
    self.metal = self.maxMetal
    self.ore = self.maxOre
    self.crew = self.maxCrew
end

return Resources
