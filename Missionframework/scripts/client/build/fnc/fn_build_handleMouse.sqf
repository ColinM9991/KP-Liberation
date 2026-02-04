#include "defines.hpp"

params [
    ["_eventType", "", [""]],
    ["_args", [], [[]]]
];

if (_eventType isEqualTo -1) exitWith {};

switch _eventType do {
    case "onMouseButtonDown": {
        _args params ["", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_button isEqualTo 1) exitWith {};
        
        SVAR(mouseDown, true);
        SVAR(ctrlDown, _ctrl);
        SVAR(shiftDown, _shift);
        SVAR(altDown, _alt);

        private _cursorObject = GVAR(cursorObject);
        private _isBuilding = GVAR(isBuilding);

        // Capture original coordinates for elevation adjustment
        if (_alt && !_isBuilding && !isNull (_cursorObject)) then {
            SVAR(originalMouseYPosition, _yPos);
            SVAR(originalObjectPosition, getPosWorld _cursorObject);
        };

        if (!_isBuilding) exitWith {};

        // Check placement bounds
        private _mousePos = GVAR(mousePos);

        // Allow for repeat building if holding CTRL when clicking
        if (!_ctrl) then {
            SVAR(cursorObject, objNull); 
            SVAR(isBuilding, false);
        } else {
            private _price = _cursorObject getVariable "KPLIB_buildPrice";
            private _object = ([typeOf _cursorObject] + _price) call KPLIB_fnc_build_createObject;
            
            SVAR(cursorObject, vehicle _object);
        };
        
        ["KPLIB_build_event_objectPlaced", _cursorObject] call KPLIB_fnc_localEvent;
    };
    case "onMouseButtonUp": {
        _args params ["_displayOrControl", "_button", "", "", "_shift", "_ctrl", "_alt"];

        if (_button isEqualTo 1) exitWith {};

        SVAR(mouseDown, false);
        SVAR(ctrlDown, false);
        SVAR(shiftDown, false);
        SVAR(altDown, false);
        SVAR(originalMouseYPosition, []);
        SVAR(originalObjectPosition, []);
    };
    case "onMouseMoving": {
        _args params ["_control", "_xPos", "_yPos", "_mouseOver"];

        private _mousePos = screenToWorld [_xPos, _yPos];
        SVAR(mousePos, _mousePos);

        if (!GVAR(mouseDown) && !GVAR(isBuilding)) exitWith {
            private _target = vehicle ([] call KPLIB_fnc_build_getCursorObject);
            SVAR(cursorObject, _target);
        };
        
        private _object = GVAR(cursorObject);
        if (isNull _object) exitWith {};

        switch (true) do {
            case GVAR(shiftDown): {
                // Rotating
                private _objectPos = getPos _object;
                private _vector = [_objectPos] call KPLIB_fnc_build_getSurfaceVector;

                _object setDir (_object getDir _mousePos); 
                _object setVectorUp _vector;
            };
            case GVAR(altDown): {
                //Elevation
                private _originalPosition = GVAR(originalObjectPosition);
                private _originalMouseY = GVAR(originalMouseYPosition);
                private _vector = [_originalPosition] call KPLIB_fnc_build_getSurfaceVector;
    
                private _mouseDelta = _yPos - _originalMouseY;
                private _heightDelta = _mouseDelta * -40;
                
                private _newPos = [_originalPosition select 0, _originalPosition select 1, (_originalPosition select 2) + _heightDelta];
                _object setVectorUp _vector;
                _object setPosWorld _newPos;
            };
            default {
                // Moving
                private _isPositionInArea = [_mousePos, GVAR(buildPosition), GVAR(buildRadius)] call KPLIB_fnc_build_isPositionInArea;
                private _vector = [_mousePos] call KPLIB_fnc_build_getSurfaceVector;

                _object setPosASL (AGLToASL _mousePos);
                _object setVectorUp _vector;
                _object setVariable ["KPLIB_build_validPlacement", _isPositionInArea];
            }
        }
    };
    case "onMouseExit";
    case "onMouseEnter": {
        private _onOrOff = if (_eventType isEqualTo "onMouseEnter") then [{"on"}, {"off"}];
        private _camera = GVAR(camera);

        _camera camCommand format["manual %1", _onOrOff];
    }
}