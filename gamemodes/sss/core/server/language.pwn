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


#define DIRECTORY_LANGUAGES			"languages/"
#define MAX_LANGUAGE				(6)
#define MAX_LANGUAGE_ENTRIES		(500)
#define MAX_LANGUAGE_KEY_LEN		(12)
#define MAX_LANGUAGE_ENTRY_LENGTH	(256)
#define MAX_LANGUAGE_NAME			(32)
#define MAX_LANGUAGE_REPLACEMENTS	(48)
#define MAX_LANGUAGE_REPL_KEY_LEN	(32)
#define MAX_LANGUAGE_REPL_VAL_LEN	(32)

#define DELIMITER_CHAR				'='
#define ALPHABET_SIZE				(26)


enum e_LANGUAGE_ENTRY_DATA
{
	lang_key[MAX_LANGUAGE_KEY_LEN],
	lang_val[MAX_LANGUAGE_ENTRY_LENGTH]
}

enum e_LANGUAGE_TAG_REPLACEMENT_DATA
{
	lang_repl_key[MAX_LANGUAGE_REPL_KEY_LEN],
	lang_repl_val[MAX_LANGUAGE_REPL_VAL_LEN]
}


static
	lang_Entries[MAX_LANGUAGE][MAX_LANGUAGE_ENTRIES][e_LANGUAGE_ENTRY_DATA],
	lang_TotalEntries[MAX_LANGUAGE],
	lang_AlphabetMap[MAX_LANGUAGE][ALPHABET_SIZE],

	lang_Replacements[MAX_LANGUAGE_REPLACEMENTS][e_LANGUAGE_TAG_REPLACEMENT_DATA],
	lang_TotalReplacements,

	lang_Name[MAX_LANGUAGE][MAX_LANGUAGE_NAME],
	lang_Total;


hook OnGameModeInit()
{
	print("\n[OnGameModeInit] Initialising 'language'...");

	DirectoryCheck(DIRECTORY_SCRIPTFILES DIRECTORY_LANGUAGES);

	DefineLanguageReplacement("C_YELLOW",					"{FFFF00}");
	DefineLanguageReplacement("C_RED",						"{E85454}");
	DefineLanguageReplacement("C_GREEN",					"{33AA33}");
	DefineLanguageReplacement("C_BLUE",						"{33CCFF}");
	DefineLanguageReplacement("C_ORANGE",					"{FFAA00}");
	DefineLanguageReplacement("C_GREY",						"{AFAFAF}");
	DefineLanguageReplacement("C_PINK",						"{FFC0CB}");
	DefineLanguageReplacement("C_NAVY",						"{000080}");
	DefineLanguageReplacement("C_GOLD",						"{B8860B}");
	DefineLanguageReplacement("C_LGREEN",					"{00FD4D}");
	DefineLanguageReplacement("C_TEAL",						"{008080}");
	DefineLanguageReplacement("C_BROWN",					"{A52A2A}");
	DefineLanguageReplacement("C_AQUA",						"{F0F8FF}");
	DefineLanguageReplacement("C_BLACK",					"{000000}");
	DefineLanguageReplacement("C_WHITE",					"{FFFFFF}");
	DefineLanguageReplacement("C_SPECIAL",					"{0025AA}");
	DefineLanguageReplacement("KEYTEXT_INTERACT",			"~k~~VEHICLE_ENTER_EXIT~");
	DefineLanguageReplacement("KEYTEXT_RELOAD",				"~k~~PED_ANSWER_PHONE~");
	DefineLanguageReplacement("KEYTEXT_PUT_AWAY",			"~k~~CONVERSATION_YES~");
	DefineLanguageReplacement("KEYTEXT_DROP_ITEM",			"~k~~CONVERSATION_NO~");
	DefineLanguageReplacement("KEYTEXT_INVENTORY",			"~k~~GROUP_CONTROL_BWD~");
	DefineLanguageReplacement("KEYTEXT_ENGINE",				"~k~~CONVERSATION_YES~");
	DefineLanguageReplacement("KEYTEXT_LIGHTS",				"~k~~CONVERSATION_NO~");
	DefineLanguageReplacement("KEYTEXT_DOORS",				"~k~~TOGGLE_SUBMISSIONS~");
	DefineLanguageReplacement("KEYTEXT_RADIO",				"R");

	LoadAllLanguages();
}

