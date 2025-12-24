-- simple plural s function for localization
-- taken right from cryptid with a single change to support empty fields lol
function BundlesOfFun.pluralize(str, vars)
    local inside = str:match("<(.-)>") -- finds args
    local _table = {}
    if inside then
        for v in (inside .. ","):gmatch("([^,]*),") do -- adds args to array (capture empty fields too)
            table.insert(_table, v)
        end
        local num = vars[tonumber(string.match(str, ">(%d+)"))] -- gets reference variable
        if type(num) == "string" then
            num = (Big and to_number(to_big(num))) or num
        end
        if not num then
            num = 1
        end
        local plural = _table[1] -- default
        local checks = { [1] = "=" } -- checks 1 by default
        local checks1mod = false -- tracks if 1 was modified
        if #_table > 1 then
            for i = 2, #_table do
                local isnum = tonumber(_table[i])
                if isnum then
                    if not checks1mod then
                        checks[1] = nil
                    end -- dumb stuff
                    checks[isnum] = "<" .. (_table[i + 1] or "") -- do less than for custom values
                    if isnum == 1 then
                        checks1mod = true
                    end
                    i = i + 1
                elseif i == 2 then
                    checks[1] = "=" .. _table[i]
                end
            end
        end
        local function fch(str, c)
            return string.sub(str, 1, 1) == c -- gets first char and returns boolean
        end
        local keys = {}
        for k in pairs(checks) do
            table.insert(keys, k)
        end
        table.sort(keys, function(a, b)
            return a < b
        end)
        if not (tonumber(num) or is_number(num)) then
            num = 1
        end
        for _, k in ipairs(keys) do
            if fch(checks[k], "=") then
                if to_big(math.abs(math.abs(num) - k)) < to_big(0.001) then
                    return string.sub(checks[k], 2, -1)
                end
            elseif fch(checks[k], "<") then
                if to_big(num) < to_big(k - 0.001) then
                    return string.sub(checks[k], 2, -1)
                end
            end
        end
        return plural
    end
end