--tmp
local inspect = require "lib.inspect"

local lg = love.graphics

local hx, hy = lg.getWidth() / 2, lg.getHeight() / 2
local scale = 2

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
    --lg.setPointStyle("rough") --WAS REMOVED IN 0.10, FIND ITS REPLACEMENT

    fleet[1] = bsg()
    for i=1,8 do
        local v = viper()
        table.insert(fleet, v)
        fleet[1]:dock(v, i)
        v.engineStatus = "off"
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
local timing = -33
local paused = false
function love.update(dt)
    if paused then return end
    dt = dt --* 10 --temporary accelerated
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
        --[[
        stats = {
            time = 0,
            ammo = 0,
            fuel = 0,
            supplies = 0,
            water = 0,
            food = 0,
            metal = 0,
            ore = 0
        }
        --]]
    end

    timing = timing + dt
    --[[
    if timing >= 121 then
        timing = timing -181+60-33
    end
    --]]

    stats.time = timing --TMP ?

    for i=1,#fleet do
        fleet[i]:update(dt)
    end
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

    ---[[temporary, raw Resource stats of Galactica
    local r = fleet[1].Resources
    lg.setColor(255, 255, 255)
    lg.print("Ammo:      " .. math.floor(r.ammo/r.maxAmmo*100) .. "% " .. r.ammo, -300, -200)
    lg.print("Fuel:        " .. math.floor(r.fuel/r.maxFuel*100) .. "% " .. r.fuel, -300, -190)
    lg.print("Supplies: " .. math.floor(r.supplies/r.maxSupplies*100) .. "% " .. r.supplies, -300, -180)
    lg.print("Food:       " .. math.floor(r.food/r.maxFood*100) .. "% " .. r.food, -300, -170)
    lg.print("Water:     " .. math.floor(r.water/r.maxWater*100) .. "% " .. r.water, -300, -160)
    lg.print("Metal:      " .. math.floor(r.metal/r.maxMetal*100) .. "% " .. r.metal, -300, -150)
    lg.print("Ore:         " .. math.floor(r.ore/r.maxOre*100) .. "% " .. r.ore, -300, -140)
    --]]

    --[[tmp, printing total time as hours/minutes/seconds]]
    lg.print("Time elapsed: " .. math.floor(timing/60/60) .. ":" .. math.floor(timing/60)%60 .. ":" .. math.floor(timing)%60, -300, -120)
    local result = 0
    for i=2,#fleet do
        result = result + fleet[i].Resources.fuel
    end
    lg.print("Viper fuel: " .. result, -300, -110)
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    elseif key == " " then
        paused = not paused
    end
end
