local logic = {}

        local money = 25000 --Player starts by having no money
        local incomeRate = 0 --Player starts by having to click
        logic.cash = 10
        local upgradeMultiplier = 1.2 -- How much the income rate increases per upgrade
        local upgradeCostMultiplier = 1.5 -- How much the upgrade cost increases per upgrade
        --local upgradeCost = 10-- Base price I've choosen for now
        logic.upgradeAmtIdle = 0 --Amout of upgrades the player has
        logic.upgradeAmtClick = 0 --Amout of upgrades the player has

        logic.mineTime = 1.5 -- will be in another folder, time between clicks and or automation. will change depending of the computer
        local isConnected = true --temporary, meaning it will stop calculating once the player leaves
        local bindMoney = game.ReplicatedStorage.Source.Events:FindFirstChild("BindUiMoney")
        local bindUpgrade = game.ReplicatedStorage.Source.Events:FindFirstChild("BindUpgrade")

        logic.baseCost = 
        {
            click = {
                m1 = {
                    initialPrice = 0;
                    upgradePrice = 20
                },
                m2 = {
                    initialPrice = 160,
                    upgradePrice = 250
                },
                m3 = {
                    initialPrice = 450,
                    upgradePrice = 600,
                },
                m4 = {
                    initialPrice = 450,
                    upgradePrice = 600,
                },
                m5 = {
                    initialPrice = 450,
                    upgradePrice = 600,
                }
            }
        }
       
        
        logic.multipliers = 
        {
            click = {
                m1 = { --Actually a more pts per Click
                    Value = 1,
                    mText = "Better Mineral Water",
                    UpgradeAmt = 0,
                },
                m2 = {
                    Value = 2,    --will be the click speed interval.
                    mText = "Faster Gardening Speed",
                    UpgradeAmt = 0,
                },
                m3 = {     --Is a Click Multiplier
                    Value = 1,
                    mText = "Add a decoration",
                    UpgradeAmt = 0,
                },
                m4 = {    --Is a Click Multiplier
                    Value = 1,
                    mText = "Add a decoration",
                    UpgradeAmt = 0,
                },
                m5 = {
                    Value = 1,
                    mText = "Add a decoration",
                    UpgradeAmt = 0,
                },
        
            },
            bees = {
                m1 = 1,
                m2 = 1,
                m3 = 1,
                m4 = 1,
                m5 = 1,
            }
        }
        
        function logic.enoughMoney(amt)
            if money >= amt then
                return true
            else
                return false
            end
        end
        
        function logic.reduceTime(amt)
            logic.mineTime = logic.mineTime - amt
        end

        function logic.round(amt)
            if amt%1 == 0 then
                amt = amt..".00"
            else
                amt = amt.."0"
            end
            return amt
        end
        function logic.giveBaseCost(item)
            return item.baseCost, item.baseUpgrade
        end
        function logic.displayMoney()
            return money
        end
        function logic.addMoney(amount)
            money = money + amount
            logic.cash = money + amount
            bindMoney:Fire(money)
        end

        function logic.addAllMultipliersFromtypeOf(multipliertypeOf)
            local count = 0
            for i, v in pairs(multipliertypeOf) do
                if string.len(i) < 4 then
                    count += v.Value
                end
            end
            return count
        end
        
        function logic.addAllMultipliers(multipliers)
            local count = 0
            for _,v in pairs(multipliers) do
                count += logic.addAllMultipliersFromtypeOf(v)
            end
            return count
        end
        
        function logic.getClickMult()
            local click = logic.multipliers.click
            return (click.m1.Value) * click.m3.Value * click.m4.Value
        end

        function logic.returnMultipliers(multipliers,typeOf,ID)
            logic.multipliers[typeOf]["m"..ID].Value = multipliers[typeOf]["m"..ID].Value
        end

        function logic.returnUpgradeCosts(costs,typeOf,ID)
                logic.baseCost[typeOf]["m"..ID].upgradePrice = costs[typeOf]["m"..ID].upgradePrice
        end
        function logic.getClickMoneyAmt()
            local total = logic.getClickMult()
            if total == 0 then return 1 end
            return total 
        end
        function logic.click()
            logic.addMoney(logic.getClickMoneyAmt())
        end
        
        

        -- Function to calculate the next upgrade cost
        function logic.nextMoneyUpgradeCost(baseCost, upgradeAmt)
            return baseCost * math.pow(upgradeCostMultiplier, upgradeAmt)
        end

        -- Function to calculate the next upgrade income
        function logic.nextMoneyUpgradeIncome(currentRate, upgradeAmt)
            return currentRate + (upgradeMultiplier * (upgradeAmt))
        end

        function logic.nextClickUpgradeCost(currentCost, amount)
            local total = currentCost + 0.5*amount
            return total
        end

        function logic.earnMoneyIdle()
            while isConnected do
                money = money + incomeRate
                print("Current Money: " .. money)
                task.wait(logic.mineTime) -- Wait for 1 second before adding more money
            end
        end
        function logic.addUpgradeIdle()
            if money >= upgradeCost then
                money = money - upgradeCost
                --upgradeCost = logic.nextMoneyUpgradeCost(upgradeCost)
                logic.upgradeAmtIDle = logic.upgradeAmtIdle + 1
                incomeRate = logic.nextMoneyUpgradeIncome(incomeRate)
                print("Upgraded! New Income Rate: " .. incomeRate .. " | New Upgrade Cost: " .. upgradeCost)
            else
                print("Not enough money to upgrade.")
            end
        end

        local function returnMultiplier(multiplier,ID)
            for i,m in pairs(multiplier) do
                if i == ("m"..ID) then
                    return m.Value
                end
            end
            --return nil
        end
        
        function logic.addMultiplierUpgrade(multiplier : number,upgradeAdd : number, upgradeMulti : number)
            local total = (multiplier + upgradeAdd) * (1 + upgradeMulti)
            print("total is "..total)
            return total
        end

        function logic.addUpgradeClick(price)
            if money >= price then
                money = money - price
                bindMoney:Fire(money)
            end
        end
        
        

        bindUpgrade.Event:Connect(function(price)
                logic.addUpgradeClick(price)
        end)
        
return logic