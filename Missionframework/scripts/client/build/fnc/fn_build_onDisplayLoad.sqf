/*
    File: fn_build_onDisplayLoad.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
    Last Update: 2026-01-30
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
private _buildInformation = _display displayCtrl BUILD_HEADER_RESOURCES;

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
		deleteVehicle GVAR(cursorObject);
	};

	private _controlsGroup = ctrlParentControlsGRoup _control;
	private _buildSectorInformation = _controlsGroup controlsGroupCtrl BUILD_PANEL_LEFT_SECTOR_INFORMATION;
	_buildSectorInformation ctrlSetStructuredText parseText "";

	// If item is linked to a sector, set the text based on whether it's locked or unlocked.
	([_rowData select 0] call KPLIB_fnc_build_isSectorLocked) params ["_sector", "_isSectorLocked"];
	private _isLinkedToSector = (_sector isNotEqualTo "");
	if (_isLinkedToSector) then {
		private _linkColour = if(!_isSectorLocked) then [{"#0040e0"}, {"#e00000"}];
		private _linkText = localize (if(!_isSectorLocked) then [{"STR_VEHICLE_UNLOCKED"}, {"STR_VEHICLE_LOCKED"}]);
		
		_buildSectorInformation ctrlSetStructuredText parseText (format["<t color='%1' align='center'>%2<br/>%3</t>", _linkColour, _linkText, markerText _sector]);
	};

	private _canBuild = _rowData call KPLIB_fnc_build_canBuildItem;
	if (!_canBuild) exitWith {};
	
	private _object = _rowData call KPLIB_fnc_build_createObject;
	SVAR(cursorObject, vehicle _object);
	SVAR(isBuilding, true);
	
	ctrlSetFocus (GVAR(display) displayCtrl BUILD_PANEL_LEFT_HEADER);
}];

_buildCategoriesCombo ctrlAddEventHandler ["LBSelChanged", {
	params [
		["_control", nil, [controlNull]],
		["_selectedIndex", -1, [-1]]
	];

	if (_selectedIndex isEqualTo -1) exitWith{};

	private _display = GVAR(display);
	private _buildDialogItemsList = _display displayCtrl BUILD_LIST_IDC;

	// Repopulate the list
	[] call KPLIB_fnc_build_refreshBuildList;
}];

{
	_buildCategoriesCombo lbAdd (localize format["STR_BUILD%1", _forEachIndex]);
	_buildCategoriesCombo lbSetCurSel 0;
} forEach KPLIB_buildList;

_buildInformation ctrlSetStructuredText formatText [
    "%1%2 - %3%4 - %5%6 | %7/%8 %9 %10/%11 %12 %13/%14 %15",
	image "res\ui_manpo.paa",
	(floor KPLIB_supplies_global),
	image "res\ui_ammo.paa",
	(floor KPLIB_ammo_global),
	image "res\ui_fuel.paa",
	(floor KPLIB_fuel_global),
    unitcap,
    ([] call KPLIB_fnc_getLocalCap),
    image "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa",
    KPLIB_heli_count,
    KPLIB_heli_slots,
    image "\A3\air_f_beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa",
    KPLIB_plane_count,
    KPLIB_plane_slots,
    image "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa"
];

SVAR(display, _display);