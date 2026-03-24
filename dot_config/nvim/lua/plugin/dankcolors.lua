local spec_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

local function normalize_url(src)
	if type(src) == "string" and not src:match("^https?://") then
		return "https://github.com/" .. src
	end
	return src
end

local function apply_spec()
	local spec = dofile(spec_path)
	if not (spec and #spec > 0) then return end

	local pack_entries = {}
	for _, plugin in ipairs(spec) do
		local src = plugin[1] or plugin.src or plugin.url
		if src then
			local entry
			if plugin.version then
				entry = { src = normalize_url(src), version = plugin.version }
			else
				entry = normalize_url(src)
			end
			table.insert(pack_entries, entry)
		end
	end

	if #pack_entries > 0 then
		vim.pack.add(pack_entries)
	end

	for _, plugin in ipairs(spec) do
		if plugin.config then
			plugin.config()
		end
	end
end

apply_spec()
