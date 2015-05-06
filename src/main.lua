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

local timer = 0
function love.update(dt)
    timer = timer + dt
    if timer >= 33 then
        timer = timer - 33
    end
end

local function drawClock(x, y, r)
    local time = math.floor(33 - timer)
    if time == 0 then time = 33 end

    local maxTime = 33

    local segments = 33
    local segmentRadius = math.pi*2 / segments
    local dividerRadius = segmentRadius / 2
    --local time = 33

    lg.setColor(255, 102, 0)
    for i=1,time do
        lg.arc("fill", x, y, r, (i-1)*segmentRadius - math.pi/2, i*segmentRadius - dividerRadius - math.pi/2)
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r/1.15)

    -- this looks cool and all, but it is the same function as the outer ring
    -- instead, use this internal space for displaying things like fuel and water and supplies
    --[[
    segments = 12
    segmentRadius = math.pi*2 / segments
    dividerRadius = segmentRadius / segments * 2
    time = math.floor(time/maxTime * segments) --33 -> 12   percentage = time/maxTime..multiply this by 12

    lg.setColor(255, 102, 0)
    for i=1,time do
        lg.arc("fill", x, y, r/1.5, (i-1)*segmentRadius - math.pi/2, i*segmentRadius - dividerRadius - math.pi/2)
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r/2)
    --]]

    --tmp, really each color-dependent section should do this itself!
    lg.setColor(255, 255, 255)
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

    drawClock(-355, -145, 120)
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
        if selected then
            -- find out where this actually is, now the ship selected is ordered to move to this point
            selected.ship:moveTo(x * scale + hx, y * scale + hy)
        else
            for i=1,#ships do
                if ships[i].selection.r then
                    if pointInRadius(x, y, ships[i].x, ships[i].y, ships[i].selection.r) then
                        -- selected
                        -- NOW CHECK IF HAS NODES AND IF WE ARE SELECTING A SHIP ON A NODE!
                        selected = {}
                        selected.ship = ships[i]
                        selected.x = ships[i].x
                        selected.y = ships[i].y
                    end
                else
                    if pointInAABB(x, y, ships[i].x, ships[i].y, ships[i].selection, ships[i].rotation) then
                        -- we are selecting it!
                        -- NOW CHECK IF HAS NODES AND IF WE ARE SELECTING A SHIP ON A NODE!
                        selected = {}
                        selected.ship = ships[i]
                        selected.x = ships[i].x
                        selected.y = ships[i].y
                    end
                end
            end
        end
    elseif button == "wd" then
        scale = scale * 1.1
    elseif button == "wu" then
        scale = scale * 0.9
    end
end
