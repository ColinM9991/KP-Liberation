/*
    File: fn_getPlayerAllowedItems.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-09
    Last Update: 2022-08-10
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Retrieves a list of arsenal items that the player can use, based on their rank.
    
    Parameter(s):
        _forceUpdate - Whether or not the cache should be deleted to force an update to the players allowed items [BOOLEAN, defaults to FALSE]
    
    Returns:
        The arsenal items which the player is allowed to use
*/
params[
    ["_forceUpdate", false, [false]]
];

if (_forceUpdate && {!isNil "TVG_playerAllowedArsenalItems"}) then {
    TVG_playerAllowedArsenalItems = nil
};

if (!isNil "TVG_playerAllowedArsenalItems") exitWith {TVG_playerAllowedArsenalItems};
if (isNil "TVG_playerAllowedArsenalItems") then {TVG_playerAllowedArsenalItems = []};

private _rankRestrictions = [] call TVG_fnc_getRankRestrictedItems;

TVG_playerAllowedArsenalItems = TVG_playerArsenalItems select { !(_x in _rankRestrictions) };
TVG_playerAllowedArsenalItems