/*
    File: fn_getBuildItemDetails.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Retrieves the name and icon for a build item

    Parameter(s):
        _className      - The classname of the menu item
        _prices         - The prices of the menu item

    Returns:
        An array of the item details
        [Name, Icon, [Supplies, Ammo, Fuel]]
*/

params[
    ["_className", "", [[], ""]],
    ["_itemIndex", -1, [-1]]    
];

private _getItemDisplayName = {
    switch (_className) do {
        case KPLIB_b_fobBox: {localize "STR_FOBBOX";};
        case KPLIB_b_arsenal: {if (KPLIB_param_mobileArsenal) then {localize "STR_ARSENAL_BOX";};};
        case KPLIB_b_mobileRespawn: {if (KPLIB_param_mobileRespawn) then {localize "STR_RESPAWN_TRUCK";};};
        case KPLIB_b_fobTruck: {localize "STR_FOBTRUCK";};
        case "Flag_White_F": {localize "STR_INDIV_FLAG";};
        case KPLIB_b_smallStorage: {localize "STR_SMALL_STORAGE";};
        case KPLIB_b_largeStorage: {localize "STR_LARGE_STORAGE";};
        case KPLIB_b_logiStation: {localize "STR_RECYCLE_BUILDING";};
        case KPLIB_b_airControl: {localize "STR_HELI_BUILDING";};
        case KPLIB_b_slotHeli: {localize "STR_HELI_SLOT";};
        case KPLIB_b_slotPlane: {localize "STR_PLANE_SLOT";};
        default {getText (configFile >> "cfgVehicles" >> _className >> "displayName");};
    };
};

private _getSquadDisplayName = {
    params["_itemIndex"];

    squads_names select _itemIndex;
};

private _displayName = "";
private _icon = "";

if(_className isEqualType []) then { 
    _displayName = [_itemIndex] call _getSquadDisplayName;
} else {
    _displayName = [_className] call _getItemDisplayName;
    _icon = getText (configFile >> "CfgVehicles" >> _className >> "icon");
    if (isText (configFile >> "CfgVehicleIcons" >> _icon)) then 
    {
        _icon = getText (configFile >> "CfgVehicleIcons" >> _icon);
    };
};

[_displayName, _icon]