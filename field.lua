
local _sc = require("stone_colors")

local _f = {{},}

for y = 1, 6 do
    for x = 1, 12 do
        table.insert(_f[y], _sc.invis)
    end
    table.insert(_f, {})
end
table.remove(_f, #_f)

_f[1][1] = _sc.blue
_f[1][7] = _sc.orange
_f[3][3] = _sc.red
_f[3][9] = _sc.green
_f[6][4] = _sc.yellow
_f[6][11] = _sc.purple

return _f

