/*
    File: fn_initRankRestrictions.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-09
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        NONE
*/
params[
    ["_arsenalItems", [], [[]]],
    ["_useAceArsenal", true, [true]]
];

if (isServer) then {
    TVG_ranksArsenalInitialized = true;
    TVG_ranksAceArsenal = _useAceArsenal;

    publicVariable "TVG_ranksArsenalInitialized";
    publicVariable "TVG_ranksAceArsenal";
};

if (!isDedicated && hasInterface) then {
    TVG_ranksArsenalItems = _arsenalItems;

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
            KPR_isAdmin && TVG_ranksArsenalInitialized
        }] call ace_interact_menu_fnc_createAction;
    
    [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin"], _action] call ace_interact_menu_fnc_addActionToClass;  
}

