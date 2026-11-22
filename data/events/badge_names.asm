BadgeNames:
    list_start
    li "Flügel"
    li "Insekt"
    li "Basis"
    li "Phantom"
    li "Stahl"
    li "Faust"
    li "Eis"
    li "Drachen"
    li "Fels"
    li "Quell"
    li "Donner"
    li "Farb"
if DEF(FAITHFUL)
    li "Seelen"
    li "Sumpf"
else
    li "Sumpf"
    li "Seelen"
endc
    li "Vulkan"
    li "Erd"
    assert_list_length NUM_BADGES
