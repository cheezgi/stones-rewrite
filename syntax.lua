-- stone colors, directions

Color = {}
Color.__index = Color
setmetatable(Color, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})
function Color.new(color, pname, weight)
    local self = setmetatable({}, Color)
    self.color = color
    self.pname = pname
    self.weight = weight
    self.is_color = true
    return self
end

Direction = {}
Direction.__index = Direction
setmetatable(Direction, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})
function Direction.new(name)
    local self = setmetatable({}, Direction)
    self.name = name
    self.is_direction = true
    return self
end

Number = {}
Number.__index = Number
setmetatable(Number, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})
function Number.new(value)
    local self = setmetatable({}, Number)
    self.value = value
    self.is_number = true
    return self
end

return {
    stoneColors = {
        red = Color.new("red",       "red--- ", 1),
        orange = Color.new("orange", "orange ", 2),
        yellow = Color.new("yellow", "yellow ", 3),
        green = Color.new("green",   "green- ", 4),
        blue = Color.new("blue",     "blue-- ", 5),
        purple = Color.new("purple", "purple ", 6),
        invis = Color.new("invis",   "------ ", 0),
    },
    directions = {
        up = Direction.new("up"),
        down = Direction.new("down"),
        left = Direction.new("left"),
        right = Direction.new("right"),
        none = Direction.new("none"),
    },
    numbers = {
        one = Number.new("one"),
        two = Number.new("two"),
        three = Number.new("three"),
    }
}
