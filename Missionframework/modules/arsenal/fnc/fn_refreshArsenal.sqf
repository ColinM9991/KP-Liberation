/*
    File: fn_refreshArsenal.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-08
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Refreshes the arsenal items based on player rank restrictions.
        If Presets are disabled, this script does nothing.
    
    Parameter(s):
    
    Returns:
        NONE
*/
if (TVG_ranksAceArsenal) then {
    [player, true, false] call ace_arsenal_fnc_removeVirtualItems;
} else {
    [missionNamespace, true] call BIS_fnc_removeVirtualWeaponCargo;
    [missionNamespace, true] call BIS_fnc_removeVirtualMagazineCargo;
    [missionNamespace, true] call BIS_fnc_removeVirtualItemCargo;
    [missionNamespace, true] call BIS_fnc_removeVirtualBackpackCargo;
};

private _allowedItems = [true] call TVG_fnc_getPlayerAllowedItems;

if (TVG_ranksAceArsenal) then {
    [player, _allowedItems, false] call ace_arsenal_fnc_addVirtualItems;
} else {
    [missionNamespace, _allowedItems] call BIS_fnc_addVirtualWeaponCargo;
    [missionNamespace, _allowedItems] call BIS_fnc_addVirtualMagazineCargo;
    [missionNamespace, _allowedItems] call BIS_fnc_addVirtualItemCargo;
    [missionNamespace, _allowedItems] call BIS_fnc_addVirtualBackpackCargo;
};