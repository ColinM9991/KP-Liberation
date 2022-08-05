/*
    File: fn_addOrRemoveAssignment.sqf
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
    ["_selectedRank", -1, [-1]],
    ["_value", "", [""]],
    ["_isUnassign", false, [false]]
];

private _allRanks = TVG_ItemRanksEdit select 1;
private _rankItems = _allRanks getOrDefault [_selectedRank, []];

if(_isUnassign) then {
    _rankItems deleteAt (_rankItems find _value);
} else {
    _rankItems pushBackUnique _value;
};

_allRanks set [_selectedRank, _rankItems];
TVG_ItemRanksEdit set [1, _allRanks];