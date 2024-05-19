local CollectionService = game:GetService("CollectionService")
local Logic = require(game.ReplicatedStorage.Source.Modules.LogicModule)
local player = game.Players.LocalPlayer

local playerGui = player.PlayerGui
local idle = require(player.PlayerScripts.Player.IdleModule)

local gui = playerGui:WaitForChild("GUI_MASTER")
local text = gui.GUI_ELEMS.moneyLabel
text.Text = Logic.cash
local repStoreSource = game.ReplicatedStorage.Source
local bindMoney = repStoreSource.Events:FindFirstChild("BindUiMoney")
local bindClick = repStoreSource.Events:FindFirstChild("BindClick")
local bindUpgrade = repStoreSource.Events:FindFirstChild("BindUpgrade")
local upgradeBtns = CollectionService:GetTagged("GUI_upgradeItem")
local function initBtns()
    for i, btn in pairs(upgradeBtns) do
        local upgradebtn = btn.upgradeButton
        local ID = upgradebtn:GetAttribute("MultiplierID")
        local typeOf = upgradebtn:GetAttribute("Type")
        local priceTag = btn.upgradePriceLabel
        local amtTag = btn.upgradeDescriptionLabel
        local amt = Logic.round(idle.costs[typeOf]["m"..ID].upgradePrice)
        priceTag.Text = amt.." $"
        amtTag.Text = idle.multipliers[typeOf]["m"..ID].mText.."(x"..idle.multipliers[typeOf]["m"..ID].UpgradeAmt..")"
    end
end
initBtns()
for _, btn in pairs(upgradeBtns) do
    local questionbtn = btn.informationQuestion
    local upgradebtn = btn.upgradeButton
    upgradebtn.Activated:Connect(function()
        local ID = upgradebtn:GetAttribute("MultiplierID")
        local typeOf = upgradebtn:GetAttribute("Type")
        
        local priceTag = btn.upgradePriceLabel
        local amtTag = btn.upgradeDescriptionLabel
        print("button "..ID)
        print("type "..typeOf)
        local price = idle.costs[typeOf]["m"..ID].upgradePrice
        if Logic.enoughMoney(price) then
            bindUpgrade:Fire(price)
            idle.costs[typeOf]["m"..ID].upgradePrice = Logic.nextClickUpgradeCost(price,idle.multipliers[typeOf]["m"..ID].UpgradeAmt)
            idle.multipliers[typeOf]["m"..ID].UpgradeAmt += 1
            if ID == 2 and typeOf == "click" then
                Logic.reduceTime(0.01)
                print("New time : "..Logic.mineTime)
            else
                idle.multipliers[typeOf]["m"..ID].Value = Logic.addMultiplierUpgrade(idle.multipliers[typeOf]["m"..ID].Value ,0.5,0)

                Logic.returnMultipliers(idle.multipliers,typeOf,ID)
                btn.upgradeValueLabel.Text = Logic.getClickMoneyAmt().."$/Click"

            end
            --Logic.returnUpgradeCosts(idle.costs,typeOf,ID)
            local amt = (math.round(idle.costs[typeOf]["m"..ID].upgradePrice * 100)/100)
            print(amt)
            amt = Logic.round(amt)
            priceTag.Text = amt.." $"
            amtTag.Text = idle.multipliers[typeOf]["m"..ID].mText.."(x"..idle.multipliers[typeOf]["m"..ID].UpgradeAmt..")"
            print("Upgrade cost    : "..idle.costs[typeOf]["m"..ID].upgradePrice)
            
        else
            print("Not Enough Money!!")
        end
        
    end)
end

local function updateText(string,textL)
    textL.Text = (math.round(string * 100)/100).." $"
end






bindMoney.Event:Connect(function(amount)
    updateText(amount,text)
end)

