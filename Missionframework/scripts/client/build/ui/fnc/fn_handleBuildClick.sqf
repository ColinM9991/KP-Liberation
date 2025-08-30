/*
    File: fn_handleBuildClick.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Handles the clicking of build button in the build menu.
        Registered via ctrlAddEventHandler on the button.

    Parameter(s):

    Returns:
        void
*/
#ifndef BUILD_DIALOG
#include "..\..\..\..\..\ui\defines.hpp"
#endif

params[
    ["_buildManned", false, [false]]];

disableSerialization;
private _buildDialogItemsList = (findDisplay BUILD_DIALOG) displayCtrl BUILD_LNB_ITEMS;
private _selectedRow = lnbCurSelRow _buildDialogItemsList;

if(_selectedRow isEqualTo -1) exitWith {};

private _data = _buildDialogItemsList lnbData [_selectedRow, 0];

if (_data isEqualTo "") exitWith {};

private _parsedData = parseSimpleArray _data;
_parsedData params [
    ["_className", "", [[], ""]],
    ["_supplyCost", 0, [0]],
    ["_ammoCost", 0, [0]],
    ["_fuelCost", 0, [0]]
];

private _buildType = [_parsedData] call KPLIB_fnc_getBuildType;

// Call build script with _parsedData
[
    _className,
    _supplyCost,
    _ammoCost,
    _fuelCost,
    _buildType,
    _buildManned
] spawn KPLIB_fnc_handleBuild;

closeDialog 0;