stock DefineLanguageReplacement(key[], val[])
{
	strcat(lang_Replacements[lang_TotalReplacements][lang_repl_key], key, MAX_LANGUAGE_REPL_KEY_LEN);
	strcat(lang_Replacements[lang_TotalReplacements][lang_repl_val], val, MAX_LANGUAGE_REPL_VAL_LEN);

	lang_TotalReplacements++;
}

stock LoadAllLanguages()
{
	new
		dir:dirhandle,
		directory_with_root[256] = DIRECTORY_SCRIPTFILES,
		item[64],
		type,
		next_path[256],
		default_entries,
		entries,
		languages;

	strcat(directory_with_root, DIRECTORY_LANGUAGES);

	dirhandle = dir_open(directory_with_root);

	if(!dirhandle)
	{
		printf("[LoadAllLanguages] ERROR: Reading directory '%s'.", directory_with_root);
		return 0;
	}

	// Force load English first since that's the default language.
	default_entries = LoadLanguage(DIRECTORY_LANGUAGES"English", "English");
	printf("Default language (English) has %d entries.", default_entries);

	if(default_entries == 0)
	{
		printf("[LoadAllLanguages] ERROR: No default entries loaded! Please add the 'English' langfile to '%s'.", directory_with_root);
		return 0;
	}

	while(dir_list(dirhandle, item, type))
	{
		if(type == FM_FILE)
		{
			if(!strcmp(item, "English"))
				continue;

			next_path[0] = EOS;
			format(next_path, sizeof(next_path), "%s%s", DIRECTORY_LANGUAGES, item);

			printf("Loading language '%s'...", item);
			entries = LoadLanguage(next_path, item);

			if(entries > 0)
			{
				printf("Loaded! %d entries, %d missing entries", entries, default_entries - entries);
				languages++;
			}
			else
			{
				printf("[LoadAllLanguages] ERROR: No entries loaded from language file '%s'", item);
			}
		}
	}

	dir_close(dirhandle);

	printf("Loaded %d languages", languages);

	return 1;
}

stock LoadLanguage(filename[], langname[])
{
	new
		File:f = fopen(filename, io_read),
		line[256],
		replace_me[MAX_LANGUAGE_ENTRY_LENGTH],
		length,
		delimiter,
		key[MAX_LANGUAGE_KEY_LEN],
		index;

	if(!f)
	{
		printf("[LoadLanguage] ERROR: Unable to open file '%s'.", filename);
		return 0;
	}

	while(fread(f, line))
	{
		length = strlen(line);

		if(length < 4)
			continue;

		delimiter = 0;

		while(line[delimiter] != DELIMITER_CHAR)
		{
			key[delimiter] = line[delimiter];
			delimiter++;
		}

		if(delimiter >= length - 1 || delimiter < 4)
		{
			printf("[LoadLanguage] ERROR: Malformed line in '%s' delimiter character (%c) is absent or in first 4 cells.", filename, DELIMITER_CHAR);
			continue;
		}

		if(!(32 <= key[0] < 127))
		{
			printf("[LoadLanguage] ERROR: First character is abnormal character (%d/%c).", key[0], key[0]);
			continue;
		}

		key[delimiter] = EOS;
		index = lang_TotalEntries[lang_Total]++;

		strmid(lang_Entries[lang_Total][index][lang_key], line, 0, delimiter, MAX_LANGUAGE_ENTRY_LENGTH);
		strmid(replace_me, line, delimiter + 1, length - 1, MAX_LANGUAGE_ENTRY_LENGTH);

		_doReplace(replace_me, lang_Entries[lang_Total][index][lang_val]);
	}

	fclose(f);

	if(lang_TotalEntries[lang_Total] == 0)
	{
		return 0;
	}

	strcat(lang_Name[lang_Total], langname, MAX_LANGUAGE_NAME);

	_qs(lang_Entries[lang_Total], 0, lang_TotalEntries[lang_Total] - 1);

	// alphabetmap
	new
		this_letter,
		letter_idx;

	for(new i; i < lang_TotalEntries[lang_Total]; i++)
	{
		this_letter = toupper(lang_Entries[lang_Total][i][lang_key][0]) - 65;

		if(this_letter == letter_idx-1)
			continue;

		while(letter_idx < this_letter)
		{
			lang_AlphabetMap[lang_Total][letter_idx] = -1;
			letter_idx++;
		}

		lang_AlphabetMap[lang_Total][letter_idx] = i;
		letter_idx++;
	}

	// fill in the empty ones
	while(letter_idx < 26)
		lang_AlphabetMap[lang_Total][letter_idx++] = -1;

	lang_Total++;

	return index;
}

