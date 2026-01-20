if (((_this select 3) select 0) != KPLIB_b_smallStorage) exitWith {
    [player getVariable ["KPLIB_nearProd", []], ((_this select 3) select 0), clientOwner] remoteExec ["build_fac_remote_call",2];
};

private _sectorPos = markerPos ([100] call KPLIB_fnc_getNearestSector);

[KPLIB_b_smallStorage, getPos player, 98] call KPLIB_fnc_build_beginSingle;