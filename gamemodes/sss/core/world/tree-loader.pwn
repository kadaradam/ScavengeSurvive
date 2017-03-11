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


#include <YSI\y_hooks>


#define DIRECTORY_TREES "Maps/"


hook OnScriptInit()
{
	DirectoryCheck(DIRECTORY_SCRIPTFILES DIRECTORY_TREES);
}

hook OnGameModeInit()
{
	LoadTreesFromFolder(DIRECTORY_TREES);
}


/*==============================================================================

	Loading

==============================================================================*/


LoadTreesFromFolder(folder[])
{
	new
		foldername[256],
		dir:dirhandle,
		item[64],
		type,
		filename[256];

	format(foldername, sizeof(foldername), DIRECTORY_SCRIPTFILES"%s", folder);
	dirhandle = dir_open(foldername);

	while(dir_list(dirhandle, item, type))
	{
		if(type == FM_FILE)
		{
			if(!strcmp(item[strlen(item) - 4], ".tpl"))
			{
				filename[0] = EOS;
				format(filename, sizeof(filename), "%s%s", folder, item);
				LoadTrees(filename);
			}
		}

		if(type == FM_DIR && strcmp(item, "..") && strcmp(item, ".") && strcmp(item, "_"))
		{
			filename[0] = EOS;
			format(filename, sizeof(filename), "%s%s/", folder, item);
			LoadTreesFromFolder(filename);
		}
	}

	dir_close(dirhandle);
}

LoadTrees(filename[])
{
	new
		File:file,
		line[256],
		linenumber = 1,
		count,

		funcname[32],
		funcargs[128],

		category_name[MAX_TREE_CATEGORY_NAME],
		category_id,
		Float:x,
		Float:y,
		Float:z;

	if(!fexist(filename))
	{
		err("file: \"%s\" NOT FOUND", filename);
		return 0;
	}

	file = fopen(filename, io_read);

	if(!file)
	{
		err("file: \"%s\" NOT LOADED", filename);
		return 0;
	}

	while(fread(file, line))
	{
		if(line[0] < 65)
		{
			linenumber++;
			continue;
		}

		if(sscanf(line, "p<(>s[32]p<)>s[128]{s[96]}", funcname, funcargs))
		{
			linenumber++;
			continue;
		}

		if(!strcmp(funcname, "CreateTree"))
		{
			if(sscanf(funcargs, "p<,>s[32]fff", category_name, x, y, z))
			{
				err("[LoadTrees] Malformed parameters on line %d", linenumber);
				linenumber++;
				continue;
			}

			category_id = GetTreeCategoryFromName(category_name);
			CreateTree(GetRandomTreeSpecies(category_id), x, y, z);
			count++;
			linenumber++;
		}
	}

	log("Loaded %d trees from '%s'.", count, filename);

	return 1;
}
