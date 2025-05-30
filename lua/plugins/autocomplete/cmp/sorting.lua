local function setup_sorting(cmp, compare)
	cmp.setup({
		sorting = {
			priority_weight = 1.0,
			comparators = {
				compare.offset, -- prioritizes items closer to the cursor
				compare.exact, -- prioritizes items starting with exactly the same prefix
				compare.score, -- prioritizes item similarity score
				compare.recently_used, -- prioritizes recently used items
				compare.kind, -- prioritizes items with the same kind
				compare.sort_text, -- prioritizes prefix matches within completion items
				compare.length, -- prioritizes shorter completion items
				compare.order, -- prioritizes items in the same received order
			},
			debug = {
				priority = true,
			},
		},
	})
end

return { setup_sorting = setup_sorting }
