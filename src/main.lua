--tmp
local inspect = require "lib.inspect"

local lg = love.graphics

local hx, hy = lg.getWidth() / 2, lg.getHeight() / 2
local scale = 8

local images = {}
local fleet = {}

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
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    end
end
