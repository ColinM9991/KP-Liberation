/*
    File: fn_getRankRestrictedItems.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-08
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Retrieves the arsenal items that a user is unable to use due to higher rank restrictions.
    
    Parameter(s):
        _rank - The player rank [NUMBER, defaults to the current player rank]
    
    Returns:
        Array of restricted items
*/
params[
    ["_rank", -1, [-1]]
];

if(_rank isEqualTo -1) then { _rank = [] call KPR_fnc_getRank; };

private _restrictedItems = [];

{
    if(_x <= _rank) then { continue };

    _restrictedItems append _y;
} forEach TVG_itemRankRestrictions;

_restrictedItems apply {toLower _x}