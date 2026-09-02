-- NvPak custom Mason registry (lua: scheme).
-- Shadows ONLY python-lsp-server to inject pylsp plugins as extra_packages
-- into the same Mason-managed venv. All other packages resolve from upstream.
return {
    ["python-lsp-server"] = "nvpak.mason_registry.python-lsp-server",
}
