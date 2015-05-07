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

return function(stats)
    lg.setColor(255, 102, 0)
    if stats.time > 0 then
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

    lg.setColor(255, 0, 0)
    for i=1,stats.ammo do
        lg.arc("fill", x, y, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*3/5 + edge/2)

    lg.setColor(255, 255, 0)
    for i=1,stats.fuel do
        lg.arc("fill", x, y, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*2/5 + edge/2)

    lg.setColor(0, 0, 255)
    for i=1,stats.supplies do
        lg.arc("fill", x, y, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r*1/5 + edge/2)

    --[[
    1-4 on first dial, main dial
    5-8 on second dial

    1 Time     orange
    2 Ammo     red
    3 Fuel     yellow
    4 Supplies blue ?

    5 Water    teal ?
    6 Food     green
    7 Metal    silver
    8 Ore      brown
    ]]

    lg.setColor(0, 255, 255)
    for i=1,stats.water do
        lg.arc("fill", x2, y2, r, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*4/5 + edge/2)

    lg.setColor(0, 255, 0)
    for i=1,stats.food do
        lg.arc("fill", x2, y2, r*4/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*3/5 + edge/2)

    lg.setColor(100, 100, 100)
    for i=1,stats.metal do
        lg.arc("fill", x2, y2, r*3/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*2/5 + edge/2)

    lg.setColor(107, 66, 38)
    for i=1,stats.ore do
        lg.arc("fill", x2, y2, r*2/5 - edge/2, (i-1)*timeSegmentRadius - verticalOffset, i*timeSegmentRadius - timeDividerRadius - verticalOffset)
    end

    lg.setColor(0, 0, 0)
    lg.circle("fill", x2, y2, r*1/5 + edge/2)

    lg.setColor(255, 255, 255)
    lg.print(stats.time, x, y)
end
