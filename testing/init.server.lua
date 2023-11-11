local TestEZ = require(game:GetService("ReplicatedStorage")["justice-sdk"]["DevPackages"].testez) :: ModuleScript
local src = game:GetService("ReplicatedStorage")["justice-sdk"]["Packages"]["justice-sdk"] :: ModuleScript

TestEZ.TestBootstrap:run({ src })
