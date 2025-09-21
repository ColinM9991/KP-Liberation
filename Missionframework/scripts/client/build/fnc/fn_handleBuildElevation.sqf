/*
    File: fn_handleBuildElevation.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-22
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Raises or lowers the build object.

    Parameters:
        _raiseElevation         - Should the object be raised. Default is false to lower.
        _fastMode               - Speed up elevation manipulation by a factor of 5.

    Returns:
        void
*/
#ifndef MAX_DISTANCE
#include "..\ui\liberation_build_info.hpp"
#endif

params[
    ["_raiseElevation", false, [false]],
    ["_fastMode", false, [false]]];

if (_raiseElevation && {build_elevation >= MAX_DISTANCE}) exitWith{};

private _moveBy = [0.05, 0.25] select _fastMode;
private _elevation = [(0 - _moveBy), _moveBy] select _raiseElevation;

build_elevation = build_elevation + _elevation;