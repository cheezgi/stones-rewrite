Stack = {}
Stack.__index = Stack

setmetatable(Stack, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function Stack.new()
    local self = setmetatable({}, Stack)
    self.table = {}
    return self
end

function Stack.get(self)
    return self.table
end

function Stack.push(self, val)
    table.insert(self.table, val)
end

function Stack.pop(self)
    return table.remove(self.table)
end

function Stack.last(self)
    return self.table[#self.table]
end

