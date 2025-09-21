/*
    File: fn_handleBuildAction.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-20
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Intended to be called from the KeyDown Display Event Handler.
        This script manages the placement of an object during build time by using key presses.
        It replaces the old action menu build system

    Parameter(s):
        _key              - The pressed key
        _shift            - Was Shift pressed
        _ctrl             - Was CTRL pressed

    Returns:
        True to block user input from performing any actions when build mode is engaged.
*/
#ifndef MAX_DISTANCE
#include "..\ui\liberation_build_info.hpp"
#endif

params [
	["_key", -1, [-1]],
	["_shift", false, [false]],
	["_ctrl", false, [false]]
];

if (!_ctrl) exitWith {false};
if (KPLIB_buildInvalid) exitWith {true};

private _vehicle = KPLIB_buildPreview;
private _buildType = KPLIB_buildType;
private _handled = false;

switch (_key) do {
	case KEY_ROTATE_LEFT;
	case KEY_ROTATE_RIGHT: {
        [_key isEqualTo KEY_ROTATE_RIGHT, _shift, _vehicle] call KPLIB_fnc_handleBuildRotation;
        _handled = true;
    };

	case KEY_LOWER;
	case KEY_RAISE: {
        [_key isEqualTo KEY_RAISE, _shift] call KPLIB_fnc_handleBuildElevation;
        _handled = true;
    };

	case KEY_CLOSER;
	case KEY_FURTHER: {
		[_key isEqualTo KEY_FURTHER, _shift, _vehicle] call KPLIB_fnc_handleBuildDistance;
        _handled = true;
	};

    case KEY_VECTOR: {
        build_vector = !build_vector;
        _handled = true;
    };

	case KEY_CANCEL: {
        [_buildType] call KPLIB_fnc_handleBuildCancel;
        _handled = true;
    };
	case KEY_PLACE: {
        [_shift, _buildType] call KPLIB_fnc_handleBuildPlacement;
        _handled = true;
    };
};
_handled;