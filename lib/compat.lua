-- semi-bignum compat
to_big = to_big or function(a)
    return a
end
lenient_bignum = lenient_bignum or function(a)
    return a
end
function is_number(x)
    if type(x) == "number" then
        return true
    end
    if type(x) == "table" and ((x.e and x.m) or (x.array and x.sign)) then
        return true
    end
    return false
end
