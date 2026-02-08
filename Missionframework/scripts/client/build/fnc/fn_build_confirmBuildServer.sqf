/*
    File: fn_build_confirmBuildServer.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-25
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [
	["_buildParams", [], [[]]],
	["_player", objNull, [objNull]]
];

{
    _x params [
        ["_className", "", [""]],
        ["_position", [], [[]]],
        ["_vectorDirAndUp", [], [[]]],
        ["_price", [], [[]], 3]
    ];

    if (_className isKindOf "Man") then {
        [_className, ASLToAGL _position, group _player] call KPLIB_fnc_createManagedUnit;
    } else {
        [_className, _position, _vectorDirAndUp] call KPLIB_fnc_build_buildItem;
    };

    if (_price isNotEqualTo [0,0,0]) then {
        _price params ["_supplyCost", "_ammoCost", "_fuelCost"];
        [[getPosATL _player] call KPLIB_fnc_getNearestFob, _supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_consumeFobResources;
    };
} forEach _buildParams;