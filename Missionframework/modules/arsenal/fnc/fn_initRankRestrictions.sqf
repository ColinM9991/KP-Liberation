/*
    File: fn_initRankRestrictions.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-09
    Last Update: 2022-08-11
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Initializes the rank restrictions functionality.
        Adds the relevant event handlers to ensure the players gear is updated when they're promoted/demoted, and to ensure gear is removed from the player.
    
Parameter(s):
    _allItems       - All of the items that will, or should be available to all players excluding any class restrictions.                                                                               [ARRAY, defaults to []]
    _arsenalItems   - The items that will be added to a players arsenal. Separate from _allItems since a players items could be further restricted based on their current class (AT, Medic, Infantry)   [ARRAY, defaults to []]
    _arsenalStore   - The object that the arsenal should be attached to. This can be a physical box or it can be the missionNamespace to attach it to all arsenal boxes or inits.                       [Namespace or Object, defaults to missionNamespace]
    _useAceArsenal  - Whether or not the ACE arsenal functions should be used.                                                                                                                          [BOOLEAN, defaults to true]

    Returns:
        NONE
*/
params[
    ["_allItems", [], [[]]],
    ["_useAceArsenal", true, [true]],
    ["_arsenalItems", [], [[]]],
    ["_arsenalStore", missionNamespace, [missionNamespace, objNull]]
];

// Valid data hasn't been supplied, nothing to do.
if(_allItems isEqualTo [] && _arsenalItems isEqualTo []) exitWith {};

if (!isDedicated && hasInterface) then {

    // If _arsenalItems hasn't been supplied, assume there are no class restrictions and use the full arsenal list.
    if(_arsenalItems isEqualTo []) then {
        _arsenalItems = _allItems;
    };

    // TODO: Test the implication of using missionNamespace with ACE Arsenal
    if(_useAceArsenal && _arsenalStore isEqualTo missionNamespace) then {
        _arsenalStore = player;
    };

    // Assign global variables that are scoped the player
    // Ideally these would be handled on the server but some of them can be quite large, particularly the arrays.
    TVG_ranksAceArsenal = _useAceArsenal;
    TVG_ranksArsenalItems = _allItems;
    TVG_playerArsenalItems = _arsenalItems;
    TVG_arsenalStore = _arsenalStore;

    // Populate the arsenal
    [] call TVG_fnc_refreshArsenal;

    // Gear Validation Event Handlers
    player addEventHandler["InventoryClosed", {
        [] call TVG_fnc_checkGear;
    }];

    if(_useAceArsenal) then {
        ["ace_arsenal_displayClosed", {
            [backpack player] call TVG_fnc_checkGear;
        }] call CBA_fnc_addEventHandler;
    } else {
        [missionNamespace, "arsenalClosed", {
            [backpack player] call TVG_fnc_checkGear;
        }] call BIS_fnc_addScriptedEventHandler;
    };

    // Arsenal Refresh Event Handlers
    ["TVG_rankItemsUpdated", {
        [] call TVG_fnc_refreshArsenal;
    }] call CBA_fnc_addEventHandler;

    ["KPR_event_playerRankChanged", {
        [] call TVG_fnc_refreshArsenal;
    }] call CBA_fnc_addEventHandler;
    
    // ACE Action for Admins
    _action = [
        "KPR_ArsenalManage", 
        "KPR Arsenal Management",
        "",
        {
            [] call TVG_fnc_openItemRanksDialog;
        },
        {
            KPR_isAdmin
        }] call ace_interact_menu_fnc_createAction;
    
    [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin"], _action] call ace_interact_menu_fnc_addActionToClass;  
}

