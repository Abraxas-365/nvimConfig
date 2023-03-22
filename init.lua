-- Get the environment variable for the desired configuration
local config_to_load = os.getenv("MY_NEOVIM_CONFIG")

if config_to_load == "config1" then
  require("abraxas.minimal_config")
elseif config_to_load == "config2" then
else
  -- Default configuration (your current configuration)
  require("abraxas.defult_config")
end
