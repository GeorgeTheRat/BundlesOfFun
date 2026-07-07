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
            num = (Big and tonumber(to_big(num))) or num
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
        local result = plural
        for _, k in ipairs(keys) do
            if fch(checks[k], "=") then
                if to_big(math.abs(math.abs(num) - k)) < to_big(0.001) then
                    result = string.sub(checks[k], 2, -1)
                    break
                end
            elseif fch(checks[k], "<") then
                if to_big(num) < to_big(k - 0.001) then
                    result = string.sub(checks[k], 2, -1)
                    break
                end
            end
        end
        -- process variables within the selected plural string
        if result and vars then
            for match in result:gmatch("#(%d+)#") do
                local var_idx = tonumber(match)
                if vars[var_idx] then
                    local formatted = format_ui_value(vars[var_idx])
                    result = result:gsub("#" .. match .. "#", formatted)
                end
            end
        end
        return result
    end
end

-- ordinal suffix function for localization (1st, 2nd, 3rd, etc.)
function BundlesOfFun.ordinalize(num)
    if type(num) == "string" then
        num = (Big and tonumber(to_big(num))) or tonumber(num)
    end
    num = tonumber(num) or 1
    
    local abs_n = math.abs(num)
    local last_two = abs_n % 100
    local last_one = abs_n % 10
    
    local suffix = "th"
    if last_two ~= 11 and last_two ~= 12 and last_two ~= 13 then
        if last_one == 1 then
            suffix = "st"
        elseif last_one == 2 then
            suffix = "nd"
        elseif last_one == 3 then
            suffix = "rd"
        end
    end
    
    return tostring(num) .. suffix
end
-- wrapper to detect <o> prefix and call ordinalize
function BundlesOfFun.process_ordinal(str, vars)
    local inside = str:match("<(.-)>")
    if inside and inside == "o" then
        local num_str = string.match(str, ">(%d+)")
        if num_str then
            local num = vars[tonumber(num_str)]
            return BundlesOfFun.ordinalize(num)
        end
    end
    return nil
end