local idle = {}
idle.multipliers = 
{
    click = {
        m1 = { --Actually a more pts per Click
            Value = 0.5,
            mText = "Better Mineral Water",
            UpgradeAmt = 0,
            unitText = "$/Click"
        },
        m2 = {
            Value = 2,    --will be the click speed interval.
            mText = "Faster Gardening Speed",
            UpgradeAmt = 0,
            unitText = "sec/Click"
        },
        m3 = {     --Is a Click Multiplier
            Value = 1,
            mText = "Add a decoration",
            UpgradeAmt = 0,
            unitText = "x%/Click"
        },
        m4 = {
            Value = 1,
            mText = "Add a decoration",
            UpgradeAmt = 0,
            unitText = "x%/Click"

        },
        m5 = {
            Value = 1,
            mText = "Add a decoration",
            UpgradeAmt = 0,
            unitText = "x%/Click"
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
idle.costs = {
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
idle.clicktime = 4
idle.moneyPerClick = 1


return idle
