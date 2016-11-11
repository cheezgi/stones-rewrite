-- stone colors, directions

Color = {}
Color.__index = Color
setmetatable(Color, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})
function Color.new(color)
    local self = setmetatable({}, Color)
    self.color = color
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
        red = Color.new("red"),
        orange = Color.new("orange"),
        yellow = Color.new("yellow"),
        green = Color.new("green"),
        blue = Color.new("blue"),
        purple = Color.new("purple"),
        invis = Color.new("invis"),
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
