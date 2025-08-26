/*
    File: fn_refreshArsenal.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-08
    Last Update: 2022-08-10
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Refreshes the arsenal items based on player rank restrictions.
        If Presets are disabled, this script does nothing.
    
    Parameter(s):
    
    Returns:
        NONE
*/
if (TVG_ranksAceArsenal) then {
    [TVG_arsenalStore, true, false] call ace_arsenal_fnc_removeVirtualItems;
} else {
    [TVG_arsenalStore, true] call BIS_fnc_removeVirtualWeaponCargo;
    [TVG_arsenalStore, true] call BIS_fnc_removeVirtualMagazineCargo;
    [TVG_arsenalStore, true] call BIS_fnc_removeVirtualItemCargo;
    [TVG_arsenalStore, true] call BIS_fnc_removeVirtualBackpackCargo;
};

private _allowedItems = [true] call TVG_fnc_getPlayerAllowedItems;

if (TVG_ranksAceArsenal) then {
    [TVG_arsenalStore, _allowedItems, false] call ace_arsenal_fnc_addVirtualItems;
} else {
    [TVG_arsenalStore, _allowedItems] call BIS_fnc_addVirtualWeaponCargo;
    [TVG_arsenalStore, _allowedItems] call BIS_fnc_addVirtualMagazineCargo;
    [TVG_arsenalStore, _allowedItems] call BIS_fnc_addVirtualItemCargo;
    [TVG_arsenalStore, _allowedItems] call BIS_fnc_addVirtualBackpackCargo;
};