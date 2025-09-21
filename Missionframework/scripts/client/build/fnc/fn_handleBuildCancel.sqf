/*
    File: fn_handleBuildCancel.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-20
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Cancels the build, if allowed.

    Returns:
        void
*/
params[
    ["_buildType", -1, [-1]]
];

if (_buildType isEqualTo 99) exitWith {
	hint "Cannot cancel"
};

KPLIB_hasCancelledBuild = true;