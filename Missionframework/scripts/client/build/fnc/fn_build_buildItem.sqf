/*
    File: fn_build_buildItem.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-02
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params[
    ["_className", "", [""]],
    ["_position", [], [[]]],
    ["_vectorDirAndUp", [], [[]]]
];

private _vehicle = objNull;
isNil {
    _vehicle = createVehicle [_className, zeroPos, [], 500, "NONE"];
    _vehicle setVectorDirAndUp _vectorDirAndUp;
    _vehicle setPosWorld _position;
};

[_vehicle] call KPLIB_fnc_addObjectInit;
[_vehicle] call KPLIB_fnc_clearCargo;

if(unitIsUAV _vehicle) then {
    [_vehicle] call KPLIB_fnc_forceBluforCrew;
};

["KPLIB_build_event_itemBuilt", _vehicle] call CBA_fnc_localEvent;
["KPLIB_build_event_itemBuilt", _vehicle] call CBA_fnc_serverEvent;