/*==============================================================================


	Southclaw's Scavenge and Survive

		Copyright (C) 2016 Barnaby "Southclaw" Keene

		This program is free software: you can redistribute it and/or modify it
		under the terms of the GNU General Public License as published by the
		Free Software Foundation, either version 3 of the License, or (at your
		option) any later version.

		This program is distributed in the hope that it will be useful, but
		WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along
		with this program.  If not, see <http://www.gnu.org/licenses/>.


==============================================================================*/


#define MAX_MOVEMENT_RANGE	(1.0)
#define NO_GO_ZONE_SIZE		(2.2)
#define TWK_AREA_IDENTIFIER	(1234)


#include <YSI\y_hooks>


static
			twk_Item[MAX_PLAYERS] = {INVALID_ITEM_ID, ...},
			twk_Tweaker[ITM_MAX] = {INVALID_PLAYER_ID, ...},
Float:		twk_Origin[MAX_PLAYERS][3],
			twk_Locked[MAX_PLAYERS],
			twk_NoGoZone[MAX_PLAYERS],
			twk_NoGoZoneCount[MAX_PLAYERS];

static
PlayerText:	twk_MoveF[MAX_PLAYERS],
PlayerText:	twk_MoveB[MAX_PLAYERS],
PlayerText:	twk_MoveL[MAX_PLAYERS],
PlayerText:	twk_MoveR[MAX_PLAYERS],
PlayerText:	twk_RotR[MAX_PLAYERS],
PlayerText:	twk_RotL[MAX_PLAYERS],
PlayerText:	twk_Unlock[MAX_PLAYERS],
PlayerText:	twk_Done[MAX_PLAYERS];

forward OnItemTweak(playerid, itemid);

static HANDLER = -1;


/*==============================================================================

	Zeroing

==============================================================================*/


hook OnScriptInit()
{
	HANDLER = debug_register_handler("item-tweak");
}

hook OnPlayerConnect(playerid)
{
	twk_Item[playerid] = INVALID_ITEM_ID;
	_twk_Reset(playerid);
	_twk_BuildUI(playerid);
}


/*==============================================================================

	Core Functions

==============================================================================*/


stock TweakItem(playerid, itemid)
{
	d:1:HANDLER("TweakItem %d %d", playerid, itemid);

	new
		geid[GEID_LEN],
		data[2];

	GetItemGEID(itemid, geid);

	if(twk_Item[playerid] != -1)
		printf("WARNING: [TweakItem] twk_Item already set to %d", twk_Item[playerid]);

	logf("[TWEAK] %p Tweaked item %d (%s)", playerid, itemid, geid);

	twk_Item[playerid] = itemid;
	twk_Tweaker[itemid] = playerid;
	GetItemPos(itemid, twk_Origin[playerid][0], twk_Origin[playerid][1], twk_Origin[playerid][2]);
	twk_NoGoZone[playerid] = CreateDynamicSphere(twk_Origin[playerid][0], twk_Origin[playerid][1], twk_Origin[playerid][2], NO_GO_ZONE_SIZE, GetItemWorld(itemid), GetItemInterior(itemid));

	data[0] = TWK_AREA_IDENTIFIER;
	data[1] = itemid;
	Streamer_SetArrayData(STREAMER_TYPE_AREA, twk_NoGoZone[playerid], E_STREAMER_EXTRA_ID, data);

	_twk_ShowUI(playerid);
	_twk_ToggleMouse(playerid, false);
	ShowActionText(playerid, "Move away from item to move it");

	return 1;
}


/*==============================================================================

	Internal

==============================================================================*/


_twk_Reset(playerid)
{
	if(IsValidItem(twk_Item[playerid]))
		twk_Tweaker[twk_Item[playerid]] = INVALID_PLAYER_ID;

	twk_Item[playerid] = INVALID_ITEM_ID;
	twk_Locked[playerid] = false;
	DestroyDynamicArea(twk_NoGoZone[playerid]);
	twk_NoGoZoneCount[playerid] = 0;

	_twk_HideUI(playerid);
}

_twk_Commit(playerid)
{
	new geid[GEID_LEN];

	GetItemGEID(twk_Item[playerid], geid);

	logf("[TWEAK] %p Tweaked item %d (%s)", playerid, twk_Item[playerid], geid);

	CallLocalFunction("OnItemTweak", "d", twk_Item[playerid]);

	_twk_HideUI(playerid);
	CancelSelectTextDraw(playerid);
	CancelPlayerMovement(playerid);
	ShowActionText(playerid, "Tweaking finished", 5000);
	_twk_Reset(playerid);
}

