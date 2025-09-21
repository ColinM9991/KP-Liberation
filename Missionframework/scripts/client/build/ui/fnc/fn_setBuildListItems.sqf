/*
    File: fn_setBuildListItems.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Refreshes the list items in the build menu

    Parameter(s):
        _buildMode		- Numberical value representing the build mode

    Returns:
        void
*/
#ifndef BUILD_DIALOG
#include "..\..\..\..\..\ui\defines.hpp"
#endif

params[
    ["_buildMode", -1, [-1]]];

disableSerialization;
private _buildDisplay = findDisplay BUILD_DIALOG;
private _buildDialogItemsList = _buildDisplay displayCtrl BUILD_LNB_ITEMS;

// Refresh page title
(_buildDisplay displayCtrl BUILD_LBL_PAGE) ctrlSetText (localize format["STR_BUILD%1", _buildMode]);

// Repopulate the list
_buildDialogItemsList lnbSetCurSelRow -1;
lnbClear _buildDialogItemsList;
{
    _x params["_className", "_supplyCost", "_ammoCost", "_fuelCost"];
    ([_className, _forEachIndex] call KPLIB_fnc_getBuildItemDetails) params ["_displayName", "_iconPath"];

    private _rowIndex = _buildDialogItemsList lnbAddRow [_displayName, str _supplyCost, str _ammoCost, str _fuelCost];
    _buildDialogItemsList lnbSetData[[_rowIndex, 0], str _x];
    
    if(!(_iconPath isEqualTo "")) then {
        _buildDialogItemsList lnbSetPicture[[_rowIndex, 0], _iconPath];
    };

    (_x call KPLIB_fnc_canBuildItem) params ["_canBuild"];
    if (!_canBuild) then {
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 0], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 1], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 2], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 3], [0.4,0.4,0.4,1]];
    };
} forEach (KPLIB_buildList select _buildMode);