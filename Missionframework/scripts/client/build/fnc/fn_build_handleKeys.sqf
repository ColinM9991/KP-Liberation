/*
    File: fn_build_handleKeys.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-23
    Last Update: 2026-02-01
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

#include "defines.hpp"
#include "\a3\ui_f\hpp\definedikcodes.inc"

params [
	["_isKeyDownEvent", false, [false]],
	["_args", [], [], 5]
];

_args params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

if (!_isKeyDownEvent) exitWith {};

switch (_key) do {
    case DIK_RETURN;
    case DIK_NUMPADENTER: {
        if (!GVAR(isSingleBuild)) exitWith {false};

        [] call KPLIB_fnc_build_confirmBuild;

        true
    };
    case DIK_N: { // NVGs
        private _value = !GVAR(cameraUseNvg);
        camUseNVG _value;

        SVAR(cameraUseNvg, _value);

        true
    };
    case DIK_C: { // Cancel build for currently selected build item, or delete existing item
        if (GVAR(isSingleBuild)) exitWith {false};
        if (_ctrl && GVAR(isBuilding)) exitWith {false};

        if (!(GVAR(isBuilding))) then {
            private _cursorObject = [] call KPLIB_fnc_build_getCursorObject;
            if (isNull _cursorObject) exitWith {false};

            // Clone an existing object
            if (_ctrl) exitWith {
                private _price = _cursorObject getVariable "KPLIB_buildPrice";
                private _object = ([typeOf _cursorObject] + _price) call KPLIB_fnc_build_createObject;
                _object setDir (getDir _cursorObject);
                
                SVAR(isBuilding, true);
                SVAR(cursorObject, vehicle _object);

                true
            };

            ["KPLIB_build_event_objectRemoved", _cursorObject] call CBA_fnc_localEvent;

            deleteVehicle _cursorObject;
        } else {
            deleteVehicle GVAR(cursorObject);

            SVAR(isBuilding, false);
            SVAR(cursorObject, objNull);
        };

        true
    };
    case DIK_V: {
        private _isVectorEnabled = GVAR(isVectorMode);
        private _content = if(_isVectorEnabled) then [{"enabled"}, {"disabled"}];

        SVAR(isVectorMode, !_isVectorEnabled);

        format["Vector mode %1", _content] call CBA_fnc_notify;
        true
    };
    case DIK_ESCAPE: {
        if (GVAR(isSingleBuild)) exitWith {true};
        
        [] call KPLIB_fnc_build_end;

        true
    };
    default {
        false
    };
}