local function calculate_item_order(item, ret, mod, order_prefix)
	if not item.order then
		item.order = 0
	end
	if ret.order then
		item.order = item.order + ret.order
	end
	if mod then
		item.order = item.order + 1e9
	end
	local order_field = order_prefix and (order_prefix .. "_order") or "cry_order"
	item[order_field] = item.order
	return item.order
end

local function process_item_order(item, ret, mod, object_buffer, order_prefix)
	if not item.take_ownership then
		local order = calculate_item_order(item, ret, mod, order_prefix)
		
		if not object_buffer[item.object_type] then
			object_buffer[item.object_type] = {}
		end
		object_buffer[item.object_type][#object_buffer[item.object_type] + 1] = item
	end
end

-- export functions for use in other mods
return {
	calculate_item_order = calculate_item_order,
	process_item_order = process_item_order,
}