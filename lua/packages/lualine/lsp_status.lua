local lsp_status = {}

-- Define function to get the LSP clients
function lsp_status.get_clients()
	return vim.lsp.get_active_clients()
end

function lsp_status.get_attached_null_ls_sources()
	local null_ls_sources = require("null-ls").get_sources()
	local ret = {}
	for _, source in pairs(null_ls_sources) do
		if source.filetypes[vim.bo.ft] then
			if not vim.tbl_contains(ret, source.name) then
				table.insert(ret, source.name)
			end
		end
	end
	return ret
end

-- Define function to update the LSP client list
-- Define function to update the LSP client list
function lsp_status.update_lsp_list(lsp_clients)
	local lsp_names = {}
	local lsp_ids = {}
	local unique_lsp_names = {}
	for _, client in ipairs(lsp_clients) do
		local lsp_name = client.name
		if lsp_name == "null-ls" then
			for _, source in pairs(lsp_status.get_attached_null_ls_sources()) do
				local null_ls_lsp_name = source .. "[Null-ls]"
				if not unique_lsp_names[null_ls_lsp_name] then
					lsp_names[#lsp_names + 1] = null_ls_lsp_name
					unique_lsp_names[null_ls_lsp_name] = true
				end
			end
		else
			if not unique_lsp_names[lsp_name] then
				lsp_names[#lsp_names + 1] = lsp_name
				unique_lsp_names[lsp_name] = true
			end
		end
		lsp_ids[#lsp_ids + 1] = client.id
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
	local lsp_sarver_status = " "
	if #lsp_names > 0 then
		lsp_sarver_status = " LSP: " .. table.concat(lsp_names, ", ")
	else
		lsp_sarver_status = "No Active LSP"
	end
	return lsp_sarver_status
end

return lsp_status
