/*
    File: fn_getRankRestrictedItems.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-08
    Last Update: 2022-08-11
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Retrieves the arsenal items that a user is unable to use due to higher rank restrictions.
    
    Parameter(s):
    
    Returns:
        Array of restricted items
*/

private _rank = [] call KPR_fnc_getRank;
private _restrictedItems = [];

{
    if(_x <= _rank) then { continue };

    _restrictedItems append _y;
} forEach TVG_itemRankRestrictions;

_restrictedItems apply {toLower _x}