_doReplace(input[], output[])
{
	new
		bool:in_tag = false,
		tag_start = -1,
		output_idx;

	for(new i = 0; input[i] != EOS; ++i)
	{
		if(in_tag)
		{
			if(input[i] == '}')
			{
				for(new j; j < lang_TotalReplacements; ++j)
				{
					if(!strcmp(input[tag_start], lang_Replacements[j][lang_repl_key], false, i - tag_start))
					{
						for(new k; lang_Replacements[j][lang_repl_val][k] != 0 && output_idx < MAX_LANGUAGE_ENTRY_LENGTH; ++k)
							output[output_idx++] = lang_Replacements[j][lang_repl_val][k];

						break;
					}
				}

				in_tag = false;
				continue;
			}
		}
		else
		{
			if(input[i] == '{')
			{
				tag_start = i + 1;
				in_tag = true;
				continue;
			}

			output[output_idx++] = input[i];
		}
	}
}

_qs(array[][], left, right)
{
	new
		tempLeft = left,
		tempRight = right,
		pivot = array[(left + right) / 2][0];

	while(tempLeft <= tempRight)
	{
		while(array[tempLeft][0] < pivot)
			tempLeft++;

		while(array[tempRight][0] > pivot)
			tempRight--;
		
		if(tempLeft <= tempRight)
		{
			_swap(array[tempLeft][lang_key], array[tempRight][lang_key]);
			_swap(array[tempLeft][lang_val], array[tempRight][lang_val]);

			tempLeft++;
			tempRight--;
		}
	}

	if(left < tempRight)
		_qs(array, left, tempRight);

	if(tempLeft < right)
		_qs(array, tempLeft, right);
}

_swap(str1[], str2[])
{
	new tmp;

	for(new i; str1[i] != '\0' || str2[i] != '\0'; i++)
	{
		tmp = str1[i];
		str1[i] = str2[i];
		str2[i] = tmp;
	}
}

stock GetLanguageString(languageid, key[], bool:encode = false)
{
	new
		result[MAX_LANGUAGE_ENTRY_LENGTH],
		ret;

	if(!(0 <= languageid < lang_Total))
	{
		printf("[GetLanguageString] ERROR: Invalid languageid %d.", languageid);
		return result;
	}

	ret = _GetLanguageString(languageid, key, result, encode);

	switch(ret)
	{
		case 1:
			printf("[GetLanguageString] ERROR: Malformed key '%s' must be alphabetical.", key);

		case 2:
			printf("[GetLanguageString] ERROR: Key not found: '%s' in language '%s'", key, lang_Name[languageid]);
	}

	return result;
}

