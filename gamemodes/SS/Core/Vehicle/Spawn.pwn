#include <YSI\y_hooks>


#define VEHICLE_FOLDER				"Vehicles"
#define VEHICLE_SPAWN_CHANCE		(4) // Percent


LoadVehicles(printeach = false, printtotal = false)
{
	LoadPlayerVehicles(printeach, printtotal);
	LoadVehiclesFromFolder(VEHICLE_FOLDER, printeach);

	printf("Loaded %d Vehicles\n", Iter_Count(veh_Index));
}

LoadVehiclesFromFolder(folder[], prints)
{
	new
		foldername[256],
		dir:dirhandle,
		item[64],
		type,
		filename[256];

	format(foldername, sizeof(foldername), "./scriptfiles/%s/", folder);
	dirhandle = dir_open(foldername);

	while(dir_list(dirhandle, item, type))
	{
		if(type == FM_DIR && strcmp(item, "..") && strcmp(item, ".") && strcmp(item, "_"))
		{
			filename[0] = EOS;
			format(filename, sizeof(filename), "%s/%s", folder, item);
			LoadVehiclesFromFolder(filename, prints);
		}
		if(type == FM_FILE)
		{
			if(!strcmp(item[strlen(item) - 4], ".dat"))
			{
				filename[0] = EOS;
				format(filename, sizeof(filename), "%s/%s", folder, item);
				LoadVehiclesFromFile(filename, prints);
			}
		}
	}

	dir_close(dirhandle);
}

LoadVehiclesFromFile(file[], prints)
{
	if(!fexist(file))
	{
		print("VEHICLE FILE NOT FOUND");
		return 0;
	}

	new
		File:f = fopen(file, io_read),
		line[128],
		modelgroupname[28],
		Float:posX,
		Float:posY,
		Float:posZ,
		Float:rotZ,
		model,
		tmpid,
		count,
		total;

	while(fread(f, line))
	{
		if(!sscanf(line, "p<,>ffffD(-1)", posX, posY, posZ, rotZ, model))
		{
			total++;
			if(tmpid - 1 >= MAX_SPAWNED_VEHICLES)
				break;

			if(random(100) < 100 - VEHICLE_SPAWN_CHANCE)
				continue;

			if(model == -1)
			{
				model = PickRandomVehicleFromGroup(veh_CurrentModelGroup);
			}
			else if(0 <= model <= 12)
			{
				model = PickRandomVehicleFromGroup(model);
			}
			else if(400 <= model < 612)
			{
				if(frandom(1.0) > VehicleFuelData[model - 400][veh_spawnRate])
					continue;
			}
			else
			{
				continue;
			}

			switch(model)
			{
				case 403, 443, 514, 515:
				{
					posZ += 2.0;
				}
			}

			switch(veh_CurrentModelGroup)
			{
				case VEHICLE_GROUP_CASUAL, VEHICLE_GROUP_TRUCK_S, VEHICLE_GROUP_SPORT, VEHICLE_GROUP_BIKE:
				{
					rotZ += random(2) ? 0.0 : 180.0;
				}
			}

			tmpid = CreateNewVehicle(model, posX, posY, posZ, rotZ);

			if(!IsValidVehicleID(tmpid))
				continue;

			count++;
		}
		else
		{
			if(!sscanf(line, "'MODELGROUP:'s[28]", modelgroupname))
			{
				strtrim(modelgroupname);

				new newgroup = GetVehicleGroupFromName(modelgroupname);

				if(newgroup != -1 && newgroup != veh_CurrentModelGroup)
					veh_CurrentModelGroup = newgroup;
			}
			else
			{
				if(strlen(line) > 3)
					print("LINE ERROR");
			}
		}
	}
	fclose(f);

	if(prints)
		printf("\t[LOAD] %d vehicles from %s (from total %d spawns)", count, file, total);

	return 1;
}

RandomNumberPlateString()
{
	new str[9];
	for(new c; c < 8; c++)
	{
		if(c<4)str[c] = 'A' + random(26);
		else if(c>4)str[c] = '0' + random(10);
		str[4] = ' ';
	}
	return str;
}
