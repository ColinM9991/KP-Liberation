/*
    File: fn_saveRankItemsServer.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-07
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
	["_rankUpdates", [], [createHashMap]]
];

if (!isServer) exitWith{};

TVG_itemRankRestrictions = _rankUpdates;

profileNamespace setVariable ["TVG_itemRankRestrictions", TVG_itemRankRestrictions];
saveProfileNamespace;

publicVariable "TVG_itemRankRestrictions";

["TVG_rankItemsUpdated"] call CBA_fnc_globalEvent;