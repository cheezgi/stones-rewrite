
local _sc = require("syntax").stoneColors

local _f = {{},}

for y = 1, 6 do
    for x = 1, 12 do
        table.insert(_f[y], _sc.invis)
    end
    table.insert(_f, {})
end
table.remove(_f, #_f)

--_f[1][1] = _sc.blue
--_f[1][7] = _sc.orange
--_f[3][3] = _sc.red
--_f[3][9] = _sc.green
--_f[5][5] = _sc.yellow
--_f[5][11] = _sc.purple

_f[3][2] = _sc.red
_f[3][3] = _sc.orange
_f[3][4] = _sc.yellow
_f[3][5] = _sc.green
_f[3][6] = _sc.blue
_f[3][7] = _sc.purple

_f.width = 12
_f.height = 6

return _f

