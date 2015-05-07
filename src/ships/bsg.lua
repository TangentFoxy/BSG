math.randomseed(os.time())
math.random() math.random()

local class = require "lib.middleclass"

local Ship = require "ships.Ship"
local Node = require "ships.Node"
local ninety = 90 * math.pi / 180

local BSG = class('BSG', Ship)

function BSG:initialize(x, y, rotation)
    Ship.initialize(self, x, y, rotation)
    self.img = "bsg"
    --offsets
    self.ox = 31.5
    self.oy = 67

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

    self.Resources.maxAmmo = 1000000
    self.Resources.maxFuel = 1300000
    self.Resources.maxSupplies = 40000
    --what the fuck are jp's ?
    -- http://www.traditionaloven.com/culinary-arts/cooking/shortening/convert-japanese-cup-measure-of-shortening-to-fluid-ounce-floz-shortening.html
    -- From show "10 mil JPs water lost, almost 60%"
    self.Resources.maxWater = 16000000
    self.Resources.maxFood = 51000
    self.Resources.maxMetal = 80000
    --self.Resources.maxOre = 0
    self.Resources.maxCrew = 5100

    self.Resources.ammo = math.random(100, 1300)
    self.Resources.fuel = math.random(496000, 512000)
    self.Resources.supplies = math.random(18000,21000)
    self.Resources.water = math.random(14186500, 14989900)
    self.Resources.food = math.random(34700, 39200)
    self.Resources.metal = math.random(19200,21600)
    --self.Resources.ore = 0
    self.Resources.crew = math.random(2870, 2960)

    self.Resources.missiles = math.random(5, 11)
    --self.Resources.nukes = 0

    --self.Resources.ammoUse = 0
    -- a year is 31,556,900 seconds
    -- for 17 mil water to last ?
    --  How about 1 water per second?
    --   195 days
    self.Resources.fuelUseIdle = 0.04
    self.Resources.fuelUseMoving = 0.54
    self.Resources.fuelUseJump = 4000
    self.Resources.suppliesUse = 0.0013
    self.Resources.waterUse = 1
    -- 45k civs = 82+85+119+304 (590) tons food
    -- 2.5 mil JPs water
    --   these are per week numbers
    --    604800 seconds, 4.13 water per second
    -- 1 ton = 2000 pounds
    --  1180000 pounds / sec = 1.95 food per second
    self.Resources.foodUse = 0.099
    --self.Resources.metalUse = 0.002 -- this # assumes normal repairs, which I'm ignoring for this
    --self.Resources.oreUse = 0
    --self.Resources.crewUse = 0
end

return BSG
