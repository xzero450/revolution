data
export remapCount
align 4
LABELV remapCount
byte 4 0
export AddRemap
code
proc AddRemap 8 8
file "../g_utils.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_utils.c -- misc utility functions for game module
;4:
;5:#include "g_local.h"
;6:
;7:typedef struct {
;8:  char oldShader[MAX_QPATH];
;9:  char newShader[MAX_QPATH];
;10:  float timeOffset;
;11:} shaderRemap_t;
;12:
;13:#define MAX_SHADER_REMAPS 128
;14:
;15:int remapCount = 0;
;16:shaderRemap_t remappedShaders[MAX_SHADER_REMAPS];
;17:
;18:void AddRemap(const char *oldShader, const char *newShader, float timeOffset) {
line 21
;19:	int i;
;20:
;21:	for (i = 0; i < remapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $72
JUMPV
LABELV $69
line 22
;22:		if (Q_stricmp(oldShader, remappedShaders[i].oldShader) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $73
line 24
;23:			// found it, just update this one
;24:			strcpy(remappedShaders[i].newShader,newShader);
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 25
;25:			remappedShaders[i].timeOffset = timeOffset;
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders+128
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 26
;26:			return;
ADDRGP4 $68
JUMPV
LABELV $73
line 28
;27:		}
;28:	}
LABELV $70
line 21
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $72
ADDRLP4 0
INDIRI4
ADDRGP4 remapCount
INDIRI4
LTI4 $69
line 29
;29:	if (remapCount < MAX_SHADER_REMAPS) {
ADDRGP4 remapCount
INDIRI4
CNSTI4 128
GEI4 $77
line 30
;30:		strcpy(remappedShaders[remapCount].newShader,newShader);
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 31
;31:		strcpy(remappedShaders[remapCount].oldShader,oldShader);
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 32
;32:		remappedShaders[remapCount].timeOffset = timeOffset;
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders+128
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 33
;33:		remapCount++;
ADDRLP4 4
ADDRGP4 remapCount
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 34
;34:	}
LABELV $77
line 35
;35:}
LABELV $68
endproc AddRemap 8 8
bss
align 1
LABELV $82
skip 4096
export BuildShaderStateConfig
code
proc BuildShaderStateConfig 144 24
line 37
;36:
;37:const char *BuildShaderStateConfig() {
line 42
;38:	static char	buff[MAX_STRING_CHARS*4];
;39:	char out[(MAX_QPATH * 2) + 5];
;40:	int i;
;41:  
;42:	memset(buff, 0, MAX_STRING_CHARS);
ADDRGP4 $82
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 43
;43:	for (i = 0; i < remapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $86
JUMPV
LABELV $83
line 44
;44:		Com_sprintf(out, (MAX_QPATH * 2) + 5, "%s=%s:%5.2f@", remappedShaders[i].oldShader, remappedShaders[i].newShader, remappedShaders[i].timeOffset);
ADDRLP4 4
ARGP4
CNSTI4 133
ARGI4
ADDRGP4 $87
ARGP4
ADDRLP4 140
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders+128
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 45
;45:		Q_strcat( buff, sizeof( buff ), out);
ADDRGP4 $82
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 46
;46:	}
LABELV $84
line 43
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $86
ADDRLP4 0
INDIRI4
ADDRGP4 remapCount
INDIRI4
LTI4 $83
line 47
;47:	return buff;
ADDRGP4 $82
RETP4
LABELV $81
endproc BuildShaderStateConfig 144 24
export G_FindConfigstringIndex
proc G_FindConfigstringIndex 1036 12
line 64
;48:}
;49:
;50:/*
;51:=========================================================================
;52:
;53:model / sound configstring indexes
;54:
;55:=========================================================================
;56:*/
;57:
;58:/*
;59:================
;60:G_FindConfigstringIndex
;61:
;62:================
;63:*/
;64:int G_FindConfigstringIndex( char *name, int start, int max, qboolean create ) {
line 68
;65:	int		i;
;66:	char	s[MAX_STRING_CHARS];
;67:
;68:	if ( !name || !name[0] ) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $93
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $91
LABELV $93
line 69
;69:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $90
JUMPV
LABELV $91
line 72
;70:	}
;71:
;72:	for ( i=1 ; i<max ; i++ ) {
ADDRLP4 1024
CNSTI4 1
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $94
line 73
;73:		trap_GetConfigstring( start + i, s, sizeof( s ) );
ADDRFP4 4
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 74
;74:		if ( !s[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $98
line 75
;75:			break;
ADDRGP4 $96
JUMPV
LABELV $98
line 77
;76:		}
;77:		if ( !strcmp( s, name ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $100
line 78
;78:			return i;
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $90
JUMPV
LABELV $100
line 80
;79:		}
;80:	}
LABELV $95
line 72
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $97
ADDRLP4 1024
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $94
LABELV $96
line 82
;81:
;82:	if ( !create ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $102
line 83
;83:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $90
JUMPV
LABELV $102
line 86
;84:	}
;85:
;86:	if ( i == max ) {
ADDRLP4 1024
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $104
line 87
;87:		G_Error( "G_FindConfigstringIndex: overflow" );
ADDRGP4 $106
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 88
;88:	}
LABELV $104
line 90
;89:
;90:	trap_SetConfigstring( start + i, name );
ADDRFP4 4
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 92
;91:
;92:	return i;
ADDRLP4 1024
INDIRI4
RETI4
LABELV $90
endproc G_FindConfigstringIndex 1036 12
export G_ModelIndex
proc G_ModelIndex 4 16
line 96
;93:}
;94:
;95:
;96:int G_ModelIndex( char *name ) {
line 97
;97:	return G_FindConfigstringIndex (name, CS_MODELS, MAX_MODELS, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
CNSTI4 256
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 G_FindConfigstringIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $107
endproc G_ModelIndex 4 16
export G_SoundIndex
proc G_SoundIndex 4 16
line 100
;98:}
;99:
;100:int G_SoundIndex( char *name ) {
line 101
;101:	return G_FindConfigstringIndex (name, CS_SOUNDS, MAX_SOUNDS, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 288
ARGI4
CNSTI4 256
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 G_FindConfigstringIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $108
endproc G_SoundIndex 4 16
export G_TeamCommand
proc G_TeamCommand 8 8
line 114
;102:}
;103:
;104://=====================================================================
;105:
;106:
;107:/*
;108:================
;109:G_TeamCommand
;110:
;111:Broadcasts a command to only a specific team
;112:================
;113:*/
;114:void G_TeamCommand( team_t team, char *cmd ) {
line 117
;115:	int		i;
;116:
;117:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $113
JUMPV
LABELV $110
line 118
;118:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $115
line 119
;119:			if ( level.clients[i].sess.sessionTeam == team ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $117
line 120
;120:				trap_SendServerCommand( i, va("%s", cmd ));
ADDRGP4 $119
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 121
;121:			}
LABELV $117
line 122
;122:		}
LABELV $115
line 123
;123:	}
LABELV $111
line 117
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $113
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $110
line 124
;124:}
LABELV $109
endproc G_TeamCommand 8 8
export G_Find
proc G_Find 8 8
line 140
;125:
;126:
;127:/*
;128:=============
;129:G_Find
;130:
;131:Searches all active entities for the next one that holds
;132:the matching string at fieldofs (use the FOFS() macro) in the structure.
;133:
;134:Searches beginning at the entity after from, or the beginning if NULL
;135:NULL will be returned if the end of the list is reached.
;136:
;137:=============
;138:*/
;139:gentity_t *G_Find (gentity_t *from, int fieldofs, const char *match)
;140:{
line 143
;141:	char	*s;
;142:
;143:	if (!from)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $121
line 144
;144:		from = g_entities;
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRGP4 $126
JUMPV
LABELV $121
line 146
;145:	else
;146:		from++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
line 148
;147:
;148:	for ( ; from < &g_entities[level.num_entities] ; from++)
ADDRGP4 $126
JUMPV
LABELV $123
line 149
;149:	{
line 150
;150:		if (!from->inuse)
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $128
line 151
;151:			continue;
ADDRGP4 $124
JUMPV
LABELV $128
line 152
;152:		s = *(char **) ((byte *)from + fieldofs);
ADDRLP4 0
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 153
;153:		if (!s)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $130
line 154
;154:			continue;
ADDRGP4 $124
JUMPV
LABELV $130
line 155
;155:		if (!Q_stricmp (s, match))
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $132
line 156
;156:			return from;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $120
JUMPV
LABELV $132
line 157
;157:	}
LABELV $124
line 148
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $126
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTI4 896
ADDRGP4 level+12
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
LTU4 $123
line 159
;158:
;159:	return NULL;
CNSTP4 0
RETP4
LABELV $120
endproc G_Find 8 8
export G_PickTarget
proc G_PickTarget 144 12
line 173
;160:}
;161:
;162:
;163:/*
;164:=============
;165:G_PickTarget
;166:
;167:Selects a random entity from among the targets
;168:=============
;169:*/
;170:#define MAXCHOICES	32
;171:
;172:gentity_t *G_PickTarget (char *targetname)
;173:{
line 174
;174:	gentity_t	*ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 175
;175:	int		num_choices = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 178
;176:	gentity_t	*choice[MAXCHOICES];
;177:
;178:	if (!targetname)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $139
line 179
;179:	{
line 180
;180:		G_Printf("G_PickTarget called with NULL targetname\n");
ADDRGP4 $137
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 181
;181:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $134
JUMPV
LABELV $138
line 185
;182:	}
;183:
;184:	while(1)
;185:	{
line 186
;186:		ent = G_Find (ent, FOFS(targetname), targetname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
line 187
;187:		if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $141
line 188
;188:			break;
ADDRGP4 $140
JUMPV
LABELV $141
line 189
;189:		choice[num_choices++] = ent;
ADDRLP4 140
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 190
;190:		if (num_choices == MAXCHOICES)
ADDRLP4 4
INDIRI4
CNSTI4 32
NEI4 $143
line 191
;191:			break;
ADDRGP4 $140
JUMPV
LABELV $143
line 192
;192:	}
LABELV $139
line 184
ADDRGP4 $138
JUMPV
LABELV $140
line 194
;193:
;194:	if (!num_choices)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $145
line 195
;195:	{
line 196
;196:		G_Printf("G_PickTarget: target %s not found\n", targetname);
ADDRGP4 $147
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 197
;197:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $134
JUMPV
LABELV $145
line 200
;198:	}
;199:
;200:	return choice[rand() % num_choices];
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
RETP4
LABELV $134
endproc G_PickTarget 144 12
export G_UseTargets
proc G_UseTargets 24 12
line 215
;201:}
;202:
;203:
;204:/*
;205:==============================
;206:G_UseTargets
;207:
;208:"activator" should be set to the entity that initiated the firing.
;209:
;210:Search for (string)targetname in all entities that
;211:match (string)self.target and call their .use function
;212:
;213:==============================
;214:*/
;215:void G_UseTargets( gentity_t *ent, gentity_t *activator ) {
line 218
;216:	gentity_t		*t;
;217:	
;218:	if ( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $149
line 219
;219:		return;
ADDRGP4 $148
JUMPV
LABELV $149
line 222
;220:	}
;221:
;222:	if (ent->targetShaderName && ent->targetShaderNewName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CNSTI4 660
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $151
ADDRLP4 4
INDIRP4
CNSTI4 664
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $151
line 223
;223:		float f = level.time * 0.001;
ADDRLP4 12
CNSTF4 981668463
ADDRGP4 level+40
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 224
;224:		AddRemap(ent->targetShaderName, ent->targetShaderNewName, f);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 660
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 AddRemap
CALLV
pop
line 225
;225:		trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
ADDRLP4 20
ADDRGP4 BuildShaderStateConfig
CALLP4
ASGNP4
CNSTI4 24
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 226
;226:	}
LABELV $151
line 228
;227:
;228:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $154
line 229
;229:		return;
ADDRGP4 $148
JUMPV
LABELV $154
line 232
;230:	}
;231:
;232:	t = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $156
line 233
;233:	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
line 234
;234:		if ( t == ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $159
line 235
;235:			G_Printf ("WARNING: Entity used itself.\n");
ADDRGP4 $161
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 236
;236:		} else {
ADDRGP4 $160
JUMPV
LABELV $159
line 237
;237:			if ( t->use ) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $162
line 238
;238:				t->use (t, ent, activator);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 239
;239:			}
LABELV $162
line 240
;240:		}
LABELV $160
line 241
;241:		if ( !ent->inuse ) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $164
line 242
;242:			G_Printf("entity was removed while using targets\n");
ADDRGP4 $166
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 243
;243:			return;
ADDRGP4 $148
JUMPV
LABELV $164
line 245
;244:		}
;245:	}
LABELV $157
line 233
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $156
line 246
;246:}
LABELV $148
endproc G_UseTargets 24 12
bss
align 4
LABELV $168
skip 4
align 4
LABELV $169
skip 96
export tv
code
proc tv 8 0
line 257
;247:
;248:
;249:/*
;250:=============
;251:TempVector
;252:
;253:This is just a convenience function
;254:for making temporary vectors for function calls
;255:=============
;256:*/
;257:float	*tv( float x, float y, float z ) {
line 264
;258:	static	int		index;
;259:	static	vec3_t	vecs[8];
;260:	float	*v;
;261:
;262:	// use an array so that multiple tempvectors won't collide
;263:	// for a while
;264:	v = vecs[index];
ADDRLP4 0
CNSTI4 12
ADDRGP4 $168
INDIRI4
MULI4
ADDRGP4 $169
ADDP4
ASGNP4
line 265
;265:	index = (index + 1)&7;
ADDRLP4 4
ADDRGP4 $168
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 7
BANDI4
ASGNI4
line 267
;266:
;267:	v[0] = x;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRF4
ASGNF4
line 268
;268:	v[1] = y;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 269
;269:	v[2] = z;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 271
;270:
;271:	return v;
ADDRLP4 0
INDIRP4
RETP4
LABELV $167
endproc tv 8 0
bss
align 4
LABELV $171
skip 4
align 1
LABELV $172
skip 256
export vtos
code
proc vtos 12 24
line 283
;272:}
;273:
;274:
;275:/*
;276:=============
;277:VectorToString
;278:
;279:This is just a convenience function
;280:for printing vectors
;281:=============
;282:*/
;283:char	*vtos( const vec3_t v ) {
line 289
;284:	static	int		index;
;285:	static	char	str[8][32];
;286:	char	*s;
;287:
;288:	// use an array so that multiple vtos won't collide
;289:	s = str[index];
ADDRLP4 0
ADDRGP4 $171
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 $172
ADDP4
ASGNP4
line 290
;290:	index = (index + 1)&7;
ADDRLP4 4
ADDRGP4 $171
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 7
BANDI4
ASGNI4
line 292
;291:
;292:	Com_sprintf (s, 32, "(%i %i %i)", (int)v[0], (int)v[1], (int)v[2]);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $173
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 294
;293:
;294:	return s;
ADDRLP4 0
INDIRP4
RETP4
LABELV $170
endproc vtos 12 24
data
align 4
LABELV $175
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV $176
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV $177
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV $178
byte 4 0
byte 4 0
byte 4 3212836864
export G_SetMovedir
code
proc G_SetMovedir 16 16
line 308
;295:}
;296:
;297:
;298:/*
;299:===============
;300:G_SetMovedir
;301:
;302:The editor only specifies a single value for angles (yaw),
;303:but we have special constants to generate an up or down direction.
;304:Angles will be cleared, because it is being used to represent a direction
;305:instead of an orientation.
;306:===============
;307:*/
;308:void G_SetMovedir( vec3_t angles, vec3_t movedir ) {
line 314
;309:	static vec3_t VEC_UP		= {0, -1, 0};
;310:	static vec3_t MOVEDIR_UP	= {0, 0, 1};
;311:	static vec3_t VEC_DOWN		= {0, -2, 0};
;312:	static vec3_t MOVEDIR_DOWN	= {0, 0, -1};
;313:
;314:	if ( VectorCompare (angles, VEC_UP) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $175
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $179
line 315
;315:		VectorCopy (MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 $176
INDIRB
ASGNB 12
line 316
;316:	} else if ( VectorCompare (angles, VEC_DOWN) ) {
ADDRGP4 $180
JUMPV
LABELV $179
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $181
line 317
;317:		VectorCopy (MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 $178
INDIRB
ASGNB 12
line 318
;318:	} else {
ADDRGP4 $182
JUMPV
LABELV $181
line 319
;319:		AngleVectors (angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 320
;320:	}
LABELV $182
LABELV $180
line 321
;321:	VectorClear( angles );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 322
;322:}
LABELV $174
endproc G_SetMovedir 16 16
export vectoyaw
proc vectoyaw 20 8
line 325
;323:
;324:
;325:float vectoyaw( const vec3_t vec ) {
line 328
;326:	float	yaw;
;327:	
;328:	if (vec[YAW] == 0 && vec[PITCH] == 0) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $184
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $184
line 329
;329:		yaw = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 330
;330:	} else {
ADDRGP4 $185
JUMPV
LABELV $184
line 331
;331:		if (vec[PITCH]) {
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 0
EQF4 $186
line 332
;332:			yaw = ( atan2( vec[YAW], vec[PITCH]) * 180 / M_PI );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1127481344
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 333
;333:		} else if (vec[YAW] > 0) {
ADDRGP4 $187
JUMPV
LABELV $186
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 0
LEF4 $188
line 334
;334:			yaw = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 335
;335:		} else {
ADDRGP4 $189
JUMPV
LABELV $188
line 336
;336:			yaw = 270;
ADDRLP4 0
CNSTF4 1132920832
ASGNF4
line 337
;337:		}
LABELV $189
LABELV $187
line 338
;338:		if (yaw < 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $190
line 339
;339:			yaw += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 340
;340:		}
LABELV $190
line 341
;341:	}
LABELV $185
line 343
;342:
;343:	return yaw;
ADDRLP4 0
INDIRF4
RETF4
LABELV $183
endproc vectoyaw 20 8
export G_InitGentity
proc G_InitGentity 4 0
line 347
;344:}
;345:
;346:
;347:void G_InitGentity( gentity_t *e ) {
line 348
;348:	e->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 349
;349:	e->classname = "noclass";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $193
ASGNP4
line 350
;350:	e->s.number = e - g_entities;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ASGNI4
line 351
;351:	e->r.ownerNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1023
ASGNI4
line 352
;352:}
LABELV $192
endproc G_InitGentity 4 0
export G_Spawn
proc G_Spawn 16 20
line 369
;353:
;354:/*
;355:=================
;356:G_Spawn
;357:
;358:Either finds a free entity, or allocates a new one.
;359:
;360:  The slots from 0 to MAX_CLIENTS-1 are always reserved for clients, and will
;361:never be used by anything else.
;362:
;363:Try to avoid reusing an entity that was recently freed, because it
;364:can cause the client to think the entity morphed into something else
;365:instead of being removed and recreated, which can cause interpolated
;366:angles and bad trails.
;367:=================
;368:*/
;369:gentity_t *G_Spawn( void ) {
line 373
;370:	int			i, force;
;371:	gentity_t	*e;
;372:
;373:	e = NULL;	// shut up warning
ADDRLP4 0
CNSTP4 0
ASGNP4
line 374
;374:	i = 0;		// shut up warning
ADDRLP4 4
CNSTI4 0
ASGNI4
line 375
;375:	for ( force = 0 ; force < 2 ; force++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $195
line 378
;376:		// if we go through all entities and can't find one to free,
;377:		// override the normal minimum times before use
;378:		e = &g_entities[MAX_CLIENTS];
ADDRLP4 0
ADDRGP4 g_entities+57344
ASGNP4
line 379
;379:		for ( i = MAX_CLIENTS ; i<level.num_entities ; i++, e++) {
ADDRLP4 4
CNSTI4 64
ASGNI4
ADDRGP4 $203
JUMPV
LABELV $200
line 380
;380:			if ( e->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $205
line 381
;381:				continue;
ADDRGP4 $201
JUMPV
LABELV $205
line 386
;382:			}
;383:
;384:			// the first couple seconds of server time can involve a lot of
;385:			// freeing and allocating, so relax the replacement policy
;386:			if ( !force && e->freetime > level.startTime + 2000 && level.time - e->freetime < 1000 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $207
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 level+48
INDIRI4
CNSTI4 2000
ADDI4
LEI4 $207
ADDRGP4 level+40
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 1000
GEI4 $207
line 387
;387:				continue;
ADDRGP4 $201
JUMPV
LABELV $207
line 391
;388:			}
;389:
;390:			// reuse this slot
;391:			G_InitGentity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 392
;392:			return e;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $194
JUMPV
LABELV $201
line 379
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $203
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $200
line 394
;393:		}
;394:		if ( i != MAX_GENTITIES ) {
ADDRLP4 4
INDIRI4
CNSTI4 1024
EQI4 $211
line 395
;395:			break;
ADDRGP4 $197
JUMPV
LABELV $211
line 397
;396:		}
;397:	}
LABELV $196
line 375
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $195
LABELV $197
line 398
;398:	if ( i == ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 4
INDIRI4
CNSTI4 1022
NEI4 $213
line 399
;399:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $215
line 400
;400:			G_Printf("%4i: %s\n", i, g_entities[i].classname);
ADDRGP4 $219
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 401
;401:		}
LABELV $216
line 399
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $215
line 402
;402:		G_Error( "G_Spawn: no free entities" );
ADDRGP4 $221
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 403
;403:	}
LABELV $213
line 406
;404:	
;405:	// open up a new slot
;406:	level.num_entities++;
ADDRLP4 12
ADDRGP4 level+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 409
;407:
;408:	// let the server system know that there are more entities
;409:	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ), 
ADDRGP4 level+4
INDIRP4
ARGP4
ADDRGP4 level+12
INDIRI4
ARGI4
CNSTI4 896
ARGI4
ADDRGP4 level
INDIRP4
ARGP4
CNSTI4 10828
ARGI4
ADDRGP4 trap_LocateGameData
CALLV
pop
line 412
;410:		&level.clients[0].ps, sizeof( level.clients[0] ) );
;411:
;412:	G_InitGentity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 413
;413:	return e;
ADDRLP4 0
INDIRP4
RETP4
LABELV $194
endproc G_Spawn 16 20
export G_EntitiesFree
proc G_EntitiesFree 8 0
line 421
;414:}
;415:
;416:/*
;417:=================
;418:G_EntitiesFree
;419:=================
;420:*/
;421:qboolean G_EntitiesFree( void ) {
line 425
;422:	int			i;
;423:	gentity_t	*e;
;424:
;425:	e = &g_entities[MAX_CLIENTS];
ADDRLP4 4
ADDRGP4 g_entities+57344
ASGNP4
line 426
;426:	for ( i = MAX_CLIENTS; i < level.num_entities; i++, e++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $230
JUMPV
LABELV $227
line 427
;427:		if ( e->inuse ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $232
line 428
;428:			continue;
ADDRGP4 $228
JUMPV
LABELV $232
line 431
;429:		}
;430:		// slot available
;431:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $225
JUMPV
LABELV $228
line 426
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $230
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $227
line 433
;432:	}
;433:	return qfalse;
CNSTI4 0
RETI4
LABELV $225
endproc G_EntitiesFree 8 0
export G_FreeEntity
proc G_FreeEntity 0 12
line 444
;434:}
;435:
;436:
;437:/*
;438:=================
;439:G_FreeEntity
;440:
;441:Marks the entity as free
;442:=================
;443:*/
;444:void G_FreeEntity( gentity_t *ed ) {
line 445
;445:	trap_UnlinkEntity (ed);		// unlink from world
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 447
;446:
;447:	if ( ed->neverFree ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $235
line 448
;448:		return;
ADDRGP4 $234
JUMPV
LABELV $235
line 451
;449:	}
;450:
;451:	memset (ed, 0, sizeof(*ed));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 896
ARGI4
ADDRGP4 memset
CALLP4
pop
line 452
;452:	ed->classname = "freed";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $237
ASGNP4
line 453
;453:	ed->freetime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 454
;454:	ed->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 455
;455:}
LABELV $234
endproc G_FreeEntity 0 12
export G_TempEntity
proc G_TempEntity 20 8
line 466
;456:
;457:/*
;458:=================
;459:G_TempEntity
;460:
;461:Spawns an event entity that will be auto-removed
;462:The origin will be snapped to save net bandwidth, so care
;463:must be taken if the origin is right on a surface (snap towards start vector first)
;464:=================
;465:*/
;466:gentity_t *G_TempEntity( vec3_t origin, int event ) {
line 470
;467:	gentity_t		*e;
;468:	vec3_t		snapped;
;469:
;470:	e = G_Spawn();
ADDRLP4 16
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 471
;471:	e->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 473
;472:
;473:	e->classname = "tempEntity";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $240
ASGNP4
line 474
;474:	e->eventTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 475
;475:	e->freeAfterEvent = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 477
;476:
;477:	VectorCopy( origin, snapped );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 478
;478:	SnapVector( snapped );		// save network bandwidth
ADDRLP4 4
ADDRLP4 4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 479
;479:	G_SetOrigin( e, snapped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 482
;480:
;481:	// find cluster for PVS
;482:	trap_LinkEntity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 484
;483:
;484:	return e;
ADDRLP4 0
INDIRP4
RETP4
LABELV $239
endproc G_TempEntity 20 8
export G_KillBox
proc G_KillBox 4176 32
line 505
;485:}
;486:
;487:
;488:
;489:/*
;490:==============================================================================
;491:
;492:Kill box
;493:
;494:==============================================================================
;495:*/
;496:
;497:/*
;498:=================
;499:G_KillBox
;500:
;501:Kills all entities that would touch the proposed new positioning
;502:of ent.  Ent should be unlinked before calling this!
;503:=================
;504:*/
;505:void G_KillBox (gentity_t *ent) {
line 511
;506:	int			i, num;
;507:	int			touch[MAX_GENTITIES];
;508:	gentity_t	*hit;
;509:	vec3_t		mins, maxs;
;510:
;511:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4136
ADDRLP4 4132
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4136
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4132
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4136
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4132
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108+8
ADDRLP4 4140
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4140
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 512
;512:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4148
ADDRLP4 4144
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4148
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4144
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4148
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4144
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120+8
ADDRLP4 4152
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4152
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 513
;513:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4156
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4156
INDIRI4
ASGNI4
line 515
;514:
;515:	for (i=0 ; i<num ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $254
JUMPV
LABELV $251
line 516
;516:		hit = &g_entities[touch[i]];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 520
;517:/*freeze
;518:		if ( !hit->client ) {
;519:freeze*/
;520:		if ( (g_gamemode.integer < 4 && !hit->client) || (g_gamemode.integer > 3 && !hit->client && !is_body_freeze( hit )) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $260
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $259
LABELV $260
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $255
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $255
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 is_body_freeze
CALLI4
ASGNI4
ADDRLP4 4164
INDIRI4
CNSTI4 0
NEI4 $255
LABELV $259
line 522
;521://freeze
;522:			continue;
ADDRGP4 $252
JUMPV
LABELV $255
line 526
;523:		}
;524:
;525:		// nail it
;526:		G_Damage ( hit, ent, ent, NULL, NULL,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4168
INDIRP4
ARGP4
ADDRLP4 4168
INDIRP4
ARGP4
ADDRLP4 4172
CNSTP4 0
ASGNP4
ADDRLP4 4172
INDIRP4
ARGP4
ADDRLP4 4172
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 528
;527:			100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
;528:	}
LABELV $252
line 515
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $254
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $251
line 530
;529:
;530:}
LABELV $246
endproc G_KillBox 4176 32
export G_AddPredictableEvent
proc G_AddPredictableEvent 0 12
line 543
;531:
;532://==============================================================================
;533:
;534:/*
;535:===============
;536:G_AddPredictableEvent
;537:
;538:Use for non-pmove events that would also be predicted on the
;539:client side: jumppads and item pickups
;540:Adds an event+parm and twiddles the event counter
;541:===============
;542:*/
;543:void G_AddPredictableEvent( gentity_t *ent, int event, int eventParm ) {
line 544
;544:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $262
line 545
;545:		return;
ADDRGP4 $261
JUMPV
LABELV $262
line 547
;546:	}
;547:	BG_AddPredictableEventToPlayerstate( event, eventParm, &ent->client->ps );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 548
;548:}
LABELV $261
endproc G_AddPredictableEvent 0 12
export G_AddEvent
proc G_AddEvent 4 8
line 558
;549:
;550:
;551:/*
;552:===============
;553:G_AddEvent
;554:
;555:Adds an event+parm and twiddles the event counter
;556:===============
;557:*/
;558:void G_AddEvent( gentity_t *ent, int event, int eventParm ) {
line 561
;559:	int		bits;
;560:
;561:	if ( !event ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $265
line 562
;562:		G_Printf( "G_AddEvent: zero event added for entity %i\n", ent->s.number );
ADDRGP4 $267
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 563
;563:		return;
ADDRGP4 $264
JUMPV
LABELV $265
line 567
;564:	}
;565:
;566:	// clients need to add the event in playerState_t instead of entityState_t
;567:	if ( ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $268
line 568
;568:		bits = ent->client->ps.externalEvent & EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 768
BANDI4
ASGNI4
line 569
;569:		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
CNSTI4 768
BANDI4
ASGNI4
line 570
;570:		ent->client->ps.externalEvent = event | bits;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 571
;571:		ent->client->ps.externalEventParm = eventParm;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 572
;572:		ent->client->ps.externalEventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 573
;573:	} else {
ADDRGP4 $269
JUMPV
LABELV $268
line 574
;574:		bits = ent->s.event & EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 768
BANDI4
ASGNI4
line 575
;575:		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
CNSTI4 768
BANDI4
ASGNI4
line 576
;576:		ent->s.event = event | bits;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 577
;577:		ent->s.eventParm = eventParm;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 578
;578:	}
LABELV $269
line 579
;579:	ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 580
;580:}
LABELV $264
endproc G_AddEvent 4 8
export G_Sound
proc G_Sound 8 8
line 588
;581:
;582:
;583:/*
;584:=============
;585:G_Sound
;586:=============
;587:*/
;588:void G_Sound( gentity_t *ent, int channel, int soundIndex ) {
line 591
;589:	gentity_t	*te;
;590:
;591:	te = G_TempEntity( ent->r.currentOrigin, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 592
;592:	te->s.eventParm = soundIndex;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 593
;593:	te->s.clientNum = ent->s.number;//XX
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 601
;594:
;595:	/*if (ent && ent->client)
;596:	{ //Is this needed?
;597:		te->r.svFlags |= SVF_CLIENTMASK;
;598:		te->r.singleClient = GetClientMask(ent->client->sess.sessionTeam);
;599:	}*/
;600:
;601:}
LABELV $272
endproc G_Sound 8 8
export G_SetOrigin
proc G_SetOrigin 8 0
line 614
;602:
;603:
;604://==============================================================================
;605:
;606:
;607:/*
;608:================
;609:G_SetOrigin
;610:
;611:Sets the pos trajectory for a fixed position
;612:================
;613:*/
;614:void G_SetOrigin( gentity_t *ent, vec3_t origin ) {
line 615
;615:	VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 616
;616:	ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 617
;617:	ent->s.pos.trTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 618
;618:	ent->s.pos.trDuration = 0;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 619
;619:	VectorClear( ent->s.pos.trDelta );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 621
;620:
;621:	VectorCopy( origin, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 622
;622:}
LABELV $273
endproc G_SetOrigin 8 0
lit
align 4
LABELV $275
byte 4 0
byte 4 0
byte 4 1065353216
export DebugLine
code
proc DebugLine 116 12
line 632
;623:
;624:/*
;625:================
;626:DebugLine
;627:
;628:  debug polygons only work when running a local game
;629:  with r_debugSurface set to 2
;630:================
;631:*/
;632:int DebugLine(vec3_t start, vec3_t end, int color) {
line 633
;633:	vec3_t points[4], dir, cross, up = {0, 0, 1};
ADDRLP4 72
ADDRGP4 $275
INDIRB
ASGNB 12
line 636
;634:	float dot;
;635:
;636:	VectorCopy(start, points[0]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 637
;637:	VectorCopy(start, points[1]);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 639
;638:	//points[1][2] -= 2;
;639:	VectorCopy(end, points[2]);
ADDRLP4 0+24
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 641
;640:	//points[2][2] -= 2;
;641:	VectorCopy(end, points[3]);
ADDRLP4 0+36
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 644
;642:
;643:
;644:	VectorSubtract(end, start, dir);
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 88
INDIRP4
INDIRF4
ADDRLP4 92
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96
CNSTI4 4
ASGNI4
ADDRLP4 60+4
ADDRLP4 88
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 100
CNSTI4 8
ASGNI4
ADDRLP4 60+8
ADDRFP4 4
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 645
;645:	VectorNormalize(dir);
ADDRLP4 60
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 646
;646:	dot = DotProduct(dir, up);
ADDRLP4 84
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
MULF4
ADDF4
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 647
;647:	if (dot > 0.99 || dot < -0.99) VectorSet(cross, 1, 0, 0);
ADDRLP4 84
INDIRF4
CNSTF4 1065185444
GTF4 $287
ADDRLP4 84
INDIRF4
CNSTF4 3212669092
GEF4 $285
LABELV $287
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
ADDRLP4 48+4
CNSTF4 0
ASGNF4
ADDRLP4 48+8
CNSTF4 0
ASGNF4
ADDRGP4 $286
JUMPV
LABELV $285
line 648
;648:	else CrossProduct(dir, up, cross);
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
LABELV $286
line 650
;649:
;650:	VectorNormalize(cross);
ADDRLP4 48
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 652
;651:
;652:	VectorMA(points[0], 2, cross, points[0]);
ADDRLP4 108
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 653
;653:	VectorMA(points[1], -2, cross, points[1]);
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
CNSTF4 3221225472
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 654
;654:	VectorMA(points[2], -2, cross, points[2]);
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 3221225472
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 655
;655:	VectorMA(points[3], 2, cross, points[3]);
ADDRLP4 0+36
ADDRLP4 0+36
INDIRF4
CNSTF4 1073741824
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+36+4
ADDRLP4 0+36+4
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+36+8
ADDRLP4 0+36+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 657
;656:
;657:	return trap_DebugPolygonCreate(color, 4, points);
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 112
ADDRGP4 trap_DebugPolygonCreate
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
RETI4
LABELV $274
endproc DebugLine 116 12
bss
export remappedShaders
align 4
LABELV remappedShaders
skip 16896
import Cmd_Timein_f
import Cmd_Timeout_f
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Args
import trap_Milliseconds
import trap_Error
import trap_Printf
import sv_allowUnnamed
import sv_motd8
import sv_motd7
import sv_motd6
import sv_motd5
import sv_motd4
import sv_motd3
import sv_motd2
import sv_motd1
import g_interference
import g_spawnProtection
import g_allowObliterate
import g_freezeAutothawTime
import g_freezeRoundRespawn
import g_DynamicGauntletCycle
import g_gauntletjumpRadius
import g_gauntletJumping
import g_gauntletKnockback
import sv_lock_cg_railHum_to
import g_allowSave
import g_AdminPassword
import g_fixMuzzleBug
import g_readyGrace
import g_allowReady
import g_sacrificeAnnounce
import g_flagSacrifice
import lastmap
import modname
import g_timeInGrace
import g_timeOutLength
import g_timeOutLimit
import g_allowHandicap
import g_pro_mode
import g_muteTourneyspecs
import g_muteSpecs
import g_fastSwitch
import g_fastRespawn
import weap_bfgCycle
import weap_plasmagunCycle
import weap_railgunCycle
import weap_rocketlauncherCycle
import weap_lightninggunCycle
import weap_grenadelauncherCycle
import weap_shotgunCycle
import weap_machinegunCycle
import weap_gauntletCycle
import weap_allowed
import weap_enableHook
import g_wpflags
import sv_fps
import g_delagProjectiles
import g_delagHitscan
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import sv_lock_pmove
import pmove_msec
import pmove_fixed
import g_IU_ctf_sounds
import g_returnFlag
import g_DynamicRailgunCycle
import g_RailjumpRadius
import g_RailJumping
import g_teamKnockback
import g_railgunKnockback
import g_StaticKnockback
import g_SelfDamage
import g_FallingDamage
import g_allowLockedTeams
import g_gamemode
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import sv_minRate
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import bans
import g_entities
import gameSettings
import tasks
import level
import InvulnerabilityEffect
import locationSpawn
import CheckDelay
import team_wins
import player_freeze
import is_body_freeze
import is_body
import DamageBody
import Body_free
import Persistant_spectator
import respawnSpectator
import Set_Client
import Set_spectator
import is_spectator
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsgByVec
import Team_GetLocationMsg
import Team_GetLocationByVec
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import getTimeDiff
import G_WriteBans
import G_WriteGameSetings
import G_WriteTaskData
import G_WriteSessionData
import G_InitWorldSession
import G_ReadBans
import G_InitSessionData
import G_ReadGameSetings
import G_ReadTaskData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import ClassnameIsMover
import AnnounceFlagSacrifice
import PlayerHasFlagPowerup
import NoDropAreaBelow
import SpawnFlagAtLastKnownGood
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import ReadyCheck
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import G_TimeShiftClient
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import FireWeaponGrapple
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletJump
import CheckGauntletAttack
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_railgun
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import CPM_RadiusDamage
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import G_TouchSolids
import G_TouchTriggers
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Registered
import CheckForAutoUnlock
import FindMapNameForNumber
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import Cmd_Stats_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import BG_ProModePlayerTouchesItem
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import trap_FS_FOpenFile
import CG_FileExists
import findCharacter
import FixedName
import SanitizeString
import ConcatArgs
import trap_Argv
import trap_Argc
import Q_CopyStringUntil
import Q_CleanString
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import stristr
import HelpParse
import GetToken
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import SnapVectorTowards
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import ColorIndex
import color_z
import color_y
import color_x
import color_w
import color_v
import color_u
import color_t
import color_s
import color_r
import color_q
import color_p
import color_o
import color_n
import color_m
import color_l
import color_k
import color_j
import color_i
import color_h
import color_g
import color_f
import color_e
import color_d
import color_c
import color_b
import color_a
import colorMdGrey
import colorOrange
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $267
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 69
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $237
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $221
byte 1 71
byte 1 95
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $219
byte 1 37
byte 1 52
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $193
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $173
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 0
align 1
LABELV $166
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $147
byte 1 71
byte 1 95
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $137
byte 1 71
byte 1 95
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 71
byte 1 95
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $87
byte 1 37
byte 1 115
byte 1 61
byte 1 37
byte 1 115
byte 1 58
byte 1 37
byte 1 53
byte 1 46
byte 1 50
byte 1 102
byte 1 64
byte 1 0
