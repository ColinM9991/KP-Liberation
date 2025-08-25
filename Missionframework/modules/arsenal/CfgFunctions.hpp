/*
    File: CfgFunctions.hpp
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-06
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
*/
class ItemRanks {
    file = "modules\arsenal\fnc";
    
    // Initialization
    class itemRanksPreInit {
        preInit = 1;
    };

    // UI Functions
    class addOrRemoveAssignment     {};
    class assignOrUnassignItem      {};
    class checkGear                 {};
    class checkWeaponCargo          {};
    class filterRanks               {};
    class filterRankItems           {};
    class getAllRankAssignments     {};
    class getCategorisedItems       {};
    class getCategoryItems          {};
    class getItemDisplay            {};
    class getPlayerAllowedItems     {};
    class getRankRestrictedItems    {};
    class getWeaponComponents       {};
    class initRankRestrictions      {};
    class isRadio                   {};
    class openItemRanksDialog       {};
    class refreshArsenal            {};
    class removeItemFromRank        {};
    class saveRankItemsClient       {};
    class saveRankItemsServer       {};
}