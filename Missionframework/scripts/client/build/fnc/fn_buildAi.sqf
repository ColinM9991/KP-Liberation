/*
    File: fn_buildAi.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-01
    Last Update: 2022-08-01
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Builds an individual AI unit.
    
    Parameter(s):
        _className      - Classname for the item to build           [ARRAY, defaults to []]
        _supplyCost     - How many supplies this item costs         [NUMBER, defaults to 0]
        _ammoCost       - How much ammo this item costs             [NUMBER, defaults to 0]
        _fuelCost       - How much fuel this item costs             [NUMBER, defaults to 0]
    
    Returns:
        NONE
*/
params[
    ["_className", "", [""]],
    ["_supplyCost", 0, [0]],
    ["_ammoCost", 0, [0]],
    ["_fuelCost", 0, [0]]
];

private _group = createGroup KPLIB_side_player;

[_className, getPos player, group player] call KPLIB_fnc_createManagedUnit;