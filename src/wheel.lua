local verticalOffset = math.pi/2
local maxTime = 60

local segments = 60
local segmentRadius = math.pi*2 / segments

local dividerRadius = segmentRadius / 2

local lg = love.graphics

local function drawWheel(x, y, r, time)
    time = math.floor(33 - time)
    if time == 0 then time = 33 end

    lg.setColor(255, 102, 0)
    for i=1,time do
        lg.arc("fill", x, y, r, (i-1)*segmentRadius - verticalOffset, i*segmentRadius - dividerRadius - verticalOffset)
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
        lg.arc("fill", x, y, r/1.5, (i-1)*segmentRadius - verticalOffset, i*segmentRadius - dividerRadius - verticalOffset)
    end
    lg.setColor(0, 0, 0)
    lg.circle("fill", x, y, r/2)
    --]]

    --tmp, really each color-dependent section should do this itself!
    lg.setColor(255, 255, 255)
end

return drawWheel
