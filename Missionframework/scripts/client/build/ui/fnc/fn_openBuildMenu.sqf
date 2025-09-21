/*
    File: fn_openBuildMenu.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Opens the build menu and configures the relevant event handlers

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

createDialog "liberation_build";
waitUntil { dialog };
disableSerialization;

// Store dialogs and inputs
private _buildDialog = findDisplay BUILD_DIALOG;
private _buildButton = _buildDialog displayCtrl BUILD_BTN_BUILD;
private _buildMannedButton = _buildDialog displayCtrl BUILD_BTN_BUILDMANNED;

// Hide buttons for non-commanders
private _isCommander = player isEqualTo ([] call KPLIB_fnc_getCommander);

ctrlShow[BUILD_BTN_GROUPS,   _isCommander];
_buildMannedButton  ctrlShow _isCommander;

// Disable build buttons by default
_buildButton        ctrlEnable false;
_buildMannedButton  ctrlEnable false;

// Add build button event handlers
_buildButton        ctrlAddEventHandler["ButtonClick", { [false] call KPLIB_fnc_handleBuildClick }];
_buildMannedButton  ctrlAddEventHandler["ButtonClick", { [true] call KPLIB_fnc_handleBuildClick }];

// Add category button event handlers
// These event handlers refresh the list items and page title according to the category
// The category is determined by the order of the array that is enumerated + 1
{
    [
        (_buildDialog displayCtrl _x),
        "ButtonClick",
        {
            _thisArgs params [["_buttonIndex", -1, [-1]]];
            if(_buttonIndex isEqualTo -1) exitWith{};

            [_buttonIndex] call KPLIB_fnc_setBuildListItems
        },
        [_forEachIndex + 1]
    ] call CBA_fnc_addBISEventHandler;
} forEach [
    BUILD_BTN_INFANTRY,
    BUILD_BTN_LIGHT,
    BUILD_BTN_HEAVY,
    BUILD_BTN_AIR,
    BUILD_BTN_DEFENCE,
    BUILD_BTN_BUILDING,
    BUILD_BTN_SUPPORT,
    BUILD_BTN_GROUPS
];

// Add ListBox Event Handler to check affordability of items
(_buildDialog displayCtrl BUILD_LNB_ITEMS) ctrlAddEventHandler ["LBSelChanged", { _this call KPLIB_fnc_handleLbSelChanged }];
(_buildDialog displayCtrl BUILD_LNB_ITEMS) ctrlAddEventHandler ["LBDblClick", { [false] call KPLIB_handleBuildClick }];

// Set the initial page
[BUILD_TYPE_LIGHT] call KPLIB_fnc_setBuildListItems;

// Set labels
ctrlSetText [BUILD_LBL_MANPOWER,    format [ "%1 : %2" , localize "STR_MANPOWER",   (floor KPLIB_supplies_global)]] ;
ctrlSetText [BUILD_LBL_AMMO,        format [ "%1 : %2" , localize "STR_AMMO",       (floor KPLIB_ammo_global)]];
ctrlSetText [BUILD_LBL_FUEL,        format [ "%1 : %2" , localize "STR_FUEL",       (floor KPLIB_fuel_global)]];

(_buildDialog displayCtrl BUILD_LBL_CAP) ctrlSetStructuredText formatText [
    "%1/%2 %3 - %4/%5 %6 - %7/%8 %9",
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