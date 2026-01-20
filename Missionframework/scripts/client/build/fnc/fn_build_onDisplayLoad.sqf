/*
    File: fn_build_onDisplayLoad.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
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
params [
	["_display", nil, [displayNull]]
];

private _buildCategoriesCombo = _display displayCtrl BUILD_CATEGORY_IDC;
private _buildItemsList = _display displayCtrl BUILD_LIST_IDC;

_buildItemsList ctrlAddEventHandler ["LBSelChanged", {
	params [
		["_control", nil, [controlNull]],
		["_selectedIndex", -1, [-1]]
	];

	if (_selectedIndex isEqualTo -1) exitWith {};

	private _rowData = _control lnbData [_selectedIndex, 0];
	if (_rowData isEqualTo "") exitWith {};
	_rowData = parseSimpleArray _rowData;

	if (GVAR(isBuilding)) then {
		deleteVehicle GVAR(cursorObject);;
	};

	private _canBuild = _rowData call KPLIB_fnc_build_canBuildItem;
	if (!_canBuild) exitWith { };
	
	private _object = _rowData call KPLIB_fnc_build_createObject;
	SVAR(cursorObject, vehicle _object);
	SVAR(isBuilding, true);
	
	ctrlSetFocus ((ctrlParent _control) displayCtrl BUILD_BUTTON_CANCEL);
}];

_buildCategoriesCombo ctrlAddEventHandler ["LBSelChanged", {
	params [
		["_control", nil, [controlNull]],
		["_selectedIndex", -1, [-1]]
	];

	if (_selectedIndex isEqualTo -1) exitWith{};

	SVAR(buildType, _selectedIndex);

	private _display = GVAR(display);
	private _buildDialogItemsList = _display displayCtrl BUILD_LIST_IDC;

	// Repopulate the list
	[] call KPLIB_fnc_build_refreshBuildList;
}];

{
	_buildCategoriesCombo lbAdd (localize format["STR_BUILD%1", _forEachIndex]);
	_buildCategoriesCombo lbSetCurSel 0;
} forEach KPLIB_buildList;

SVAR(display, _display);