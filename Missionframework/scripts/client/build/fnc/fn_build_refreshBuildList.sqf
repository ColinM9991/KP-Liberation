/*
    File: fn_build_refreshBuildList.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-01-25
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

#include "..\ui\defines.hpp"
#include "defines.hpp"

private _dialog = GVAR(dialog);
private _buildDialogItemsList = _display displayCtrl BUILD_LIST_IDC;
private _buildTypeList = _display displayCtrl BUILD_CATEGORY_IDC;
private _buildType = lbCurSel _buildTypeList;

if (_buildType isEqualTo -1) exitWith{};

_buildDialogItemsList lnbSetCurSelRow -1;
lnbClear _buildDialogItemsList;
{
	_x params["_className", "_supplyCost", "_ammoCost", "_fuelCost"];
	([_className, _forEachIndex] call KPLIB_fnc_build_getItemDetails) params ["_displayName", "_iconPath"];

	private _rowIndex = _buildDialogItemsList lnbAddRow [_displayName, str _supplyCost, str _ammoCost, str _fuelCost];
	_buildDialogItemsList lnbSetData [[_rowIndex, 0], str _x];
	
	if(_iconPath isNotEqualTo "") then {
		_buildDialogItemsList lnbSetPicture[[_rowIndex, 0], _iconPath];
	};
    
    private _canBuild = _x call KPLIB_fnc_build_canBuildItem;
    if (!_canBuild) then {
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 0], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 1], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 2], [0.4,0.4,0.4,1]];
        _buildDialogItemsList lnbSetColor  [[_rowIndex, 3], [0.4,0.4,0.4,1]];
    };
} forEach (KPLIB_buildList select (_buildType));