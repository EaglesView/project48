local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")


local LogicModule = require(game.ReplicatedStorage.Source.Modules.LogicModule)

local floors = CollectionService:GetTagged("FloorClick")

for _, floor in pairs(floors) do
    if floor.ClickDetector then
        local click = floor.ClickDetector
        print("FloorDetector found in"..floor.Name)
        click.MouseClick:Connect(function()
            click.MaxActivationDistance = 0.1
            task.wait(LogicModule.mineTime)
            LogicModule.click()
            click.MaxActivationDistance = 100
        end)
    end
end


