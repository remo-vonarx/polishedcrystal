BadgeNames:
    list_start
    li "Flügelorden"
    li "Insektorden"
    li "Basisorden"
    li "Phantomorden"
    li "Stahlorden"
    li "Faustorden"
    li "Eisorden"
    li "Drachenorden"
    li "Felsorden"
    li "Quellorden"
    li "Donnerorden"
    li "Farborden"
if DEF(FAITHFUL)
    li "Seelenorden"
    li "Sumpforden"
else
    li "Sumpforden"
    li "Seelenorden"
endc
    li "Vulkanorden"
    li "Erdorden"
    assert_list_length NUM_BADGES
