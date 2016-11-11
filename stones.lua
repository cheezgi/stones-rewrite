
-- external libraries
local microlight = require("libs.ml")

-- internal libraries
require("stmt")
require("stack")
local syntax = require("syntax")
local field = require("field")
local frames = Stack.new()

local stoneColors = syntax.stoneColors
local directions = syntax.directions
local numbers = syntax.numbers

function lex(lines)
    local rawtokens = {}
    local tokens = {}

    for line in lines do
        for word in line:gmatch("([^%s]+)") do
            table.insert(rawtokens, word)
        end
    end

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
end

function parse(tokens)
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
                        -- not really sure what to do here
                        i = i + 1
                    end
                else
                    error("Expected direction after color in statement #" .. tostring(k))
                end
            else
                -- or here
                i = i + 1
            end
        end
    end

    return statements
end

function eval(proc)
    for k, stmt in ipairs(proc) do
        if stmt.color == "red" then
            if stmt.direction == "up" then
                if stmt.number == 1 then             -- 0
                elseif stmt.number == 2 then         -- 4
                else                                 -- 8
                end
            elseif stmt.direction == "down" then
                if stmt.number == 1 then             -- 1
                elseif stmt.number == 2 then         -- 5
                else                                 -- 9
                end
            elseif stmt.direction == "left" then
                if stmt.number == 1 then             -- 2
                elseif stmt.number == 2 then         -- 6
                else                                 -- true
                end
            elseif stmt.direction == "right" then
                if stmt.number == 1 then             -- 3
                elseif stmt.number == 2 then         -- 7
                else                                 -- false
                end
            end
        elseif stmt.color == "orange" then
            if stmt.direction == "up" then
                if stmt.number == 1 then             -- [
                elseif stmt.number == 2 then         -- ==
                end
            elseif stmt.direction == "down" then
                if stmt.number == 1 then             -- ]
                elseif stmt.number == 2 then         -- <
                end
            elseif stmt.direction == "left" then
                if stmt.number == 1 then             -- ,
                elseif stmt.number == 2 then         -- >
                end
            elseif stmt.direction == "right" then
                if stmt.number == 1 then             -- nth
                elseif stmt.number == 2 then         -- nothing yet: gotos?
                end
            end
        elseif stmt.color == "yellow" then
            if stmt.direction == "up" then           -- *
            elseif stmt.direction == "down" then     -- +
            elseif stmt.direction == "left" then     -- -
            elseif stmt.direction == "right" then    -- /
            end
        elseif stmt.color == "green" then
            if stmt.direction == "up" then           -- roll
            elseif stmt.direction == "down" then     -- dup
            elseif stmt.direction == "left" then     -- drop
            elseif stmt.direction == "right" then    -- not
            end
        elseif stmt.color == "blue" then
            if stmt.direction == "up" then           -- print
            elseif stmt.direction == "down" then     -- input
            elseif stmt.direction == "left" then     -- printc
            elseif stmt.direction == "right" then    -- quine
            end
        elseif stmt.color == "purple" then
            if stmt.direction == "up" then           -- if
            elseif stmt.direction == "down" then     -- else
            elseif stmt.direction == "left" then     -- while
            elseif stmt.direction == "right" then    -- end
            end
        end
    end
end

function main()
    local argparse = require("libs.argparse")
            ("stones", "Esoteric programming language")

    -- get command line arguments
    argparse:argument("file", "File to be interpreted")
    argparse:flag("-f --field", "Print field")
    argparse:flag("-r --frames", "Print frames")
    argparse:flag("-d --debug", "Print debugging")
    argparse:flag("-s --stack", "Print stack")
    argparse:flag("-v --version", "Print version")

    local args = argparse:parse()

    local file = io.open(args.file)

    if file == nil then
        print("File not found: " .. args.file)
        os.exit(1)
    end

    local lines = file:lines()

    local tokens = lex(lines)
    local proc = parse(tokens)
    --eval(proc)
    for k,v in ipairs(proc) do print(microlight.tstring(v)) end
end

main()