static stock _GetLanguageString(languageid, key[], result[], bool:encode = false)
{
	if(!('A' <= key[0] <= 'Z'))
		return 1;

	new
		index,
		start,
		end,
		abindex;

	abindex = toupper(key[0] - 65);

	start = lang_AlphabetMap[languageid][abindex];

	if(start == -1)
		return 2;

	do
	{
		abindex++;

		if(abindex == ALPHABET_SIZE)
			break;
	}
	while(lang_AlphabetMap[languageid][abindex] == -1);

	if(abindex < ALPHABET_SIZE)
		end = lang_AlphabetMap[languageid][abindex];

	else
		end = lang_TotalEntries[languageid];

	// start..end is now the search space

	// dumb search for now, will probably replace with bisect
	for(index = start; index < end; index++)
	{
		if(!strcmp(lang_Entries[languageid][index][lang_key], key, false, MAX_LANGUAGE_ENTRY_LENGTH))
			break;
	}

	if(index == end)
		return 2;

	strcat(result, lang_Entries[languageid][index][lang_val], MAX_LANGUAGE_ENTRY_LENGTH);

	if(encode)
		ConvertEncoding(result);

	return 0;
}

/*
	Credit for this function goes to Y_Less:
	http://forum.sa-mp.com/showpost.php?p=3015480&postcount=6
*/
stock ConvertEncoding(string[])
{
	static const
		real[256] =
		{
			  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,
			 16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31,
			 32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47,
			 48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63,
			 64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79,
			 80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,
			 96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
			112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
			128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143,
			144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
			160,  94, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
			124, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 175,
			128, 129, 130, 195, 131, 197, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141,
			208, 173, 142, 143, 144, 213, 145, 215, 216, 146, 147, 148, 149, 221, 222, 150,
			151, 152, 153, 227, 154, 229, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164,
			240, 174, 165, 166, 167, 245, 168, 247, 248, 169, 170, 171, 172, 253, 254, 255
		};

	for(new i = 0, len = strlen(string), ch; i != len; ++i)
	{
		// Check if this character is in our reduced range.
		if(0 <= (ch = string[i]) < 256)
		{
			string[i] = real[ch];
		}
	}
}

/*
	Not sure where this code came from... random pastebin link!

stock ConvertEncoding(string[])
{
	for(new i = 0, len = strlen(string); i != len; ++i)
	{
		switch(string[i])
		{
			case 0xC0 .. 0xC3: string[i] -= 0x40;
			case 0xC7 .. 0xC9: string[i] -= 0x42;
			case 0xD2 .. 0xD5: string[i] -= 0x44;
			case 0xD9 .. 0xDC: string[i] -= 0x47;
			case 0xE0 .. 0xE3: string[i] -= 0x49;
			case 0xE7 .. 0xEF: string[i] -= 0x4B;
			case 0xF2 .. 0xF5: string[i] -= 0x4D;
			case 0xF9 .. 0xFC: string[i] -= 0x50;
			case 0xC4, 0xE4: string[i] = 0x83;
			case 0xC6, 0xE6: string[i] = 0x84;
			case 0xD6, 0xF6: string[i] = 0x91;
			case 0xD1, 0xF1: string[i] = 0xEC;
			case 0xDF: string[i] = 0x96;
			case 0xBF: string[i] = 0xAF;
		}
	}
}
*/
stock GetLanguageList(list[][])
{
	for(new i; i < lang_Total; i++)
	{
		list[i][0] = EOS;
		strcat(list[i], lang_Name[i], MAX_LANGUAGE_NAME);
	}

	return lang_Total;
}

stock GetLanguageName(languageid, name[])
{
	if(!(0 <= languageid < lang_Total))
		return 0;

	name[0] = EOS;
	strcat(name, lang_Name[languageid], MAX_LANGUAGE_NAME);

	return 1;
}

stock GetLanguageID(name[])
{
	for(new i; i < lang_Total; i++)
	{
		if(!strcmp(name, lang_Name[i]))
			return i;
	}
	return -1;
}
