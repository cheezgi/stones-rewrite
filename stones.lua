-- external libraries
local ml = require("libs.ml")

-- internal libraries
require("stmt")
require("stack")

-- global variables
local syntax = require("syntax")

local stoneColors = syntax.stoneColors
local directions = syntax.directions
local numbers = syntax.numbers

function lex(lines) -- {{{
    local rawtokens = {}
    local tokens = {}

    -- split lines into whitespace
    for line in lines do
        for word in line:gmatch("([^%s]+)") do
            table.insert(rawtokens, word)
        end
    end

    -- convert raw tokens to real tokens
    for k, token in ipairs(rawtokens) do
        if token == "red" then
            table.insert(tokens, stoneColors.red)
        elseif token == "orange" then
            table.insert(tokens, stoneColors.orange)
        elseif token == "yellow" then
            table.insert(tokens, stoneColors.yellow)
        elseif token == "green" then
            table.insert(tokens, stoneColors.green)
        elseif token == "blue" then
            table.insert(tokens, stoneColors.blue)
        elseif token == "purple" then
            table.insert(tokens, stoneColors.purple)
        elseif token == "up" then
            table.insert(tokens, directions.up)
        elseif token == "down" then
            table.insert(tokens, directions.down)
        elseif token == "left" then
            table.insert(tokens, directions.left)
        elseif token == "right" then
            table.insert(tokens, directions.right)
        elseif token == "1" then
            table.insert(tokens, numbers.one)
        elseif token == "2" then
            table.insert(tokens, numbers.two)
        elseif token == "3" then
            table.insert(tokens, numbers.three)
        end
    end

    return tokens
end -- }}}

function parse(tokens) -- {{{
    local statements = {}
    local k = 1
    local i = 1

    -- oh boy - loop through list of tokens
    while i < #tokens do
        -- check if color
        if tokens[i].is_color then
            -- nil check
            if tokens[i + 1] then
                -- check if next is direction
                if tokens[i + 1].is_direction then
                    -- nil check
                    if tokens[i + 2] then
                        -- check if next is number
                        if tokens[i + 2].is_number then
                            -- check if orange/red - only colors that take magnitudes
                            if tokens[i] == stoneColors.red or tokens[i] == stoneColors.orange then
                                -- add statement
                                table.insert(statements, Statement.new(tokens[i], tokens[i + 1], tokens[i + 2], k))
                                i = i + 3
                                k = k + 1
                            else
                                error("Did not expect number for non orange/red in statement #" .. tostring(k))
                            end
                        else
                            -- if not a number, make sure it didn't need one
                            if tokens[i] == stoneColors.red or tokens[i] == stoneColors.orange then
                                error("Expected number for orange/red in statement #" .. tostring(k))
                            else
                                -- add statement
                                table.insert(statements, Statement.new(tokens[i], tokens[i + 1], nil, k))
                                i = i + 2
                                k = k + 1
                            end
                        end
                    else
                        -- last two tokens
                        if tokens[i] == stoneColors.red or tokens[i] == stoneColors.orange then
                            error("Expected number for orange/red in statement #" .. tostring(k))
                        else
                            table.insert(statements, Statement.new(tokens[i], tokens[i + 1], nil, k))
                        end
                        i = i + 1
                    end
                else
                    error("Expected direction after color in statement #" .. tostring(k))
                end
            else
                -- last tokens
                i = i + 1
            end
        else
            error("Expected color after statement #" .. tostring(k))
        end
    end

    return statements
end -- }}}

