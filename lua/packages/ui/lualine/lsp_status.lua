local lsp_status = {}


-- Define function to get the LSP clients
function lsp_status.get_clients()
	return vim.lsp.get_active_clients()
end

-- Define function to update the LSP client list
function lsp_status.update_lsp_list(lsp_clients)
	local lsp_names = {}
	local lsp_ids = {}
	for _, client in ipairs(lsp_clients) do
		local lsp_name = client.name
		if lsp_name == "null-ls" or lsp_name == "dap" then
			lsp_name = "[" .. lsp_name .. "]"
		end
		table.insert(lsp_names, lsp_name)
		table.insert(lsp_ids, client.id)
	end
	return lsp_names, lsp_ids
end

-- Define function to remove disconnected LSP clients from the list
function lsp_status.remove_disconnected_clients(lsp_names, lsp_ids)
	for i = #lsp_names, 1, -1 do
		local client = vim.lsp.get_client_by_id(lsp_ids[i])
		if client == nil then
			table.remove(lsp_names, i)
			table.remove(lsp_ids, i)
		end
	end
	return lsp_names
end

-- Define function to get the LSP status
function lsp_status.get()
	local lsp_clients = lsp_status.get_clients()
	local lsp_names, lsp_ids = lsp_status.update_lsp_list(lsp_clients)
	lsp_status.remove_disconnected_clients(lsp_names, lsp_ids)
	local lsp_status = ""
	if #lsp_names > 0 then
		lsp_status = " LSP: " .. table.concat(lsp_names, ", ")
	end
	return lsp_status
end

return lsp_status
