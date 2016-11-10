
-- external libraries
local microlight = require("libs.microlight")
local argparse = require("libs.argparse")
        ("stones", "Esoteric programming language")

-- internal libraries
local syntax = require("syntax")
local field = require("field")

local stoneColors = syntax.stoneColors
local directions = syntax.directions

argparse:argument("file", "File to be interpreted")
parser:flag("-f --field", "Print field")
parser:flag("-r --frames", "Print frames")
parser:flag("-d --debug", "Print debugging")
parser:flag("-s --stack", "Print stack")
parser:flag("-v --version", "Print version")