_twk_ShowUI(playerid)
{
	PlayerTextDrawShow(playerid, twk_MoveF[playerid]);
	PlayerTextDrawShow(playerid, twk_MoveB[playerid]);
	PlayerTextDrawShow(playerid, twk_MoveL[playerid]);
	PlayerTextDrawShow(playerid, twk_MoveR[playerid]);
	PlayerTextDrawShow(playerid, twk_RotR[playerid]);
	PlayerTextDrawShow(playerid, twk_RotL[playerid]);
	PlayerTextDrawShow(playerid, twk_Unlock[playerid]);
	PlayerTextDrawShow(playerid, twk_Done[playerid]);
}

_twk_HideUI(playerid)
{
	PlayerTextDrawHide(playerid, twk_MoveF[playerid]);
	PlayerTextDrawHide(playerid, twk_MoveB[playerid]);
	PlayerTextDrawHide(playerid, twk_MoveL[playerid]);
	PlayerTextDrawHide(playerid, twk_MoveR[playerid]);
	PlayerTextDrawHide(playerid, twk_RotR[playerid]);
	PlayerTextDrawHide(playerid, twk_RotL[playerid]);
	PlayerTextDrawHide(playerid, twk_Unlock[playerid]);
	PlayerTextDrawHide(playerid, twk_Done[playerid]);
}

_twk_ToggleMouse(playerid, bool:toggle)
{
	if(toggle)
	{
		twk_Locked[playerid] = true;
		SelectTextDraw(playerid, 0xffff00ff);
		PlayerTextDrawSetString(playerid, twk_Unlock[playerid], "Move");
	}
	else
	{
		twk_Locked[playerid] = false;
		CancelSelectTextDraw(playerid);
		PlayerTextDrawSetString(playerid, twk_Unlock[playerid], "Mouse: ~k~~SNEAK_ABOUT~");
	}
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(IsValidItem(twk_Item[playerid]))
	{
		if(playertextid == twk_MoveF[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.1, 0.0, 0.0);
		}

		if(playertextid == twk_MoveB[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.1, 180.0, 0.0);
		}

		if(playertextid == twk_MoveL[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.1, 90.0, 0.0);
		}

		if(playertextid == twk_MoveR[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.1, -90.0, 0.0);
		}

		if(playertextid == twk_RotR[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.0, 0.0, -5.0);
		}

		if(playertextid == twk_RotL[playerid])
		{
			_twk_AdjustItemPos(playerid, 0.0, 0.0, 5.0);
		}

		if(playertextid == twk_Unlock[playerid])
		{
			_twk_ToggleMouse(playerid, false);
		}

		if(playertextid == twk_Done[playerid])
		{
			_twk_Commit(playerid);
		}
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsValidItem(twk_Item[playerid]))
	{
		if(!twk_Locked[playerid] && newkeys & KEY_WALK)
			_twk_ToggleMouse(playerid, true);

		else if(twk_Locked[playerid] && newkeys & 16)
			_twk_Commit(playerid);
	}
}

_twk_AdjustItemPos(playerid, Float:distance, Float:direction, /*Float:rx, Float:ry, */Float:rotation)
{
	if(!IsPlayerConnected(playerid))
	{
		printf("[_twk_AdjustItemPos] WARNING: Called on invalid player %d", playerid);
		return 1;
	}

	if(!IsValidItem(twk_Item[playerid]))
	{
		printf("[_twk_AdjustItemPos] WARNING: Called on invalid item %d", twk_Item[playerid]);
		_twk_Reset(playerid);
		return 2;
	}

	if(twk_NoGoZoneCount[playerid] > 0)
	{
		ShowActionText(playerid, "Cannot move item with players nearby", 6000);
		return 3;
	}

	new
		Float:new_x,
		Float:new_y,
		Float:new_z,
		Float:rx,
		Float:ry,
		Float:rz;

	GetItemPos(twk_Item[playerid], new_x, new_y, new_z);
	GetItemRot(twk_Item[playerid], rx, ry, rz);

	new_x += distance * floatsin(-(rz + direction), degrees);
	new_y += distance * floatcos(-(rz + direction), degrees);

	if(Distance(new_x, new_y, new_z, twk_Origin[playerid][0], twk_Origin[playerid][1], twk_Origin[playerid][2]) >= MAX_MOVEMENT_RANGE)
	{
		ShowActionText(playerid, "Too far from original build position", 6000);
		return 4;
	}

	SetItemPos(twk_Item[playerid], new_x, new_y, new_z);
	SetItemRot(twk_Item[playerid], rx, rx, rz + rotation);

	return 0;
}

