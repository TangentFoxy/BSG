local r = 75
local edge = 5

local x = -480 + r + edge
local y = 270 - r - edge

local x2 = 480 - r - edge
local y2 = 270 - r - edge

local verticalOffset = math.pi/2

local timeSegments = 60
local timeSegmentRadius = math.pi*2 / timeSegments
local timeDividerRadius = timeSegmentRadius / 2

local lg = love.graphics

--[[
local function brighten(color)
    if color[cycle] == true then
        if color[1] < 251 then
            color[1] = color[1] + 5
        else
            color[1] = 255
        end
        if color[2] < 251 then
            color[2] = color[2] + 5
        else
            color[2] = 255
        end
        if color[3] < 251 then
            color[3] = color[3] + 5
        else
            color[3] = 255
        end
        if color[1] == 255 and color[2] == 255 and color[3] == 255 then
            color[cycle] = false
        end
    else
        if color[1] > 4 then
            color[1] = color[1] - 5
        else
            color[1] = 0
        end
        if color[2] > 4 then
            color[2] = color[2] - 5
        else
            color[2] = 0
        end
        if color[3] > 4 then
            color[3] = color[3] - 5
        else
            color[3] = 0
        end
        if color[1] == 0 and color[2] == 0 and color[3] == 0 then
            color[cycle] = true
        end
    end
    lg.setColor(color)
    return color
end
--]]

return function(stats)
    --[[ for seeing warnings
    stats.ammo = 3
    stats.fuel = 2
    stats.supplies = 1
    stats.water = 4
    stats.food = 5
    stats.metal = 1
    stats.ore = 2
    --]]
    local tCalc = stats.time * 10
    stats.time = math.floor(stats.time)

    lg.setColor(10, 20, 30)
    for i=1,60 do
        lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end
    --local timeColor = {165, 52, 0, cycle = true}
    lg.setColor(165, 52, 0)
    if stats.time > 120 then
        lg.setColor(255, 210, 110)
        for i=1,60 do
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
        --lg.setColor(40, 60, 100)
        if tCalc%32 < 16 then
            lg.setColor(165, 52, 0)
        else
            lg.setColor(0, 45, 145)
        end
        --lg.setColor(0, 45, 145)
        for i=1,(stats.time-120)/5+1 do
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    elseif stats.time > 60 then
        for i=1,60 do
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
        lg.setColor(255, 210, 110)
        for i=1,stats.time-60 do
            --timeColor = brighten(timeColor)
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    elseif stats.time > 0 then
        for i=1,stats.time do
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    else
        for i=0,stats.time+1,-1 do
            lg.arc("fill", x, y, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*4/5 + edge/2)

    if stats.ammo < 2 then
        if tCalc%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x, y, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x, y, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.ammo < 6 then
        if tCalc%8 < 4 then
            lg.setColor(255, 0, 0)
            for i=1,stats.ammo do
                lg.arc("fill", x, y, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(255, 0, 0)
        for i=1,stats.ammo do
            lg.arc("fill", x, y, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*3/5 + edge/2)

    ---[[tmp to see warnings]] stats.fuel = 1
    if stats.fuel < 2 then
        if (tCalc+1)%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x, y, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x, y, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.fuel < 6 then
        if (tCalc+1)%8 < 4 then
            lg.setColor(255, 255, 0)
            for i=1,stats.fuel do
                lg.arc("fill", x, y, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(255, 255, 0)
        for i=1,stats.fuel do
            lg.arc("fill", x, y, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*2/5 + edge/2)

    ---[[tmp to see warnings]] stats.supplies = 1
    if stats.supplies < 2 then
        if (tCalc+2)%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x, y, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x, y, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.supplies < 6 then
        if (tCalc+2)%8 < 4 then
            lg.setColor(0, 255, 255)
            for i=1,stats.supplies do
                lg.arc("fill", x, y, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(0, 255, 255)
        for i=1,stats.supplies do
            lg.arc("fill", x, y, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*1/5 + edge/2)

    --[[
    1-4 on first dial, main dial
    5-8 on second dial

    1 Time     orange
    2 Ammo     red
    3 Fuel     yellow
    4 Supplies teal

    5 Water    blue
    6 Food     green
    7 Metal    silver
    8 Ore      brown
    ]]

    ---[[tmp to see warnings]] stats.water = 1
    if stats.water < 2 then
        if (tCalc+3)%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x2, y2, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x2, y2, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.water < 6 then
        if (tCalc+3)%8 < 4 then
            lg.setColor(0, 0, 255)
            for i=1,stats.water do
                lg.arc("fill", x2, y2, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(0, 0, 255)
        for i=1,stats.water do
            lg.arc("fill", x2, y2, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*4/5 + edge/2)

    ---[[tmp to see warnings]] stats.food = 1
    if stats.food < 2 then
        if tCalc%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x2, y2, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x2, y2, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.food < 6 then
        if tCalc%8 < 4 then
            lg.setColor(0, 160, 0)
            for i=1,stats.food do
                lg.arc("fill", x2, y2, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(0, 160, 0)
        for i=1,stats.food do
            lg.arc("fill", x2, y2, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*3/5 + edge/2)

    ---[[tmp to see warnings]] stats.metal = 1
    if stats.metal < 2 then
        if (tCalc+1)%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x2, y2, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x2, y2, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.metal < 6 then
        if (tCalc+1)%8 < 4 then
            lg.setColor(100, 100, 100)
            for i=1,stats.metal do
                lg.arc("fill", x2, y2, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(100, 100, 100)
        for i=1,stats.metal do
            lg.arc("fill", x2, y2, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*2/5 + edge/2)

    ---[[tmp to see warnings]] stats.ore = 1
    if stats.ore < 2 then
        if (tCalc+2)%4 < 2 then
            lg.setColor(10, 20, 30)
            for i=1,60 do
                lg.arc("fill", x2, y2, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(10, 20, 30)
        for i=1,60 do
            lg.arc("fill", x2, y2, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    if stats.ore < 7 then
        if (tCalc+2)%8 < 4 then
            lg.setColor(107, 66, 38)
            for i=1,stats.ore do
                lg.arc("fill", x2, y2, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
            end
        end
    else
        lg.setColor(107, 66, 38)
        for i=1,stats.ore do
            lg.arc("fill", x2, y2, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
        end
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*1/5 + edge/2)

    --lg.setColor(255, 255, 255)
    if stats.time < 0 then
        lg.setColor(255, 102, 0)
    elseif stats.time < 6 then
        if tCalc%4 < 2 then
            lg.setColor(255, 102, 0)
        else
            lg.setColor(255, 255, 255)
        end
    elseif stats.time < 31 then
        if tCalc%8 < 4 then
            lg.setColor(255, 102, 0)
        else
            lg.setColor(255, 255, 255)
        end
    else
        if tCalc%16 < 8 then
            lg.setColor(255, 255, 255)
        else
            lg.setColor(255, 210, 110)
            --lg.setColor(255, 102, 0)
        end
    end
    --stats.time = math.floor(stats.time)
    local font = lg.getFont();
    lg.print(stats.time, x - font:getWidth(stats.time)/2, y - font:getHeight()/2)
end
