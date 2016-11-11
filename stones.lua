
-- external libraries
local microlight = require("libs.ml")

-- internal libraries
local syntax = require("syntax")
local field = require("field")
local frames = require("stack").new()

local stoneColors = syntax.stoneColors
local directions = syntax.directions
local numbers = syntax.numbers

function parse(tokens)
    local statements = {}
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
                  table.insert(statements, {tokens[i], tokens[i + 1], tokens[i + 2]})
                  i = i + 3
                else
                  error("Did not expect number for non orange/red")
                end
              else
                -- if not a number, make sure it didn't need one
                if tokens[i] == stoneColors.red or tokens[i] == stoneColors.orange then
                  error("Expected number for orange/red")
                else
                  -- add statement
                  table.insert(statements, {tokens[i], tokens[i + 1]})
                  i = i + 2
                end
              end
            else
              -- not really sure what to do here
              i = i + 1
            end
          else
            error("Expected direction after color")
          end
        else
          -- or here
          i = i + 1
        end
      end
    end

    for k,v in ipairs(statements) do
        print(microlight.tstring(v))
    end
end

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
    --print(microlight.tstring(tokens))
    local proc = parse(tokens)
end

main()