-- function eval(proc) {{{
local frames = {true}
local cf = #frames
local stack = Stack.new()
local field = require("field")
local nmove = 0
stack:push(1)
stack:push(1)
stack:push(1)
stack:push(1)

function eval(proc)
    for k, stmt in ipairs(proc) do
        if stmt.color == "red" then
            if frames[cf] then
                if stmt.direction == "up" then
                    if stmt.number == 1 then                                                          -- 0
                        if move(stoneColors.red, stmt.direction) then
                            stack:push(0)
                        end
                    elseif stmt.number == 2 then                                                      -- 4
                        for i = 1, 2 do
                            if move(stoneColors.red, stmt.direction) and i == 2 then
                                    stack:push(4)
                            end
                        end
                    elseif stmt.number == 3 then                                                      -- 8
                        for i = 1, 3 do
                            if move(stoneColors.red, stmt.direction) and i == 3 then
                                stack:push(8)
                            end
                        end
                    end
                elseif stmt.direction == "down" then
                    if stmt.number == 1 then                                                          -- 1
                        if move(stoneColors.red, stmt.direction) then
                            stack:push(1)
                        end
                    elseif stmt.number == 2 then                                                      -- 5
                        for i = 1, 2 do
                            if move(stoneColors.red, stmt.direction) and i == 2 then
                                    stack:push(5)
                            end
                        end
                    elseif stmt.number == 3 then                                                      -- 9
                        for i = 1, 3 do
                            if move(stoneColors.red, stmt.direction) and i == 3 then
                                stack:push(9)
                            end
                        end
                    end
                elseif stmt.direction == "left" then
                    if stmt.number == 1 then                                                          -- 2
                        if move(stoneColors.red, stmt.direction) then
                            stack:push(2)
                        end
                    elseif stmt.number == 2 then                                                      -- 6
                        for i = 1, 2 do
                            if move(stoneColors.red, stmt.direction) and i == 2 then
                                    stack:push(6)
                            end
                        end
                    elseif stmt.number == 3 then                                                      -- true
                        for i = 1, 3 do
                            if move(stoneColors.red, stmt.direction) and i == 3 then
                                stack:push(true)
                            end
                        end
                    end
                elseif stmt.direction == "right" then
                    if stmt.number == 1 then                                                          -- 3
                        if move(stoneColors.red, stmt.direction) then
                            stack:push(3)
                        end
                    elseif stmt.number == 2 then                                                      -- 7
                        for i = 1, 2 do
                            if move(stoneColors.red, stmt.direction) and i == 2 then
                                    stack:push(7)
                            end
                        end
                    elseif stmt.number == 3 then                                                      -- false
                        for i = 1, 3 do
                            if move(stoneColors.red, stmt.direction) and i == 3 then
                                stack:push(false)
                            end
                        end
                    end
                end
            end
        elseif stmt.color == "orange" then
            if frames[cf] then
                if stmt.direction == "up" then
                    if stmt.number == 1 then                                                          -- [
                        if move(stoneColors.orange, stmt.direction) then
                        end
                    elseif stmt.number == 2 then                                                      -- ==
                        for i = 1, 2 do
                            if move(stoneColors.orange, stmt.direction) and i == 2 then
                            end
                        end
                    end
                elseif stmt.direction == "down" then
                    if stmt.number == 1 then                                                          -- ]
                        if move(stoneColors.orange, stmt.direction) then
                        end
                    elseif stmt.number == 2 then                                                      -- <
                        for i = 1, 2 do
                            if move(stoneColors.orange, stmt.direction) and i == 2 then
                            end
                        end
                    end
                elseif stmt.direction == "left" then
                    if stmt.number == 1 then                                                          -- ,
                        if move(stoneColors.orange, stmt.direction) then
                        end
                    elseif stmt.number == 2 then                                                      -- >
                        for i = 1, 2 do
                            if move(stoneColors.orange, stmt.direction) and i == 2 then
                            end
                        end
                    end
                elseif stmt.direction == "right" then
                    if stmt.number == 1 then                                                          -- nth
                        if move(stoneColors.orange, stmt.direction) then
                        end
                    elseif stmt.number == 2 then                                                      -- nothing yet: gotos?
                        for i = 1, 2 do
                            if move(stoneColors.orange, stmt.direction) and i == 2 then
                            end
                        end
                    end
                end
            end
        elseif stmt.color == "yellow" then
            if frames[cf] then
                if move(stoneColors.yellow, stmt.direction) then
                    local lhs = stack:pop()
                    local rhs = stack:pop()
                    if type(lhs) ~= "number" or type(rhs) ~= "number" then
                        print("Cannot perform arithmetic on non-numbers at statement #" .. k)
                        os.exit(1)
                    end
                    if stmt.direction == "up" then                                                        -- *
                        stack:push(rhs * lhs)
                    elseif stmt.direction == "down" then                                                  -- +
                        stack:push(rhs + lhs)
                    elseif stmt.direction == "left" then                                                  -- -
                        stack:push(rhs - lhs)
                    elseif stmt.direction == "right" then                                                 -- /
                        stack:push(rhs / lhs)
                    end
                end
            end
        elseif stmt.color == "green" then
            if frames[cf] then
                if move(stoneColors.green, stmt.direction) then
                    if stmt.direction == "up" then                                                        -- roll
                        local depth = stack:pop()
                        local toroll = {}
                        if depth > #stack:get() then
                            print("Stack underflow")
                            os.exit(1)
                        end
                        for i = 1, depth do
                            table.insert(toroll, stack:pop())
                        end
                        reverse(toroll)
                        local top = table.remove(toroll)
                        table.insert(toroll, 1, top)
                        for k, v in ipairs(toroll) do
                            stack:push(v)
                        end
                    elseif stmt.direction == "down" then                                                  -- dup
                        local dup = stack:pop()
                        stack:push(dup)
                        stack:push(dup)
                    elseif stmt.direction == "left" then                                                  -- drop
                        stack:pop()
                    elseif stmt.direction == "right" then                                                 -- not
                        stack:push(not stack:pop()) -- boolean check?
                    end
                end
            end
        elseif stmt.color == "blue" then
            if frames[cf] then
                if move(stoneColors.blue, stmt.direction) then
                    if stmt.direction == "up" then                                                        -- print
                        io.write(tostring(stack:pop()))
                    elseif stmt.direction == "down" then                                                  -- input
                        stack:push(tonumber(io.read()))
                    elseif stmt.direction == "left" then                                                  -- printc
                        io.write(string.char(stack:pop()))
                        io.flush()
                    elseif stmt.direction == "right" then                                                 -- quine
                        io.write("blue right")
                        os.exit(0)
                    end
                end
            end
        elseif stmt.color == "purple" then
            if stmt.direction == "up" then                                                            -- if
                if frames[cf] then
                    if stack:pop() then
                        table.insert(frames, true)
                    else
                        table.insert(frames, false)
                    end
                    cf = cf + 1
                    move(stoneColors.purple, stmt.direction)
                end
            elseif stmt.direction == "down" then                                                      -- else
                frames[cf] = not frames[cf]
                move(stoneColors.purple, stmt.direction)
            elseif stmt.direction == "left" then                                                      -- while
                move(stoneColors.purple, stmt.direction)
            elseif stmt.direction == "right" then                                                     -- end
                table.remove(frames)
                cf = cf - 1
                move(stoneColors.purple, stmt.direction)
            end
        end

        if args.debug then
            if nmove > 0 then
                print("MOVE " .. nmove .. ":", stmt.color, stmt.direction, stmt.number, frames[cf], #frames)
            else
                print(k .. ":", stmt.color, stmt.direction, stmt.number, frames[cf], #frames)
            end
        end
        if args.stack then
            if nmove > 0 then
                print("MOVE " .. nmove .. ":", "stack:")
                for k,v in ipairs(stack:get()) do print(ml.tstring(v)) end
            else
                print(k, "stack:")
                for k,v in ipairs(stack:get()) do print(ml.tstring(v)) end
            end
        end
        if args.field then
            if nmove > 0 then
                print("MOVE " .. nmove .. ":", "field:")
                for y = 1, field.height do
                    for x = 1, field.width do
                        io.write(field[y][x].pname)
                    end
                    print("")
                end
            else
                print(k, "field:")
                for y = 1, field.height do
                    for x = 1, field.width do
                        io.write(field[y][x].pname)
                    end
                    print("")
                end
            end
        end
    end
end -- }}}

function move(stone, dir) -- {{{
    -- loop through rows
    for y, row in ipairs(field) do
        -- loop through columns
        for x, item in ipairs(row) do
            -- check for stone
            if field[y][x] == stone then
                -- check direction
                if dir == "up" then
                    -- check for wrapping around
                    if y ~= 1 then
                        -- check weight of stone
                        if field[y - 1][x].weight <= stone.weight then
                            -- check if stone is blocking
                            if field[y - 1][x] ~= stoneColors.invis then
                                -- move it out of the way
                                local tm = field[y - 1][x]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.up, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y - 1][x].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y - 1][x] = stone
                            end
                            return true
                        else
                            return false
                        end
                    else
                        if field[field.height][x].weight <= stone.weight then
                            -- wrap stone around
                            if field[field.height][x] ~= stoneColors.invis then
                                local tm = field[field.height][x]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.up, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[field.height][x].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[field.height][x] = stone
                            end
                            return true
                        else
                            return false
                        end
                    end
                elseif dir == "down" then
                    if y ~= field.height then
                        if field[y + 1][x].weight <= stone.weight then
                            if field[y + 1][x] ~= stoneColors.invis then
                                local tm = field[y + 1][x]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.down, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y + 1][x].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y + 1][x] = stone
                            end
                            return true
                        else
                            return false
                        end
                    else
                        if field[1][x].weight <= stone.weight then
                            if field[1][x] ~= stoneColors.invis then
                                local tm = field[1][x]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.down, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[1][x].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[1][x] = stone
                            end
                            return true
                        else
                            return false
                        end
                    end
                elseif dir == "left" then
                    if x ~= 1 then
                        if field[y][x - 1].weight <= stone.weight then
                            if field[y][x - 1] ~= stoneColors.invis then
                                local tm = field[y][x - 1]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.left, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y][x - 1].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y][x - 1] = stone
                            end
                            return true
                        else
                            return false
                        end
                    else
                        if field[y][field.width].weight <= stone.weight then
                            if field[y][field.width] ~= stoneColors.invis then
                                local tm = field[y][field.width]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.left, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y][field.width].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y][field.width] = stone
                            end
                            return true
                        else
                            return false
                        end
                    end
                elseif dir == "right" then
                    if x ~= field.width then
                        if field[y][x + 1].weight <= stone.weight then
                            if field[y][x + 1] ~= stoneColors.invis then
                                local tm = field[y][x + 1]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.right, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y][x + 1].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y][x + 1] = stone
                            end
                            return true
                        else
                            return false
                        end
                    else
                        if field[y][1].weight <= stone.weight then
                            if field[y][1] ~= stoneColors.invis then
                                local tm = field[y][1]
                                nmove = nmove + 1
                                eval({Statement.new(tm, directions.right, numbers.one)})
                                nmove = nmove - 1
                                move(tm, dir)
                            end
                            if field[y][1].weight <= stone.weight then
                                field[y][x] = stoneColors.invis
                                field[y][1] = stone
                            end
                            return true
                        else
                            return false
                        end
                    end
                end
            end
        end
    end
end -- }}}

function reverse(tbl) -- {{{
    for i = 1, math.floor(#tbl / 2) do
        tbl[i], tbl[#tbl - i - 1] = tbl[#tbl - i + 1], tbl[i]
    end
end -- }}}

function main()
    -- init arg parser
    local argparse = require("libs.argparse")
            ("stones", "Esoteric programming language")

    -- set up parser
    argparse:argument("file", "File to be interpreted")
    argparse:flag("-f --field", "Print field")
    argparse:flag("-d --debug", "Print debugging")
    argparse:flag("-s --stack", "Print stack")
    argparse:flag("-v --version", "Print version")

    -- get cmd line args
    args = argparse:parse()

    -- open file
    local file = io.open(args.file)
    if file == nil then
        print("File not found: " .. args.file)
        os.exit(1)
    end

    -- split into lines to be lexed
    local lines = file:lines()

    -- lex file into tokens
    local tokens = lex(lines)

    -- parse tokens into statements
    local proc = parse(tokens)

    -- evaluate statements
    eval(proc)
end

main()

