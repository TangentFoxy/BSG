--tmp
local inspect = require "lib.inspect"

local lg = love.graphics

local hx, hy = lg.getWidth() / 2, lg.getHeight() / 2
local scale = 8

local images = {}
local fleet = {}

local hud = require "hud"

local bsg = require "ships.bsg"
local viper = require "ships.viper"

--tmp
local selected

function love.load()
    lg.setDefaultFilter("linear", "nearest", 1)
    images.bsg = lg.newImage('img/bsg.png')
    images.viper = lg.newImage('img/viper.png')
    --tmp
    lg.setPointSize(10)
    lg.setPointStyle("rough")

    fleet[1] = bsg()
    for i=1,8 do
        local v = viper()
        table.insert(fleet, v)
        fleet[1]:dock(v, i)
    end
end

local timer = 0
local stats = {
    time = 60,
    ammo = 40,
    fuel = 55,
    supplies = 10,
    water = 30,
    food = 40,
    metal = 60,
    ore = 24
}
local function getStats()
    local ammo = 0
    local fuel = 0
    local supplies = 0
    local water = 0
    local food = 0
    local metal = 0
    local ore = 0

    local maxAmmo = 0
    local maxFuel = 0
    local maxSupplies = 0
    local maxWater = 0
    local maxFood = 0
    local maxMetal = 0
    local maxOre = 0

    for i=1,#fleet do
        ammo = ammo + fleet[i].Resources.ammo
        fuel = fuel + fleet[i].Resources.fuel
        supplies = supplies + fleet[i].Resources.supplies
        water = water + fleet[i].Resources.water
        food = food + fleet[i].Resources.food
        metal = metal + fleet[i].Resources.metal
        ore = ore + fleet[i].Resources.ore

        maxAmmo = maxAmmo + fleet[i].Resources.maxAmmo
        maxFuel = maxFuel + fleet[i].Resources.maxFuel
        maxSupplies = maxSupplies + fleet[i].Resources.maxSupplies
        maxWater = maxWater + fleet[i].Resources.maxWater
        maxFood = maxFood + fleet[i].Resources.maxFood
        maxMetal = maxMetal + fleet[i].Resources.maxMetal
        maxOre = maxOre + fleet[i].Resources.maxOre
    end

    ammo = ammo * 60 / maxAmmo
    fuel = fuel * 60 / maxFuel
    supplies = supplies * 60 / maxSupplies
    water = water * 60 / maxWater
    food = food * 60 / maxFood
    metal = metal * 60 / maxMetal
    ore = ore * 60 / maxOre

    if ammo > 0 and ammo < 1 then
        ammo = 1
    end
    if fuel > 0 and fuel < 1 then
        fuel = 1
    end
    if supplies > 0 and supplies < 1 then
        supplies = 1
    end
    if water > 0 and water < 1 then
        water = 1
    end
    if food > 0 and food < 1 then
        food = 1
    end
    if metal > 0 and metal < 1 then
        metal = 1
    end
    if ore > 0 and ore < 1 then
        ore = 1
    end

    return {
        ammo = math.floor(ammo),
        fuel = math.floor(fuel),
        supplies = math.floor(supplies),
        water = math.floor(water),
        food = math.floor(food),
        metal = math.floor(metal),
        ore = math.floor(ore)
    }
end
local timing = -60
function love.update(dt)
    timer = timer + dt
    if timer >= 1 then
        timer = timer - 1
        --stat = current * 60 / max
        stats = getStats()
        --[[
        stats = {
            time = math.random(0, 60),
            ammo = math.random(0, 60),
            fuel = math.random(0, 60),
            supplies = math.random(0, 60),
            water = math.random(0, 60),
            food = math.random(0, 60),
            metal = math.random(0, 60),
            ore = math.random(0, 60)
        }
        --]]
    end

    timing = timing + dt
    if timing >= 60 then
        timing = timing -120
    end

    stats.time = math.floor(timing) --TMP
end

function love.draw()
    lg.translate(hx, hy)

    lg.setColor(255, 255, 255)
    for i=1,#fleet do
        lg.draw(images[fleet[i].img], fleet[i].x * scale, fleet[i].y * scale, fleet[i].rotation, scale, scale, fleet[i].ox, fleet[i].oy)
    end

    --tmp
    if selected then
        lg.setColor(220, 180, 0)
        lg.point(selected.x * scale, selected.y * scale)
    end

    hud(stats)
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    end
end
