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
    self.last = nil
    return self
end

function Stack:get()
    return self.table
end

function Stack:push(val)
    table.insert(self.table, val)
    self.last = self.table[#self.table]
end

function Stack:pop()
    self.last = self.table[#self.table - 1]
    return table.remove(self.table)
end

function Stack:last()
    return self.table[#self.table]
end

