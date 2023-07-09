local function setup_mapping(cmp, cmp_mapping)
	cmp.setup({
		mapping = cmp_mapping,
	})
end

return { setup_mapping = setup_mapping }
