/*
    File: fn_handleLbSelChanged.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Handles the LBSelChanged event for the build menu.

    Parameter(s):

    Returns:
        void
*/
#ifndef BUILD_DIALOG
#include "..\..\..\..\..\ui\defines.hpp"
#endif
#ifndef BUILD_TYPE_BUILDING
#include "..\build_types.hpp"
#endif

params[
    ["_control", controlNull, [controlNull]],
    ["_selectedIndex", -1, [-1]]
];

if(_selectedIndex isEqualTo -1) exitWith{};

// Retrieve the classname and prices from the listbox
private _data = (parseSimpleArray (_control lnbData [_selectedIndex, 0]));
private _className = _data select 0;

// Can the item be Built, and Built as a manned object.
(_data call KPLIB_fnc_canBuildItem) params["_canBuild", "_canBuildManned"];

// Enable or disable the build buttons based on whether it's affordable, sector locked, or resources permit it
ctrlEnable [BUILD_BTN_BUILD,        _canBuild];
ctrlEnable [BUILD_BTN_BUILDMANNED,  _canBuildManned];

// If it's not an elite vehicle, exit as we've finished.
if(!(_className isEqualType "" && {_className in elite_vehicles})) exitWith {
    ((findDisplay BUILD_DIALOG) displayCtrl (BUILD_LNK_SECTOR)) ctrlSetText "";
};

// If item is linked to a sector, set the text based on whether it's locked or unlocked.
([_className] call KPLIB_fnc_isSectorLocked) params ["_sector", "_isSectorLocked"];
private _isLinkedToSector = !(_sector isEqualTo "");
if (_isLinkedToSector) then {
    private _linkColour = if(!_isSectorLocked) then [{"#0040e0"}, {"#e00000"}];
    private _linkText = localize (if(!_isSectorLocked) then [{"STR_VEHICLE_UNLOCKED"}, {"STR_VEHICLE_LOCKED"}]);
    ((findDisplay BUILD_DIALOG) displayCtrl (BUILD_LNK_SECTOR)) ctrlSetStructuredText parseText (format["<t color='%1' align='center'>%2<br/>%3</t>", _linkColour, _linkText, markerText _sector]);
};