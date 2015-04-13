local bsg = require "ships.bsg"
local viper = require "ships.viper"

local lg = love.graphics

local images = {}
local ships = {}

local hx, hy = lg.getWidth() / 2, lg.getHeight() / 2

local scale = 8

local selected

function love.load()
    lg.setDefaultFilter("linear", "nearest", 1)
    images.bsg = lg.newImage('img/bsg.png')
    images.viper = lg.newImage('img/viper.png')
    lg.setPointSize(10)
    lg.setPointStyle("rough")

    ships[1] = bsg()
    for i=1,8 do
        local v = viper()
        table.insert(ships, v)
        ships[1]:dock(v, i)
    end
end

function love.draw()
    lg.translate(hx, hy)

    for i=1,#ships do
        lg.draw(images[ships[i].img], ships[i].x * scale, ships[i].y * scale, ships[i].rotation, scale, scale, ships[i].ox, ships[i].oy)
    end

    if selected then
        lg.setColor(220, 180, 0)
        lg.point(selected.x * scale, selected.y * scale)
        lg.setColor(255, 255, 255)
    end
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    end
end

local function pointInRadius(x, y, cx, cy, r)
    cx = cx * scale + hx
    cy = cy * scale + hy
    local dx = x - cx
    local dy = y - cy
    return r * scale >= math.sqrt(dx * dx + dy * dy)
end

local function pointInAABB(x, y, cx, cy, s, r)
    -- THIS IS HORRIBLY WRONG, FIX IT LATER
    --[[
    var x=((objects[i].x-objects[renderId].x)*Math.cos(rot)-(objects[i].y-objects[renderId].y)*Math.sin(rot))*scaleFactor;
    var y=((objects[i].x-objects[renderId].x)*Math.sin(rot)+(objects[i].y-objects[renderId].y)*Math.cos(rot))*scaleFactor;
    ]]
    local nx = (x - cx) * math.cos(r) - (y - cy) * math.sin(r)
    local ny = (x - cx) * math.sin(r) + (y - cy) * math.cos(r)
    x = nx
    y = ny
    cx = cx * scale + hx
    cy = cy * scale + hy
    return x >= cx - s.w * scale / 2 and x <= cx + s.w * scale / 2 and y >= cy - s.h * scale / 2 and y <= cy + s.h * scale / 2
end

function love.mousepressed(x, y, button)
    if button == "l" then
        for i=1,#ships do
            if ships[i].selection.r then
                if pointInRadius(x, y, ships[i].x, ships[i].y, ships[i].selection.r) then
                    -- selected
                    -- NOW CHECK IF HAS NODES AND IF WE ARE SELECTING A SHIP ON A NODE!
                    selected = {}
                    selected.x = ships[i].x
                    selected.y = ships[i].y
                end
            else
                if pointInAABB(x, y, ships[i].x, ships[i].y, ships[i].selection, ships[i].rotation) then
                    -- we are selecting it!
                    -- NOW CHECK IF HAS NODES AND IF WE ARE SELECTING A SHIP ON A NODE!
                    selected = {}
                    selected.x = ships[i].x
                    selected.y = ships[i].y
                end
            end
        end
    elseif button == "wd" then
        scale = scale * 1.1
    elseif button == "wu" then
        scale = scale * 0.9
    end
end