_twk_BuildUI(playerid)
{
	twk_MoveF[playerid]				=CreatePlayerTextDraw(playerid, 580.000000, 320.000000, "~u~");
	PlayerTextDrawBackgroundColor	(playerid, twk_MoveF[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_MoveF[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_MoveF[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_MoveF[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_MoveF[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_MoveF[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_MoveF[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_MoveF[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_MoveF[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_MoveF[playerid], 594.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_MoveF[playerid], true);

	twk_MoveB[playerid]				=CreatePlayerTextDraw(playerid, 580.000000, 360.000000, "~d~");
	PlayerTextDrawBackgroundColor	(playerid, twk_MoveB[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_MoveB[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_MoveB[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_MoveB[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_MoveB[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_MoveB[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_MoveB[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_MoveB[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_MoveB[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_MoveB[playerid], 594.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_MoveB[playerid], true);

	twk_MoveL[playerid]				=CreatePlayerTextDraw(playerid, 560.000000, 340.000000, "~<~");
	PlayerTextDrawBackgroundColor	(playerid, twk_MoveL[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_MoveL[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_MoveL[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_MoveL[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_MoveL[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_MoveL[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_MoveL[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_MoveL[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_MoveL[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_MoveL[playerid], 574.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_MoveL[playerid], true);

	twk_MoveR[playerid]				=CreatePlayerTextDraw(playerid, 600.000000, 340.000000, "~>~");
	PlayerTextDrawBackgroundColor	(playerid, twk_MoveR[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_MoveR[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_MoveR[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_MoveR[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_MoveR[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_MoveR[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_MoveR[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_MoveR[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_MoveR[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_MoveR[playerid], 614.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_MoveR[playerid], true);

	twk_RotR[playerid]				=CreatePlayerTextDraw(playerid, 610.000000, 310.000000, "R");
	PlayerTextDrawBackgroundColor	(playerid, twk_RotR[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_RotR[playerid], 2);
	PlayerTextDrawLetterSize		(playerid, twk_RotR[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_RotR[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_RotR[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_RotR[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_RotR[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_RotR[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_RotR[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_RotR[playerid], 624.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_RotR[playerid], true);

	twk_RotL[playerid]				=CreatePlayerTextDraw(playerid, 550.000000, 310.000000, "L");
	PlayerTextDrawBackgroundColor	(playerid, twk_RotL[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_RotL[playerid], 2);
	PlayerTextDrawLetterSize		(playerid, twk_RotL[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_RotL[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_RotL[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_RotL[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_RotL[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_RotL[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_RotL[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_RotL[playerid], 564.000000, 20.000000);
	PlayerTextDrawSetSelectable		(playerid, twk_RotL[playerid], true);

	twk_Unlock[playerid]			=CreatePlayerTextDraw(playerid, 587.000000, 390.000000, "Move");
	PlayerTextDrawAlignment			(playerid, twk_Unlock[playerid], 2);
	PlayerTextDrawBackgroundColor	(playerid, twk_Unlock[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_Unlock[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_Unlock[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_Unlock[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_Unlock[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_Unlock[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_Unlock[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_Unlock[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_Unlock[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_Unlock[playerid], 20.0, 80.0);
	PlayerTextDrawSetSelectable		(playerid, twk_Unlock[playerid], true);

	twk_Done[playerid]				=CreatePlayerTextDraw(playerid, 587.000000, 420.000000, "Done");
	PlayerTextDrawAlignment			(playerid, twk_Done[playerid], 2);
	PlayerTextDrawBackgroundColor	(playerid, twk_Done[playerid], 255);
	PlayerTextDrawFont				(playerid, twk_Done[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, twk_Done[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, twk_Done[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, twk_Done[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, twk_Done[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, twk_Done[playerid], 1);
	PlayerTextDrawUseBox			(playerid, twk_Done[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, twk_Done[playerid], 255);
	PlayerTextDrawTextSize			(playerid, twk_Done[playerid], 20.0, 80.0);
	PlayerTextDrawSetSelectable		(playerid, twk_Done[playerid], true);
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	new data[2];
	Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, data);

	if(data[0] != TWK_AREA_IDENTIFIER)
		return Y_HOOKS_CONTINUE_RETURN_0;

	if(!IsValidItem(data[1]))
		return Y_HOOKS_CONTINUE_RETURN_0;

	if(!IsPlayerConnected(twk_Tweaker[data[1]]))
	{
		printf("ERROR: Player entered area of tweaked item %d item has no connected player.", data[1]);
		return Y_HOOKS_CONTINUE_RETURN_0;
	}

	ShowActionText(playerid, "You are blocking an item from being built, please stand back", 6000);
	twk_NoGoZoneCount[twk_Tweaker[data[1]]]++;

	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new data[2];
	Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, data);

	if(data[0] != TWK_AREA_IDENTIFIER)
		return Y_HOOKS_CONTINUE_RETURN_0;

	if(!IsValidItem(data[1]))
		return Y_HOOKS_CONTINUE_RETURN_0;

	if(!IsPlayerConnected(twk_Tweaker[data[1]]))
	{
		printf("ERROR: Player left area of tweaked item %d item has no connected player.", data[1]);
		return Y_HOOKS_CONTINUE_RETURN_0;
	}

	twk_NoGoZoneCount[twk_Tweaker[data[1]]]--;

	return Y_HOOKS_CONTINUE_RETURN_0;
}


/*==============================================================================

	Disallow

==============================================================================*/


/*
item pickup, drop
item use
inventory open
container open
*/