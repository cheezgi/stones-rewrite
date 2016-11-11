Statement = {}
Statement.__index = Statement

setmetatable(Statement, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function Statement.new(color, direction, number, id)
    local self = setmetatable({}, Statement)
    self.color = color.color
    self.direction = direction.name
    self.id = id
    if number then
        --self.number = number.value
        if number.value == "one" then self.number = 1 end
        if number.value == "two" then self.number = 2 end
        if number.value == "three" then self.numer = 3 end
    else
        self.number = nil
    end
    return self
end

