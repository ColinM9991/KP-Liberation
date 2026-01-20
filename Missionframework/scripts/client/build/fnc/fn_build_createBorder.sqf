/*
    File: fn_build_createBorder.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-23
    Last Update: 2026-01-23
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [
	["_pos", eyePos player, [[]]],
	["_radius", -1, [-1]]
];

private _spheres = [];

private _posX = _pos select 0;
private _posY = _pos select 1;
private _posZ = _pos select 2;

for "_i" from 0 to _radius do {
	private _angle = _i * (360/_radius);

	_spheres pushBack ("Sign_Sphere100cm_F" createVehicleLocal [
        _posX + (_radius * cos(_angle)),
        _posY + (_radius * sin(_angle)),
        _posZ]);
 };

 _spheres