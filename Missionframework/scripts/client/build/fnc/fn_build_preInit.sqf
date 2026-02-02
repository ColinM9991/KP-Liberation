/*
    File: fn_build_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-02
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

if (isServer) then {
	["KPLIB_build_event_itemBuilt", {
		private _vehicle = _this;
		if (_vehicle isKindOf "Man") then {
            stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + 1;
        } else {
            if (!( _vehicle isKindOf "Building" )) then {
                stats_blufor_vehicles_built = stats_blufor_vehicles_built + 1;
            };
        };

		if (_vehicle isKindOf "AllVehicles") then {
			_vehicle addMPEventHandler ["MPKilled", { ["KPLib_manageKills", _this] call CBA_fnc_localEvent; }];
			{ _x addMPEventHandler ["MPKilled", { ["KPLib_manageKills", _this] call CBA_fnc_localEvent; }]; true } count (crew _vehicle);
		};

	}] call CBA_fnc_addEventHandler;

	["KPLIB_build_event_sectorStorageCreated", {
		_this setVariable ["KPLIB_storage_type", 1, true];
		recalculate_sectors = true;
	}] call CBA_fnc_addEventHandler;

	["KPLIB_build_event_fobCreated", {
		[position _this, false] spawn build_fob_remote_call;
	}] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
	["KPLIB_build_event_objectPlaced", {
		GVAR(buildCart) pushBack (_this);

		private _display = GVAR(display);
		private _buildCartList = _display displayCtrl BUILD_CART_IDC;

		// Repopulate the list
		private _className = typeOf _this;

		([_className] call KPLIB_fnc_build_getItemDetails) params ["_displayName", "_iconPath"];
		(_object getVariable ["KPLIB_buildPrice", []]) params ["_supplyCost", "_ammoCost", "_fuelCost"];

		private _rowIndex = _buildCartList lnbAddRow [_displayName, str _supplyCost, str _ammoCost, str _fuelCost];
		
		if(_iconPath isNotEqualTo "") then {
			_buildCartList lnbSetPicture[[_rowIndex, 0], _iconPath];
		};

		[] call KPLIB_fnc_build_refreshBuildList;
	}] call CBA_fnc_addEventHandler;

	["KPLIB_build_event_objectRemoved", {
		private _buildCart = GVAR(buildCart);
		private _rowIndex = _buildCart find _this;

		if (_rowIndex isEqualTo -1) exitWith {};

		private _display = GVAR(display);
		private _buildCartList = _display displayCtrl BUILD_CART_IDC;

		_buildCartList lnbDeleteRow _rowIndex;
		SVAR(buildCart, _buildCart - [_this]);

		[] call KPLIB_fnc_build_refreshBuildList;
	}] call CBA_fnc_addEventHandler;

	["KPLIB_build_event_fobBuildRequested", {
		[
			KPLIB_b_fobBuilding,
			getPos player,
			KPLIB_range_fob,
			{
				["KPLIB_build_event_fobCreated", _this] call CBA_fnc_serverEvent;
			}] call KPLIB_fnc_build_beginSingle;
	}] call CBA_fnc_addEventHandler;

	["KPLIB_build_event_sectorStorageRequested", {
		[
			KPLIB_b_smallStorage,
			_this,
			KPLIB_range_fob,
			{
				["KPLIB_build_event_sectorStorageCreated", _this] call CBA_fnc_serverEvent;
			}] call KPLIB_fnc_build_beginSingle;
	}] call CBA_fnc_addEventHandler;

	player addEventHandler ["Killed", {
		if (KPLIB_isBuilding) then {
			[] call KPLIB_fnc_build_end;
		}
	}];
};

KPLIB_isBuilding = false;