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


hook OnGameModeInit()
{
	print("\n[OnGameModeInit] Initialising 'bandana'...");

	new tmp;

	tmp = DefineMaskItem(item_BandanaBlue);

	SetMaskOffsetsForSkin(tmp, skin_MainM, 0.088999, 0.034000, -0.002999, -85.499992, 8.599997, -92.800048, 0.998000, 1.000000, 0.914000);
	SetMaskOffsetsForSkin(tmp, skin_MainF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1M, 0.071999, 0.025000, -0.006999, -85.499992, 16.900012, -92.800048, 0.964000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ2M, 0.081999, 0.017000, 0.000000, -85.499992, 14.300015, -92.800048, 1.011000, 1.000000, 0.989001); 
	SetMaskOffsetsForSkin(tmp, skin_Civ3M, 0.079000, 0.019000, 0.002999, -82.199974, 14.199999, -99.000000, 0.941000, 1.265999, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_Civ4M, 0.099999, 0.025000, -0.002999, -85.499992, 5.200016, -92.800048, 1.083000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_MechM, 0.099999, -0.008999, -0.006999, -85.499992, 3.299999, -92.800048, 1.072000, 1.000000, 1.140000);
	SetMaskOffsetsForSkin(tmp, skin_BikeM, 0.093000, 0.021999, 0.002999, -86.900016, 9.399997, -94.800003, 1.058000, 1.000000, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_ArmyM, 0.074000, 0.037999, 0.004999, -86.900016, 4.699994, -94.800003, 1.012000, 1.000000, 0.885999);
	SetMaskOffsetsForSkin(tmp, skin_ClawM, 0.081999, 0.021000, -0.001999, -85.499992, 12.300005, -92.800048, 0.998000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_FreeM, 0.092999, 0.028000, -0.002999, -85.499992, 5.100017, -92.800048, 1.112001, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1F, 0.064999, 0.006000, -0.002999, -85.499992, 8.599997, -92.800048, 1.096000, 1.000000, 1.191000);
	SetMaskOffsetsForSkin(tmp, skin_Civ2F, 0.052999, 0.022000, -0.002999, -85.499992, 12.300005, -92.800048, 1.060000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_Civ3F, 0.052999, 0.025000, -0.001999, -85.499992, 10.300015, -92.800048, 1.020000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ4F, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_ArmyF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_IndiF, 0.042999, 0.027000, -0.003999, -85.499992, 18.700014, -92.800048, 0.869001, 1.000000, 1.019000);


	tmp = DefineMaskItem(item_BandanaGrey);

	SetMaskOffsetsForSkin(tmp, skin_MainM, 0.088999, 0.034000, -0.002999, -85.499992, 8.599997, -92.800048, 0.998000, 1.000000, 0.914000);
	SetMaskOffsetsForSkin(tmp, skin_MainF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1M, 0.071999, 0.025000, -0.006999, -85.499992, 16.900012, -92.800048, 0.964000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ2M, 0.081999, 0.017000, 0.000000, -85.499992, 14.300015, -92.800048, 1.011000, 1.000000, 0.989001); 
	SetMaskOffsetsForSkin(tmp, skin_Civ3M, 0.079000, 0.019000, 0.002999, -82.199974, 14.199999, -99.000000, 0.941000, 1.265999, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_Civ4M, 0.099999, 0.025000, -0.002999, -85.499992, 5.200016, -92.800048, 1.083000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_MechM, 0.099999, -0.008999, -0.006999, -85.499992, 3.299999, -92.800048, 1.072000, 1.000000, 1.140000);
	SetMaskOffsetsForSkin(tmp, skin_BikeM, 0.093000, 0.021999, 0.002999, -86.900016, 9.399997, -94.800003, 1.058000, 1.000000, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_ArmyM, 0.074000, 0.037999, 0.004999, -86.900016, 4.699994, -94.800003, 1.012000, 1.000000, 0.885999);
	SetMaskOffsetsForSkin(tmp, skin_ClawM, 0.081999, 0.021000, -0.001999, -85.499992, 12.300005, -92.800048, 0.998000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_FreeM, 0.092999, 0.028000, -0.002999, -85.499992, 5.100017, -92.800048, 1.112001, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1F, 0.064999, 0.006000, -0.002999, -85.499992, 8.599997, -92.800048, 1.096000, 1.000000, 1.191000);
	SetMaskOffsetsForSkin(tmp, skin_Civ2F, 0.052999, 0.022000, -0.002999, -85.499992, 12.300005, -92.800048, 1.060000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_Civ3F, 0.052999, 0.025000, -0.001999, -85.499992, 10.300015, -92.800048, 1.020000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ4F, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_ArmyF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_IndiF, 0.042999, 0.027000, -0.003999, -85.499992, 18.700014, -92.800048, 0.869001, 1.000000, 1.019000);


	tmp = DefineMaskItem(item_BandanaWhite);

	SetMaskOffsetsForSkin(tmp, skin_MainM, 0.088999, 0.034000, -0.002999, -85.499992, 8.599997, -92.800048, 0.998000, 1.000000, 0.914000);
	SetMaskOffsetsForSkin(tmp, skin_MainF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1M, 0.071999, 0.025000, -0.006999, -85.499992, 16.900012, -92.800048, 0.964000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ2M, 0.081999, 0.017000, 0.000000, -85.499992, 14.300015, -92.800048, 1.011000, 1.000000, 0.989001); 
	SetMaskOffsetsForSkin(tmp, skin_Civ3M, 0.079000, 0.019000, 0.002999, -82.199974, 14.199999, -99.000000, 0.941000, 1.265999, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_Civ4M, 0.099999, 0.025000, -0.002999, -85.499992, 5.200016, -92.800048, 1.083000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_MechM, 0.099999, -0.008999, -0.006999, -85.499992, 3.299999, -92.800048, 1.072000, 1.000000, 1.140000);
	SetMaskOffsetsForSkin(tmp, skin_BikeM, 0.093000, 0.021999, 0.002999, -86.900016, 9.399997, -94.800003, 1.058000, 1.000000, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_ArmyM, 0.074000, 0.037999, 0.004999, -86.900016, 4.699994, -94.800003, 1.012000, 1.000000, 0.885999);
	SetMaskOffsetsForSkin(tmp, skin_ClawM, 0.081999, 0.021000, -0.001999, -85.499992, 12.300005, -92.800048, 0.998000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_FreeM, 0.092999, 0.028000, -0.002999, -85.499992, 5.100017, -92.800048, 1.112001, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1F, 0.064999, 0.006000, -0.002999, -85.499992, 8.599997, -92.800048, 1.096000, 1.000000, 1.191000);
	SetMaskOffsetsForSkin(tmp, skin_Civ2F, 0.052999, 0.022000, -0.002999, -85.499992, 12.300005, -92.800048, 1.060000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_Civ3F, 0.052999, 0.025000, -0.001999, -85.499992, 10.300015, -92.800048, 1.020000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ4F, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_ArmyF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_IndiF, 0.042999, 0.027000, -0.003999, -85.499992, 18.700014, -92.800048, 0.869001, 1.000000, 1.019000);


	tmp = DefineMaskItem(item_BandanaPattern);

	SetMaskOffsetsForSkin(tmp, skin_MainM, 0.088999, 0.034000, -0.002999, -85.499992, 8.599997, -92.800048, 0.998000, 1.000000, 0.914000);
	SetMaskOffsetsForSkin(tmp, skin_MainF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1M, 0.071999, 0.025000, -0.006999, -85.499992, 16.900012, -92.800048, 0.964000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ2M, 0.081999, 0.017000, 0.000000, -85.499992, 14.300015, -92.800048, 1.011000, 1.000000, 0.989001); 
	SetMaskOffsetsForSkin(tmp, skin_Civ3M, 0.079000, 0.019000, 0.002999, -82.199974, 14.199999, -99.000000, 0.941000, 1.265999, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_Civ4M, 0.099999, 0.025000, -0.002999, -85.499992, 5.200016, -92.800048, 1.083000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_MechM, 0.099999, -0.008999, -0.006999, -85.499992, 3.299999, -92.800048, 1.072000, 1.000000, 1.140000);
	SetMaskOffsetsForSkin(tmp, skin_BikeM, 0.093000, 0.021999, 0.002999, -86.900016, 9.399997, -94.800003, 1.058000, 1.000000, 1.000000);
	SetMaskOffsetsForSkin(tmp, skin_ArmyM, 0.074000, 0.037999, 0.004999, -86.900016, 4.699994, -94.800003, 1.012000, 1.000000, 0.885999);
	SetMaskOffsetsForSkin(tmp, skin_ClawM, 0.081999, 0.021000, -0.001999, -85.499992, 12.300005, -92.800048, 0.998000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_FreeM, 0.092999, 0.028000, -0.002999, -85.499992, 5.100017, -92.800048, 1.112001, 1.000000, 0.989001);

	SetMaskOffsetsForSkin(tmp, skin_Civ1F, 0.064999, 0.006000, -0.002999, -85.499992, 8.599997, -92.800048, 1.096000, 1.000000, 1.191000);
	SetMaskOffsetsForSkin(tmp, skin_Civ2F, 0.052999, 0.022000, -0.002999, -85.499992, 12.300005, -92.800048, 1.060000, 1.000000, 1.015000);
	SetMaskOffsetsForSkin(tmp, skin_Civ3F, 0.052999, 0.025000, -0.001999, -85.499992, 10.300015, -92.800048, 1.020000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_Civ4F, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_ArmyF, 0.082999, 0.025000, -0.001999, -85.499992, 6.000015, -92.800048, 1.011000, 1.000000, 0.989001);
	SetMaskOffsetsForSkin(tmp, skin_IndiF, 0.042999, 0.027000, -0.003999, -85.499992, 18.700014, -92.800048, 0.869001, 1.000000, 1.019000);
}
