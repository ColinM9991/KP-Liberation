/*
    File: fn_buildSquad.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-01
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Builds the squad.
    
    Parameter(s):
        _className      - Classname for the item to build           [ARRAY, defaults to []]
        _supplyCost     - How many supplies this item costs         [NUMBER, defaults to 0]
        _ammoCost       - How much ammo this item costs             [NUMBER, defaults to 0]
        _fuelCost       - How much fuel this item costs             [NUMBER, defaults to 0]
    
    Returns:
        NONE
*/
params[
    ["_className", "", [[]]],
    ["_supplyCost", 0, [0]],
    ["_ammoCost", 0, [0]],
    ["_fuelCost", 0, [0]]
];

private _group = createGroup KPLIB_side_player;
private _localCap = [] call KPLIB_fnc_getLocalCap;

if ((unitcap + (count _className)) > _localCap) then {
    private _numberToBuild = _localCap - unitcap;

    _className resize _numberToBuild;

    hint "Couldn't build full squad due to unit cap";
};

{ [_x, getPos player, _group] call KPLIB_fnc_createManagedUnit; true } count _className;
