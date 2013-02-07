data
align 4
LABELV captureFunc
byte 4 0
align 4
LABELV captureData
byte 4 0
align 4
LABELV itemCapture
byte 4 0
export DC
align 4
LABELV DC
byte 4 0
align 4
LABELV g_waitingForKey
byte 4 0
align 4
LABELV g_editingField
byte 4 0
align 4
LABELV g_bindItem
byte 4 0
align 4
LABELV g_editItem
byte 4 0
export menuCount
align 4
LABELV menuCount
byte 4 0
export openMenuCount
align 4
LABELV openMenuCount
byte 4 0
align 4
LABELV debugMode
byte 4 0
align 4
LABELV lastListBoxClickTime
byte 4 0
export UI_Alloc
code
proc UI_Alloc 8 4
file "../ui_shared.c"
line 71
;1:// 
;2:// string allocation/managment
;3:
;4:#include "ui_shared.h"
;5:
;6:#define SCROLL_TIME_START					500
;7:#define SCROLL_TIME_ADJUST				150
;8:#define SCROLL_TIME_ADJUSTOFFSET	40
;9:#define SCROLL_TIME_FLOOR					20
;10:
;11:typedef struct scrollInfo_s {
;12:	int nextScrollTime;
;13:	int nextAdjustTime;
;14:	int adjustValue;
;15:	int scrollKey;
;16:	float xStart;
;17:	float yStart;
;18:	itemDef_t *item;
;19:	qboolean scrollDir;
;20:} scrollInfo_t;
;21:
;22:static scrollInfo_t scrollInfo;
;23:
;24:static void (*captureFunc) (void *p) = NULL;
;25:static void *captureData = NULL;
;26:static itemDef_t *itemCapture = NULL;   // item that has the mouse captured ( if any )
;27:
;28:displayContextDef_t *DC = NULL;
;29:
;30:static qboolean g_waitingForKey = qfalse;
;31:static qboolean g_editingField = qfalse;
;32:
;33:static itemDef_t *g_bindItem = NULL;
;34:static itemDef_t *g_editItem = NULL;
;35:
;36:menuDef_t Menus[MAX_MENUS];      // defined menus
;37:int menuCount = 0;               // how many
;38:
;39:menuDef_t *menuStack[MAX_OPEN_MENUS];
;40:int openMenuCount = 0;
;41:
;42:static qboolean debugMode = qfalse;
;43:
;44:#define DOUBLE_CLICK_DELAY 300
;45:static int lastListBoxClickTime = 0;
;46:
;47:void Item_RunScript(itemDef_t *item, const char *s);
;48:void Item_SetupKeywordHash(void);
;49:void Menu_SetupKeywordHash(void);
;50:int BindingIDFromName(const char *name);
;51:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down);
;52:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu);
;53:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu);
;54:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y);
;55:
;56:#ifdef CGAME
;57:#define MEM_POOL_SIZE  128 * 1024
;58:#else
;59:#define MEM_POOL_SIZE  1024 * 1024
;60:#endif
;61:
;62:static char		memoryPool[MEM_POOL_SIZE];
;63:static int		allocPoint, outOfMemory;
;64:
;65:
;66:/*
;67:===============
;68:UI_Alloc
;69:===============
;70:*/				  
;71:void *UI_Alloc( int size ) {
line 74
;72:	char	*p; 
;73:
;74:	if ( allocPoint + size > MEM_POOL_SIZE ) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 1048576
LEI4 $42
line 75
;75:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 76
;76:		if (DC->Print) {
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $44
line 77
;77:			DC->Print("UI_Alloc: Failure. Out of memory!\n");
ADDRGP4 $46
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 78
;78:		}
LABELV $44
line 80
;79:    //DC->trap_Print(S_COLOR_YELLOW"WARNING: UI Out of Memory!\n");
;80:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $41
JUMPV
LABELV $42
line 83
;81:	}
;82:
;83:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 85
;84:
;85:	allocPoint += ( size + 15 ) & ~15;
ADDRLP4 4
ADDRGP4 allocPoint
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 15
ADDI4
CNSTI4 -16
BANDI4
ADDI4
ASGNI4
line 87
;86:
;87:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $41
endproc UI_Alloc 8 4
export UI_InitMemory
proc UI_InitMemory 0 0
line 95
;88:}
;89:
;90:/*
;91:===============
;92:UI_InitMemory
;93:===============
;94:*/
;95:void UI_InitMemory( void ) {
line 96
;96:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 97
;97:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 98
;98:}
LABELV $47
endproc UI_InitMemory 0 0
export UI_OutOfMemory
proc UI_OutOfMemory 0 0
line 100
;99:
;100:qboolean UI_OutOfMemory() {
line 101
;101:	return outOfMemory;
ADDRGP4 outOfMemory
INDIRI4
RETI4
LABELV $48
endproc UI_OutOfMemory 0 0
proc hashForString 16 4
line 114
;102:}
;103:
;104:
;105:
;106:
;107:
;108:#define HASH_TABLE_SIZE 2048
;109:/*
;110:================
;111:return a hash value for the string
;112:================
;113:*/
;114:static long hashForString(const char *str) {
line 119
;115:	int		i;
;116:	long	hash;
;117:	char	letter;
;118:
;119:	hash = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 120
;120:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $51
JUMPV
LABELV $50
line 121
;121:	while (str[i] != '\0') {
line 122
;122:		letter = tolower(str[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 123
;123:		hash+=(long)(letter)*(i+119);
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
line 124
;124:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 125
;125:	}
LABELV $51
line 121
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $50
line 126
;126:	hash &= (HASH_TABLE_SIZE-1);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2047
BANDI4
ASGNI4
line 127
;127:	return hash;
ADDRLP4 8
INDIRI4
RETI4
LABELV $49
endproc hashForString 16 4
data
align 4
LABELV strPoolIndex
byte 4 0
align 4
LABELV strHandleCount
byte 4 0
align 4
LABELV $54
address $55
export String_Alloc
code
proc String_Alloc 44 8
line 142
;128:}
;129:
;130:typedef struct stringDef_s {
;131:	struct stringDef_s *next;
;132:	const char *str;
;133:} stringDef_t;
;134:
;135:static int strPoolIndex = 0;
;136:static char strPool[STRING_POOL_SIZE];
;137:
;138:static int strHandleCount = 0;
;139:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;140:
;141:
;142:const char *String_Alloc(const char *p) {
line 148
;143:	int len;
;144:	long hash;
;145:	stringDef_t *str, *last;
;146:	static const char *staticNULL = "";
;147:
;148:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $56
line 149
;149:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $53
JUMPV
LABELV $56
line 152
;150:	}
;151:
;152:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $58
line 153
;153:		return staticNULL;
ADDRGP4 $54
INDIRP4
RETP4
ADDRGP4 $53
JUMPV
LABELV $58
line 156
;154:	}
;155:
;156:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 158
;157:
;158:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $61
JUMPV
LABELV $60
line 159
;159:	while (str) {
line 160
;160:		if (strcmp(p, str->str) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $63
line 161
;161:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $53
JUMPV
LABELV $63
line 163
;162:		}
;163:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 164
;164:	}
LABELV $61
line 159
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $60
line 166
;165:
;166:	len = strlen(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 167
;167:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 393216
GEI4 $65
line 168
;168:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 169
;169:		strcpy(&strPool[strPoolIndex], p);
ADDRGP4 strPoolIndex
INDIRI4
ADDRGP4 strPool
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 170
;170:		strPoolIndex += len + 1;
ADDRLP4 28
ADDRGP4 strPoolIndex
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 172
;171:
;172:		str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 173
;173:		last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $68
JUMPV
LABELV $67
line 174
;174:		while (str && str->next) {
line 175
;175:			last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 176
;176:			str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 177
;177:		}
LABELV $68
line 174
ADDRLP4 36
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $70
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
NEU4 $67
LABELV $70
line 179
;178:
;179:		str  = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 40
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 180
;180:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 181
;181:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 182
;182:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $71
line 183
;183:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 184
;184:		} else {
ADDRGP4 $72
JUMPV
LABELV $71
line 185
;185:			strHandle[hash] = str;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 186
;186:		}
LABELV $72
line 187
;187:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $53
JUMPV
LABELV $65
line 189
;188:	}
;189:	return NULL;
CNSTP4 0
RETP4
LABELV $53
endproc String_Alloc 44 8
export String_Report
proc String_Report 4 16
line 192
;190:}
;191:
;192:void String_Report() {
line 194
;193:	float f;
;194:	Com_Printf("Memory/String Pool Info\n");
ADDRGP4 $74
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 195
;195:	Com_Printf("----------------\n");
ADDRGP4 $75
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 196
;196:	f = strPoolIndex;
ADDRLP4 0
ADDRGP4 strPoolIndex
INDIRI4
CVIF4 4
ASGNF4
line 197
;197:	f /= STRING_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1220542464
DIVF4
ASGNF4
line 198
;198:	f *= 100;
ADDRLP4 0
CNSTF4 1120403456
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 199
;199:	Com_Printf("String Pool is %.1f%% full, %i bytes out of %i used.\n", f, strPoolIndex, STRING_POOL_SIZE);
ADDRGP4 $76
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 strPoolIndex
INDIRI4
ARGI4
CNSTI4 393216
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 200
;200:	f = allocPoint;
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
CVIF4 4
ASGNF4
line 201
;201:	f /= MEM_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1233125376
DIVF4
ASGNF4
line 202
;202:	f *= 100;
ADDRLP4 0
CNSTF4 1120403456
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 203
;203:	Com_Printf("Memory Pool is %.1f%% full, %i bytes out of %i used.\n", f, allocPoint, MEM_POOL_SIZE);
ADDRGP4 $77
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 allocPoint
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 204
;204:}
LABELV $73
endproc String_Report 4 16
export String_Init
proc String_Init 12 0
line 211
;205:
;206:/*
;207:=================
;208:String_Init
;209:=================
;210:*/
;211:void String_Init() {
line 213
;212:	int i;
;213:	for (i = 0; i < HASH_TABLE_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $79
line 214
;214:		strHandle[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
CNSTP4 0
ASGNP4
line 215
;215:	}
LABELV $80
line 213
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2048
LTI4 $79
line 216
;216:	strHandleCount = 0;
ADDRGP4 strHandleCount
CNSTI4 0
ASGNI4
line 217
;217:	strPoolIndex = 0;
ADDRGP4 strPoolIndex
CNSTI4 0
ASGNI4
line 218
;218:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 219
;219:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 220
;220:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 221
;221:	Item_SetupKeywordHash();
ADDRGP4 Item_SetupKeywordHash
CALLV
pop
line 222
;222:	Menu_SetupKeywordHash();
ADDRGP4 Menu_SetupKeywordHash
CALLV
pop
line 223
;223:	if (DC && DC->getBindingBuf) {
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $83
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $83
line 224
;224:		Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 225
;225:	}
LABELV $83
line 226
;226:}
LABELV $78
endproc String_Init 12 0
bss
align 1
LABELV $86
skip 4096
export PC_SourceWarning
code
proc PC_SourceWarning 136 16
line 233
;227:
;228:/*
;229:=================
;230:PC_SourceWarning
;231:=================
;232:*/
;233:void PC_SourceWarning(int handle, char *format, ...) {
line 239
;234:	int line;
;235:	char filename[128];
;236:	va_list argptr;
;237:	static char string[4096];
;238:
;239:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 240
;240:	vsprintf (string, format, argptr);
ADDRGP4 $86
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 241
;241:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 243
;242:
;243:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 244
;244:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 245
;245:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 247
;246:
;247:	Com_Printf(S_COLOR_YELLOW "WARNING: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $88
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 248
;248:}
LABELV $85
endproc PC_SourceWarning 136 16
bss
align 1
LABELV $90
skip 4096
export PC_SourceError
code
proc PC_SourceError 136 16
line 255
;249:
;250:/*
;251:=================
;252:PC_SourceError
;253:=================
;254:*/
;255:void PC_SourceError(int handle, char *format, ...) {
line 261
;256:	int line;
;257:	char filename[128];
;258:	va_list argptr;
;259:	static char string[4096];
;260:
;261:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 262
;262:	vsprintf (string, format, argptr);
ADDRGP4 $90
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 263
;263:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 265
;264:
;265:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 266
;266:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 267
;267:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 269
;268:
;269:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $92
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 270
;270:}
LABELV $89
endproc PC_SourceError 136 16
export LerpColor
proc LerpColor 12 0
line 278
;271:
;272:/*
;273:=================
;274:LerpColor
;275:=================
;276:*/
;277:void LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
;278:{
line 282
;279:	int i;
;280:
;281:	// lerp and clamp each component
;282:	for (i=0; i<4; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $94
line 283
;283:	{
line 284
;284:		c[i] = a[i] + t*(b[i]-a[i]);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 285
;285:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $98
line 286
;286:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $99
JUMPV
LABELV $98
line 287
;287:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $100
line 288
;288:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $100
LABELV $99
line 289
;289:	}
LABELV $95
line 282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $94
line 290
;290:}
LABELV $93
endproc LerpColor 12 0
export Float_Parse
proc Float_Parse 16 8
line 297
;291:
;292:/*
;293:=================
;294:Float_Parse
;295:=================
;296:*/
;297:qboolean Float_Parse(char **p, float *f) {
line 299
;298:	char	*token;
;299:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 300
;300:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $103
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $103
line 301
;301:		*f = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 302
;302:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 303
;303:	} else {
line 304
;304:		return qfalse;
CNSTI4 0
RETI4
LABELV $102
endproc Float_Parse 16 8
export PC_Float_Parse
proc PC_Float_Parse 1052 12
line 313
;305:	}
;306:}
;307:
;308:/*
;309:=================
;310:PC_Float_Parse
;311:=================
;312:*/
;313:qboolean PC_Float_Parse(int handle, float *f) {
line 315
;314:	pc_token_t token;
;315:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 317
;316:
;317:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $106
line 318
;318:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $106
line 319
;319:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $108
line 320
;320:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $111
line 321
;321:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $111
line 322
;322:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 323
;323:	}
LABELV $108
line 324
;324:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $113
line 325
;325:		PC_SourceError(handle, "expected float but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $115
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 326
;326:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $113
line 328
;327:	}
;328:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $117
line 329
;329:		*f = -token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
NEGF4
ASGNF4
ADDRGP4 $118
JUMPV
LABELV $117
line 331
;330:	else
;331:		*f = token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
ASGNF4
LABELV $118
line 332
;332:	return qtrue;
CNSTI4 1
RETI4
LABELV $105
endproc PC_Float_Parse 1052 12
export Color_Parse
proc Color_Parse 12 8
line 340
;333:}
;334:
;335:/*
;336:=================
;337:Color_Parse
;338:=================
;339:*/
;340:qboolean Color_Parse(char **p, vec4_t *c) {
line 344
;341:	int i;
;342:	float f;
;343:
;344:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $122
line 345
;345:		if (!Float_Parse(p, &f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $126
line 346
;346:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $121
JUMPV
LABELV $126
line 348
;347:		}
;348:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 349
;349:	}
LABELV $123
line 344
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $122
line 350
;350:	return qtrue;
CNSTI4 1
RETI4
LABELV $121
endproc Color_Parse 12 8
export PC_Color_Parse
proc PC_Color_Parse 12 8
line 358
;351:}
;352:
;353:/*
;354:=================
;355:PC_Color_Parse
;356:=================
;357:*/
;358:qboolean PC_Color_Parse(int handle, vec4_t *c) {
line 362
;359:	int i;
;360:	float f;
;361:
;362:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $129
line 363
;363:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $133
line 364
;364:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $128
JUMPV
LABELV $133
line 366
;365:		}
;366:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 367
;367:	}
LABELV $130
line 362
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $129
line 368
;368:	return qtrue;
CNSTI4 1
RETI4
LABELV $128
endproc PC_Color_Parse 12 8
export Int_Parse
proc Int_Parse 16 8
line 376
;369:}
;370:
;371:/*
;372:=================
;373:Int_Parse
;374:=================
;375:*/
;376:qboolean Int_Parse(char **p, int *i) {
line 378
;377:	char	*token;
;378:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 380
;379:
;380:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $136
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $136
line 381
;381:		*i = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 382
;382:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $136
line 383
;383:	} else {
line 384
;384:		return qfalse;
CNSTI4 0
RETI4
LABELV $135
endproc Int_Parse 16 8
export PC_Int_Parse
proc PC_Int_Parse 1052 12
line 393
;385:	}
;386:}
;387:
;388:/*
;389:=================
;390:PC_Int_Parse
;391:=================
;392:*/
;393:qboolean PC_Int_Parse(int handle, int *i) {
line 395
;394:	pc_token_t token;
;395:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 397
;396:
;397:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $139
line 398
;398:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $139
line 399
;399:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $141
line 400
;400:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $144
line 401
;401:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $144
line 402
;402:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 403
;403:	}
LABELV $141
line 404
;404:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $146
line 405
;405:		PC_SourceError(handle, "expected integer but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $148
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 406
;406:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $146
line 408
;407:	}
;408:	*i = token.intvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+8
INDIRI4
ASGNI4
line 409
;409:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $151
line 410
;410:		*i = - *i;
ADDRLP4 1048
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
NEGI4
ASGNI4
LABELV $151
line 411
;411:	return qtrue;
CNSTI4 1
RETI4
LABELV $138
endproc PC_Int_Parse 1052 12
export Rect_Parse
proc Rect_Parse 16 8
line 419
;412:}
;413:
;414:/*
;415:=================
;416:Rect_Parse
;417:=================
;418:*/
;419:qboolean Rect_Parse(char **p, rectDef_t *r) {
line 420
;420:	if (Float_Parse(p, &r->x)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $154
line 421
;421:		if (Float_Parse(p, &r->y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $156
line 422
;422:			if (Float_Parse(p, &r->w)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $158
line 423
;423:				if (Float_Parse(p, &r->h)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $160
line 424
;424:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $160
line 426
;425:				}
;426:			}
LABELV $158
line 427
;427:		}
LABELV $156
line 428
;428:	}
LABELV $154
line 429
;429:	return qfalse;
CNSTI4 0
RETI4
LABELV $153
endproc Rect_Parse 16 8
export PC_Rect_Parse
proc PC_Rect_Parse 16 8
line 437
;430:}
;431:
;432:/*
;433:=================
;434:PC_Rect_Parse
;435:=================
;436:*/
;437:qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
line 438
;438:	if (PC_Float_Parse(handle, &r->x)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $163
line 439
;439:		if (PC_Float_Parse(handle, &r->y)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $165
line 440
;440:			if (PC_Float_Parse(handle, &r->w)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $167
line 441
;441:				if (PC_Float_Parse(handle, &r->h)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $169
line 442
;442:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $162
JUMPV
LABELV $169
line 444
;443:				}
;444:			}
LABELV $167
line 445
;445:		}
LABELV $165
line 446
;446:	}
LABELV $163
line 447
;447:	return qfalse;
CNSTI4 0
RETI4
LABELV $162
endproc PC_Rect_Parse 16 8
export String_Parse
proc String_Parse 16 8
line 455
;448:}
;449:
;450:/*
;451:=================
;452:String_Parse
;453:=================
;454:*/
;455:qboolean String_Parse(char **p, const char **out) {
line 458
;456:	char *token;
;457:
;458:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 459
;459:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $172
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $172
line 460
;460:		*(out) = String_Alloc(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
ASGNP4
line 461
;461:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $171
JUMPV
LABELV $172
line 463
;462:	}
;463:	return qfalse;
CNSTI4 0
RETI4
LABELV $171
endproc String_Parse 16 8
export PC_String_Parse
proc PC_String_Parse 1048 8
line 471
;464:}
;465:
;466:/*
;467:=================
;468:PC_String_Parse
;469:=================
;470:*/
;471:qboolean PC_String_Parse(int handle, const char **out) {
line 474
;472:	pc_token_t token;
;473:
;474:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $175
line 475
;475:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $174
JUMPV
LABELV $175
line 477
;476:	
;477:	*(out) = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1044
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1044
INDIRP4
ASGNP4
line 478
;478:    return qtrue;
CNSTI4 1
RETI4
LABELV $174
endproc PC_String_Parse 1048 8
export PC_Script_Parse
proc PC_Script_Parse 2084 12
line 486
;479:}
;480:
;481:/*
;482:=================
;483:PC_Script_Parse
;484:=================
;485:*/
;486:qboolean PC_Script_Parse(int handle, const char **out) {
line 490
;487:	char script[1024];
;488:	pc_token_t token;
;489:
;490:	memset(script, 0, sizeof(script));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 494
;491:	// scripts start with { and have ; separated command lists.. commands are command, arg.. 
;492:	// basically we want everything between the { } as it will be interpreted at run time
;493:  
;494:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $179
line 495
;495:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $178
JUMPV
LABELV $179
line 496
;496:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $184
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
EQI4 $186
line 497
;497:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $178
JUMPV
LABELV $185
line 500
;498:	}
;499:
;500:	while ( 1 ) {
line 501
;501:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2072
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $188
line 502
;502:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $178
JUMPV
LABELV $188
line 504
;503:
;504:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $193
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $190
line 505
;505:			*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 506
;506:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $178
JUMPV
LABELV $190
line 509
;507:		}
;508:
;509:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $194
line 510
;510:			Q_strcat(script, 1024, va("\"%s\"", token.string));
ADDRGP4 $198
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 2080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2080
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 511
;511:		} else {
ADDRGP4 $195
JUMPV
LABELV $194
line 512
;512:			Q_strcat(script, 1024, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 513
;513:		}
LABELV $195
line 514
;514:		Q_strcat(script, 1024, " ");
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $201
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 515
;515:	}
LABELV $186
line 500
ADDRGP4 $185
JUMPV
line 516
;516:	return qfalse; 	// bk001105 - LCC   missing return value
CNSTI4 0
RETI4
LABELV $178
endproc PC_Script_Parse 2084 12
export Init_Display
proc Init_Display 0 0
line 529
;517:}
;518:
;519:// display, window, menu, item code
;520:// 
;521:
;522:/*
;523:==================
;524:Init_Display
;525:
;526:Initializes the display with a structure to all the drawing routines
;527: ==================
;528:*/
;529:void Init_Display(displayContextDef_t *dc) {
line 530
;530:	DC = dc;
ADDRGP4 DC
ADDRFP4 0
INDIRP4
ASGNP4
line 531
;531:}
LABELV $202
endproc Init_Display 0 0
export GradientBar_Paint
proc GradientBar_Paint 12 20
line 537
;532:
;533:
;534:
;535:// type and style painting 
;536:
;537:void GradientBar_Paint(rectDef_t *rect, vec4_t color) {
line 539
;538:	// gradient bar takes two paints
;539:	DC->setColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 540
;540:	DC->drawHandlePic(rect->x, rect->y, rect->w, rect->h, DC->Assets.gradientBar);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 61888
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CALLV
pop
line 541
;541:	DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 542
;542:}
LABELV $203
endproc GradientBar_Paint 12 20
export Window_Init
proc Window_Init 8 12
line 553
;543:
;544:
;545:/*
;546:==================
;547:Window_Init
;548:
;549:Initializes a window structure ( windowDef_t ) with defaults
;550: 
;551:==================
;552:*/
;553:void Window_Init(Window *w) {
line 554
;554:	memset(w, 0, sizeof(windowDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 180
ARGI4
ADDRGP4 memset
CALLP4
pop
line 555
;555:	w->borderSize = 1;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1065353216
ASGNF4
line 556
;556:	w->foreColor[0] = w->foreColor[1] = w->foreColor[2] = w->foreColor[3] = 1.0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 557
;557:	w->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 558
;558:}
LABELV $204
endproc Window_Init 8 12
export Fade
proc Fade 8 0
line 560
;559:
;560:void Fade(int *flags, float *f, float clamp, int *nextTime, int offsetTime, qboolean bFlags, float fadeAmount) {
line 561
;561:  if (*flags & (WINDOW_FADINGOUT | WINDOW_FADINGIN)) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $206
line 562
;562:    if (DC->realTime > *nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
LEI4 $208
line 563
;563:      *nextTime = DC->realTime + offsetTime;
ADDRFP4 12
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 564
;564:      if (*flags & WINDOW_FADINGOUT) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $210
line 565
;565:        *f -= fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
SUBF4
ASGNF4
line 566
;566:        if (bFlags && *f <= 0.0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $211
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
GTF4 $211
line 567
;567:          *flags &= ~(WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -37
BANDI4
ASGNI4
line 568
;568:        }
line 569
;569:      } else {
ADDRGP4 $211
JUMPV
LABELV $210
line 570
;570:        *f += fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
ADDF4
ASGNF4
line 571
;571:        if (*f >= clamp) {
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $214
line 572
;572:          *f = clamp;
ADDRFP4 4
INDIRP4
ADDRFP4 8
INDIRF4
ASGNF4
line 573
;573:          if (bFlags) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $216
line 574
;574:            *flags &= ~WINDOW_FADINGIN;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 575
;575:          }
LABELV $216
line 576
;576:        }
LABELV $214
line 577
;577:      }
LABELV $211
line 578
;578:    }
LABELV $208
line 579
;579:  }
LABELV $206
line 580
;580:}
LABELV $205
endproc Fade 8 0
export Window_Paint
proc Window_Paint 60 28
line 584
;581:
;582:
;583:
;584:void Window_Paint(Window *w, float fadeAmount, float fadeClamp, float fadeCycle) {
line 587
;585:  //float bordersize = 0;
;586:  vec4_t color;
;587:  rectDef_t fillRect = w->rect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 590
;588:
;589:
;590:  if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $219
line 591
;591:    color[0] = color[1] = color[2] = color[3] = 1;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 16+12
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
ASGNF4
line 592
;592:    DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, 1, color);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 593
;593:  }
LABELV $219
line 595
;594:
;595:  if (w == NULL || (w->style == 0 && w->border == 0)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $226
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $224
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $224
LABELV $226
line 596
;596:    return;
ADDRGP4 $218
JUMPV
LABELV $224
line 599
;597:  }
;598:
;599:  if (w->border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $227
line 600
;600:    fillRect.x += w->borderSize;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 601
;601:    fillRect.y += w->borderSize;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 602
;602:    fillRect.w -= w->borderSize + 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 603
;603:    fillRect.h -= w->borderSize + 1;
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 604
;604:  }
LABELV $227
line 606
;605:
;606:  if (w->style == WINDOW_STYLE_FILLED) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
NEI4 $232
line 608
;607:    // box, but possible a shader that needs filled
;608:		if (w->background) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $234
line 609
;609:		  Fade(&w->flags, &w->backColor[3], fadeClamp, &w->nextTime, fadeCycle, qtrue, fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 140
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 610
;610:      DC->setColor(w->backColor);
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 611
;611:	    DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 612
;612:		  DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 613
;613:		} else {
ADDRGP4 $233
JUMPV
LABELV $234
line 614
;614:	    DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->backColor);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 615
;615:		}
line 616
;616:  } else if (w->style == WINDOW_STYLE_GRADIENT) {
ADDRGP4 $233
JUMPV
LABELV $232
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $242
line 617
;617:    GradientBar_Paint(&fillRect, w->backColor);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 619
;618:    // gradient bar
;619:  } else if (w->style == WINDOW_STYLE_SHADER) {
ADDRGP4 $243
JUMPV
LABELV $242
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $244
line 620
;620:    if (w->flags & WINDOW_FORECOLORSET) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $246
line 621
;621:      DC->setColor(w->foreColor);
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 622
;622:    }
LABELV $246
line 623
;623:    DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 624
;624:    DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 625
;625:  } else if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRGP4 $245
JUMPV
LABELV $244
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $251
line 626
;626:    if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $252
line 627
;627:      DC->getTeamColor(&color);
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 628
;628:      DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, color);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 629
;629:    }
line 630
;630:  } else if (w->style == WINDOW_STYLE_CINEMATIC) {
ADDRGP4 $252
JUMPV
LABELV $251
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $258
line 631
;631:		if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $260
line 632
;632:			w->cinematic = DC->playCinematic(w->cinematicName, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 633
;633:			if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $265
line 634
;634:				w->cinematic = -2;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -2
ASGNI4
line 635
;635:			}
LABELV $265
line 636
;636:		} 
LABELV $260
line 637
;637:		if (w->cinematic >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $267
line 638
;638:	    DC->runCinematicFrame(w->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLV
pop
line 639
;639:			DC->drawCinematic(w->cinematic, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 640
;640:		}
LABELV $267
line 641
;641:  }
LABELV $258
LABELV $252
LABELV $245
LABELV $243
LABELV $233
line 643
;642:
;643:  if (w->border == WINDOW_BORDER_FULL) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1
NEI4 $272
line 646
;644:    // full
;645:    // HACK HACK HACK
;646:    if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $274
line 647
;647:      if (color[0] > 0) { 
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $276
line 649
;648:        // red
;649:        color[0] = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 650
;650:        color[1] = color[2] = .5;
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 40
INDIRF4
ASGNF4
line 652
;651:
;652:      } else {
ADDRGP4 $277
JUMPV
LABELV $276
line 653
;653:        color[2] = 1;
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 654
;654:        color[0] = color[1] = .5;
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 40
INDIRF4
ASGNF4
line 655
;655:      }
LABELV $277
line 656
;656:      color[3] = 1;
ADDRLP4 16+12
CNSTF4 1065353216
ASGNF4
line 657
;657:      DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, color);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 658
;658:    } else {
ADDRGP4 $273
JUMPV
LABELV $274
line 659
;659:      DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, w->borderColor);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 660
;660:    }
line 661
;661:  } else if (w->border == WINDOW_BORDER_HORZ) {
ADDRGP4 $273
JUMPV
LABELV $272
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
NEI4 $283
line 663
;662:    // top/bottom
;663:    DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 664
;664:    DC->drawTopBottom(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 665
;665:  	DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 666
;666:  } else if (w->border == WINDOW_BORDER_VERT) {
ADDRGP4 $284
JUMPV
LABELV $283
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 3
NEI4 $285
line 668
;667:    // left right
;668:    DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 669
;669:    DC->drawSides(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CALLV
pop
line 670
;670:  	DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 671
;671:  } else if (w->border == WINDOW_BORDER_KCGRADIENT) {
ADDRGP4 $286
JUMPV
LABELV $285
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 4
NEI4 $287
line 673
;672:    // this is just two gradient bars along each horz edge
;673:    rectDef_t r = w->rect;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 674
;674:    r.h = w->borderSize;
ADDRLP4 40+12
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
line 675
;675:    GradientBar_Paint(&r, w->borderColor);
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 676
;676:    r.y = w->rect.y + w->rect.h - 1;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40+4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 677
;677:    GradientBar_Paint(&r, w->borderColor);
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 678
;678:  }
LABELV $287
LABELV $286
LABELV $284
LABELV $273
line 680
;679:
;680:}
LABELV $218
endproc Window_Paint 60 28
export Item_SetScreenCoords
proc Item_SetScreenCoords 16 0
line 683
;681:
;682:
;683:void Item_SetScreenCoords(itemDef_t *item, float x, float y) {
line 685
;684:  
;685:  if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $292
line 686
;686:    return;
ADDRGP4 $291
JUMPV
LABELV $292
line 689
;687:  }
;688:
;689:  if (item->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $294
line 690
;690:    x += item->window.borderSize;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 691
;691:    y += item->window.borderSize;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 692
;692:  }
LABELV $294
line 694
;693:
;694:  item->window.rect.x = x + item->window.rectClient.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 695
;695:  item->window.rect.y = y + item->window.rectClient.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 696
;696:  item->window.rect.w = item->window.rectClient.w;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 697
;697:  item->window.rect.h = item->window.rectClient.h;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 700
;698:
;699:  // force the text rects to recompute
;700:  item->textRect.w = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 701
;701:  item->textRect.h = 0;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 702
;702:}
LABELV $291
endproc Item_SetScreenCoords 16 0
export Item_UpdatePosition
proc Item_UpdatePosition 20 12
line 705
;703:
;704:// FIXME: consolidate this with nearby stuff
;705:void Item_UpdatePosition(itemDef_t *item) {
line 709
;706:  float x, y;
;707:  menuDef_t *menu;
;708:  
;709:  if (item == NULL || item->parent == NULL) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $299
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $297
LABELV $299
line 710
;710:    return;
ADDRGP4 $296
JUMPV
LABELV $297
line 713
;711:  }
;712:
;713:  menu = item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 715
;714:
;715:  x = menu->window.rect.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 716
;716:  y = menu->window.rect.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 718
;717:  
;718:  if (menu->window.border != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $300
line 719
;719:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 720
;720:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 721
;721:  }
LABELV $300
line 723
;722:
;723:  Item_SetScreenCoords(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 725
;724:
;725:}
LABELV $296
endproc Item_UpdatePosition 20 12
export Menu_UpdatePosition
proc Menu_UpdatePosition 12 12
line 728
;726:
;727:// menus
;728:void Menu_UpdatePosition(menuDef_t *menu) {
line 732
;729:  int i;
;730:  float x, y;
;731:
;732:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $303
line 733
;733:    return;
ADDRGP4 $302
JUMPV
LABELV $303
line 736
;734:  }
;735:  
;736:  x = menu->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 737
;737:  y = menu->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 738
;738:  if (menu->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
line 739
;739:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 740
;740:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 741
;741:  }
LABELV $305
line 743
;742:
;743:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $310
JUMPV
LABELV $307
line 744
;744:    Item_SetScreenCoords(menu->items[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 745
;745:  }
LABELV $308
line 743
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $310
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $307
line 746
;746:}
LABELV $302
endproc Menu_UpdatePosition 12 12
export Menu_PostParse
proc Menu_PostParse 0 4
line 748
;747:
;748:void Menu_PostParse(menuDef_t *menu) {
line 749
;749:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $312
line 750
;750:		return;
ADDRGP4 $311
JUMPV
LABELV $312
line 752
;751:	}
;752:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $314
line 753
;753:		menu->window.rect.x = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 754
;754:		menu->window.rect.y = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 755
;755:		menu->window.rect.w = 640;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1142947840
ASGNF4
line 756
;756:		menu->window.rect.h = 480;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1139802112
ASGNF4
line 757
;757:	}
LABELV $314
line 758
;758:	Menu_UpdatePosition(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 759
;759:}
LABELV $311
endproc Menu_PostParse 0 4
export Menu_ClearFocus
proc Menu_ClearFocus 28 8
line 761
;760:
;761:itemDef_t *Menu_ClearFocus(menuDef_t *menu) {
line 763
;762:  int i;
;763:  itemDef_t *ret = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 765
;764:
;765:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $317
line 766
;766:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $316
JUMPV
LABELV $317
line 769
;767:  }
;768:
;769:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $322
JUMPV
LABELV $319
line 770
;770:    if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 8
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
BANDI4
CNSTI4 0
EQI4 $323
line 771
;771:      ret = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 772
;772:    } 
LABELV $323
line 773
;773:    menu->items[i]->window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 774
;774:    if (menu->items[i]->leaveFocus) {
ADDRLP4 16
CNSTI4 260
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDP4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $325
line 775
;775:      Item_RunScript(menu->items[i], menu->items[i]->leaveFocus);
ADDRLP4 20
CNSTI4 260
ASGNI4
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 776
;776:    }
LABELV $325
line 777
;777:  }
LABELV $320
line 769
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $322
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $319
line 779
;778: 
;779:  return ret;
ADDRLP4 4
INDIRP4
RETP4
LABELV $316
endproc Menu_ClearFocus 28 8
export IsVisible
proc IsVisible 12 0
line 782
;780:}
;781:
;782:qboolean IsVisible(int flags) {
line 783
;783:  return (flags & WINDOW_VISIBLE && !(flags & WINDOW_FADINGOUT));
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $329
ADDRLP4 4
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $329
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $330
JUMPV
LABELV $329
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $330
ADDRLP4 0
INDIRI4
RETI4
LABELV $327
endproc IsVisible 12 0
export Rect_ContainsPoint
proc Rect_ContainsPoint 20 0
line 786
;784:}
;785:
;786:qboolean Rect_ContainsPoint(rectDef_t *rect, float x, float y) {
line 787
;787:  if (rect) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $332
line 788
;788:    if (x > rect->x && x < rect->x + rect->w && y > rect->y && y < rect->y + rect->h) {
ADDRLP4 0
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $334
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
GEF4 $334
ADDRLP4 12
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $334
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $334
line 789
;789:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $331
JUMPV
LABELV $334
line 791
;790:    }
;791:  }
LABELV $332
line 792
;792:  return qfalse;
CNSTI4 0
RETI4
LABELV $331
endproc Rect_ContainsPoint 20 0
export Menu_ItemsMatchingGroup
proc Menu_ItemsMatchingGroup 20 8
line 795
;793:}
;794:
;795:int Menu_ItemsMatchingGroup(menuDef_t *menu, const char *name) {
line 797
;796:  int i;
;797:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 798
;798:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $340
JUMPV
LABELV $337
line 799
;799:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $343
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $341
LABELV $343
line 800
;800:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 801
;801:    } 
LABELV $341
line 802
;802:  }
LABELV $338
line 798
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $340
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $337
line 803
;803:  return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $336
endproc Menu_ItemsMatchingGroup 20 8
export Menu_GetMatchingItemByNumber
proc Menu_GetMatchingItemByNumber 20 8
line 806
;804:}
;805:
;806:itemDef_t *Menu_GetMatchingItemByNumber(menuDef_t *menu, int index, const char *name) {
line 808
;807:  int i;
;808:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 809
;809:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $348
JUMPV
LABELV $345
line 810
;810:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $351
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $349
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $349
LABELV $351
line 811
;811:      if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $352
line 812
;812:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $344
JUMPV
LABELV $352
line 814
;813:      }
;814:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 815
;815:    } 
LABELV $349
line 816
;816:  }
LABELV $346
line 809
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $348
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $345
line 817
;817:  return NULL;
CNSTP4 0
RETP4
LABELV $344
endproc Menu_GetMatchingItemByNumber 20 8
export Script_SetColor
proc Script_SetColor 36 8
line 822
;818:}
;819:
;820:
;821:
;822:void Script_SetColor(itemDef_t *item, char **args) {
line 828
;823:  const char *name;
;824:  int i;
;825:  float f;
;826:  vec4_t *out;
;827:  // expecting type of color to set and 4 args for the color
;828:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $355
line 829
;829:      out = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 830
;830:      if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $359
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $357
line 831
;831:        out = &item->window.backColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 832
;832:        item->window.flags |= WINDOW_BACKCOLORSET;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4194304
BORI4
ASGNI4
line 833
;833:      } else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $358
JUMPV
LABELV $357
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $360
line 834
;834:        out = &item->window.foreColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 835
;835:        item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 836
;836:      } else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $361
JUMPV
LABELV $360
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $365
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $363
line 837
;837:        out = &item->window.borderColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 838
;838:      }
LABELV $363
LABELV $361
LABELV $358
line 840
;839:
;840:      if (out) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $366
line 841
;841:        for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $368
line 842
;842:          if (!Float_Parse(args, &f)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $372
line 843
;843:            return;
ADDRGP4 $354
JUMPV
LABELV $372
line 845
;844:          }
;845:          (*out)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 846
;846:        }
LABELV $369
line 841
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $368
line 847
;847:      }
LABELV $366
line 848
;848:  }
LABELV $355
line 849
;849:}
LABELV $354
endproc Script_SetColor 36 8
export Script_SetAsset
proc Script_SetAsset 8 8
line 851
;850:
;851:void Script_SetAsset(itemDef_t *item, char **args) {
line 854
;852:  const char *name;
;853:  // expecting name to set asset to
;854:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $375
line 856
;855:    // check for a model 
;856:    if (item->type == ITEM_TYPE_MODEL) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $377
line 857
;857:    }
LABELV $377
line 858
;858:  }
LABELV $375
line 859
;859:}
LABELV $374
endproc Script_SetAsset 8 8
export Script_SetBackground
proc Script_SetBackground 12 8
line 861
;860:
;861:void Script_SetBackground(itemDef_t *item, char **args) {
line 864
;862:  const char *name;
;863:  // expecting name to set asset to
;864:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $380
line 865
;865:    item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 866
;866:  }
LABELV $380
line 867
;867:}
LABELV $379
endproc Script_SetBackground 12 8
export Menu_FindItemByName
proc Menu_FindItemByName 12 8
line 872
;868:
;869:
;870:
;871:
;872:itemDef_t *Menu_FindItemByName(menuDef_t *menu, const char *p) {
line 874
;873:  int i;
;874:  if (menu == NULL || p == NULL) {
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $385
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
NEU4 $383
LABELV $385
line 875
;875:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $382
JUMPV
LABELV $383
line 878
;876:  }
;877:
;878:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $389
JUMPV
LABELV $386
line 879
;879:    if (Q_stricmp(p, menu->items[i]->window.name) == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $390
line 880
;880:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $382
JUMPV
LABELV $390
line 882
;881:    }
;882:  }
LABELV $387
line 878
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $389
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $386
line 884
;883:
;884:  return NULL;
CNSTP4 0
RETP4
LABELV $382
endproc Menu_FindItemByName 12 8
export Script_SetTeamColor
proc Script_SetTeamColor 24 4
line 887
;885:}
;886:
;887:void Script_SetTeamColor(itemDef_t *item, char **args) {
line 888
;888:  if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $393
line 891
;889:    int i;
;890:    vec4_t color;
;891:    DC->getTeamColor(&color);
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 892
;892:    for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $395
line 893
;893:      item->window.backColor[i] = color[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 894
;894:    }
LABELV $396
line 892
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $395
line 895
;895:  }
LABELV $393
line 896
;896:}
LABELV $392
endproc Script_SetTeamColor 24 4
export Script_SetItemColor
proc Script_SetItemColor 80 12
line 898
;897:
;898:void Script_SetItemColor(itemDef_t *item, char **args) {
line 905
;899:  const char *itemname;
;900:  const char *name;
;901:  vec4_t color;
;902:  int i;
;903:  vec4_t *out;
;904:  // expecting type of color to set and 4 args for the color
;905:  if (String_Parse(args, &itemname) && String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $400
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 36
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $400
line 908
;906:    itemDef_t *item2;
;907:    int j;
;908:    int count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
line 910
;909:
;910:    if (!Color_Parse(args, &color)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 56
ADDRGP4 Color_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $402
line 911
;911:      return;
ADDRGP4 $399
JUMPV
LABELV $402
line 914
;912:    }
;913:
;914:    for (j = 0; j < count; j++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $407
JUMPV
LABELV $404
line 915
;915:      item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 60
INDIRP4
ASGNP4
line 916
;916:      if (item2 != NULL) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $408
line 917
;917:        out = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 918
;918:        if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $359
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $410
line 919
;919:          out = &item2->window.backColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 920
;920:        } else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $411
JUMPV
LABELV $410
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $412
line 921
;921:          out = &item2->window.foreColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 922
;922:          item2->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 72
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 923
;923:        } else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $413
JUMPV
LABELV $412
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $365
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $414
line 924
;924:          out = &item2->window.borderColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 925
;925:        }
LABELV $414
LABELV $413
LABELV $411
line 927
;926:
;927:        if (out) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $416
line 928
;928:          for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $418
line 929
;929:            (*out)[i] = color[i];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 76
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 76
INDIRI4
ADDRLP4 8
ADDP4
INDIRF4
ASGNF4
line 930
;930:          }
LABELV $419
line 928
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $418
line 931
;931:        }
LABELV $416
line 932
;932:      }
LABELV $408
line 933
;933:    }
LABELV $405
line 914
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $407
ADDRLP4 40
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $404
line 934
;934:  }
LABELV $400
line 935
;935:}
LABELV $399
endproc Script_SetItemColor 80 12
export Menu_ShowItemByName
proc Menu_ShowItemByName 24 12
line 938
;936:
;937:
;938:void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow) {
line 941
;939:	itemDef_t *item;
;940:	int i;
;941:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 942
;942:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $426
JUMPV
LABELV $423
line 943
;943:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 944
;944:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $427
line 945
;945:			if (bShow) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $429
line 946
;946:				item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 947
;947:			} else {
ADDRGP4 $430
JUMPV
LABELV $429
line 948
;948:				item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 950
;949:				// stop cinematics playing in the window
;950:				if (item->window.cinematic >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $431
line 951
;951:					DC->stopCinematic(item->window.cinematic);
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 952
;952:					item->window.cinematic = -1;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 953
;953:				}
LABELV $431
line 954
;954:			}
LABELV $430
line 955
;955:		}
LABELV $427
line 956
;956:	}
LABELV $424
line 942
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $426
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $423
line 957
;957:}
LABELV $422
endproc Menu_ShowItemByName 24 12
export Menu_FadeItemByName
proc Menu_FadeItemByName 32 12
line 959
;958:
;959:void Menu_FadeItemByName(menuDef_t *menu, const char *p, qboolean fadeOut) {
line 962
;960:  itemDef_t *item;
;961:  int i;
;962:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 963
;963:  for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $437
JUMPV
LABELV $434
line 964
;964:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 965
;965:    if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $438
line 966
;966:      if (fadeOut) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $440
line 967
;967:        item->window.flags |= (WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 36
BORI4
ASGNI4
line 968
;968:        item->window.flags &= ~WINDOW_FADINGIN;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 969
;969:      } else {
ADDRGP4 $441
JUMPV
LABELV $440
line 970
;970:        item->window.flags |= (WINDOW_VISIBLE | WINDOW_FADINGIN);
ADDRLP4 20
CNSTI4 68
ASGNI4
ADDRLP4 24
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 20
INDIRI4
BORI4
ASGNI4
line 971
;971:        item->window.flags &= ~WINDOW_FADINGOUT;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 972
;972:      }
LABELV $441
line 973
;973:    }
LABELV $438
line 974
;974:  }
LABELV $435
line 963
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $437
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $434
line 975
;975:}
LABELV $433
endproc Menu_FadeItemByName 32 12
export Menus_FindByName
proc Menus_FindByName 8 8
line 977
;976:
;977:menuDef_t *Menus_FindByName(const char *p) {
line 979
;978:  int i;
;979:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $446
JUMPV
LABELV $443
line 980
;980:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $447
line 981
;981:      return &Menus[i];
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $442
JUMPV
LABELV $447
line 983
;982:    } 
;983:  }
LABELV $444
line 979
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $446
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $443
line 984
;984:  return NULL;
CNSTP4 0
RETP4
LABELV $442
endproc Menus_FindByName 8 8
export Menus_ShowByName
proc Menus_ShowByName 8 4
line 987
;985:}
;986:
;987:void Menus_ShowByName(const char *p) {
line 988
;988:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 989
;989:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $451
line 990
;990:		Menus_Activate(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 991
;991:	}
LABELV $451
line 992
;992:}
LABELV $450
endproc Menus_ShowByName 8 4
export Menus_OpenByName
proc Menus_OpenByName 0 4
line 994
;993:
;994:void Menus_OpenByName(const char *p) {
line 995
;995:  Menus_ActivateByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 996
;996:}
LABELV $453
endproc Menus_OpenByName 0 4
proc Menu_RunCloseScript 548 8
line 998
;997:
;998:static void Menu_RunCloseScript(menuDef_t *menu) {
line 999
;999:	if (menu && menu->window.flags & WINDOW_VISIBLE && menu->onClose) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $455
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $455
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $455
line 1001
;1000:		itemDef_t item;
;1001:    item.parent = menu;
ADDRLP4 8+228
ADDRFP4 0
INDIRP4
ASGNP4
line 1002
;1002:    Item_RunScript(&item, menu->onClose);
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1003
;1003:	}
LABELV $455
line 1004
;1004:}
LABELV $454
endproc Menu_RunCloseScript 548 8
export Menus_CloseByName
proc Menus_CloseByName 12 4
line 1006
;1005:
;1006:void Menus_CloseByName(const char *p) {
line 1007
;1007:  menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1008
;1008:  if (menu != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
line 1009
;1009:		Menu_RunCloseScript(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1010
;1010:		menu->window.flags &= ~(WINDOW_VISIBLE | WINDOW_HASFOCUS);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1011
;1011:  }
LABELV $459
line 1012
;1012:}
LABELV $458
endproc Menus_CloseByName 12 4
export Menus_CloseAll
proc Menus_CloseAll 8 4
line 1014
;1013:
;1014:void Menus_CloseAll() {
line 1016
;1015:  int i;
;1016:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $465
JUMPV
LABELV $462
line 1017
;1017:		Menu_RunCloseScript(&Menus[i]);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1018
;1018:		Menus[i].window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1019
;1019:  }
LABELV $463
line 1016
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $465
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $462
line 1020
;1020:}
LABELV $461
endproc Menus_CloseAll 8 4
export Script_Show
proc Script_Show 8 12
line 1023
;1021:
;1022:
;1023:void Script_Show(itemDef_t *item, char **args) {
line 1025
;1024:  const char *name;
;1025:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $468
line 1026
;1026:    Menu_ShowItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1027
;1027:  }
LABELV $468
line 1028
;1028:}
LABELV $467
endproc Script_Show 8 12
export Script_Hide
proc Script_Hide 8 12
line 1030
;1029:
;1030:void Script_Hide(itemDef_t *item, char **args) {
line 1032
;1031:  const char *name;
;1032:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $471
line 1033
;1033:    Menu_ShowItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1034
;1034:  }
LABELV $471
line 1035
;1035:}
LABELV $470
endproc Script_Hide 8 12
export Script_FadeIn
proc Script_FadeIn 8 12
line 1037
;1036:
;1037:void Script_FadeIn(itemDef_t *item, char **args) {
line 1039
;1038:  const char *name;
;1039:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $474
line 1040
;1040:    Menu_FadeItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1041
;1041:  }
LABELV $474
line 1042
;1042:}
LABELV $473
endproc Script_FadeIn 8 12
export Script_FadeOut
proc Script_FadeOut 8 12
line 1044
;1043:
;1044:void Script_FadeOut(itemDef_t *item, char **args) {
line 1046
;1045:  const char *name;
;1046:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $477
line 1047
;1047:    Menu_FadeItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1048
;1048:  }
LABELV $477
line 1049
;1049:}
LABELV $476
endproc Script_FadeOut 8 12
export Script_Open
proc Script_Open 8 8
line 1053
;1050:
;1051:
;1052:
;1053:void Script_Open(itemDef_t *item, char **args) {
line 1055
;1054:  const char *name;
;1055:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $480
line 1056
;1056:    Menus_OpenByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1057
;1057:  }
LABELV $480
line 1058
;1058:}
LABELV $479
endproc Script_Open 8 8
export Script_ConditionalOpen
proc Script_ConditionalOpen 32 8
line 1060
;1059:
;1060:void Script_ConditionalOpen(itemDef_t *item, char **args) {
line 1066
;1061:	const char *cvar;
;1062:	const char *name1;
;1063:	const char *name2;
;1064:	float           val;
;1065:
;1066:	if ( String_Parse(args, &cvar) && String_Parse(args, &name1) && String_Parse(args, &name2) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $483
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $483
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $483
line 1067
;1067:		val = DC->getCVarValue( cvar );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 1068
;1068:		if ( val == 0.f ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $485
line 1069
;1069:			Menus_OpenByName(name2);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1070
;1070:		} else {
ADDRGP4 $486
JUMPV
LABELV $485
line 1071
;1071:			Menus_OpenByName(name1);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1072
;1072:		}
LABELV $486
line 1073
;1073:	}
LABELV $483
line 1074
;1074:}
LABELV $482
endproc Script_ConditionalOpen 32 8
export Script_Close
proc Script_Close 8 8
line 1076
;1075:
;1076:void Script_Close(itemDef_t *item, char **args) {
line 1078
;1077:  const char *name;
;1078:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $488
line 1079
;1079:    Menus_CloseByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1080
;1080:  }
LABELV $488
line 1081
;1081:}
LABELV $487
endproc Script_Close 8 8
export Menu_TransitionItemByName
proc Menu_TransitionItemByName 56 12
line 1083
;1082:
;1083:void Menu_TransitionItemByName(menuDef_t *menu, const char *p, rectDef_t rectFrom, rectDef_t rectTo, int time, float amt) {
line 1086
;1084:  itemDef_t *item;
;1085:  int i;
;1086:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1087
;1087:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $494
JUMPV
LABELV $491
line 1088
;1088:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1089
;1089:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $495
line 1090
;1090:      item->window.flags |= (WINDOW_INTRANSITION | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 260
BORI4
ASGNI4
line 1091
;1091:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 1092
;1092:			memcpy(&item->window.rectClient, &rectFrom, sizeof(rectDef_t));
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1093
;1093:			memcpy(&item->window.rectEffects, &rectTo, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1094
;1094:			item->window.rectEffects2.x = abs(rectTo.x - rectFrom.x) / amt;
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1095
;1095:			item->window.rectEffects2.y = abs(rectTo.y - rectFrom.y) / amt;
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1096
;1096:			item->window.rectEffects2.w = abs(rectTo.w - rectFrom.w) / amt;
ADDRLP4 40
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 44
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1097
;1097:			item->window.rectEffects2.h = abs(rectTo.h - rectFrom.h) / amt;
ADDRLP4 48
CNSTI4 12
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 52
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 52
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1098
;1098:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1099
;1099:    }
LABELV $495
line 1100
;1100:  }
LABELV $492
line 1087
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $494
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $491
line 1101
;1101:}
LABELV $490
endproc Menu_TransitionItemByName 56 12
export Script_Transition
proc Script_Transition 96 24
line 1104
;1102:
;1103:
;1104:void Script_Transition(itemDef_t *item, char **args) {
line 1110
;1105:  const char *name;
;1106:	rectDef_t rectFrom, rectTo;
;1107:  int time;
;1108:	float amt;
;1109:
;1110:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $498
line 1111
;1111:    if ( Rect_Parse(args, &rectFrom) && Rect_Parse(args, &rectTo) && Int_Parse(args, &time) && Float_Parse(args, &amt)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $500
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $500
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 56
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $500
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 60
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $500
line 1112
;1112:      Menu_TransitionItemByName(item->parent, name, rectFrom, rectTo, time, amt);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRLP4 4
INDIRB
ASGNB 16
ADDRLP4 64
ARGP4
ADDRLP4 80
ADDRLP4 20
INDIRB
ASGNB 16
ADDRLP4 80
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 Menu_TransitionItemByName
CALLV
pop
line 1113
;1113:    }
LABELV $500
line 1114
;1114:  }
LABELV $498
line 1115
;1115:}
LABELV $497
endproc Script_Transition 96 24
export Menu_OrbitItemByName
proc Menu_OrbitItemByName 24 12
line 1118
;1116:
;1117:
;1118:void Menu_OrbitItemByName(menuDef_t *menu, const char *p, float x, float y, float cx, float cy, int time) {
line 1121
;1119:  itemDef_t *item;
;1120:  int i;
;1121:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1122
;1122:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $506
JUMPV
LABELV $503
line 1123
;1123:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1124
;1124:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $507
line 1125
;1125:      item->window.flags |= (WINDOW_ORBITING | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 65540
BORI4
ASGNI4
line 1126
;1126:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1127
;1127:      item->window.rectEffects.x = cx;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1128
;1128:      item->window.rectEffects.y = cy;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 1129
;1129:      item->window.rectClient.x = x;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1130
;1130:      item->window.rectClient.y = y;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 1131
;1131:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1132
;1132:    }
LABELV $507
line 1133
;1133:  }
LABELV $504
line 1122
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $506
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $503
line 1134
;1134:}
LABELV $502
endproc Menu_OrbitItemByName 24 12
export Script_Orbit
proc Script_Orbit 48 28
line 1137
;1135:
;1136:
;1137:void Script_Orbit(itemDef_t *item, char **args) {
line 1142
;1138:  const char *name;
;1139:  float cx, cy, x, y;
;1140:  int time;
;1141:
;1142:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $510
line 1143
;1143:    if ( Float_Parse(args, &x) && Float_Parse(args, &y) && Float_Parse(args, &cx) && Float_Parse(args, &cy) && Int_Parse(args, &time) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $512
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $512
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $512
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $512
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $512
line 1144
;1144:      Menu_OrbitItemByName(item->parent, name, x, y, cx, cy, time);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 Menu_OrbitItemByName
CALLV
pop
line 1145
;1145:    }
LABELV $512
line 1146
;1146:  }
LABELV $510
line 1147
;1147:}
LABELV $509
endproc Script_Orbit 48 28
export Script_SetFocus
proc Script_SetFocus 36 8
line 1151
;1148:
;1149:
;1150:
;1151:void Script_SetFocus(itemDef_t *item, char **args) {
line 1155
;1152:  const char *name;
;1153:  itemDef_t *focusItem;
;1154:
;1155:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $515
line 1156
;1156:    focusItem = Menu_FindItemByName(item->parent, name);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_FindItemByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1157
;1157:    if (focusItem && !(focusItem->window.flags & WINDOW_DECORATION) && !(focusItem->window.flags & WINDOW_HASFOCUS)) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $517
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $517
ADDRLP4 20
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $517
line 1158
;1158:      Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRGP4 Menu_ClearFocus
CALLP4
pop
line 1159
;1159:      focusItem->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1160
;1160:      if (focusItem->onFocus) {
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $519
line 1161
;1161:        Item_RunScript(focusItem, focusItem->onFocus);
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1162
;1162:      }
LABELV $519
line 1163
;1163:      if (DC->Assets.itemFocusSound) {
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
CNSTI4 0
EQI4 $521
line 1164
;1164:        DC->startLocalSound( DC->Assets.itemFocusSound, CHAN_LOCAL_SOUND );
ADDRLP4 32
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1165
;1165:      }
LABELV $521
line 1166
;1166:    }
LABELV $517
line 1167
;1167:  }
LABELV $515
line 1168
;1168:}
LABELV $514
endproc Script_SetFocus 36 8
export Script_SetPlayerModel
proc Script_SetPlayerModel 8 8
line 1170
;1169:
;1170:void Script_SetPlayerModel(itemDef_t *item, char **args) {
line 1172
;1171:  const char *name;
;1172:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $524
line 1173
;1173:    DC->setCVar("team_model", name);
ADDRGP4 $526
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1174
;1174:  }
LABELV $524
line 1175
;1175:}
LABELV $523
endproc Script_SetPlayerModel 8 8
export Script_SetPlayerHead
proc Script_SetPlayerHead 8 8
line 1177
;1176:
;1177:void Script_SetPlayerHead(itemDef_t *item, char **args) {
line 1179
;1178:  const char *name;
;1179:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $528
line 1180
;1180:    DC->setCVar("team_headmodel", name);
ADDRGP4 $530
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1181
;1181:  }
LABELV $528
line 1182
;1182:}
LABELV $527
endproc Script_SetPlayerHead 8 8
export Script_SetCvar
proc Script_SetCvar 16 8
line 1184
;1183:
;1184:void Script_SetCvar(itemDef_t *item, char **args) {
line 1186
;1185:	const char *cvar, *val;
;1186:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $532
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $532
line 1187
;1187:		DC->setCVar(cvar, val);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1188
;1188:	}
LABELV $532
line 1190
;1189:	
;1190:}
LABELV $531
endproc Script_SetCvar 16 8
export Script_Exec
proc Script_Exec 12 8
line 1192
;1191:
;1192:void Script_Exec(itemDef_t *item, char **args) {
line 1194
;1193:	const char *val;
;1194:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $535
line 1195
;1195:		DC->executeText(EXEC_APPEND, va("%s ; ", val));
ADDRGP4 $537
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 1196
;1196:	}
LABELV $535
line 1197
;1197:}
LABELV $534
endproc Script_Exec 12 8
export Script_Play
proc Script_Play 12 8
line 1199
;1198:
;1199:void Script_Play(itemDef_t *item, char **args) {
line 1201
;1200:	const char *val;
;1201:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $539
line 1202
;1202:		DC->startLocalSound(DC->registerSound(val, qfalse), CHAN_LOCAL_SOUND);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1203
;1203:	}
LABELV $539
line 1204
;1204:}
LABELV $538
endproc Script_Play 12 8
export Script_playLooped
proc Script_playLooped 12 8
line 1206
;1205:
;1206:void Script_playLooped(itemDef_t *item, char **args) {
line 1208
;1207:	const char *val;
;1208:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $542
line 1209
;1209:		DC->stopBackgroundTrack();
ADDRGP4 DC
INDIRP4
CNSTI4 176
ADDP4
INDIRP4
CALLV
pop
line 1210
;1210:		DC->startBackgroundTrack(val, val);
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 1211
;1211:	}
LABELV $542
line 1212
;1212:}
LABELV $541
endproc Script_playLooped 12 8
data
export commandList
align 4
LABELV commandList
address $544
address Script_FadeIn
address $545
address Script_FadeOut
address $546
address Script_Show
address $547
address Script_Hide
address $548
address Script_SetColor
address $549
address Script_Open
address $550
address Script_ConditionalOpen
address $551
address Script_Close
address $552
address Script_SetAsset
address $553
address Script_SetBackground
address $554
address Script_SetItemColor
address $555
address Script_SetTeamColor
address $556
address Script_SetFocus
address $557
address Script_SetPlayerModel
address $558
address Script_SetPlayerHead
address $559
address Script_Transition
address $560
address Script_SetCvar
address $561
address Script_Exec
address $562
address Script_Play
address $563
address Script_playLooped
address $564
address Script_Orbit
export scriptCommandCount
align 4
LABELV scriptCommandCount
byte 4 21
export Item_RunScript
code
proc Item_RunScript 1060 12
line 1243
;1213:
;1214:
;1215:commandDef_t commandList[] =
;1216:{
;1217:  {"fadein", &Script_FadeIn},                   // group/name
;1218:  {"fadeout", &Script_FadeOut},                 // group/name
;1219:  {"show", &Script_Show},                       // group/name
;1220:  {"hide", &Script_Hide},                       // group/name
;1221:  {"setcolor", &Script_SetColor},               // works on this
;1222:  {"open", &Script_Open},                       // menu
;1223:	{"conditionalopen", &Script_ConditionalOpen},	// menu
;1224:  {"close", &Script_Close},                     // menu
;1225:  {"setasset", &Script_SetAsset},               // works on this
;1226:  {"setbackground", &Script_SetBackground},     // works on this
;1227:  {"setitemcolor", &Script_SetItemColor},       // group/name
;1228:  {"setteamcolor", &Script_SetTeamColor},       // sets this background color to team color
;1229:  {"setfocus", &Script_SetFocus},               // sets this background color to team color
;1230:  {"setplayermodel", &Script_SetPlayerModel},   // sets this background color to team color
;1231:  {"setplayerhead", &Script_SetPlayerHead},     // sets this background color to team color
;1232:  {"transition", &Script_Transition},           // group/name
;1233:  {"setcvar", &Script_SetCvar},           // group/name
;1234:  {"exec", &Script_Exec},           // group/name
;1235:  {"play", &Script_Play},           // group/name
;1236:  {"playlooped", &Script_playLooped},           // group/name
;1237:  {"orbit", &Script_Orbit}                      // group/name
;1238:};
;1239:
;1240:int scriptCommandCount = sizeof(commandList) / sizeof(commandDef_t);
;1241:
;1242:
;1243:void Item_RunScript(itemDef_t *item, const char *s) {
line 1247
;1244:  char script[1024], *p;
;1245:  int i;
;1246:  qboolean bRan;
;1247:  memset(script, 0, sizeof(script));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1248
;1248:  if (item && s && s[0]) {
ADDRLP4 1036
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 1036
INDIRU4
EQU4 $566
ADDRLP4 1040
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CVPU4 4
ADDRLP4 1036
INDIRU4
EQU4 $566
ADDRLP4 1040
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $566
line 1249
;1249:    Q_strcat(script, 1024, s);
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1250
;1250:    p = script;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $569
JUMPV
LABELV $568
line 1251
;1251:    while (1) {
line 1254
;1252:      const char *command;
;1253:      // expect command then arguments, ; ends command, NULL ends script
;1254:      if (!String_Parse(&p, &command)) {
ADDRLP4 8
ARGP4
ADDRLP4 1044
ARGP4
ADDRLP4 1048
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $571
line 1255
;1255:        return;
ADDRGP4 $565
JUMPV
LABELV $571
line 1258
;1256:      }
;1257:
;1258:      if (command[0] == ';' && command[1] == '\0') {
ADDRLP4 1052
ADDRLP4 1044
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $573
ADDRLP4 1052
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $573
line 1259
;1259:        continue;
ADDRGP4 $569
JUMPV
LABELV $573
line 1262
;1260:      }
;1261:
;1262:      bRan = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1263
;1263:      for (i = 0; i < scriptCommandCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $578
JUMPV
LABELV $575
line 1264
;1264:        if (Q_stricmp(command, commandList[i].name) == 0) {
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList
ADDP4
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $579
line 1265
;1265:          (commandList[i].handler(item, &p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList+4
ADDP4
INDIRP4
CALLV
pop
line 1266
;1266:          bRan = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1267
;1267:          break;
ADDRGP4 $577
JUMPV
LABELV $579
line 1269
;1268:        }
;1269:      }
LABELV $576
line 1263
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $578
ADDRLP4 0
INDIRI4
ADDRGP4 scriptCommandCount
INDIRI4
LTI4 $575
LABELV $577
line 1271
;1270:      // not in our auto list, pass to handler
;1271:      if (!bRan) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $582
line 1272
;1272:        DC->runScript(&p);
ADDRLP4 8
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 80
ADDP4
INDIRP4
CALLV
pop
line 1273
;1273:      }
LABELV $582
line 1274
;1274:    }
LABELV $569
line 1251
ADDRGP4 $568
JUMPV
line 1275
;1275:  }
LABELV $566
line 1276
;1276:}
LABELV $565
endproc Item_RunScript 1060 12
export Item_EnableShowViaCvar
proc Item_EnableShowViaCvar 2088 12
line 1279
;1277:
;1278:
;1279:qboolean Item_EnableShowViaCvar(itemDef_t *item, int flag) {
line 1281
;1280:  char script[1024], *p;
;1281:  memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1282
;1282:  if (item && item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
CNSTU4 0
ASGNU4
ADDRLP4 1028
INDIRP4
CVPU4 4
ADDRLP4 1032
INDIRU4
EQU4 $585
ADDRLP4 1036
ADDRLP4 1028
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
ADDRLP4 1032
INDIRU4
EQU4 $585
ADDRLP4 1040
CNSTI4 0
ASGNI4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 1040
INDIRI4
EQI4 $585
ADDRLP4 1044
ADDRLP4 1028
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
ADDRLP4 1032
INDIRU4
EQU4 $585
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 1040
INDIRI4
EQI4 $585
line 1284
;1283:		char buff[1024];
;1284:	  DC->getCVarString(item->cvarTest, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1286
;1285:
;1286:    Q_strcat(script, 1024, item->enableCvar);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1287
;1287:    p = script;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $588
JUMPV
LABELV $587
line 1288
;1288:    while (1) {
line 1291
;1289:      const char *val;
;1290:      // expect value then ; or NULL, NULL ends list
;1291:      if (!String_Parse(&p, &val)) {
ADDRLP4 0
ARGP4
ADDRLP4 2072
ARGP4
ADDRLP4 2076
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $590
line 1292
;1292:				return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $593
ADDRLP4 2080
CNSTI4 0
ASGNI4
ADDRGP4 $594
JUMPV
LABELV $593
ADDRLP4 2080
CNSTI4 1
ASGNI4
LABELV $594
ADDRLP4 2080
INDIRI4
RETI4
ADDRGP4 $584
JUMPV
LABELV $590
line 1295
;1293:      }
;1294:
;1295:      if (val[0] == ';' && val[1] == '\0') {
ADDRLP4 2080
ADDRLP4 2072
INDIRP4
ASGNP4
ADDRLP4 2080
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $595
ADDRLP4 2080
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $595
line 1296
;1296:        continue;
ADDRGP4 $588
JUMPV
LABELV $595
line 1300
;1297:      }
;1298:
;1299:			// enable it if any of the values are true
;1300:			if (item->cvarFlags & flag) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $597
line 1301
;1301:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1048
ARGP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $598
line 1302
;1302:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $584
JUMPV
line 1304
;1303:				}
;1304:			} else {
LABELV $597
line 1306
;1305:				// disable it if any of the values are true
;1306:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1048
ARGP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $601
line 1307
;1307:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $584
JUMPV
LABELV $601
line 1309
;1308:				}
;1309:			}
LABELV $598
line 1311
;1310:
;1311:    }
LABELV $588
line 1288
ADDRGP4 $587
JUMPV
line 1312
;1312:		return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $604
ADDRLP4 2072
CNSTI4 0
ASGNI4
ADDRGP4 $605
JUMPV
LABELV $604
ADDRLP4 2072
CNSTI4 1
ASGNI4
LABELV $605
ADDRLP4 2072
INDIRI4
RETI4
ADDRGP4 $584
JUMPV
LABELV $585
line 1314
;1313:  }
;1314:	return qtrue;
CNSTI4 1
RETI4
LABELV $584
endproc Item_EnableShowViaCvar 2088 12
export Item_SetFocus
proc Item_SetFocus 80 12
line 1319
;1315:}
;1316:
;1317:
;1318:// will optionaly set focus to this item 
;1319:qboolean Item_SetFocus(itemDef_t *item, float x, float y) {
line 1322
;1320:	int i;
;1321:	itemDef_t *oldFocus;
;1322:	sfxHandle_t *sfx = &DC->Assets.itemFocusSound;
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
ASGNP4
line 1323
;1323:	qboolean playSound = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1326
;1324:	menuDef_t *parent; // bk001206: = (menuDef_t*)item->parent;
;1325:	// sanity check, non-null, not a decoration and does not already have the focus
;1326:	if (item == NULL || item->window.flags & WINDOW_DECORATION || item->window.flags & WINDOW_HASFOCUS || !(item->window.flags & WINDOW_VISIBLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $611
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $611
ADDRLP4 24
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $611
ADDRLP4 24
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $607
LABELV $611
line 1327
;1327:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $606
JUMPV
LABELV $607
line 1331
;1328:	}
;1329:
;1330:	// bk001206 - this can be NULL.
;1331:	parent = (menuDef_t*)item->parent; 
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 1334
;1332:      
;1333:	// items can be enabled and disabled based on cvars
;1334:	if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $612
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $612
line 1335
;1335:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $606
JUMPV
LABELV $612
line 1338
;1336:	}
;1337:
;1338:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $614
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 44
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $614
line 1339
;1339:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $606
JUMPV
LABELV $614
line 1342
;1340:	}
;1341:
;1342:	oldFocus = Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Menu_ClearFocus
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 48
INDIRP4
ASGNP4
line 1344
;1343:
;1344:	if (item->type == ITEM_TYPE_TEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $616
line 1346
;1345:		rectDef_t r;
;1346:		r = item->textRect;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1347
;1347:		r.y -= r.h;
ADDRLP4 52+4
ADDRLP4 52+4
INDIRF4
ADDRLP4 52+12
INDIRF4
SUBF4
ASGNF4
line 1348
;1348:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 52
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $620
line 1349
;1349:			item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1350
;1350:			if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $622
line 1351
;1351:				sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1352
;1352:			}
LABELV $622
line 1353
;1353:			playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1354
;1354:		} else {
ADDRGP4 $617
JUMPV
LABELV $620
line 1355
;1355:			if (oldFocus) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $617
line 1356
;1356:				oldFocus->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 72
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1357
;1357:				if (oldFocus->onFocus) {
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $617
line 1358
;1358:					Item_RunScript(oldFocus, oldFocus->onFocus);
ADDRLP4 76
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1359
;1359:				}
line 1360
;1360:			}
line 1361
;1361:		}
line 1362
;1362:	} else {
ADDRGP4 $617
JUMPV
LABELV $616
line 1363
;1363:	    item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1364
;1364:		if (item->onFocus) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $628
line 1365
;1365:			Item_RunScript(item, item->onFocus);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1366
;1366:		}
LABELV $628
line 1367
;1367:		if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $630
line 1368
;1368:			sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1369
;1369:		}
LABELV $630
line 1370
;1370:		playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1371
;1371:	}
LABELV $617
line 1373
;1372:
;1373:	if (playSound && sfx) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $632
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $632
line 1374
;1374:		DC->startLocalSound( *sfx, CHAN_LOCAL_SOUND );
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1375
;1375:	}
LABELV $632
line 1377
;1376:
;1377:	for (i = 0; i < parent->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $637
JUMPV
LABELV $634
line 1378
;1378:		if (parent->items[i] == item) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $638
line 1379
;1379:			parent->cursorItem = i;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1380
;1380:			break;
ADDRGP4 $636
JUMPV
LABELV $638
line 1382
;1381:		}
;1382:	}
LABELV $635
line 1377
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $637
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $634
LABELV $636
line 1384
;1383:
;1384:	return qtrue;
CNSTI4 1
RETI4
LABELV $606
endproc Item_SetFocus 80 12
export Item_ListBox_MaxScroll
proc Item_ListBox_MaxScroll 16 4
line 1387
;1385:}
;1386:
;1387:int Item_ListBox_MaxScroll(itemDef_t *item) {
line 1388
;1388:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1389
;1389:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1392
;1390:	int max;
;1391:
;1392:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $641
line 1393
;1393:		max = count - (item->window.rect.w / listPtr->elementWidth) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1394
;1394:	}
ADDRGP4 $642
JUMPV
LABELV $641
line 1395
;1395:	else {
line 1396
;1396:		max = count - (item->window.rect.h / listPtr->elementHeight) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1397
;1397:	}
LABELV $642
line 1398
;1398:	if (max < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $643
line 1399
;1399:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $640
JUMPV
LABELV $643
line 1401
;1400:	}
;1401:	return max;
ADDRLP4 0
INDIRI4
RETI4
LABELV $640
endproc Item_ListBox_MaxScroll 16 4
export Item_ListBox_ThumbPosition
proc Item_ListBox_ThumbPosition 20 4
line 1404
;1402:}
;1403:
;1404:int Item_ListBox_ThumbPosition(itemDef_t *item) {
line 1406
;1405:	float max, pos, size;
;1406:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1408
;1407:
;1408:	max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1409
;1409:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $646
line 1410
;1410:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1411
;1411:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $648
line 1412
;1412:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1413
;1413:		} else {
ADDRGP4 $649
JUMPV
LABELV $648
line 1414
;1414:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1415
;1415:		}
LABELV $649
line 1416
;1416:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1417
;1417:		return item->window.rect.x + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
ADDRGP4 $645
JUMPV
LABELV $646
line 1419
;1418:	}
;1419:	else {
line 1420
;1420:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1421
;1421:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $650
line 1422
;1422:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1423
;1423:		} else {
ADDRGP4 $651
JUMPV
LABELV $650
line 1424
;1424:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1425
;1425:		}
LABELV $651
line 1426
;1426:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1427
;1427:		return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
LABELV $645
endproc Item_ListBox_ThumbPosition 20 4
export Item_ListBox_ThumbDrawPosition
proc Item_ListBox_ThumbDrawPosition 24 4
line 1431
;1428:	}
;1429:}
;1430:
;1431:int Item_ListBox_ThumbDrawPosition(itemDef_t *item) {
line 1434
;1432:	int min, max;
;1433:
;1434:	if (itemCapture == item) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $653
line 1435
;1435:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $655
line 1436
;1436:			min = item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1437
;1437:			max = item->window.rect.x + item->window.rect.w - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 1438
;1438:			if (DC->cursorx >= min + SCROLLBAR_SIZE/2 && DC->cursorx <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
LTF4 $657
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
GTF4 $657
line 1439
;1439:				return DC->cursorx - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $652
JUMPV
LABELV $657
line 1441
;1440:			}
;1441:			else {
line 1442
;1442:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $652
JUMPV
LABELV $655
line 1445
;1443:			}
;1444:		}
;1445:		else {
line 1446
;1446:			min = item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1447
;1447:			max = item->window.rect.y + item->window.rect.h - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 1448
;1448:			if (DC->cursory >= min + SCROLLBAR_SIZE/2 && DC->cursory <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
LTF4 $659
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
GTF4 $659
line 1449
;1449:				return DC->cursory - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $652
JUMPV
LABELV $659
line 1451
;1450:			}
;1451:			else {
line 1452
;1452:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $652
JUMPV
LABELV $653
line 1456
;1453:			}
;1454:		}
;1455:	}
;1456:	else {
line 1457
;1457:		return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $652
endproc Item_ListBox_ThumbDrawPosition 24 4
export Item_Slider_ThumbPosition
proc Item_Slider_ThumbPosition 28 4
line 1461
;1458:	}
;1459:}
;1460:
;1461:float Item_Slider_ThumbPosition(itemDef_t *item) {
line 1463
;1462:	float value, range, x;
;1463:	editFieldDef_t *editDef = item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1465
;1464:
;1465:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $662
line 1466
;1466:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1467
;1467:	} else {
ADDRGP4 $663
JUMPV
LABELV $662
line 1468
;1468:		x = item->window.rect.x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1469
;1469:	}
LABELV $663
line 1471
;1470:
;1471:	if (editDef == NULL && item->cvar) {
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $664
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $664
line 1472
;1472:		return x;
ADDRLP4 8
INDIRF4
RETF4
ADDRGP4 $661
JUMPV
LABELV $664
line 1475
;1473:	}
;1474:
;1475:	value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1477
;1476:
;1477:	if (value < editDef->minVal) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
GEF4 $666
line 1478
;1478:		value = editDef->minVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
line 1479
;1479:	} else if (value > editDef->maxVal) {
ADDRGP4 $667
JUMPV
LABELV $666
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $668
line 1480
;1480:		value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1481
;1481:	}
LABELV $668
LABELV $667
line 1483
;1482:
;1483:	range = editDef->maxVal - editDef->minVal;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1484
;1484:	value -= editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1485
;1485:	value /= range;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 1487
;1486:	//value /= (editDef->maxVal - editDef->minVal);
;1487:	value *= SLIDER_WIDTH;
ADDRLP4 0
CNSTF4 1119879168
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1488
;1488:	x += value;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 1491
;1489:	// vm fuckage
;1490:	//x = x + (((float)value / editDef->maxVal) * SLIDER_WIDTH);
;1491:	return x;
ADDRLP4 8
INDIRF4
RETF4
LABELV $661
endproc Item_Slider_ThumbPosition 28 4
export Item_Slider_OverSlider
proc Item_Slider_OverSlider 24 12
line 1494
;1492:}
;1493:
;1494:int Item_Slider_OverSlider(itemDef_t *item, float x, float y) {
line 1497
;1495:	rectDef_t r;
;1496:
;1497:	r.x = Item_Slider_ThumbPosition(item) - (SLIDER_THUMB_WIDTH / 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 1086324736
SUBF4
ASGNF4
line 1498
;1498:	r.y = item->window.rect.y - 2;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1499
;1499:	r.w = SLIDER_THUMB_WIDTH;
ADDRLP4 0+8
CNSTF4 1094713344
ASGNF4
line 1500
;1500:	r.h = SLIDER_THUMB_HEIGHT;
ADDRLP4 0+12
CNSTF4 1101004800
ASGNF4
line 1502
;1501:
;1502:	if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $674
line 1503
;1503:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $670
JUMPV
LABELV $674
line 1505
;1504:	}
;1505:	return 0;
CNSTI4 0
RETI4
LABELV $670
endproc Item_Slider_OverSlider 24 12
export Item_ListBox_OverLB
proc Item_ListBox_OverLB 72 12
line 1508
;1506:}
;1507:
;1508:int Item_ListBox_OverLB(itemDef_t *item, float x, float y) {
line 1514
;1509:	rectDef_t r;
;1510:	listBoxDef_t *listPtr;
;1511:	int thumbstart;
;1512:	int count;
;1513:
;1514:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 1515
;1515:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1516
;1516:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $677
line 1518
;1517:		// check if on left arrow
;1518:		r.x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1519
;1519:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1520
;1520:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1521
;1521:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $682
line 1522
;1522:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $676
JUMPV
LABELV $682
line 1525
;1523:		}
;1524:		// check if on right arrow
;1525:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1526
;1526:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $684
line 1527
;1527:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $676
JUMPV
LABELV $684
line 1530
;1528:		}
;1529:		// check if on thumb
;1530:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1531
;1531:		r.x = thumbstart;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1532
;1532:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $686
line 1533
;1533:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $676
JUMPV
LABELV $686
line 1535
;1534:		}
;1535:		r.x = item->window.rect.x + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1536
;1536:		r.w = thumbstart - r.x;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1537
;1537:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $689
line 1538
;1538:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $676
JUMPV
LABELV $689
line 1540
;1539:		}
;1540:		r.x = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1541
;1541:		r.w = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1542
;1542:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $678
line 1543
;1543:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $676
JUMPV
line 1545
;1544:		}
;1545:	} else {
LABELV $677
line 1546
;1546:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1547
;1547:		r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1548
;1548:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1549
;1549:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $697
line 1550
;1550:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $676
JUMPV
LABELV $697
line 1552
;1551:		}
;1552:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1553
;1553:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $700
line 1554
;1554:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $676
JUMPV
LABELV $700
line 1556
;1555:		}
;1556:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1557
;1557:		r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1558
;1558:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $703
line 1559
;1559:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $676
JUMPV
LABELV $703
line 1561
;1560:		}
;1561:		r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1562
;1562:		r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 1563
;1563:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $708
line 1564
;1564:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $676
JUMPV
LABELV $708
line 1566
;1565:		}
;1566:		r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1567
;1567:		r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1568
;1568:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $712
line 1569
;1569:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $676
JUMPV
LABELV $712
line 1571
;1570:		}
;1571:	}
LABELV $678
line 1572
;1572:	return 0;
CNSTI4 0
RETI4
LABELV $676
endproc Item_ListBox_OverLB 72 12
export Item_ListBox_MouseEnter
proc Item_ListBox_MouseEnter 56 12
line 1577
;1573:}
;1574:
;1575:
;1576:void Item_ListBox_MouseEnter(itemDef_t *item, float x, float y) 
;1577:{
line 1579
;1578:	rectDef_t r;
;1579:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1581
;1580:        
;1581:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -63489
BANDI4
ASGNI4
line 1582
;1582:	item->window.flags |= Item_ListBox_OverLB(item, x, y);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 1584
;1583:
;1584:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $715
line 1585
;1585:		if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $716
line 1587
;1586:			// check for selection hit as we have exausted buttons and thumb
;1587:			if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $716
line 1588
;1588:				r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1589
;1589:				r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1590
;1590:				r.h = item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1591
;1591:				r.w = item->window.rect.w - listPtr->drawPadding;
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1592
;1592:				if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $716
line 1593
;1593:					listPtr->cursorPos =  (int)((x - r.x) / listPtr->elementWidth)  + listPtr->startPos;
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 44
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 1594
;1594:					if (listPtr->cursorPos >= listPtr->endPos) {
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $716
line 1595
;1595:						listPtr->cursorPos = listPtr->endPos;
ADDRLP4 52
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1596
;1596:					}
line 1597
;1597:				}
line 1598
;1598:			} else {
line 1600
;1599:				// text hit.. 
;1600:			}
line 1601
;1601:		}
line 1602
;1602:	} else if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRGP4 $716
JUMPV
LABELV $715
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $728
line 1603
;1603:		r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1604
;1604:		r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1605
;1605:		r.w = item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1606
;1606:		r.h = item->window.rect.h - listPtr->drawPadding;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1607
;1607:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $733
line 1608
;1608:			listPtr->cursorPos =  (int)((y - 2 - r.y) / listPtr->elementHeight)  + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ADDRLP4 4+4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 1609
;1609:			if (listPtr->cursorPos > listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $736
line 1610
;1610:				listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1611
;1611:			}
LABELV $736
line 1612
;1612:		}
LABELV $733
line 1613
;1613:	}
LABELV $728
LABELV $716
line 1614
;1614:}
LABELV $714
endproc Item_ListBox_MouseEnter 56 12
export Item_MouseEnter
proc Item_MouseEnter 44 12
line 1616
;1615:
;1616:void Item_MouseEnter(itemDef_t *item, float x, float y) {
line 1618
;1617:	rectDef_t r;
;1618:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $739
line 1619
;1619:		r = item->textRect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1620
;1620:		r.y -= r.h;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
line 1624
;1621:		// in the text rect?
;1622:
;1623:		// items can be enabled and disabled based on cvars
;1624:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $743
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $743
line 1625
;1625:			return;
ADDRGP4 $738
JUMPV
LABELV $743
line 1628
;1626:		}
;1627:
;1628:		if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $745
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $745
line 1629
;1629:			return;
ADDRGP4 $738
JUMPV
LABELV $745
line 1632
;1630:		}
;1631:
;1632:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $747
line 1633
;1633:			if (!(item->window.flags & WINDOW_MOUSEOVERTEXT)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $749
line 1634
;1634:				Item_RunScript(item, item->mouseEnterText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1635
;1635:				item->window.flags |= WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1636
;1636:			}
LABELV $749
line 1637
;1637:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $748
line 1638
;1638:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1639
;1639:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1640
;1640:			}
line 1642
;1641:
;1642:		} else {
ADDRGP4 $748
JUMPV
LABELV $747
line 1644
;1643:			// not in the text rect
;1644:			if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $753
line 1646
;1645:				// if we were
;1646:				Item_RunScript(item, item->mouseExitText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1647
;1647:				item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1648
;1648:			}
LABELV $753
line 1649
;1649:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $755
line 1650
;1650:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1651
;1651:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1652
;1652:			}
LABELV $755
line 1654
;1653:
;1654:			if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $757
line 1655
;1655:				Item_ListBox_MouseEnter(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_ListBox_MouseEnter
CALLV
pop
line 1656
;1656:			}
LABELV $757
line 1657
;1657:		}
LABELV $748
line 1658
;1658:	}
LABELV $739
line 1659
;1659:}
LABELV $738
endproc Item_MouseEnter 44 12
export Item_MouseLeave
proc Item_MouseLeave 8 8
line 1661
;1660:
;1661:void Item_MouseLeave(itemDef_t *item) {
line 1662
;1662:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $760
line 1663
;1663:    if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $762
line 1664
;1664:      Item_RunScript(item, item->mouseExitText);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1665
;1665:      item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1666
;1666:    }
LABELV $762
line 1667
;1667:    Item_RunScript(item, item->mouseExit);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1668
;1668:    item->window.flags &= ~(WINDOW_LB_RIGHTARROW | WINDOW_LB_LEFTARROW);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -6145
BANDI4
ASGNI4
line 1669
;1669:  }
LABELV $760
line 1670
;1670:}
LABELV $759
endproc Item_MouseLeave 8 8
export Menu_HitTest
proc Menu_HitTest 8 12
line 1672
;1671:
;1672:itemDef_t *Menu_HitTest(menuDef_t *menu, float x, float y) {
line 1674
;1673:  int i;
;1674:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $768
JUMPV
LABELV $765
line 1675
;1675:    if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $769
line 1676
;1676:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $764
JUMPV
LABELV $769
line 1678
;1677:    }
;1678:  }
LABELV $766
line 1674
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $768
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $765
line 1679
;1679:  return NULL;
CNSTP4 0
RETP4
LABELV $764
endproc Menu_HitTest 8 12
export Item_SetMouseOver
proc Item_SetMouseOver 4 0
line 1682
;1680:}
;1681:
;1682:void Item_SetMouseOver(itemDef_t *item, qboolean focus) {
line 1683
;1683:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $772
line 1684
;1684:    if (focus) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $774
line 1685
;1685:      item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1686
;1686:    } else {
ADDRGP4 $775
JUMPV
LABELV $774
line 1687
;1687:      item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1688
;1688:    }
LABELV $775
line 1689
;1689:  }
LABELV $772
line 1690
;1690:}
LABELV $771
endproc Item_SetMouseOver 4 0
export Item_OwnerDraw_HandleKey
proc Item_OwnerDraw_HandleKey 12 16
line 1693
;1691:
;1692:
;1693:qboolean Item_OwnerDraw_HandleKey(itemDef_t *item, int key) {
line 1694
;1694:  if (item && DC->ownerDrawHandleKey) {
ADDRLP4 0
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
EQU4 $777
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
EQU4 $777
line 1695
;1695:    return DC->ownerDrawHandleKey(item->window.ownerDraw, item->window.ownerDrawFlags, &item->special, key);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $776
JUMPV
LABELV $777
line 1697
;1696:  }
;1697:  return qfalse;
CNSTI4 0
RETI4
LABELV $776
endproc Item_OwnerDraw_HandleKey 12 16
export Item_ListBox_HandleKey
proc Item_ListBox_HandleKey 72 12
line 1700
;1698:}
;1699:
;1700:qboolean Item_ListBox_HandleKey(itemDef_t *item, int key, qboolean down, qboolean force) {
line 1701
;1701:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1702
;1702:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 1705
;1703:	int max, viewmax;
;1704:
;1705:	if (force || (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $782
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $780
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $780
LABELV $782
line 1706
;1706:		max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 1707
;1707:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $783
line 1708
;1708:			viewmax = (item->window.rect.w / listPtr->elementWidth);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1709
;1709:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 134
EQI4 $787
ADDRLP4 36
INDIRI4
CNSTI4 163
NEI4 $785
LABELV $787
line 1710
;1710:			{
line 1711
;1711:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $788
line 1712
;1712:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1713
;1713:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $790
line 1714
;1714:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1715
;1715:					}
LABELV $790
line 1716
;1716:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $792
line 1717
;1717:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1718
;1718:					}
LABELV $792
line 1719
;1719:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $794
line 1720
;1720:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1721
;1721:					}
LABELV $794
line 1722
;1722:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1723
;1723:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1724
;1724:				}
ADDRGP4 $789
JUMPV
LABELV $788
line 1725
;1725:				else {
line 1726
;1726:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1727
;1727:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $796
line 1728
;1728:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $796
line 1729
;1729:				}
LABELV $789
line 1730
;1730:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $785
line 1732
;1731:			}
;1732:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 135
EQI4 $800
ADDRLP4 40
INDIRI4
CNSTI4 165
NEI4 $784
LABELV $800
line 1733
;1733:			{
line 1734
;1734:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $801
line 1735
;1735:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1736
;1736:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $803
line 1737
;1737:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1738
;1738:					}
LABELV $803
line 1739
;1739:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $805
line 1740
;1740:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1741
;1741:					}
LABELV $805
line 1742
;1742:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $807
line 1743
;1743:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1744
;1744:					}
LABELV $807
line 1745
;1745:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1746
;1746:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1747
;1747:				}
ADDRGP4 $802
JUMPV
LABELV $801
line 1748
;1748:				else {
line 1749
;1749:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1750
;1750:					if (listPtr->startPos >= count)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $809
line 1751
;1751:						listPtr->startPos = count-1;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $809
line 1752
;1752:				}
LABELV $802
line 1753
;1753:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
line 1755
;1754:			}
;1755:		}
LABELV $783
line 1756
;1756:		else {
line 1757
;1757:			viewmax = (item->window.rect.h / listPtr->elementHeight);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1758
;1758:			if ( key == K_UPARROW || key == K_KP_UPARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 132
EQI4 $813
ADDRLP4 36
INDIRI4
CNSTI4 161
NEI4 $811
LABELV $813
line 1759
;1759:			{
line 1760
;1760:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $814
line 1761
;1761:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1762
;1762:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $816
line 1763
;1763:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1764
;1764:					}
LABELV $816
line 1765
;1765:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $818
line 1766
;1766:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1767
;1767:					}
LABELV $818
line 1768
;1768:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $820
line 1769
;1769:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1770
;1770:					}
LABELV $820
line 1771
;1771:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1772
;1772:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1773
;1773:				}
ADDRGP4 $815
JUMPV
LABELV $814
line 1774
;1774:				else {
line 1775
;1775:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1776
;1776:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $822
line 1777
;1777:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $822
line 1778
;1778:				}
LABELV $815
line 1779
;1779:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $811
line 1781
;1780:			}
;1781:			if ( key == K_DOWNARROW || key == K_KP_DOWNARROW ) 
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 133
EQI4 $826
ADDRLP4 40
INDIRI4
CNSTI4 167
NEI4 $824
LABELV $826
line 1782
;1782:			{
line 1783
;1783:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $827
line 1784
;1784:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1785
;1785:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $829
line 1786
;1786:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1787
;1787:					}
LABELV $829
line 1788
;1788:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $831
line 1789
;1789:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1790
;1790:					}
LABELV $831
line 1791
;1791:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $833
line 1792
;1792:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1793
;1793:					}
LABELV $833
line 1794
;1794:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1795
;1795:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1796
;1796:				}
ADDRGP4 $828
JUMPV
LABELV $827
line 1797
;1797:				else {
line 1798
;1798:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1799
;1799:					if (listPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $835
line 1800
;1800:						listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $835
line 1801
;1801:				}
LABELV $828
line 1802
;1802:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $824
line 1804
;1803:			}
;1804:		}
LABELV $784
line 1806
;1805:		// mouse hit
;1806:		if (key == K_MOUSE1 || key == K_MOUSE2) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $839
ADDRLP4 36
INDIRI4
CNSTI4 179
NEI4 $837
LABELV $839
line 1807
;1807:			if (item->window.flags & WINDOW_LB_LEFTARROW) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $840
line 1808
;1808:				listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1809
;1809:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $841
line 1810
;1810:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1811
;1811:				}
line 1812
;1812:			} else if (item->window.flags & WINDOW_LB_RIGHTARROW) {
ADDRGP4 $841
JUMPV
LABELV $840
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $844
line 1814
;1813:				// one down
;1814:				listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1815
;1815:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $845
line 1816
;1816:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1817
;1817:				}
line 1818
;1818:			} else if (item->window.flags & WINDOW_LB_PGUP) {
ADDRGP4 $845
JUMPV
LABELV $844
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $848
line 1820
;1819:				// page up
;1820:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1821
;1821:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $849
line 1822
;1822:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1823
;1823:				}
line 1824
;1824:			} else if (item->window.flags & WINDOW_LB_PGDN) {
ADDRGP4 $849
JUMPV
LABELV $848
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $852
line 1826
;1825:				// page down
;1826:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1827
;1827:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $853
line 1828
;1828:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1829
;1829:				}
line 1830
;1830:			} else if (item->window.flags & WINDOW_LB_THUMB) {
ADDRGP4 $853
JUMPV
LABELV $852
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $856
line 1832
;1831:				// Display_SetCaptureItem(item);
;1832:			} else {
ADDRGP4 $857
JUMPV
LABELV $856
line 1834
;1833:				// select an item
;1834:				if (DC->realTime < lastListBoxClickTime && listPtr->doubleClick) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRGP4 lastListBoxClickTime
INDIRI4
GEI4 $858
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $858
line 1835
;1835:					Item_RunScript(item, listPtr->doubleClick);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1836
;1836:				}
LABELV $858
line 1837
;1837:				lastListBoxClickTime = DC->realTime + DOUBLE_CLICK_DELAY;
ADDRGP4 lastListBoxClickTime
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 1838
;1838:				if (item->cursorPos != listPtr->cursorPos) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $860
line 1839
;1839:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1840
;1840:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1841
;1841:				}
LABELV $860
line 1842
;1842:			}
LABELV $857
LABELV $853
LABELV $849
LABELV $845
LABELV $841
line 1843
;1843:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $837
line 1845
;1844:		}
;1845:		if ( key == K_HOME || key == K_KP_HOME) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 143
EQI4 $864
ADDRLP4 40
INDIRI4
CNSTI4 160
NEI4 $862
LABELV $864
line 1847
;1846:			// home
;1847:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1848
;1848:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $862
line 1850
;1849:		}
;1850:		if ( key == K_END || key == K_KP_END) {
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 144
EQI4 $867
ADDRLP4 44
INDIRI4
CNSTI4 166
NEI4 $865
LABELV $867
line 1852
;1851:			// end
;1852:			listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1853
;1853:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $865
line 1855
;1854:		}
;1855:		if (key == K_PGUP || key == K_KP_PGUP ) {
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 142
EQI4 $870
ADDRLP4 48
INDIRI4
CNSTI4 162
NEI4 $868
LABELV $870
line 1857
;1856:			// page up
;1857:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $871
line 1858
;1858:				listPtr->cursorPos -= viewmax;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1859
;1859:				if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $873
line 1860
;1860:					listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1861
;1861:				}
LABELV $873
line 1862
;1862:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $875
line 1863
;1863:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1864
;1864:				}
LABELV $875
line 1865
;1865:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $877
line 1866
;1866:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1867
;1867:				}
LABELV $877
line 1868
;1868:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1869
;1869:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1870
;1870:			}
ADDRGP4 $872
JUMPV
LABELV $871
line 1871
;1871:			else {
line 1872
;1872:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1873
;1873:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $879
line 1874
;1874:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1875
;1875:				}
LABELV $879
line 1876
;1876:			}
LABELV $872
line 1877
;1877:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $868
line 1879
;1878:		}
;1879:		if ( key == K_PGDN || key == K_KP_PGDN ) {
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 141
EQI4 $883
ADDRLP4 52
INDIRI4
CNSTI4 168
NEI4 $881
LABELV $883
line 1881
;1880:			// page down
;1881:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $884
line 1882
;1882:				listPtr->cursorPos += viewmax;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1883
;1883:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $886
line 1884
;1884:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1885
;1885:				}
LABELV $886
line 1886
;1886:				if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $888
line 1887
;1887:					listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1888
;1888:				}
LABELV $888
line 1889
;1889:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $890
line 1890
;1890:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1891
;1891:				}
LABELV $890
line 1892
;1892:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1893
;1893:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1894
;1894:			}
ADDRGP4 $885
JUMPV
LABELV $884
line 1895
;1895:			else {
line 1896
;1896:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1897
;1897:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $892
line 1898
;1898:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1899
;1899:				}
LABELV $892
line 1900
;1900:			}
LABELV $885
line 1901
;1901:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $779
JUMPV
LABELV $881
line 1903
;1902:		}
;1903:	}
LABELV $780
line 1904
;1904:	return qfalse;
CNSTI4 0
RETI4
LABELV $779
endproc Item_ListBox_HandleKey 72 12
export Item_YesNo_HandleKey
proc Item_YesNo_HandleKey 32 12
line 1907
;1905:}
;1906:
;1907:qboolean Item_YesNo_HandleKey(itemDef_t *item, int key) {
line 1909
;1908:
;1909:  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $895
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $895
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $895
line 1910
;1910:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $901
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $901
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $901
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $897
LABELV $901
line 1911
;1911:	    DC->setCVar(item->cvar, va("%i", !DC->getCVarValue(item->cvar)));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 0
NEF4 $904
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $905
JUMPV
LABELV $904
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $905
ADDRGP4 $902
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1912
;1912:		  return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $894
JUMPV
LABELV $897
line 1914
;1913:		}
;1914:  }
LABELV $895
line 1916
;1915:
;1916:  return qfalse;
CNSTI4 0
RETI4
LABELV $894
endproc Item_YesNo_HandleKey 32 12
export Item_Multi_CountSettings
proc Item_Multi_CountSettings 4 0
line 1920
;1917:
;1918:}
;1919:
;1920:int Item_Multi_CountSettings(itemDef_t *item) {
line 1921
;1921:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1922
;1922:	if (multiPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $907
line 1923
;1923:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $906
JUMPV
LABELV $907
line 1925
;1924:	}
;1925:	return multiPtr->count;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
RETI4
LABELV $906
endproc Item_Multi_CountSettings 4 0
export Item_Multi_FindCvarByValue
proc Item_Multi_FindCvarByValue 1040 12
line 1928
;1926:}
;1927:
;1928:int Item_Multi_FindCvarByValue(itemDef_t *item) {
line 1930
;1929:	char buff[1024];
;1930:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1932
;1931:	int i;
;1932:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1933
;1933:	if (multiPtr) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $910
line 1934
;1934:		if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $912
line 1935
;1935:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1936
;1936:		} else {
ADDRGP4 $913
JUMPV
LABELV $912
line 1937
;1937:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 1938
;1938:		}
LABELV $913
line 1939
;1939:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $917
JUMPV
LABELV $914
line 1940
;1940:			if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $918
line 1941
;1941:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $919
line 1942
;1942:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $909
JUMPV
line 1944
;1943:				}
;1944:			} else {
LABELV $918
line 1945
;1945: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $922
line 1946
;1946: 					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $909
JUMPV
LABELV $922
line 1948
;1947: 				}
;1948: 			}
LABELV $919
line 1949
;1949: 		}
LABELV $915
line 1939
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $917
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $914
line 1950
;1950:	}
LABELV $910
line 1951
;1951:	return 0;
CNSTI4 0
RETI4
LABELV $909
endproc Item_Multi_FindCvarByValue 1040 12
export Item_Multi_Setting
proc Item_Multi_Setting 1040 12
line 1954
;1952:}
;1953:
;1954:const char *Item_Multi_Setting(itemDef_t *item) {
line 1956
;1955:	char buff[1024];
;1956:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1958
;1957:	int i;
;1958:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1959
;1959:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $925
line 1960
;1960:		if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $927
line 1961
;1961:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1962
;1962:		} else {
ADDRGP4 $928
JUMPV
LABELV $927
line 1963
;1963:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 1964
;1964:		}
LABELV $928
line 1965
;1965:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $932
JUMPV
LABELV $929
line 1966
;1966:			if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $933
line 1967
;1967:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $934
line 1968
;1968:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $924
JUMPV
line 1970
;1969:				}
;1970:			} else {
LABELV $933
line 1971
;1971: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $937
line 1972
;1972:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $924
JUMPV
LABELV $937
line 1974
;1973: 				}
;1974: 			}
LABELV $934
line 1975
;1975: 		}
LABELV $930
line 1965
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $932
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $929
line 1976
;1976:	}
LABELV $925
line 1977
;1977:	return "";
ADDRGP4 $55
RETP4
LABELV $924
endproc Item_Multi_Setting 1040 12
export Item_Multi_HandleKey
proc Item_Multi_HandleKey 56 12
line 1980
;1978:}
;1979:
;1980:qboolean Item_Multi_HandleKey(itemDef_t *item, int key) {
line 1981
;1981:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1982
;1982:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $940
line 1983
;1983:	  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $942
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $942
ADDRLP4 16
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $942
line 1984
;1984:			if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 178
EQI4 $948
ADDRLP4 20
INDIRI4
CNSTI4 13
EQI4 $948
ADDRLP4 20
INDIRI4
CNSTI4 179
EQI4 $948
ADDRLP4 20
INDIRI4
CNSTI4 180
NEI4 $944
LABELV $948
line 1985
;1985:				int current = Item_Multi_FindCvarByValue(item) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_Multi_FindCvarByValue
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1986
;1986:				int max = Item_Multi_CountSettings(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_Multi_CountSettings
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 1987
;1987:				if ( current < 0 || current >= max ) {
ADDRLP4 40
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $951
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $949
LABELV $951
line 1988
;1988:					current = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 1989
;1989:				}
LABELV $949
line 1990
;1990:				if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $952
line 1991
;1991:					DC->setCVar(item->cvar, multiPtr->cvarStr[current]);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1992
;1992:				} else {
ADDRGP4 $953
JUMPV
LABELV $952
line 1993
;1993:					float value = multiPtr->cvarValue[current];
ADDRLP4 44
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ASGNF4
line 1994
;1994:					if (((float)((int) value)) == value) {
ADDRLP4 48
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
CVFI4 4
CVIF4 4
ADDRLP4 48
INDIRF4
NEF4 $954
line 1995
;1995:						DC->setCVar(item->cvar, va("%i", (int) value ));
ADDRGP4 $902
ARGP4
ADDRLP4 44
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1996
;1996:					}
ADDRGP4 $955
JUMPV
LABELV $954
line 1997
;1997:					else {
line 1998
;1998:						DC->setCVar(item->cvar, va("%f", value ));
ADDRGP4 $956
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1999
;1999:					}
LABELV $955
line 2000
;2000:				}
LABELV $953
line 2001
;2001:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $939
JUMPV
LABELV $944
line 2003
;2002:			}
;2003:		}
LABELV $942
line 2004
;2004:	}
LABELV $940
line 2005
;2005:  return qfalse;
CNSTI4 0
RETI4
LABELV $939
endproc Item_Multi_HandleKey 56 12
export Item_TextField_HandleKey
proc Item_TextField_HandleKey 1076 12
line 2008
;2006:}
;2007:
;2008:qboolean Item_TextField_HandleKey(itemDef_t *item, int key) {
line 2011
;2009:	char buff[1024];
;2010:	int len;
;2011:	itemDef_t *newItem = NULL;
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 2012
;2012:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2014
;2013:
;2014:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $958
line 2016
;2015:
;2016:		memset(buff, 0, sizeof(buff));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2017
;2017:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2018
;2018:		len = strlen(buff);
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1036
INDIRI4
ASGNI4
line 2019
;2019:		if (editPtr->maxChars && len > editPtr->maxChars) {
ADDRLP4 1040
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $960
ADDRLP4 1032
INDIRI4
ADDRLP4 1040
INDIRI4
LEI4 $960
line 2020
;2020:			len = editPtr->maxChars;
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2021
;2021:		}
LABELV $960
line 2022
;2022:		if ( key & K_CHAR_FLAG ) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $962
line 2023
;2023:			key &= ~K_CHAR_FLAG;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2026
;2024:
;2025:
;2026:			if (key == 'h' - 'a' + 1 )	{	// ctrl-h is backspace
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $964
line 2027
;2027:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $966
line 2028
;2028:					memmove( &buff[item->cursorPos - 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1044
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
ADDRLP4 4-1
ADDP4
ARGP4
ADDRLP4 1044
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1044
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2029
;2029:					item->cursorPos--;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2030
;2030:					if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $969
line 2031
;2031:						editPtr->paintOffset--;
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2032
;2032:					}
LABELV $969
line 2033
;2033:				}
LABELV $966
line 2034
;2034:				DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2035
;2035:	    		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $964
line 2042
;2036:			}
;2037:
;2038:
;2039:			//
;2040:			// ignore any non printable chars
;2041:			//
;2042:			if ( key < 32 || !item->cvar) {
ADDRFP4 4
INDIRI4
CNSTI4 32
LTI4 $973
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $971
LABELV $973
line 2043
;2043:			    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $971
line 2046
;2044:		    }
;2045:
;2046:			if (item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $974
line 2047
;2047:				if (key < '0' || key > '9') {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 48
LTI4 $978
ADDRLP4 1044
INDIRI4
CNSTI4 57
LEI4 $976
LABELV $978
line 2048
;2048:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $957
JUMPV
LABELV $976
line 2050
;2049:				}
;2050:			}
LABELV $974
line 2052
;2051:
;2052:			if (!DC->getOverstrikeMode()) {
ADDRLP4 1044
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $979
line 2053
;2053:				if (( len == MAX_EDITFIELD - 1 ) || (editPtr->maxChars && len >= editPtr->maxChars)) {
ADDRLP4 1048
ADDRLP4 1032
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 255
EQI4 $983
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $981
ADDRLP4 1048
INDIRI4
ADDRLP4 1052
INDIRI4
LTI4 $981
LABELV $983
line 2054
;2054:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $981
line 2056
;2055:				}
;2056:				memmove( &buff[item->cursorPos + 1], &buff[item->cursorPos], len + 1 - item->cursorPos );
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1056
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1056
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2057
;2057:			} else {
ADDRGP4 $980
JUMPV
LABELV $979
line 2058
;2058:				if (editPtr->maxChars && item->cursorPos >= editPtr->maxChars) {
ADDRLP4 1048
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $985
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
LTI4 $985
line 2059
;2059:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $985
line 2061
;2060:				}
;2061:			}
LABELV $980
line 2063
;2062:
;2063:			buff[item->cursorPos] = key;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 2065
;2064:
;2065:			DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2067
;2066:
;2067:			if (item->cursorPos < len + 1) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
GEI4 $963
line 2068
;2068:				item->cursorPos++;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2069
;2069:				if (editPtr->maxPaintChars && item->cursorPos > editPtr->maxPaintChars) {
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $963
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1052
INDIRI4
LEI4 $963
line 2070
;2070:					editPtr->paintOffset++;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2071
;2071:				}
line 2072
;2072:			}
line 2074
;2073:
;2074:		} else {
ADDRGP4 $963
JUMPV
LABELV $962
line 2076
;2075:
;2076:			if ( key == K_DEL || key == K_KP_DEL ) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 140
EQI4 $993
ADDRLP4 1044
INDIRI4
CNSTI4 171
NEI4 $991
LABELV $993
line 2077
;2077:				if ( item->cursorPos < len ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $994
line 2078
;2078:					memmove( buff + item->cursorPos, buff + item->cursorPos + 1, len - item->cursorPos);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1048
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1048
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2079
;2079:					DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2080
;2080:				}
LABELV $994
line 2081
;2081:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $991
line 2084
;2082:			}
;2083:
;2084:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 135
EQI4 $999
ADDRLP4 1048
INDIRI4
CNSTI4 165
NEI4 $997
LABELV $999
line 2085
;2085:			{
line 2086
;2086:				if (editPtr->maxPaintChars && item->cursorPos >= editPtr->maxPaintChars && item->cursorPos < len) {
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $1000
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
ADDRLP4 1052
INDIRI4
LTI4 $1000
ADDRLP4 1056
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1000
line 2087
;2087:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2088
;2088:					editPtr->paintOffset++;
ADDRLP4 1064
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2089
;2089:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $1000
line 2091
;2090:				}
;2091:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1002
line 2092
;2092:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2093
;2093:				} 
LABELV $1002
line 2094
;2094:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $997
line 2097
;2095:			}
;2096:
;2097:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 134
EQI4 $1006
ADDRLP4 1052
INDIRI4
CNSTI4 163
NEI4 $1004
LABELV $1006
line 2098
;2098:			{
line 2099
;2099:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1007
line 2100
;2100:					item->cursorPos--;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2101
;2101:				}
LABELV $1007
line 2102
;2102:				if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1009
line 2103
;2103:					editPtr->paintOffset--;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2104
;2104:				}
LABELV $1009
line 2105
;2105:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $1004
line 2108
;2106:			}
;2107:
;2108:			if ( key == K_HOME || key == K_KP_HOME) {// || ( tolower(key) == 'a' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1056
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 143
EQI4 $1013
ADDRLP4 1056
INDIRI4
CNSTI4 160
NEI4 $1011
LABELV $1013
line 2109
;2109:				item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2110
;2110:				editPtr->paintOffset = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2111
;2111:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $1011
line 2114
;2112:			}
;2113:
;2114:			if ( key == K_END || key == K_KP_END)  {// ( tolower(key) == 'e' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1060
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 144
EQI4 $1016
ADDRLP4 1060
INDIRI4
CNSTI4 166
NEI4 $1014
LABELV $1016
line 2115
;2115:				item->cursorPos = len;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 2116
;2116:				if(item->cursorPos > editPtr->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1017
line 2117
;2117:					editPtr->paintOffset = len - editPtr->maxPaintChars;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2118
;2118:				}
LABELV $1017
line 2119
;2119:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $1014
line 2122
;2120:			}
;2121:
;2122:			if ( key == K_INS || key == K_KP_INS ) {
ADDRLP4 1064
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 139
EQI4 $1021
ADDRLP4 1064
INDIRI4
CNSTI4 170
NEI4 $1019
LABELV $1021
line 2123
;2123:				DC->setOverstrikeMode(!DC->getOverstrikeMode());
ADDRLP4 1072
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1023
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $1024
JUMPV
LABELV $1023
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1024
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2124
;2124:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $1019
line 2126
;2125:			}
;2126:		}
LABELV $963
line 2128
;2127:
;2128:		if (key == K_TAB || key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 9
EQI4 $1028
ADDRLP4 1044
INDIRI4
CNSTI4 133
EQI4 $1028
ADDRLP4 1044
INDIRI4
CNSTI4 167
NEI4 $1025
LABELV $1028
line 2129
;2129:			newItem = Menu_SetNextCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 Menu_SetNextCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1048
INDIRP4
ASGNP4
line 2130
;2130:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1029
ADDRLP4 1056
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 4
EQI4 $1031
ADDRLP4 1056
INDIRI4
CNSTI4 9
NEI4 $1029
LABELV $1031
line 2131
;2131:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2132
;2132:			}
LABELV $1029
line 2133
;2133:		}
LABELV $1025
line 2135
;2134:
;2135:		if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 132
EQI4 $1034
ADDRLP4 1048
INDIRI4
CNSTI4 161
NEI4 $1032
LABELV $1034
line 2136
;2136:			newItem = Menu_SetPrevCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1052
INDIRP4
ASGNP4
line 2137
;2137:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1035
ADDRLP4 1060
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 4
EQI4 $1037
ADDRLP4 1060
INDIRI4
CNSTI4 9
NEI4 $1035
LABELV $1037
line 2138
;2138:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2139
;2139:			}
LABELV $1035
line 2140
;2140:		}
LABELV $1032
line 2142
;2141:
;2142:		if ( key == K_ENTER || key == K_KP_ENTER || key == K_ESCAPE)  {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 13
EQI4 $1041
ADDRLP4 1052
INDIRI4
CNSTI4 169
EQI4 $1041
ADDRLP4 1052
INDIRI4
CNSTI4 27
NEI4 $1038
LABELV $1041
line 2143
;2143:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $957
JUMPV
LABELV $1038
line 2146
;2144:		}
;2145:
;2146:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $958
line 2148
;2147:	}
;2148:	return qfalse;
CNSTI4 0
RETI4
LABELV $957
endproc Item_TextField_HandleKey 1076 12
proc Scroll_ListBox_AutoFunc 12 16
line 2152
;2149:
;2150:}
;2151:
;2152:static void Scroll_ListBox_AutoFunc(void *p) {
line 2153
;2153:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2154
;2154:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1043
line 2158
;2155:		// need to scroll which is done by simulating a click to the item
;2156:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2157:		// so it calls it directly
;2158:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2159
;2159:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2160
;2160:	}
LABELV $1043
line 2162
;2161:
;2162:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1045
line 2163
;2163:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2164
;2164:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1047
line 2165
;2165:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2166
;2166:		}
LABELV $1047
line 2167
;2167:	}
LABELV $1045
line 2168
;2168:}
LABELV $1042
endproc Scroll_ListBox_AutoFunc 12 16
proc Scroll_ListBox_ThumbFunc 40 16
line 2170
;2169:
;2170:static void Scroll_ListBox_ThumbFunc(void *p) {
line 2171
;2171:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2175
;2172:	rectDef_t r;
;2173:	int pos, max;
;2174:
;2175:	listBoxDef_t *listPtr = (listBoxDef_t*)si->item->typeData;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2176
;2176:	if (si->item->window.flags & WINDOW_HORIZONTAL) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1050
line 2177
;2177:		if (DC->cursorx == si->xStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
NEF4 $1052
line 2178
;2178:			return;
ADDRGP4 $1049
JUMPV
LABELV $1052
line 2180
;2179:		}
;2180:		r.x = si->item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2181
;2181:		r.y = si->item->window.rect.y + si->item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2182
;2182:		r.h = SCROLLBAR_SIZE;
ADDRLP4 4+12
CNSTF4 1098907648
ASGNF4
line 2183
;2183:		r.w = si->item->window.rect.w - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2184
;2184:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2186
;2185:		//
;2186:		pos = (DC->cursorx - r.x - SCROLLBAR_SIZE/2) * max / (r.w - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2187
;2187:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1058
line 2188
;2188:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2189
;2189:		}
ADDRGP4 $1059
JUMPV
LABELV $1058
line 2190
;2190:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1060
line 2191
;2191:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2192
;2192:		}
LABELV $1060
LABELV $1059
line 2193
;2193:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2194
;2194:		si->xStart = DC->cursorx;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2195
;2195:	}
ADDRGP4 $1051
JUMPV
LABELV $1050
line 2196
;2196:	else if (DC->cursory != si->yStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1062
line 2198
;2197:
;2198:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2199
;2199:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2200
;2200:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2201
;2201:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2202
;2202:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2204
;2203:		//
;2204:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE/2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4+4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+12
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2205
;2205:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1069
line 2206
;2206:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2207
;2207:		}
ADDRGP4 $1070
JUMPV
LABELV $1069
line 2208
;2208:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1071
line 2209
;2209:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2210
;2210:		}
LABELV $1071
LABELV $1070
line 2211
;2211:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2212
;2212:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2213
;2213:	}
LABELV $1062
LABELV $1051
line 2215
;2214:
;2215:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1073
line 2219
;2216:		// need to scroll which is done by simulating a click to the item
;2217:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2218:		// so it calls it directly
;2219:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2220
;2220:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2221
;2221:	}
LABELV $1073
line 2223
;2222:
;2223:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1075
line 2224
;2224:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2225
;2225:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1077
line 2226
;2226:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2227
;2227:		}
LABELV $1077
line 2228
;2228:	}
LABELV $1075
line 2229
;2229:}
LABELV $1049
endproc Scroll_ListBox_ThumbFunc 40 16
proc Scroll_Slider_ThumbFunc 28 8
line 2231
;2230:
;2231:static void Scroll_Slider_ThumbFunc(void *p) {
line 2233
;2232:	float x, value, cursorx;
;2233:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2234
;2234:	editFieldDef_t *editDef = si->item->typeData;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2236
;2235:
;2236:	if (si->item->text) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1080
line 2237
;2237:		x = si->item->textRect.x + si->item->textRect.w + 8;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2238
;2238:	} else {
ADDRGP4 $1081
JUMPV
LABELV $1080
line 2239
;2239:		x = si->item->window.rect.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 2240
;2240:	}
LABELV $1081
line 2242
;2241:
;2242:	cursorx = DC->cursorx;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2244
;2243:
;2244:	if (cursorx < x) {
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $1082
line 2245
;2245:		cursorx = x;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 2246
;2246:	} else if (cursorx > x + SLIDER_WIDTH) {
ADDRGP4 $1083
JUMPV
LABELV $1082
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
LEF4 $1084
line 2247
;2247:		cursorx = x + SLIDER_WIDTH;
ADDRLP4 12
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 2248
;2248:	}
LABELV $1084
LABELV $1083
line 2249
;2249:	value = cursorx - x;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2250
;2250:	value /= SLIDER_WIDTH;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1119879168
DIVF4
ASGNF4
line 2251
;2251:	value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2252
;2252:	value += editDef->minVal;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2253
;2253:	DC->setCVar(si->item->cvar, va("%f", value));
ADDRGP4 $956
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2254
;2254:}
LABELV $1079
endproc Scroll_Slider_ThumbFunc 28 8
export Item_StartCapture
proc Item_StartCapture 24 12
line 2256
;2255:
;2256:void Item_StartCapture(itemDef_t *item, int key) {
line 2258
;2257:	int flags;
;2258:	switch (item->type) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $1087
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $1087
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1114-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1114
address $1090
address $1087
address $1090
address $1087
address $1087
address $1090
address $1107
code
LABELV $1090
line 2263
;2259:    case ITEM_TYPE_EDITFIELD:
;2260:    case ITEM_TYPE_NUMERICFIELD:
;2261:
;2262:		case ITEM_TYPE_LISTBOX:
;2263:		{
line 2264
;2264:			flags = Item_ListBox_OverLB(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2265
;2265:			if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) {
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1091
line 2266
;2266:				scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2267
;2267:				scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2268
;2268:				scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 2269
;2269:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2270
;2270:				scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1098
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1099
JUMPV
LABELV $1098
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1099
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 2271
;2271:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2272
;2272:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2273
;2273:				captureFunc = &Scroll_ListBox_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_AutoFunc
ASGNP4
line 2274
;2274:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2275
;2275:			} else if (flags & WINDOW_LB_THUMB) {
ADDRGP4 $1088
JUMPV
LABELV $1091
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1088
line 2276
;2276:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2277
;2277:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2278
;2278:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2279
;2279:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2280
;2280:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2281
;2281:				captureFunc = &Scroll_ListBox_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_ThumbFunc
ASGNP4
line 2282
;2282:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2283
;2283:			}
line 2284
;2284:			break;
ADDRGP4 $1088
JUMPV
LABELV $1107
line 2287
;2285:		}
;2286:		case ITEM_TYPE_SLIDER:
;2287:		{
line 2288
;2288:			flags = Item_Slider_OverSlider(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_Slider_OverSlider
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2289
;2289:			if (flags & WINDOW_LB_THUMB) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1088
line 2290
;2290:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2291
;2291:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2292
;2292:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2293
;2293:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2294
;2294:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2295
;2295:				captureFunc = &Scroll_Slider_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_Slider_ThumbFunc
ASGNP4
line 2296
;2296:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2297
;2297:			}
line 2298
;2298:			break;
LABELV $1087
LABELV $1088
line 2301
;2299:		}
;2300:	}
;2301:}
LABELV $1086
endproc Item_StartCapture 24 12
export Item_StopCapture
proc Item_StopCapture 0 0
line 2303
;2302:
;2303:void Item_StopCapture(itemDef_t *item) {
line 2305
;2304:
;2305:}
LABELV $1116
endproc Item_StopCapture 0 0
export Item_Slider_HandleKey
proc Item_Slider_HandleKey 68 12
line 2307
;2306:
;2307:qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2311
;2308:	float x, value, width, work;
;2309:
;2310:	//DC->Print("slider handle key\n");
;2311:	if (item->window.flags & WINDOW_HASFOCUS && item->cvar && Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1118
ADDRLP4 16
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1118
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1118
line 2312
;2312:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 178
EQI4 $1124
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1124
ADDRLP4 28
INDIRI4
CNSTI4 179
EQI4 $1124
ADDRLP4 28
INDIRI4
CNSTI4 180
NEI4 $1120
LABELV $1124
line 2313
;2313:			editFieldDef_t *editDef = item->typeData;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2314
;2314:			if (editDef) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1125
line 2316
;2315:				rectDef_t testRect;
;2316:				width = SLIDER_WIDTH;
ADDRLP4 8
CNSTF4 1119879168
ASGNF4
line 2317
;2317:				if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1127
line 2318
;2318:					x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2319
;2319:				} else {
ADDRGP4 $1128
JUMPV
LABELV $1127
line 2320
;2320:					x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2321
;2321:				}
LABELV $1128
line 2323
;2322:
;2323:				testRect = item->window.rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 2324
;2324:				testRect.x = x;
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
line 2325
;2325:				value = (float)SLIDER_THUMB_WIDTH / 2;
ADDRLP4 0
CNSTF4 1086324736
ASGNF4
line 2326
;2326:				testRect.x -= value;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 2328
;2327:				//DC->Print("slider x: %f\n", testRect.x);
;2328:				testRect.w = (SLIDER_WIDTH + (float)SLIDER_THUMB_WIDTH / 2);
ADDRLP4 36+8
CNSTF4 1120665600
ASGNF4
line 2330
;2329:				//DC->Print("slider w: %f\n", testRect.w);
;2330:				if (Rect_ContainsPoint(&testRect, DC->cursorx, DC->cursory)) {
ADDRLP4 36
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1130
line 2331
;2331:					work = DC->cursorx - x;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 2332
;2332:					value = work / width;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 2333
;2333:					value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 60
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2336
;2334:					// vm fuckage
;2335:					// value = (((float)(DC->cursorx - x)/ SLIDER_WIDTH) * (editDef->maxVal - editDef->minVal));
;2336:					value += editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2337
;2337:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $956
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2338
;2338:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1117
JUMPV
LABELV $1130
line 2340
;2339:				}
;2340:			}
LABELV $1125
line 2341
;2341:		}
LABELV $1120
line 2342
;2342:	}
LABELV $1118
line 2343
;2343:	DC->Print("slider handle key exit\n");
ADDRGP4 $1132
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 2344
;2344:	return qfalse;
CNSTI4 0
RETI4
LABELV $1117
endproc Item_Slider_HandleKey 68 12
export Item_HandleKey
proc Item_HandleKey 32 16
line 2348
;2345:}
;2346:
;2347:
;2348:qboolean Item_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2350
;2349:
;2350:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1134
line 2351
;2351:		Item_StopCapture(itemCapture);
ADDRGP4 itemCapture
INDIRP4
ARGP4
ADDRGP4 Item_StopCapture
CALLV
pop
line 2352
;2352:		itemCapture = NULL;
ADDRGP4 itemCapture
CNSTP4 0
ASGNP4
line 2353
;2353:		captureFunc = NULL;
ADDRGP4 captureFunc
CNSTP4 0
ASGNP4
line 2354
;2354:		captureData = NULL;
ADDRGP4 captureData
CNSTP4 0
ASGNP4
line 2355
;2355:	} else {
ADDRGP4 $1135
JUMPV
LABELV $1134
line 2357
;2356:	  // bk001206 - parentheses
;2357:		if ( down && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1136
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1139
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1139
ADDRLP4 0
INDIRI4
CNSTI4 180
NEI4 $1136
LABELV $1139
line 2358
;2358:			Item_StartCapture(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Item_StartCapture
CALLV
pop
line 2359
;2359:		}
LABELV $1136
line 2360
;2360:	}
LABELV $1135
line 2362
;2361:
;2362:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1140
line 2363
;2363:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
LABELV $1140
line 2366
;2364:	}
;2365:
;2366:  switch (item->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1142
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $1142
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1156-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1156
address $1145
address $1146
address $1147
address $1148
address $1149
address $1150
address $1142
address $1153
address $1148
address $1155
address $1151
address $1152
address $1154
code
LABELV $1145
line 2368
;2367:    case ITEM_TYPE_BUTTON:
;2368:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
line 2369
;2369:      break;
LABELV $1146
line 2371
;2370:    case ITEM_TYPE_RADIOBUTTON:
;2371:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
line 2372
;2372:      break;
LABELV $1147
line 2374
;2373:    case ITEM_TYPE_CHECKBOX:
;2374:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
line 2375
;2375:      break;
LABELV $1148
line 2379
;2376:    case ITEM_TYPE_EDITFIELD:
;2377:    case ITEM_TYPE_NUMERICFIELD:
;2378:      //return Item_TextField_HandleKey(item, key);
;2379:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
line 2380
;2380:      break;
LABELV $1149
line 2382
;2381:    case ITEM_TYPE_COMBO:
;2382:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1133
JUMPV
line 2383
;2383:      break;
LABELV $1150
line 2385
;2384:    case ITEM_TYPE_LISTBOX:
;2385:      return Item_ListBox_HandleKey(item, key, down, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 Item_ListBox_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2386
;2386:      break;
LABELV $1151
line 2388
;2387:    case ITEM_TYPE_YESNO:
;2388:      return Item_YesNo_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Item_YesNo_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2389
;2389:      break;
LABELV $1152
line 2391
;2390:    case ITEM_TYPE_MULTI:
;2391:      return Item_Multi_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Item_Multi_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2392
;2392:      break;
LABELV $1153
line 2394
;2393:    case ITEM_TYPE_OWNERDRAW:
;2394:      return Item_OwnerDraw_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_OwnerDraw_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2395
;2395:      break;
LABELV $1154
line 2397
;2396:    case ITEM_TYPE_BIND:
;2397:			return Item_Bind_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_Bind_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2398
;2398:      break;
LABELV $1155
line 2400
;2399:    case ITEM_TYPE_SLIDER:
;2400:      return Item_Slider_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Item_Slider_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $1133
JUMPV
line 2401
;2401:      break;
LABELV $1142
line 2406
;2402:    //case ITEM_TYPE_IMAGE:
;2403:    //  Item_Image_Paint(item);
;2404:    //  break;
;2405:    default:
;2406:      return qfalse;
CNSTI4 0
RETI4
line 2407
;2407:      break;
LABELV $1133
endproc Item_HandleKey 32 16
export Item_Action
proc Item_Action 4 8
line 2413
;2408:  }
;2409:
;2410:  //return qfalse;
;2411:}
;2412:
;2413:void Item_Action(itemDef_t *item) {
line 2414
;2414:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1159
line 2415
;2415:    Item_RunScript(item, item->action);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2416
;2416:  }
LABELV $1159
line 2417
;2417:}
LABELV $1158
endproc Item_Action 4 8
export Menu_SetPrevCursorItem
proc Menu_SetPrevCursorItem 44 12
line 2419
;2418:
;2419:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu) {
line 2420
;2420:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2421
;2421:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2423
;2422:  
;2423:  if (menu->cursorItem < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1165
line 2424
;2424:    menu->cursorItem = menu->itemCount-1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2425
;2425:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2426
;2426:  } 
ADDRGP4 $1165
JUMPV
LABELV $1164
line 2428
;2427:
;2428:  while (menu->cursorItem > -1) {
line 2430
;2429:    
;2430:    menu->cursorItem--;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2431
;2431:    if (menu->cursorItem < 0 && !wrapped) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1167
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1167
line 2432
;2432:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2433
;2433:      menu->cursorItem = menu->itemCount -1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2434
;2434:    }
LABELV $1167
line 2436
;2435:
;2436:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1169
line 2437
;2437:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2438
;2438:      return menu->items[menu->cursorItem];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1161
JUMPV
LABELV $1169
line 2440
;2439:    }
;2440:  }
LABELV $1165
line 2428
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
GTI4 $1164
line 2441
;2441:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2442
;2442:	return NULL;
CNSTP4 0
RETP4
LABELV $1161
endproc Menu_SetPrevCursorItem 44 12
export Menu_SetNextCursorItem
proc Menu_SetNextCursorItem 44 12
line 2446
;2443:
;2444:}
;2445:
;2446:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu) {
line 2448
;2447:
;2448:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2449
;2449:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2452
;2450:
;2451:
;2452:  if (menu->cursorItem == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1175
line 2453
;2453:    menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2454
;2454:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2455
;2455:  }
ADDRGP4 $1175
JUMPV
LABELV $1174
line 2457
;2456:
;2457:  while (menu->cursorItem < menu->itemCount) {
line 2459
;2458:
;2459:    menu->cursorItem++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2460
;2460:    if (menu->cursorItem >= menu->itemCount && !wrapped) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1177
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1177
line 2461
;2461:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2462
;2462:      menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2463
;2463:    }
LABELV $1177
line 2464
;2464:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1179
line 2465
;2465:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2466
;2466:      return menu->items[menu->cursorItem];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1171
JUMPV
LABELV $1179
line 2469
;2467:    }
;2468:    
;2469:  }
LABELV $1175
line 2457
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1174
line 2471
;2470:
;2471:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2472
;2472:	return NULL;
CNSTP4 0
RETP4
LABELV $1171
endproc Menu_SetNextCursorItem 44 12
proc Window_CloseCinematic 4 4
line 2475
;2473:}
;2474:
;2475:static void Window_CloseCinematic(windowDef_t *window) {
line 2476
;2476:	if (window->style == WINDOW_STYLE_CINEMATIC && window->cinematic >= 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1182
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1182
line 2477
;2477:		DC->stopCinematic(window->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2478
;2478:		window->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 2479
;2479:	}
LABELV $1182
line 2480
;2480:}
LABELV $1181
endproc Window_CloseCinematic 4 4
proc Menu_CloseCinematics 4 4
line 2482
;2481:
;2482:static void Menu_CloseCinematics(menuDef_t *menu) {
line 2483
;2483:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1185
line 2485
;2484:		int i;
;2485:		Window_CloseCinematic(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2486
;2486:	  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1190
JUMPV
LABELV $1187
line 2487
;2487:		  Window_CloseCinematic(&menu->items[i]->window);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2488
;2488:			if (menu->items[i]->type == ITEM_TYPE_OWNERDRAW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1191
line 2489
;2489:				DC->stopCinematic(0-menu->items[i]->window.ownerDraw);
CNSTI4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2490
;2490:			}
LABELV $1191
line 2491
;2491:	  }
LABELV $1188
line 2486
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1190
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1187
line 2492
;2492:	}
LABELV $1185
line 2493
;2493:}
LABELV $1184
endproc Menu_CloseCinematics 4 4
proc Display_CloseCinematics 4 4
line 2495
;2494:
;2495:static void Display_CloseCinematics() {
line 2497
;2496:	int i;
;2497:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1197
JUMPV
LABELV $1194
line 2498
;2498:		Menu_CloseCinematics(&Menus[i]);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CloseCinematics
CALLV
pop
line 2499
;2499:	}
LABELV $1195
line 2497
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1197
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1194
line 2500
;2500:}
LABELV $1193
endproc Display_CloseCinematics 4 4
export Menus_Activate
proc Menus_Activate 544 8
line 2502
;2501:
;2502:void  Menus_Activate(menuDef_t *menu) {
line 2503
;2503:	menu->window.flags |= (WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 6
BORI4
ASGNI4
line 2504
;2504:	if (menu->onOpen) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1199
line 2506
;2505:		itemDef_t item;
;2506:		item.parent = menu;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2507
;2507:		Item_RunScript(&item, menu->onOpen);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2508
;2508:	}
LABELV $1199
line 2510
;2509:
;2510:	if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1202
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1202
line 2512
;2511://		DC->stopBackgroundTrack();					// you don't want to do this since it will reset s_rawend
;2512:		DC->startBackgroundTrack(menu->soundName, menu->soundName);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 2513
;2513:	}
LABELV $1202
line 2515
;2514:
;2515:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2517
;2516:
;2517:}
LABELV $1198
endproc Menus_Activate 544 8
export Display_VisibleMenuCount
proc Display_VisibleMenuCount 8 0
line 2519
;2518:
;2519:int Display_VisibleMenuCount() {
line 2521
;2520:	int i, count;
;2521:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2522
;2522:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1208
JUMPV
LABELV $1205
line 2523
;2523:		if (Menus[i].window.flags & (WINDOW_FORCED | WINDOW_VISIBLE)) {
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $1209
line 2524
;2524:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2525
;2525:		}
LABELV $1209
line 2526
;2526:	}
LABELV $1206
line 2522
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1208
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1205
line 2527
;2527:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1204
endproc Display_VisibleMenuCount 8 0
export Menus_HandleOOBClick
proc Menus_HandleOOBClick 24 12
line 2530
;2528:}
;2529:
;2530:void Menus_HandleOOBClick(menuDef_t *menu, int key, qboolean down) {
line 2531
;2531:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1213
line 2536
;2532:		int i;
;2533:		// basically the behaviour we are looking for is if there are windows in the stack.. see if 
;2534:		// the cursor is within any of them.. if not close them otherwise activate them and pass the 
;2535:		// key on.. force a mouse move to activate focus and script stuff 
;2536:		if (down && menu->window.flags & WINDOW_OOB_CLICK) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1215
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $1215
line 2537
;2537:			Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2538
;2538:			menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 2539
;2539:		}
LABELV $1215
line 2541
;2540:
;2541:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1220
JUMPV
LABELV $1217
line 2542
;2542:			if (Menu_OverActiveItem(&Menus[i], DC->cursorx, DC->cursory)) {
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Menu_OverActiveItem
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1221
line 2543
;2543:				Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2544
;2544:				menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 2545
;2545:				Menus_Activate(&Menus[i]);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 2546
;2546:				Menu_HandleMouseMove(&Menus[i], DC->cursorx, DC->cursory);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2547
;2547:				Menu_HandleKey(&Menus[i], key, down);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 2548
;2548:			}
LABELV $1221
line 2549
;2549:		}
LABELV $1218
line 2541
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1220
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1217
line 2551
;2550:
;2551:		if (Display_VisibleMenuCount() == 0) {
ADDRLP4 8
ADDRGP4 Display_VisibleMenuCount
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1223
line 2552
;2552:			if (DC->Pause) {
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1225
line 2553
;2553:				DC->Pause(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 2554
;2554:			}
LABELV $1225
line 2555
;2555:		}
LABELV $1223
line 2556
;2556:		Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2557
;2557:	}
LABELV $1213
line 2558
;2558:}
LABELV $1212
endproc Menus_HandleOOBClick 24 12
bss
align 4
LABELV $1228
skip 16
code
proc Item_CorrectedTextRect 4 12
line 2560
;2559:
;2560:static rectDef_t *Item_CorrectedTextRect(itemDef_t *item) {
line 2562
;2561:	static rectDef_t rect;
;2562:	memset(&rect, 0, sizeof(rectDef_t));
ADDRGP4 $1228
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2563
;2563:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1229
line 2564
;2564:		rect = item->textRect;
ADDRGP4 $1228
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 2565
;2565:		if (rect.w) {
ADDRGP4 $1228+8
INDIRF4
CNSTF4 0
EQF4 $1231
line 2566
;2566:			rect.y -= rect.h;
ADDRLP4 0
ADDRGP4 $1228+4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 $1228+12
INDIRF4
SUBF4
ASGNF4
line 2567
;2567:		}
LABELV $1231
line 2568
;2568:	}
LABELV $1229
line 2569
;2569:	return &rect;
ADDRGP4 $1228
RETP4
LABELV $1227
endproc Item_CorrectedTextRect 4 12
data
align 4
LABELV $1257
byte 4 0
export Menu_HandleKey
code
proc Menu_HandleKey 628 12
line 2572
;2570:}
;2571:
;2572:void Menu_HandleKey(menuDef_t *menu, int key, qboolean down) {
line 2574
;2573:	int i;
;2574:	itemDef_t *item = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 2575
;2575:	qboolean inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2577
;2576:
;2577:	if (inHandler) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1237
line 2578
;2578:		return;
ADDRGP4 $1236
JUMPV
LABELV $1237
line 2581
;2579:	}
;2580:
;2581:	inHandler = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2582
;2582:	if (g_waitingForKey && down) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1239
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1239
line 2583
;2583:		Item_Bind_HandleKey(g_bindItem, key, down);
ADDRGP4 g_bindItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Item_Bind_HandleKey
CALLI4
pop
line 2584
;2584:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2585
;2585:		return;
ADDRGP4 $1236
JUMPV
LABELV $1239
line 2588
;2586:	}
;2587:
;2588:	if (g_editingField && down) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1241
ADDRFP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1241
line 2589
;2589:		if (!Item_TextField_HandleKey(g_editItem, key)) {
ADDRGP4 g_editItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_TextField_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1243
line 2590
;2590:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2591
;2591:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2592
;2592:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2593
;2593:			return;
ADDRGP4 $1236
JUMPV
LABELV $1243
line 2594
;2594:		} else if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 178
EQI4 $1248
ADDRLP4 24
INDIRI4
CNSTI4 179
EQI4 $1248
ADDRLP4 24
INDIRI4
CNSTI4 180
NEI4 $1245
LABELV $1248
line 2595
;2595:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2596
;2596:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2597
;2597:			Display_MouseMove(NULL, DC->cursorx, DC->cursory);
CNSTP4 0
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 2598
;2598:		} else if (key == K_TAB || key == K_UPARROW || key == K_DOWNARROW) {
ADDRGP4 $1246
JUMPV
LABELV $1245
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 9
EQI4 $1252
ADDRLP4 28
INDIRI4
CNSTI4 132
EQI4 $1252
ADDRLP4 28
INDIRI4
CNSTI4 133
NEI4 $1249
LABELV $1252
line 2599
;2599:			return;
ADDRGP4 $1236
JUMPV
LABELV $1249
LABELV $1246
line 2601
;2600:		}
;2601:	}
LABELV $1241
line 2603
;2602:
;2603:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1253
line 2604
;2604:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2605
;2605:		return;
ADDRGP4 $1236
JUMPV
LABELV $1253
line 2609
;2606:	}
;2607:
;2608:		// see if the mouse is within the window bounds and if so is this a mouse click
;2609:	if (down && !(menu->window.flags & WINDOW_POPUP) && !Rect_ContainsPoint(&menu->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1255
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $1255
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $1255
line 2612
;2610:		static qboolean inHandleKey = qfalse;
;2611:		// bk001206 - parentheses
;2612:		if (!inHandleKey && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRGP4 $1257
INDIRI4
CNSTI4 0
NEI4 $1258
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $1261
ADDRLP4 36
INDIRI4
CNSTI4 179
EQI4 $1261
ADDRLP4 36
INDIRI4
CNSTI4 180
NEI4 $1258
LABELV $1261
line 2613
;2613:			inHandleKey = qtrue;
ADDRGP4 $1257
CNSTI4 1
ASGNI4
line 2614
;2614:			Menus_HandleOOBClick(menu, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menus_HandleOOBClick
CALLV
pop
line 2615
;2615:			inHandleKey = qfalse;
ADDRGP4 $1257
CNSTI4 0
ASGNI4
line 2616
;2616:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2617
;2617:			return;
ADDRGP4 $1236
JUMPV
LABELV $1258
line 2619
;2618:		}
;2619:	}
LABELV $1255
line 2622
;2620:
;2621:	// get the item with focus
;2622:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1265
JUMPV
LABELV $1262
line 2623
;2623:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1266
line 2624
;2624:			item = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 2625
;2625:		}
LABELV $1266
line 2626
;2626:	}
LABELV $1263
line 2622
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1265
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1262
line 2628
;2627:
;2628:	if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1268
line 2629
;2629:		if (Item_HandleKey(item, key, down)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Item_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1270
line 2630
;2630:			Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2631
;2631:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2632
;2632:			return;
ADDRGP4 $1236
JUMPV
LABELV $1270
line 2634
;2633:		}
;2634:	}
LABELV $1268
line 2636
;2635:
;2636:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1272
line 2637
;2637:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2638
;2638:		return;
ADDRGP4 $1236
JUMPV
LABELV $1272
line 2642
;2639:	}
;2640:
;2641:	// default handling
;2642:	switch ( key ) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 155
EQI4 $1276
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1280
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
GTI4 $1312
LABELV $1311
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
CNSTI4 13
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $1305
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
GTI4 $1314
LABELV $1313
ADDRFP4 4
INDIRI4
CNSTI4 9
EQI4 $1289
ADDRGP4 $1274
JUMPV
LABELV $1314
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 56
CNSTI4 27
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $1285
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $1274
LABELV $1315
ADDRLP4 60
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 132
EQI4 $1284
ADDRLP4 60
INDIRI4
CNSTI4 133
EQI4 $1289
ADDRGP4 $1274
JUMPV
LABELV $1312
ADDRLP4 64
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 167
EQI4 $1289
ADDRLP4 68
CNSTI4 169
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $1305
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
GTI4 $1317
LABELV $1316
ADDRFP4 4
INDIRI4
CNSTI4 161
EQI4 $1284
ADDRGP4 $1274
JUMPV
LABELV $1317
ADDRLP4 72
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 178
LTI4 $1274
ADDRLP4 72
INDIRI4
CNSTI4 188
GTI4 $1318
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1319-712
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1319
address $1290
address $1290
address $1274
address $1274
address $1274
address $1274
address $1274
address $1275
address $1275
address $1275
address $1275
code
LABELV $1318
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 217
LTI4 $1274
ADDRLP4 76
INDIRI4
CNSTI4 232
GTI4 $1274
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1321-868
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1321
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
address $1275
code
LABELV $1276
line 2645
;2643:
;2644:		case K_F11:
;2645:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1279
ARGP4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
EQF4 $1275
line 2646
;2646:				debugMode ^= 1;
ADDRLP4 84
ADDRGP4 debugMode
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2647
;2647:			}
line 2648
;2648:			break;
ADDRGP4 $1275
JUMPV
LABELV $1280
line 2651
;2649:
;2650:		case K_F12:
;2651:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1279
ARGP4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 0
EQF4 $1275
line 2652
;2652:				DC->executeText(EXEC_APPEND, "screenshot\n");
CNSTI4 2
ARGI4
ADDRGP4 $1283
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 2653
;2653:			}
line 2654
;2654:			break;
ADDRGP4 $1275
JUMPV
LABELV $1284
line 2657
;2655:		case K_KP_UPARROW:
;2656:		case K_UPARROW:
;2657:			Menu_SetPrevCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
pop
line 2658
;2658:			break;
ADDRGP4 $1275
JUMPV
LABELV $1285
line 2661
;2659:
;2660:		case K_ESCAPE:
;2661:			if (!g_waitingForKey && menu->onESC) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1275
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1275
line 2663
;2662:				itemDef_t it;
;2663:		    it.parent = menu;
ADDRLP4 88+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2664
;2664:		    Item_RunScript(&it, menu->onESC);
ADDRLP4 88
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2665
;2665:			}
line 2666
;2666:			break;
ADDRGP4 $1275
JUMPV
LABELV $1289
line 2670
;2667:		case K_TAB:
;2668:		case K_KP_DOWNARROW:
;2669:		case K_DOWNARROW:
;2670:			Menu_SetNextCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetNextCursorItem
CALLP4
pop
line 2671
;2671:			break;
ADDRGP4 $1275
JUMPV
LABELV $1290
line 2675
;2672:
;2673:		case K_MOUSE1:
;2674:		case K_MOUSE2:
;2675:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1275
line 2676
;2676:				if (item->type == ITEM_TYPE_TEXT) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1293
line 2677
;2677:					if (Rect_ContainsPoint(Item_CorrectedTextRect(item), DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1275
line 2678
;2678:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2679
;2679:					}
line 2680
;2680:				} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRGP4 $1275
JUMPV
LABELV $1293
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
EQI4 $1299
ADDRLP4 88
INDIRI4
CNSTI4 9
NEI4 $1297
LABELV $1299
line 2681
;2681:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1275
line 2682
;2682:						item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2683
;2683:						g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2684
;2684:						g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2685
;2685:						DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2686
;2686:					}
line 2687
;2687:				} else {
ADDRGP4 $1275
JUMPV
LABELV $1297
line 2688
;2688:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1275
line 2689
;2689:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2690
;2690:					}
line 2691
;2691:				}
line 2692
;2692:			}
line 2693
;2693:			break;
ADDRGP4 $1275
JUMPV
line 2715
;2694:
;2695:		case K_JOY1:
;2696:		case K_JOY2:
;2697:		case K_JOY3:
;2698:		case K_JOY4:
;2699:		case K_AUX1:
;2700:		case K_AUX2:
;2701:		case K_AUX3:
;2702:		case K_AUX4:
;2703:		case K_AUX5:
;2704:		case K_AUX6:
;2705:		case K_AUX7:
;2706:		case K_AUX8:
;2707:		case K_AUX9:
;2708:		case K_AUX10:
;2709:		case K_AUX11:
;2710:		case K_AUX12:
;2711:		case K_AUX13:
;2712:		case K_AUX14:
;2713:		case K_AUX15:
;2714:		case K_AUX16:
;2715:			break;
LABELV $1305
line 2718
;2716:		case K_KP_ENTER:
;2717:		case K_ENTER:
;2718:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1275
line 2719
;2719:				if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
EQI4 $1310
ADDRLP4 88
INDIRI4
CNSTI4 9
NEI4 $1308
LABELV $1310
line 2720
;2720:					item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2721
;2721:					g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2722
;2722:					g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2723
;2723:					DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2724
;2724:				} else {
ADDRGP4 $1275
JUMPV
LABELV $1308
line 2725
;2725:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2726
;2726:				}
line 2727
;2727:			}
line 2728
;2728:			break;
LABELV $1274
LABELV $1275
line 2730
;2729:	}
;2730:	inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2731
;2731:}
LABELV $1236
endproc Menu_HandleKey 628 12
export ToWindowCoords
proc ToWindowCoords 8 0
line 2733
;2732:
;2733:void ToWindowCoords(float *x, float *y, windowDef_t *window) {
line 2734
;2734:	if (window->border != 0) {
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1324
line 2735
;2735:		*x += window->borderSize;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2736
;2736:		*y += window->borderSize;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2737
;2737:	} 
LABELV $1324
line 2738
;2738:	*x += window->rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2739
;2739:	*y += window->rect.y;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2740
;2740:}
LABELV $1323
endproc ToWindowCoords 8 0
export Rect_ToWindowCoords
proc Rect_ToWindowCoords 4 12
line 2742
;2741:
;2742:void Rect_ToWindowCoords(rectDef_t *rect, windowDef_t *window) {
line 2743
;2743:	ToWindowCoords(&rect->x, &rect->y, window);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2744
;2744:}
LABELV $1326
endproc Rect_ToWindowCoords 4 12
export Item_SetTextExtents
proc Item_SetTextExtents 296 12
line 2746
;2745:
;2746:void Item_SetTextExtents(itemDef_t *item, int *width, int *height, const char *text) {
line 2747
;2747:	const char *textPtr = (text) ? text : item->text;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1329
ADDRLP4 4
ADDRFP4 12
INDIRP4
ASGNP4
ADDRGP4 $1330
JUMPV
LABELV $1329
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
LABELV $1330
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2749
;2748:
;2749:	if (textPtr == NULL ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1331
line 2750
;2750:		return;
ADDRGP4 $1327
JUMPV
LABELV $1331
line 2753
;2751:	}
;2752:
;2753:	*width = item->textRect.w;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2754
;2754:	*height = item->textRect.h;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2757
;2755:
;2756:	// keeps us from computing the widths and heights more than once
;2757:	if (*width == 0 || (item->type == ITEM_TYPE_OWNERDRAW && item->textalignment == ITEM_ALIGN_CENTER)) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1335
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1333
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1333
LABELV $1335
line 2758
;2758:		int originalWidth = DC->textWidth(item->text, item->textscale, 0);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 2760
;2759:
;2760:		if (item->type == ITEM_TYPE_OWNERDRAW && (item->textalignment == ITEM_ALIGN_CENTER || item->textalignment == ITEM_ALIGN_RIGHT)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1336
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $1338
ADDRLP4 28
INDIRI4
CNSTI4 2
NEI4 $1336
LABELV $1338
line 2761
;2761:			originalWidth += DC->ownerDrawWidth(item->window.ownerDraw, item->textscale);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ASGNI4
line 2762
;2762:		} else if (item->type == ITEM_TYPE_EDITFIELD && item->textalignment == ITEM_ALIGN_CENTER && item->cvar) {
ADDRGP4 $1337
JUMPV
LABELV $1336
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1339
ADDRLP4 32
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1339
ADDRLP4 32
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1339
line 2764
;2763:			char buff[256];
;2764:			DC->getCVarString(item->cvar, buff, 256);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2765
;2765:			originalWidth += DC->textWidth(buff, item->textscale, 0);
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 292
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 292
INDIRI4
ADDI4
ASGNI4
line 2766
;2766:		}
LABELV $1339
LABELV $1337
line 2768
;2767:
;2768:		*width = DC->textWidth(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2769
;2769:		*height = DC->textHeight(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 40
INDIRI4
ASGNI4
line 2770
;2770:		item->textRect.w = *width;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2771
;2771:		item->textRect.h = *height;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2772
;2772:		item->textRect.x = item->textalignx;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2773
;2773:		item->textRect.y = item->textaligny;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2774
;2774:		if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1341
line 2775
;2775:			item->textRect.x = item->textalignx - originalWidth;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2776
;2776:		} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1342
JUMPV
LABELV $1341
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1343
line 2777
;2777:			item->textRect.x = item->textalignx - originalWidth / 2;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2778
;2778:		}
LABELV $1343
LABELV $1342
line 2780
;2779:
;2780:		ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2781
;2781:	}
LABELV $1333
line 2782
;2782:}
LABELV $1327
endproc Item_SetTextExtents 296 12
export Item_TextColor
proc Item_TextColor 60 28
line 2784
;2783:
;2784:void Item_TextColor(itemDef_t *item, vec4_t *newColor) {
line 2786
;2785:	vec4_t lowLight;
;2786:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 2788
;2787:
;2788:	Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 2790
;2789:
;2790:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1346
line 2791
;2791:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 2792
;2792:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 4+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 2793
;2793:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 4+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 2794
;2794:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 4+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 2795
;2795:		LerpColor(parent->focusColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2796
;2796:	} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $1347
JUMPV
LABELV $1346
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $1351
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
ADDRLP4 28
INDIRI4
BANDI4
CNSTI4 0
NEI4 $1351
line 2797
;2797:		lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 2798
;2798:		lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 4+4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 2799
;2799:		lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 4+8
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 2800
;2800:		lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 4+12
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
MULF4
ASGNF4
line 2801
;2801:		LerpColor(item->window.foreColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 32
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2802
;2802:	} else {
ADDRGP4 $1352
JUMPV
LABELV $1351
line 2803
;2803:		memcpy(newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2805
;2804:		// items can be enabled and disabled based on cvars
;2805:	}
LABELV $1352
LABELV $1347
line 2807
;2806:
;2807:	if (item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1356
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
EQI4 $1356
ADDRLP4 48
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1356
ADDRLP4 48
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
EQI4 $1356
line 2808
;2808:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1358
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $1358
line 2809
;2809:			memcpy(newColor, &parent->disableColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2810
;2810:		}
LABELV $1358
line 2811
;2811:	}
LABELV $1356
line 2812
;2812:}
LABELV $1345
endproc Item_TextColor 60 28
export Item_Text_AutoWrapped_Paint
proc Item_Text_AutoWrapped_Paint 2128 32
line 2814
;2813:
;2814:void Item_Text_AutoWrapped_Paint(itemDef_t *item) {
line 2822
;2815:	char text[1024];
;2816:	const char *p, *textPtr, *newLinePtr;
;2817:	char buff[1024];
;2818:	int width, height, len, textWidth, newLine, newLineWidth;
;2819:	float y;
;2820:	vec4_t color;
;2821:
;2822:	textWidth = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 2823
;2823:	newLinePtr = NULL;
ADDRLP4 1044
CNSTP4 0
ASGNP4
line 2825
;2824:
;2825:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1361
line 2826
;2826:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1363
line 2827
;2827:			return;
ADDRGP4 $1360
JUMPV
LABELV $1363
line 2829
;2828:		}
;2829:		else {
line 2830
;2830:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2831
;2831:			textPtr = text;
ADDRLP4 1056
ADDRLP4 1080
ASGNP4
line 2832
;2832:		}
line 2833
;2833:	}
ADDRGP4 $1362
JUMPV
LABELV $1361
line 2834
;2834:	else {
line 2835
;2835:		textPtr = item->text;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2836
;2836:	}
LABELV $1362
line 2837
;2837:	if (*textPtr == '\0') {
ADDRLP4 1056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1365
line 2838
;2838:		return;
ADDRGP4 $1360
JUMPV
LABELV $1365
line 2840
;2839:	}
;2840:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2841
;2841:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1076
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2843
;2842:
;2843:	y = item->textaligny;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2844
;2844:	len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2845
;2845:	buff[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 2846
;2846:	newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2847
;2847:	newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2848
;2848:	p = textPtr;
ADDRLP4 0
ADDRLP4 1056
INDIRP4
ASGNP4
ADDRGP4 $1368
JUMPV
LABELV $1367
line 2849
;2849:	while (p) {
line 2850
;2850:		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
ADDRLP4 2104
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 32
EQI4 $1374
ADDRLP4 2104
INDIRI4
CNSTI4 9
EQI4 $1374
ADDRLP4 2104
INDIRI4
CNSTI4 10
EQI4 $1374
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $1370
LABELV $1374
line 2851
;2851:			newLine = len;
ADDRLP4 1036
ADDRLP4 1028
INDIRI4
ASGNI4
line 2852
;2852:			newLinePtr = p+1;
ADDRLP4 1044
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2853
;2853:			newLineWidth = textWidth;
ADDRLP4 1040
ADDRLP4 1032
INDIRI4
ASGNI4
line 2854
;2854:		}
LABELV $1370
line 2855
;2855:		textWidth = DC->textWidth(buff, item->textscale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2108
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 2108
INDIRI4
ASGNI4
line 2856
;2856:		if ( (newLine && textWidth > item->window.rect.w) || *p == '\n' || *p == '\0') {
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1378
ADDRLP4 1032
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GTF4 $1379
LABELV $1378
ADDRLP4 2112
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 10
EQI4 $1379
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $1375
LABELV $1379
line 2857
;2857:			if (len) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $1380
line 2858
;2858:				if (item->textalignment == ITEM_ALIGN_LEFT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1382
line 2859
;2859:					item->textRect.x = item->textalignx;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2860
;2860:				} else if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRGP4 $1383
JUMPV
LABELV $1382
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1384
line 2861
;2861:					item->textRect.x = item->textalignx - newLineWidth;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2862
;2862:				} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1385
JUMPV
LABELV $1384
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1386
line 2863
;2863:					item->textRect.x = item->textalignx - newLineWidth / 2;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2864
;2864:				}
LABELV $1386
LABELV $1385
LABELV $1383
line 2865
;2865:				item->textRect.y = y;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1048
INDIRF4
ASGNF4
line 2866
;2866:				ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2868
;2867:				//
;2868:				buff[newLine] = '\0';
ADDRLP4 1036
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2869
;2869:				DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 2120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2120
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1060
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2120
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2870
;2870:			}
LABELV $1380
line 2871
;2871:			if (*p == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1388
line 2872
;2872:				break;
ADDRGP4 $1369
JUMPV
LABELV $1388
line 2875
;2873:			}
;2874:			//
;2875:			y += height + 5;
ADDRLP4 1048
ADDRLP4 1048
INDIRF4
ADDRLP4 1052
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2876
;2876:			p = newLinePtr;
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 2877
;2877:			len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2878
;2878:			newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2879
;2879:			newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2880
;2880:			continue;
ADDRGP4 $1368
JUMPV
LABELV $1375
line 2882
;2881:		}
;2882:		buff[len++] = *p++;
ADDRLP4 2116
ADDRLP4 1028
INDIRI4
ASGNI4
ADDRLP4 2124
CNSTI4 1
ASGNI4
ADDRLP4 1028
ADDRLP4 2116
INDIRI4
ADDRLP4 2124
INDIRI4
ADDI4
ASGNI4
ADDRLP4 2120
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 2120
INDIRP4
ADDRLP4 2124
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2116
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 2120
INDIRP4
INDIRI1
ASGNI1
line 2883
;2883:		buff[len] = '\0';
ADDRLP4 1028
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2884
;2884:	}
LABELV $1368
line 2849
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1367
LABELV $1369
line 2885
;2885:}
LABELV $1360
endproc Item_Text_AutoWrapped_Paint 2128 32
export Item_Text_Wrapped_Paint
proc Item_Text_Wrapped_Paint 2112 32
line 2887
;2886:
;2887:void Item_Text_Wrapped_Paint(itemDef_t *item) {
line 2898
;2888:	char text[1024];
;2889:	const char *p, *start, *textPtr;
;2890:	char buff[1024];
;2891:	int width, height;
;2892:	float x, y;
;2893:	vec4_t color;
;2894:
;2895:	// now paint the text and/or any optional images
;2896:	// default to left
;2897:
;2898:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1391
line 2899
;2899:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1393
line 2900
;2900:			return;
ADDRGP4 $1390
JUMPV
LABELV $1393
line 2902
;2901:		}
;2902:		else {
line 2903
;2903:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1068
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2904
;2904:			textPtr = text;
ADDRLP4 1060
ADDRLP4 1068
ASGNP4
line 2905
;2905:		}
line 2906
;2906:	}
ADDRGP4 $1392
JUMPV
LABELV $1391
line 2907
;2907:	else {
line 2908
;2908:		textPtr = item->text;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2909
;2909:	}
LABELV $1392
line 2910
;2910:	if (*textPtr == '\0') {
ADDRLP4 1060
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1395
line 2911
;2911:		return;
ADDRGP4 $1390
JUMPV
LABELV $1395
line 2914
;2912:	}
;2913:
;2914:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2915
;2915:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ARGP4
ADDRLP4 1056
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2917
;2916:
;2917:	x = item->textRect.x;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
line 2918
;2918:	y = item->textRect.y;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
line 2919
;2919:	start = textPtr;
ADDRLP4 4
ADDRLP4 1060
INDIRP4
ASGNP4
line 2920
;2920:	p = strchr(textPtr, '\r');
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2092
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2092
INDIRP4
ASGNP4
ADDRGP4 $1398
JUMPV
LABELV $1397
line 2921
;2921:	while (p && *p) {
line 2922
;2922:		strncpy(buff, start, p-start+1);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 2923
;2923:		buff[p-start] = '\0';
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 2924
;2924:		DC->drawText(x, y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2925
;2925:		y += height + 5;
ADDRLP4 1032
ADDRLP4 1032
INDIRF4
ADDRLP4 1056
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2926
;2926:		start += p - start + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
line 2927
;2927:		p = strchr(p+1, '\r');
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2108
INDIRP4
ASGNP4
line 2928
;2928:	}
LABELV $1398
line 2921
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1400
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1397
LABELV $1400
line 2929
;2929:	DC->drawText(x, y, item->textscale, color, start, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2930
;2930:}
LABELV $1390
endproc Item_Text_Wrapped_Paint 2112 32
export Item_Text_Paint
proc Item_Text_Paint 1056 32
line 2932
;2931:
;2932:void Item_Text_Paint(itemDef_t *item) {
line 2938
;2933:	char text[1024];
;2934:	const char *textPtr;
;2935:	int height, width;
;2936:	vec4_t color;
;2937:
;2938:	if (item->window.flags & WINDOW_WRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1402
line 2939
;2939:		Item_Text_Wrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Wrapped_Paint
CALLV
pop
line 2940
;2940:		return;
ADDRGP4 $1401
JUMPV
LABELV $1402
line 2942
;2941:	}
;2942:	if (item->window.flags & WINDOW_AUTOWRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1404
line 2943
;2943:		Item_Text_AutoWrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_AutoWrapped_Paint
CALLV
pop
line 2944
;2944:		return;
ADDRGP4 $1401
JUMPV
LABELV $1404
line 2947
;2945:	}
;2946:
;2947:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1406
line 2948
;2948:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1408
line 2949
;2949:			return;
ADDRGP4 $1401
JUMPV
LABELV $1408
line 2951
;2950:		}
;2951:		else {
line 2952
;2952:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2953
;2953:			textPtr = text;
ADDRLP4 0
ADDRLP4 28
ASGNP4
line 2954
;2954:		}
line 2955
;2955:	}
ADDRGP4 $1407
JUMPV
LABELV $1406
line 2956
;2956:	else {
line 2957
;2957:		textPtr = item->text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2958
;2958:	}
LABELV $1407
line 2961
;2959:
;2960:	// this needs to go here as it sets extents for cvar types as well
;2961:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2963
;2962:
;2963:	if (*textPtr == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1410
line 2964
;2964:		return;
ADDRGP4 $1401
JUMPV
LABELV $1410
line 2968
;2965:	}
;2966:
;2967:
;2968:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2999
;2969:
;2970:	//FIXME: this is a fucking mess
;2971:/*
;2972:	adjust = 0;
;2973:	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2974:		adjust = 0.5;
;2975:	}
;2976:
;2977:	if (item->textStyle == ITEM_TEXTSTYLE_SHADOWED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2978:		Fade(&item->window.flags, &DC->Assets.shadowColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;2979:		DC->drawText(item->textRect.x + DC->Assets.shadowX, item->textRect.y + DC->Assets.shadowY, item->textscale, DC->Assets.shadowColor, textPtr, adjust);
;2980:	}
;2981:*/
;2982:
;2983:
;2984://	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2985://		Fade(&item->window.flags, &item->window.outlineColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;2986://		/*
;2987://		Text_Paint(item->textRect.x-1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2988://		Text_Paint(item->textRect.x, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2989://		Text_Paint(item->textRect.x+1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2990://		Text_Paint(item->textRect.x-1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;2991://		Text_Paint(item->textRect.x+1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;2992://		Text_Paint(item->textRect.x-1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2993://		Text_Paint(item->textRect.x, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2994://		Text_Paint(item->textRect.x+1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2995://		*/
;2996://		DC->drawText(item->textRect.x - 1, item->textRect.y + 1, item->textscale * 1.02, item->window.outlineColor, textPtr, adjust);
;2997://	}
;2998:
;2999:	DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3000
;3000:}
LABELV $1401
endproc Item_Text_Paint 1056 32
export Item_TextField_Paint
proc Item_TextField_Paint 1104 36
line 3007
;3001:
;3002:
;3003:
;3004://float			trap_Cvar_VariableValue( const char *var_name );
;3005://void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
;3006:
;3007:void Item_TextField_Paint(itemDef_t *item) {
line 3011
;3008:	char buff[1024];
;3009:	vec4_t newColor, lowLight;
;3010:	int offset;
;3011:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3012
;3012:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3014
;3013:
;3014:	Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3016
;3015:
;3016:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 3018
;3017:
;3018:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1413
line 3019
;3019:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3020
;3020:	} 
LABELV $1413
line 3022
;3021:
;3022:	parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3024
;3023:
;3024:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1415
line 3025
;3025:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 1032
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3026
;3026:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 1032+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3027
;3027:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 1032+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3028
;3028:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 1032+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3029
;3029:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1068
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1048
ARGP4
CNSTF4 1056964608
ADDRLP4 1068
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3030
;3030:	} else {
ADDRGP4 $1416
JUMPV
LABELV $1415
line 3031
;3031:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 1048
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3032
;3032:	}
LABELV $1416
line 3034
;3033:
;3034:	offset = (item->text && *item->text) ? 8 : 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1421
ADDRLP4 1072
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1421
ADDRLP4 1068
CNSTI4 8
ASGNI4
ADDRGP4 $1422
JUMPV
LABELV $1421
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1422
ADDRLP4 1064
ADDRLP4 1068
INDIRI4
ASGNI4
line 3035
;3035:	if (item->window.flags & WINDOW_HASFOCUS && g_editingField) {
ADDRLP4 1076
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 1076
INDIRI4
EQI4 $1423
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 1076
INDIRI4
EQI4 $1423
line 3036
;3036:		char cursor = DC->getOverstrikeMode() ? '_' : '|';
ADDRLP4 1088
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $1426
ADDRLP4 1084
CNSTI4 95
ASGNI4
ADDRGP4 $1427
JUMPV
LABELV $1426
ADDRLP4 1084
CNSTI4 124
ASGNI4
LABELV $1427
ADDRLP4 1080
ADDRLP4 1084
INDIRI4
CVII1 4
ASGNI1
line 3037
;3037:		DC->drawTextWithCursor(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, item->cursorPos - editPtr->paintOffset , cursor, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1092
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1092
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1092
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 1100
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1100
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 1092
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1100
INDIRI4
SUBI4
ARGI4
ADDRLP4 1080
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 100
ADDP4
INDIRP4
CALLV
pop
line 3038
;3038:	} else {
ADDRGP4 $1424
JUMPV
LABELV $1423
line 3039
;3039:		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1080
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1080
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1080
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1080
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3040
;3040:	}
LABELV $1424
line 3042
;3041:
;3042:}
LABELV $1412
endproc Item_TextField_Paint 1104 36
export Item_YesNo_Paint
proc Item_YesNo_Paint 56 32
line 3044
;3043:
;3044:void Item_YesNo_Paint(itemDef_t *item) {
line 3047
;3045:	vec4_t newColor, lowLight;
;3046:	float value;
;3047:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3049
;3048:
;3049:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1430
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 44
INDIRF4
ASGNF4
ADDRGP4 $1431
JUMPV
LABELV $1430
ADDRLP4 40
CNSTF4 0
ASGNF4
LABELV $1431
ADDRLP4 36
ADDRLP4 40
INDIRF4
ASGNF4
line 3051
;3050:
;3051:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1432
line 3052
;3052:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3053
;3053:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 4+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3054
;3054:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 4+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3055
;3055:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 4+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3056
;3056:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
CNSTF4 1056964608
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3057
;3057:	} else {
ADDRGP4 $1433
JUMPV
LABELV $1432
line 3058
;3058:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3059
;3059:	}
LABELV $1433
line 3061
;3060:
;3061:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1437
line 3062
;3062:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3063
;3063:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1442
ADDRLP4 48
ADDRGP4 $1439
ASGNP4
ADDRGP4 $1443
JUMPV
LABELV $1442
ADDRLP4 48
ADDRGP4 $1440
ASGNP4
LABELV $1443
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3064
;3064:	} else {
ADDRGP4 $1438
JUMPV
LABELV $1437
line 3065
;3065:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1445
ADDRLP4 48
ADDRGP4 $1439
ASGNP4
ADDRGP4 $1446
JUMPV
LABELV $1445
ADDRLP4 48
ADDRGP4 $1440
ASGNP4
LABELV $1446
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3066
;3066:	}
LABELV $1438
line 3067
;3067:}
LABELV $1428
endproc Item_YesNo_Paint 56 32
export Item_Multi_Paint
proc Item_Multi_Paint 48 32
line 3069
;3068:
;3069:void Item_Multi_Paint(itemDef_t *item) {
line 3071
;3070:	vec4_t newColor, lowLight;
;3071:	const char *text = "";
ADDRLP4 4
ADDRGP4 $55
ASGNP4
line 3072
;3072:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3074
;3073:
;3074:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1448
line 3075
;3075:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3076
;3076:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 8+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3077
;3077:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 8+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3078
;3078:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 8+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3079
;3079:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ARGP4
CNSTF4 1056964608
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3080
;3080:	} else {
ADDRGP4 $1449
JUMPV
LABELV $1448
line 3081
;3081:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3082
;3082:	}
LABELV $1449
line 3084
;3083:
;3084:	text = Item_Multi_Setting(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_Multi_Setting
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3086
;3085:
;3086:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1453
line 3087
;3087:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3088
;3088:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3089
;3089:	} else {
ADDRGP4 $1454
JUMPV
LABELV $1453
line 3090
;3090:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3091
;3091:	}
LABELV $1454
line 3092
;3092:}
LABELV $1447
endproc Item_Multi_Paint 48 32
data
align 4
LABELV g_bindings
address $1457
byte 4 9
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1458
byte 4 13
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1459
byte 4 138
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1460
byte 4 132
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1461
byte 4 133
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1462
byte 4 44
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1463
byte 4 46
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1464
byte 4 32
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1465
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1466
byte 4 134
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1467
byte 4 135
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1468
byte 4 136
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1469
byte 4 141
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1470
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1471
byte 4 47
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1472
byte 4 144
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1473
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1474
byte 4 49
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1475
byte 4 50
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1476
byte 4 51
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1477
byte 4 52
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1478
byte 4 53
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1479
byte 4 54
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1480
byte 4 55
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1481
byte 4 56
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1482
byte 4 57
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1483
byte 4 48
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1484
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1485
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1486
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1487
byte 4 137
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1488
byte 4 91
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1489
byte 4 93
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1490
byte 4 180
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1491
byte 4 181
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1492
byte 4 119
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1493
byte 4 114
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1494
byte 4 116
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1495
byte 4 121
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1496
byte 4 110
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1497
byte 4 111
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1498
byte 4 100
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1499
byte 4 112
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1500
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1501
byte 4 102
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1502
byte 4 118
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1503
byte 4 101
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1504
byte 4 105
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1505
byte 4 107
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1506
byte 4 145
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1507
byte 4 146
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1508
byte 4 147
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1509
byte 4 148
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1510
byte 4 149
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1511
byte 4 162
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1512
byte 4 168
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1513
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1514
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1515
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1516
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
lit
align 4
LABELV g_bindCount
byte 4 60
code
proc Controls_GetKeyAssignment 276 12
line 3201
;3093:
;3094:
;3095:typedef struct {
;3096:	char	*command;
;3097:	int		id;
;3098:	int		defaultbind1;
;3099:	int		defaultbind2;
;3100:	int		bind1;
;3101:	int		bind2;
;3102:} bind_t;
;3103:
;3104:typedef struct
;3105:{
;3106:	char*	name;
;3107:	float	defaultvalue;
;3108:	float	value;	
;3109:} configcvar_t;
;3110:
;3111:
;3112:static bind_t g_bindings[] = 
;3113:{
;3114:	{"+scores",			 K_TAB,				-1,		-1, -1},
;3115:	{"+button2",		 K_ENTER,			-1,		-1, -1},
;3116:	{"+speed", 			 K_SHIFT,			-1,		-1,	-1},
;3117:	{"+forward", 		 K_UPARROW,		-1,		-1, -1},
;3118:	{"+back", 			 K_DOWNARROW,	-1,		-1, -1},
;3119:	{"+moveleft", 	 ',',					-1,		-1, -1},
;3120:	{"+moveright", 	 '.',					-1,		-1, -1},
;3121:	{"+moveup",			 K_SPACE,			-1,		-1, -1},
;3122:	{"+movedown",		 'c',					-1,		-1, -1},
;3123:	{"+left", 			 K_LEFTARROW,	-1,		-1, -1},
;3124:	{"+right", 			 K_RIGHTARROW,	-1,		-1, -1},
;3125:	{"+strafe", 		 K_ALT,				-1,		-1, -1},
;3126:	{"+lookup", 		 K_PGDN,				-1,		-1, -1},
;3127:	{"+lookdown", 	 K_DEL,				-1,		-1, -1},
;3128:	{"+mlook", 			 '/',					-1,		-1, -1},
;3129:	{"centerview", 	 K_END,				-1,		-1, -1},
;3130:	{"+zoom", 			 -1,						-1,		-1, -1},
;3131:	{"weapon 1",		 '1',					-1,		-1, -1},
;3132:	{"weapon 2",		 '2',					-1,		-1, -1},
;3133:	{"weapon 3",		 '3',					-1,		-1, -1},
;3134:	{"weapon 4",		 '4',					-1,		-1, -1},
;3135:	{"weapon 5",		 '5',					-1,		-1, -1},
;3136:	{"weapon 6",		 '6',					-1,		-1, -1},
;3137:	{"weapon 7",		 '7',					-1,		-1, -1},
;3138:	{"weapon 8",		 '8',					-1,		-1, -1},
;3139:	{"weapon 9",		 '9',					-1,		-1, -1},
;3140:	{"weapon 10",		 '0',					-1,		-1, -1},
;3141:	{"weapon 11",		 -1,					-1,		-1, -1},
;3142:	{"weapon 12",		 -1,					-1,		-1, -1},
;3143:	{"weapon 13",		 -1,					-1,		-1, -1},
;3144:	{"+attack", 		 K_CTRL,				-1,		-1, -1},
;3145:	{"weapprev",		 '[',					-1,		-1, -1},
;3146:	{"weapnext", 		 ']',					-1,		-1, -1},
;3147:	{"+button3", 		 K_MOUSE3,			-1,		-1, -1},
;3148:	{"+button4", 		 K_MOUSE4,			-1,		-1, -1},
;3149:	{"prevTeamMember", 'w',					-1,		-1, -1},
;3150:	{"nextTeamMember", 'r',					-1,		-1, -1},
;3151:	{"nextOrder", 't',					-1,		-1, -1},
;3152:	{"confirmOrder", 'y',					-1,		-1, -1},
;3153:	{"denyOrder", 'n',					-1,		-1, -1},
;3154:	{"taskOffense", 'o',					-1,		-1, -1},
;3155:	{"taskDefense", 'd',					-1,		-1, -1},
;3156:	{"taskPatrol", 'p',					-1,		-1, -1},
;3157:	{"taskCamp", 'c',					-1,		-1, -1},
;3158:	{"taskFollow", 'f',					-1,		-1, -1},
;3159:	{"taskRetrieve", 'v',					-1,		-1, -1},
;3160:	{"taskEscort", 'e',					-1,		-1, -1},
;3161:	{"taskOwnFlag", 'i',					-1,		-1, -1},
;3162:	{"taskSuicide", 'k',					-1,		-1, -1},
;3163:	{"tauntKillInsult", K_F1,			-1,		-1, -1},
;3164:	{"tauntPraise", K_F2,			-1,		-1, -1},
;3165:	{"tauntTaunt", K_F3,			-1,		-1, -1},
;3166:	{"tauntDeathInsult", K_F4,			-1,		-1, -1},
;3167:	{"tauntGauntlet", K_F5,			-1,		-1, -1},
;3168:	{"scoresUp", K_KP_PGUP,			-1,		-1, -1},
;3169:	{"scoresDown", K_KP_PGDN,			-1,		-1, -1},
;3170:	// bk001205 - this one below was:  '-1' 
;3171:	{"messagemode",  -1,					-1,		-1, -1},
;3172:	{"messagemode2", -1,						-1,		-1, -1},
;3173:	{"messagemode3", -1,						-1,		-1, -1},
;3174:	{"messagemode4", -1,						-1,		-1, -1}
;3175:};
;3176:
;3177:
;3178:static const int g_bindCount = sizeof(g_bindings) / sizeof(bind_t);
;3179:
;3180:#ifndef MISSIONPACK // bk001206
;3181:static configcvar_t g_configcvars[] =
;3182:{
;3183:	{"cl_run",			0,					0},
;3184:	{"m_pitch",			0,					0},
;3185:	{"cg_autoswitch",	0,					0},
;3186:	{"sensitivity",		0,					0},
;3187:	{"in_joystick",		0,					0},
;3188:	{"joy_threshold",	0,					0},
;3189:	{"m_filter",		0,					0},
;3190:	{"cl_freelook",		0,					0},
;3191:	{NULL,				0,					0}
;3192:};
;3193:#endif
;3194:
;3195:/*
;3196:=================
;3197:Controls_GetKeyAssignment
;3198:=================
;3199:*/
;3200:static void Controls_GetKeyAssignment (char *command, int *twokeys)
;3201:{
line 3206
;3202:	int		count;
;3203:	int		j;
;3204:	char	b[256];
;3205:
;3206:	twokeys[0] = twokeys[1] = -1;
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 268
CNSTI4 -1
ASGNI4
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRP4
ADDRLP4 268
INDIRI4
ASGNI4
line 3207
;3207:	count = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 3209
;3208:
;3209:	for ( j = 0; j < 256; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1518
line 3210
;3210:	{
line 3211
;3211:		DC->getBindingBuf( j, b, 256 );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLV
pop
line 3212
;3212:		if ( *b == 0 ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1522
line 3213
;3213:			continue;
ADDRGP4 $1519
JUMPV
LABELV $1522
line 3215
;3214:		}
;3215:		if ( !Q_stricmp( b, command ) ) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $1524
line 3216
;3216:			twokeys[count] = j;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 3217
;3217:			count++;
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3218
;3218:			if (count == 2) {
ADDRLP4 260
INDIRI4
CNSTI4 2
NEI4 $1526
line 3219
;3219:				break;
ADDRGP4 $1520
JUMPV
LABELV $1526
line 3221
;3220:			}
;3221:		}
LABELV $1524
line 3222
;3222:	}
LABELV $1519
line 3209
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1518
LABELV $1520
line 3223
;3223:}
LABELV $1517
endproc Controls_GetKeyAssignment 276 12
export Controls_GetConfig
proc Controls_GetConfig 12 8
line 3231
;3224:
;3225:/*
;3226:=================
;3227:Controls_GetConfig
;3228:=================
;3229:*/
;3230:void Controls_GetConfig( void )
;3231:{
line 3236
;3232:	int		i;
;3233:	int		twokeys[2];
;3234:
;3235:	// iterate each command, get its numeric binding
;3236:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1532
JUMPV
LABELV $1529
line 3237
;3237:	{
line 3239
;3238:
;3239:		Controls_GetKeyAssignment(g_bindings[i].command, twokeys);
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Controls_GetKeyAssignment
CALLV
pop
line 3241
;3240:
;3241:		g_bindings[i].bind1 = twokeys[0];
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3242
;3242:		g_bindings[i].bind2 = twokeys[1];
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 3243
;3243:	}
LABELV $1530
line 3236
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1532
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1529
line 3253
;3244:
;3245:	//s_controls.invertmouse.curvalue  = DC->getCVarValue( "m_pitch" ) < 0;
;3246:	//s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
;3247:	//s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
;3248:	//s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
;3249:	//s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
;3250:	//s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
;3251:	//s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05, 0.75, Controls_GetCvarValue( "joy_threshold" ) );
;3252:	//s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
;3253:}
LABELV $1528
endproc Controls_GetConfig 12 8
export Controls_SetConfig
proc Controls_SetConfig 12 8
line 3261
;3254:
;3255:/*
;3256:=================
;3257:Controls_SetConfig
;3258:=================
;3259:*/
;3260:void Controls_SetConfig(qboolean restart)
;3261:{
line 3265
;3262:	int		i;
;3263:
;3264:	// iterate each command, get its numeric binding
;3265:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1540
JUMPV
LABELV $1537
line 3266
;3266:	{
line 3268
;3267:
;3268:		if (g_bindings[i].bind1 != -1)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1541
line 3269
;3269:		{	
line 3270
;3270:			DC->setBinding( g_bindings[i].bind1, g_bindings[i].command );
ADDRLP4 4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3272
;3271:
;3272:			if (g_bindings[i].bind2 != -1)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1545
line 3273
;3273:				DC->setBinding( g_bindings[i].bind2, g_bindings[i].command );
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
LABELV $1545
line 3274
;3274:		}
LABELV $1541
line 3275
;3275:	}
LABELV $1538
line 3265
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1540
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1537
line 3289
;3276:
;3277:	//if ( s_controls.invertmouse.curvalue )
;3278:	//	DC->setCVar("m_pitch", va("%f),-fabs( DC->getCVarValue( "m_pitch" ) ) );
;3279:	//else
;3280:	//	trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
;3281:
;3282:	//trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
;3283:	//trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
;3284:	//trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
;3285:	//trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
;3286:	//trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
;3287:	//trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
;3288:	//trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
;3289:	DC->executeText(EXEC_APPEND, "in_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $1549
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 3291
;3290:	//trap_Cmd_ExecuteText( EXEC_APPEND, "in_restart\n" );
;3291:}
LABELV $1536
endproc Controls_SetConfig 12 8
export Controls_SetDefaults
proc Controls_SetDefaults 12 0
line 3299
;3292:
;3293:/*
;3294:=================
;3295:Controls_SetDefaults
;3296:=================
;3297:*/
;3298:void Controls_SetDefaults( void )
;3299:{
line 3303
;3300:	int	i;
;3301:
;3302:	// iterate each command, set its default binding
;3303:  for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1554
JUMPV
LABELV $1551
line 3304
;3304:	{
line 3305
;3305:		g_bindings[i].bind1 = g_bindings[i].defaultbind1;
ADDRLP4 4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings+8
ADDP4
INDIRI4
ASGNI4
line 3306
;3306:		g_bindings[i].bind2 = g_bindings[i].defaultbind2;
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ASGNI4
line 3307
;3307:	}
LABELV $1552
line 3303
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1554
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1551
line 3317
;3308:
;3309:	//s_controls.invertmouse.curvalue  = Controls_GetCvarDefault( "m_pitch" ) < 0;
;3310:	//s_controls.smoothmouse.curvalue  = Controls_GetCvarDefault( "m_filter" );
;3311:	//s_controls.alwaysrun.curvalue    = Controls_GetCvarDefault( "cl_run" );
;3312:	//s_controls.autoswitch.curvalue   = Controls_GetCvarDefault( "cg_autoswitch" );
;3313:	//s_controls.sensitivity.curvalue  = Controls_GetCvarDefault( "sensitivity" );
;3314:	//s_controls.joyenable.curvalue    = Controls_GetCvarDefault( "in_joystick" );
;3315:	//s_controls.joythreshold.curvalue = Controls_GetCvarDefault( "joy_threshold" );
;3316:	//s_controls.freelook.curvalue     = Controls_GetCvarDefault( "cl_freelook" );
;3317:}
LABELV $1550
endproc Controls_SetDefaults 12 0
export BindingIDFromName
proc BindingIDFromName 8 8
line 3319
;3318:
;3319:int BindingIDFromName(const char *name) {
line 3321
;3320:	int i;
;3321:  for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1563
JUMPV
LABELV $1560
line 3322
;3322:	{
line 3323
;3323:		if (Q_stricmp(name, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1564
line 3324
;3324:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1559
JUMPV
LABELV $1564
line 3326
;3325:		}
;3326:	}
LABELV $1561
line 3321
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1563
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1560
line 3327
;3327:	return -1;
CNSTI4 -1
RETI4
LABELV $1559
endproc BindingIDFromName 8 8
export BindingFromName
proc BindingFromName 16 12
line 3333
;3328:}
;3329:
;3330:char g_nameBind1[32];
;3331:char g_nameBind2[32];
;3332:
;3333:void BindingFromName(const char *cvar) {
line 3337
;3334:	int	i, b1, b2;
;3335:
;3336:	// iterate each command, set its default binding
;3337:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1570
JUMPV
LABELV $1567
line 3338
;3338:	{
line 3339
;3339:		if (Q_stricmp(cvar, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1571
line 3340
;3340:			b1 = g_bindings[i].bind1;
ADDRLP4 4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 3341
;3341:			if (b1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $1574
line 3342
;3342:				break;
ADDRGP4 $1569
JUMPV
LABELV $1574
line 3344
;3343:			}
;3344:				DC->keynumToStringBuf( b1, g_nameBind1, 32 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 g_nameBind1
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3345
;3345:				Q_strupr(g_nameBind1);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3347
;3346:
;3347:				b2 = g_bindings[i].bind2;
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3348
;3348:				if (b2 != -1)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1566
line 3349
;3349:				{
line 3350
;3350:					DC->keynumToStringBuf( b2, g_nameBind2, 32 );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 g_nameBind2
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3351
;3351:					Q_strupr(g_nameBind2);
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3352
;3352:					strcat( g_nameBind1, " or " );
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1579
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3353
;3353:					strcat( g_nameBind1, g_nameBind2 );
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3354
;3354:				}
line 3355
;3355:			return;
ADDRGP4 $1566
JUMPV
LABELV $1571
line 3357
;3356:		}
;3357:	}
LABELV $1568
line 3337
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1570
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1567
LABELV $1569
line 3358
;3358:	strcpy(g_nameBind1, "???");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1580
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3359
;3359:}
LABELV $1566
endproc BindingFromName 16 12
export Item_Slider_Paint
proc Item_Slider_Paint 68 20
line 3361
;3360:
;3361:void Item_Slider_Paint(itemDef_t *item) {
line 3364
;3362:	vec4_t newColor, lowLight;
;3363:	float x, y, value;
;3364:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3366
;3365:
;3366:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1583
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1584
JUMPV
LABELV $1583
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1584
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3368
;3367:
;3368:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1585
line 3369
;3369:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 12
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3370
;3370:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 12+4
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3371
;3371:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 12+8
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3372
;3372:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 12+12
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3373
;3373:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
CNSTF4 1056964608
ADDRLP4 56
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3374
;3374:	} else {
ADDRGP4 $1586
JUMPV
LABELV $1585
line 3375
;3375:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3376
;3376:	}
LABELV $1586
line 3378
;3377:
;3378:	y = item->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 3379
;3379:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1590
line 3380
;3380:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3381
;3381:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3382
;3382:	} else {
ADDRGP4 $1591
JUMPV
LABELV $1590
line 3383
;3383:		x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 3384
;3384:	}
LABELV $1591
line 3385
;3385:	DC->setColor(newColor);
ADDRLP4 28
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 3386
;3386:	DC->drawHandlePic( x, y, SLIDER_WIDTH, SLIDER_HEIGHT, DC->Assets.sliderBar );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1119879168
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61928
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3388
;3387:
;3388:	x = Item_Slider_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 60
INDIRF4
ASGNF4
line 3389
;3389:	DC->drawHandlePic( x - (SLIDER_THUMB_WIDTH / 2), y - 2, SLIDER_THUMB_WIDTH, SLIDER_THUMB_HEIGHT, DC->Assets.sliderThumb );
ADDRLP4 0
INDIRF4
CNSTF4 1086324736
SUBF4
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61932
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3391
;3390:
;3391:}
LABELV $1581
endproc Item_Slider_Paint 68 20
export Item_Bind_Paint
proc Item_Bind_Paint 64 32
line 3393
;3392:
;3393:void Item_Bind_Paint(itemDef_t *item) {
line 3396
;3394:	vec4_t newColor, lowLight;
;3395:	float value;
;3396:	int maxChars = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3397
;3397:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3398
;3398:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3399
;3399:	if (editPtr) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1593
line 3400
;3400:		maxChars = editPtr->maxPaintChars;
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 3401
;3401:	}
LABELV $1593
line 3403
;3402:
;3403:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1596
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1597
JUMPV
LABELV $1596
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1597
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3405
;3404:
;3405:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1598
line 3406
;3406:		if (g_bindItem == item) {
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1600
line 3407
;3407:			lowLight[0] = 0.8f * 1.0f;
ADDRLP4 0
CNSTF4 1061997773
ASGNF4
line 3408
;3408:			lowLight[1] = 0.8f * 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3409
;3409:			lowLight[2] = 0.8f * 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3410
;3410:			lowLight[3] = 0.8f * 1.0f;
ADDRLP4 0+12
CNSTF4 1061997773
ASGNF4
line 3411
;3411:		} else {
ADDRGP4 $1601
JUMPV
LABELV $1600
line 3412
;3412:			lowLight[0] = 0.8f * parent->focusColor[0]; 
ADDRLP4 0
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3413
;3413:			lowLight[1] = 0.8f * parent->focusColor[1]; 
ADDRLP4 0+4
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3414
;3414:			lowLight[2] = 0.8f * parent->focusColor[2]; 
ADDRLP4 0+8
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3415
;3415:			lowLight[3] = 0.8f * parent->focusColor[3]; 
ADDRLP4 0+12
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3416
;3416:		}
LABELV $1601
line 3417
;3417:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
CNSTF4 1056964608
ADDRLP4 56
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3418
;3418:	} else {
ADDRGP4 $1599
JUMPV
LABELV $1598
line 3419
;3419:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3420
;3420:	}
LABELV $1599
line 3422
;3421:
;3422:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1608
line 3423
;3423:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3424
;3424:		BindingFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 BindingFromName
CALLV
pop
line 3425
;3425:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, g_nameBind1, 0, maxChars, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 g_nameBind1
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3426
;3426:	} else {
ADDRGP4 $1609
JUMPV
LABELV $1608
line 3427
;3427:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "FIXME" : "FIXME", 0, maxChars, item->textStyle);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRLP4 44
INDIRF4
CNSTF4 0
EQF4 $1612
ADDRLP4 56
ADDRGP4 $1610
ASGNP4
ADDRGP4 $1613
JUMPV
LABELV $1612
ADDRLP4 56
ADDRGP4 $1610
ASGNP4
LABELV $1613
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3428
;3428:	}
LABELV $1609
line 3429
;3429:}
LABELV $1592
endproc Item_Bind_Paint 64 32
export Display_KeyBindPending
proc Display_KeyBindPending 0 0
line 3431
;3430:
;3431:qboolean Display_KeyBindPending() {
line 3432
;3432:	return g_waitingForKey;
ADDRGP4 g_waitingForKey
INDIRI4
RETI4
LABELV $1614
endproc Display_KeyBindPending 0 0
export Item_Bind_HandleKey
proc Item_Bind_HandleKey 32 12
line 3435
;3433:}
;3434:
;3435:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3439
;3436:	int			id;
;3437:	int			i;
;3438:
;3439:	if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && !g_waitingForKey)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1616
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1616
line 3440
;3440:	{
line 3441
;3441:		if (down && (key == K_MOUSE1 || key == K_ENTER)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1618
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 178
EQI4 $1620
ADDRLP4 20
INDIRI4
CNSTI4 13
NEI4 $1618
LABELV $1620
line 3442
;3442:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 3443
;3443:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 3444
;3444:		}
LABELV $1618
line 3445
;3445:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1616
line 3448
;3446:	}
;3447:	else
;3448:	{
line 3449
;3449:		if (!g_waitingForKey || g_bindItem == NULL) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1623
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1621
LABELV $1623
line 3450
;3450:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1621
line 3453
;3451:		}
;3452:
;3453:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1624
line 3454
;3454:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1624
line 3457
;3455:		}
;3456:
;3457:		switch (key)
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 96
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1634
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1636
LABELV $1635
ADDRFP4 4
INDIRI4
CNSTI4 27
EQI4 $1628
ADDRGP4 $1626
JUMPV
LABELV $1636
ADDRFP4 4
INDIRI4
CNSTI4 127
EQI4 $1629
ADDRGP4 $1626
JUMPV
line 3458
;3458:		{
LABELV $1628
line 3460
;3459:			case K_ESCAPE:
;3460:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3461
;3461:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1629
line 3464
;3462:	
;3463:			case K_BACKSPACE:
;3464:				id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 3465
;3465:				if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1630
line 3466
;3466:					g_bindings[id].bind1 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3467
;3467:					g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3468
;3468:				}
LABELV $1630
line 3469
;3469:				Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3470
;3470:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3471
;3471:				g_bindItem = NULL;
ADDRGP4 g_bindItem
CNSTP4 0
ASGNP4
line 3472
;3472:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1634
line 3475
;3473:
;3474:			case '`':
;3475:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1626
line 3477
;3476:		}
;3477:	}
line 3479
;3478:
;3479:	if (key != -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $1637
line 3480
;3480:	{
line 3482
;3481:
;3482:		for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1642
JUMPV
LABELV $1639
line 3483
;3483:		{
line 3485
;3484:
;3485:			if (g_bindings[i].bind2 == key) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1643
line 3486
;3486:				g_bindings[i].bind2 = -1;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3487
;3487:			}
LABELV $1643
line 3489
;3488:
;3489:			if (g_bindings[i].bind1 == key)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1647
line 3490
;3490:			{
line 3491
;3491:				g_bindings[i].bind1 = g_bindings[i].bind2;
ADDRLP4 20
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 20
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3492
;3492:				g_bindings[i].bind2 = -1;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3493
;3493:			}
LABELV $1647
line 3494
;3494:		}
LABELV $1640
line 3482
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1642
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1639
line 3495
;3495:	}
LABELV $1637
line 3498
;3496:
;3497:
;3498:	id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 3500
;3499:
;3500:	if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1653
line 3501
;3501:		if (key == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $1655
line 3502
;3502:			if( g_bindings[id].bind1 != -1 ) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1657
line 3503
;3503:				DC->setBinding( g_bindings[id].bind1, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3504
;3504:				g_bindings[id].bind1 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3505
;3505:			}
LABELV $1657
line 3506
;3506:			if( g_bindings[id].bind2 != -1 ) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1656
line 3507
;3507:				DC->setBinding( g_bindings[id].bind2, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3508
;3508:				g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3509
;3509:			}
line 3510
;3510:		}
ADDRGP4 $1656
JUMPV
LABELV $1655
line 3511
;3511:		else if (g_bindings[id].bind1 == -1) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1667
line 3512
;3512:			g_bindings[id].bind1 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3513
;3513:		}
ADDRGP4 $1668
JUMPV
LABELV $1667
line 3514
;3514:		else if (g_bindings[id].bind1 != key && g_bindings[id].bind2 == -1) {
ADDRLP4 24
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $1671
ADDRLP4 24
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1671
line 3515
;3515:			g_bindings[id].bind2 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3516
;3516:		}
ADDRGP4 $1672
JUMPV
LABELV $1671
line 3517
;3517:		else {
line 3518
;3518:			DC->setBinding( g_bindings[id].bind1, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3519
;3519:			DC->setBinding( g_bindings[id].bind2, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3520
;3520:			g_bindings[id].bind1 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3521
;3521:			g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3522
;3522:		}						
LABELV $1672
LABELV $1668
LABELV $1656
line 3523
;3523:	}
LABELV $1653
line 3525
;3524:
;3525:	Controls_SetConfig(qtrue);	
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3526
;3526:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3528
;3527:
;3528:	return qtrue;
CNSTI4 1
RETI4
LABELV $1615
endproc Item_Bind_HandleKey 32 12
export AdjustFrom640
proc AdjustFrom640 16 0
line 3533
;3529:}
;3530:
;3531:
;3532:
;3533:void AdjustFrom640(float *x, float *y, float *w, float *h) {
line 3535
;3534:	//*x = *x * DC->scale + DC->bias;
;3535:	*x *= DC->xscale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 3536
;3536:	*y *= DC->yscale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
line 3537
;3537:	*w *= DC->xscale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 3538
;3538:	*h *= DC->yscale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
line 3539
;3539:}
LABELV $1680
endproc AdjustFrom640 16 0
export Item_Model_Paint
proc Item_Model_Paint 588 16
line 3541
;3540:
;3541:void Item_Model_Paint(itemDef_t *item) {
line 3547
;3542:	float x, y, w, h;
;3543:	refdef_t refdef;
;3544:	refEntity_t		ent;
;3545:	vec3_t			mins, maxs, origin;
;3546:	vec3_t			angles;
;3547:	modelDef_t *modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 508
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3549
;3548:
;3549:	if (modelPtr == NULL) {
ADDRLP4 508
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1682
line 3550
;3550:		return;
ADDRGP4 $1681
JUMPV
LABELV $1682
line 3554
;3551:	}
;3552:
;3553:	// setup the refdef
;3554:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3555
;3555:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 3556
;3556:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 3557
;3557:	x = item->window.rect.x+1;
ADDRLP4 568
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3558
;3558:	y = item->window.rect.y+1;
ADDRLP4 572
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3559
;3559:	w = item->window.rect.w-2;
ADDRLP4 524
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3560
;3560:	h = item->window.rect.h-2;
ADDRLP4 528
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3562
;3561:
;3562:	AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 568
ARGP4
ADDRLP4 572
ARGP4
ADDRLP4 524
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 AdjustFrom640
CALLV
pop
line 3564
;3563:
;3564:	refdef.x = x;
ADDRLP4 0
ADDRLP4 568
INDIRF4
CVFI4 4
ASGNI4
line 3565
;3565:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 572
INDIRF4
CVFI4 4
ASGNI4
line 3566
;3566:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 524
INDIRF4
CVFI4 4
ASGNI4
line 3567
;3567:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 528
INDIRF4
CVFI4 4
ASGNI4
line 3569
;3568:
;3569:	DC->modelBounds( item->asset, mins, maxs );
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 544
ARGP4
ADDRLP4 556
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CALLV
pop
line 3571
;3570:
;3571:	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 512+8
CNSTF4 3204448256
ADDRLP4 544+8
INDIRF4
ADDRLP4 556+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 3572
;3572:	origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 512+4
CNSTF4 1056964608
ADDRLP4 544+4
INDIRF4
ADDRLP4 556+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 3575
;3573:
;3574:	// calculate distance so the model nearly fills the box
;3575:	if (qtrue) {
line 3576
;3576:		float len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 576
CNSTF4 1056964608
ADDRLP4 556+8
INDIRF4
ADDRLP4 544+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 3577
;3577:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 512
ADDRLP4 576
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 3579
;3578:		//origin[0] = len / tan(w/2);
;3579:	} else {
ADDRGP4 $1696
JUMPV
LABELV $1695
line 3580
;3580:		origin[0] = item->textscale;
ADDRLP4 512
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 3581
;3581:	}
LABELV $1696
line 3582
;3582:	refdef.fov_x = (modelPtr->fov_x) ? modelPtr->fov_x : w;
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1701
ADDRLP4 576
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1702
JUMPV
LABELV $1701
ADDRLP4 576
ADDRLP4 524
INDIRF4
ASGNF4
LABELV $1702
ADDRLP4 0+16
ADDRLP4 576
INDIRF4
ASGNF4
line 3583
;3583:	refdef.fov_y = (modelPtr->fov_y) ? modelPtr->fov_y : h;
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1705
ADDRLP4 580
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1706
JUMPV
LABELV $1705
ADDRLP4 580
ADDRLP4 528
INDIRF4
ASGNF4
LABELV $1706
ADDRLP4 0+20
ADDRLP4 580
INDIRF4
ASGNF4
line 3590
;3584:
;3585:	//refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
;3586:	//xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
;3587:	//refdef.fov_y = atan2( refdef.height, xx );
;3588:	//refdef.fov_y *= ( 360 / M_PI );
;3589:
;3590:	DC->clearScene();
ADDRGP4 DC
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
line 3592
;3591:
;3592:	refdef.time = DC->realTime;
ADDRLP4 0+72
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 3596
;3593:
;3594:	// add the model
;3595:
;3596:	memset( &ent, 0, sizeof(ent) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3603
;3597:
;3598:	//adjust = 5.0 * sin( (float)uis.realtime / 500 );
;3599:	//adjust = 360 % (int)((float)uis.realtime / 1000);
;3600:	//VectorSet( angles, 0, 0, 1 );
;3601:
;3602:	// use item storage to track
;3603:	if (modelPtr->rotationSpeed) {
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1708
line 3604
;3604:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1710
line 3605
;3605:			item->window.nextTime = DC->realTime + modelPtr->rotationSpeed;
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3606
;3606:			modelPtr->angle = (int)(modelPtr->angle + 1) % 360;
ADDRLP4 508
INDIRP4
ADDRLP4 508
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 360
MODI4
ASGNI4
line 3607
;3607:		}
LABELV $1710
line 3608
;3608:	}
LABELV $1708
line 3609
;3609:	VectorSet( angles, 0, modelPtr->angle, 0 );
ADDRLP4 532
CNSTF4 0
ASGNF4
ADDRLP4 532+4
ADDRLP4 508
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 532+8
CNSTF4 0
ASGNF4
line 3610
;3610:	AnglesToAxis( angles, ent.axis );
ADDRLP4 532
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 3612
;3611:
;3612:	ent.hModel = item->asset;
ADDRLP4 368+8
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 3613
;3613:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRLP4 512
INDIRB
ASGNB 12
line 3614
;3614:	VectorCopy( origin, ent.lightingOrigin );
ADDRLP4 368+12
ADDRLP4 512
INDIRB
ASGNB 12
line 3615
;3615:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 3616
;3616:	VectorCopy( ent.origin, ent.oldorigin );
ADDRLP4 368+84
ADDRLP4 368+68
INDIRB
ASGNB 12
line 3618
;3617:
;3618:	DC->addRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 3619
;3619:	DC->renderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 3621
;3620:
;3621:}
LABELV $1681
endproc Item_Model_Paint 588 16
export Item_Image_Paint
proc Item_Image_Paint 16 20
line 3624
;3622:
;3623:
;3624:void Item_Image_Paint(itemDef_t *item) {
line 3625
;3625:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1722
line 3626
;3626:		return;
ADDRGP4 $1721
JUMPV
LABELV $1722
line 3628
;3627:	}
;3628:	DC->drawHandlePic(item->window.rect.x+1, item->window.rect.y+1, item->window.rect.w-2, item->window.rect.h-2, item->asset);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRLP4 12
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
CALLV
pop
line 3629
;3629:}
LABELV $1721
endproc Item_Image_Paint 16 20
export Item_ListBox_Paint
proc Item_ListBox_Paint 104 32
line 3631
;3630:
;3631:void Item_ListBox_Paint(itemDef_t *item) {
line 3635
;3632:	float x, y, size, count, i, thumb;
;3633:	qhandle_t image;
;3634:	qhandle_t optionalImage;
;3635:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3641
;3636:
;3637:	// the listbox is horizontal or vertical and has a fixed size scroll bar going either direction
;3638:	// elements are enumerated from the DC and either text or image handles are acquired from the DC as well
;3639:	// textscale is used to size the text, textalignx and textaligny are used to size image elements
;3640:	// there is no clipping available so only the last completely visible item is painted
;3641:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
line 3643
;3642:	// default is vertical if horizontal flag is not here
;3643:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1725
line 3646
;3644:		// draw scrollbar in bottom of the window
;3645:		// bar
;3646:		x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3647
;3647:		y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3648
;3648:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowLeft);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 44
CNSTF4 1098907648
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 61900
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3649
;3649:		x += SCROLLBAR_SIZE - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3650
;3650:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3651
;3651:		DC->drawHandlePic(x, y, size+1, SCROLLBAR_SIZE, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3652
;3652:		x += size - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3653
;3653:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowRight);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1098907648
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 61904
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3655
;3654:		// thumb
;3655:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 64
INDIRI4
CVIF4 4
ASGNF4
line 3656
;3656:		if (thumb > x - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1727
line 3657
;3657:			thumb = x - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3658
;3658:		}
LABELV $1727
line 3659
;3659:		DC->drawHandlePic(thumb, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 68
CNSTF4 1098907648
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 61912
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3661
;3660:		//
;3661:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3662
;3662:		size = item->window.rect.w - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3665
;3663:		// items
;3664:		// size contains max available space
;3665:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1726
line 3667
;3666:			// fit = 0;
;3667:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3668
;3668:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3669
;3669:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1734
JUMPV
LABELV $1731
line 3672
;3670:				// always draw at least one
;3671:				// which may overdraw the box if it is too small for the element
;3672:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 80
INDIRI4
ASGNI4
line 3673
;3673:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1735
line 3674
;3674:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 92
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3675
;3675:				}
LABELV $1735
line 3677
;3676:
;3677:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1737
line 3678
;3678:					DC->drawRect(x, y, listPtr->elementWidth-1, listPtr->elementHeight-1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 88
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3679
;3679:				}
LABELV $1737
line 3681
;3680:
;3681:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3682
;3682:				if (size < listPtr->elementWidth) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
GEF4 $1739
line 3683
;3683:					listPtr->drawPadding = size; //listPtr->elementWidth - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 3684
;3684:					break;
ADDRGP4 $1726
JUMPV
LABELV $1739
line 3686
;3685:				}
;3686:				x += listPtr->elementWidth;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3687
;3687:				listPtr->endPos++;
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3689
;3688:				// fit++;
;3689:			}
LABELV $1732
line 3669
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1734
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1731
line 3690
;3690:		} else {
line 3692
;3691:			//
;3692:		}
line 3693
;3693:	} else {
ADDRGP4 $1726
JUMPV
LABELV $1725
line 3695
;3694:		// draw scrollbar to right side of the window
;3695:		x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3696
;3696:		y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3697
;3697:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 44
CNSTF4 1098907648
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 61892
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3698
;3698:		y += SCROLLBAR_SIZE - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3700
;3699:
;3700:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3701
;3701:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3702
;3702:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size+1, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3703
;3703:		y += size - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3704
;3704:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1098907648
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61896
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3706
;3705:		// thumb
;3706:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
CVIF4 4
ASGNF4
line 3707
;3707:		if (thumb > y - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1741
line 3708
;3708:			thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3709
;3709:		}
LABELV $1741
line 3710
;3710:		DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 72
CNSTF4 1098907648
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 61912
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3713
;3711:
;3712:		// adjust size for item painting
;3713:		size = item->window.rect.h - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3714
;3714:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1743
line 3716
;3715:			// fit = 0;
;3716:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3717
;3717:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3718
;3718:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1748
JUMPV
LABELV $1745
line 3721
;3719:				// always draw at least one
;3720:				// which may overdraw the box if it is too small for the element
;3721:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 80
INDIRI4
ASGNI4
line 3722
;3722:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1749
line 3723
;3723:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 92
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3724
;3724:				}
LABELV $1749
line 3726
;3725:
;3726:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1751
line 3727
;3727:					DC->drawRect(x, y, listPtr->elementWidth - 1, listPtr->elementHeight - 1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 88
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3728
;3728:				}
LABELV $1751
line 3730
;3729:
;3730:				listPtr->endPos++;
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3731
;3731:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3732
;3732:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1753
line 3733
;3733:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3734
;3734:					break;
ADDRGP4 $1744
JUMPV
LABELV $1753
line 3736
;3735:				}
;3736:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3738
;3737:				// fit++;
;3738:			}
LABELV $1746
line 3718
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1748
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1745
line 3739
;3739:		} else {
ADDRGP4 $1744
JUMPV
LABELV $1743
line 3740
;3740:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3741
;3741:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3742
;3742:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1758
JUMPV
LABELV $1755
line 3747
;3743:				const char *text;
;3744:				// always draw at least one
;3745:				// which may overdraw the box if it is too small for the element
;3746:
;3747:				if (listPtr->numColumns > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1759
line 3749
;3748:					int j;
;3749:					for (j = 0; j < listPtr->numColumns; j++) {
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRGP4 $1764
JUMPV
LABELV $1761
line 3750
;3750:						text = DC->feederItemText(item->special, i, j, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 88
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 88
INDIRP4
ASGNP4
line 3751
;3751:						if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1765
line 3752
;3752:							DC->drawHandlePic(x + 4 + listPtr->columnInfo[j].pos, y - 1 + listPtr->elementHeight / 2, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
ADDRLP4 96
CNSTI4 12
ADDRLP4 84
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 96
INDIRP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ADDF4
ARGF4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3753
;3753:						} else if (text) {
ADDRGP4 $1766
JUMPV
LABELV $1765
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1767
line 3754
;3754:							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle);
ADDRLP4 96
CNSTI4 12
ADDRLP4 84
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 96
INDIRP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 100
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 96
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3755
;3755:						}
LABELV $1767
LABELV $1766
line 3756
;3756:					}
LABELV $1762
line 3749
ADDRLP4 84
ADDRLP4 84
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1764
ADDRLP4 84
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
LTI4 $1761
line 3757
;3757:				} else {
ADDRGP4 $1760
JUMPV
LABELV $1759
line 3758
;3758:					text = DC->feederItemText(item->special, i, 0, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 84
INDIRP4
ASGNP4
line 3759
;3759:					if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1769
line 3761
;3760:						//DC->drawHandlePic(x + 4 + listPtr->elementHeight, y, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
;3761:					} else if (text) {
ADDRGP4 $1770
JUMPV
LABELV $1769
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1771
line 3762
;3762:						DC->drawText(x + 4, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3763
;3763:					}
LABELV $1771
LABELV $1770
line 3764
;3764:				}
LABELV $1760
line 3766
;3765:
;3766:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1773
line 3767
;3767:					DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, listPtr->elementHeight, item->window.outlineColor);
ADDRLP4 84
CNSTF4 1073741824
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 3768
;3768:				}
LABELV $1773
line 3770
;3769:
;3770:				size -= listPtr->elementHeight;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3771
;3771:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1775
line 3772
;3772:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3773
;3773:					break;
ADDRGP4 $1757
JUMPV
LABELV $1775
line 3775
;3774:				}
;3775:				listPtr->endPos++;
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3776
;3776:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3778
;3777:				// fit++;
;3778:			}
LABELV $1756
line 3742
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1758
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1755
LABELV $1757
line 3779
;3779:		}
LABELV $1744
line 3780
;3780:	}
LABELV $1726
line 3781
;3781:}
LABELV $1724
endproc Item_ListBox_Paint 104 32
export Item_OwnerDraw_Paint
proc Item_OwnerDraw_Paint 68 56
line 3784
;3782:
;3783:
;3784:void Item_OwnerDraw_Paint(itemDef_t *item) {
line 3787
;3785:  menuDef_t *parent;
;3786:
;3787:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1778
line 3788
;3788:		return;
ADDRGP4 $1777
JUMPV
LABELV $1778
line 3790
;3789:	}
;3790:  parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3792
;3791:
;3792:	if (DC->ownerDrawItem) {
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1780
line 3794
;3793:		vec4_t color, lowLight;
;3794:		menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3795
;3795:		Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 3796
;3796:		memcpy(&color, &item->window.foreColor, sizeof(color));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3797
;3797:		if (item->numColors > 0 && DC->getValue) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1782
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1782
line 3800
;3798:			// if the value is within one of the ranges then set color to that, otherwise leave at default
;3799:			int i;
;3800:			float f = DC->getValue(item->window.ownerDraw);
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 56
INDIRF4
ASGNF4
line 3801
;3801:			for (i = 0; i < item->numColors; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $1787
JUMPV
LABELV $1784
line 3802
;3802:				if (f >= item->colorRanges[i].low && f <= item->colorRanges[i].high) {
ADDRLP4 64
CNSTI4 24
ADDRLP4 48
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
LTF4 $1788
ADDRLP4 52
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GTF4 $1788
line 3803
;3803:					memcpy(&color, &item->colorRanges[i].color, sizeof(color));
ADDRLP4 4
ARGP4
CNSTI4 24
ADDRLP4 48
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3804
;3804:					break;
ADDRGP4 $1786
JUMPV
LABELV $1788
line 3806
;3805:				}
;3806:			}
LABELV $1785
line 3801
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1787
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
LTI4 $1784
LABELV $1786
line 3807
;3807:		}
LABELV $1782
line 3809
;3808:
;3809:		if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1790
line 3810
;3810:			lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 24
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3811
;3811:			lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 24+4
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3812
;3812:			lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 24+8
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3813
;3813:			lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 24+12
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3814
;3814:			LerpColor(parent->focusColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3815
;3815:		} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $1791
JUMPV
LABELV $1790
ADDRLP4 48
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $1795
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
ADDRLP4 48
INDIRI4
BANDI4
CNSTI4 0
NEI4 $1795
line 3816
;3816:			lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 24
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 3817
;3817:			lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 24+4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 3818
;3818:			lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 24+8
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 3819
;3819:			lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 24+12
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
MULF4
ASGNF4
line 3820
;3820:			LerpColor(item->window.foreColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 52
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ADDRLP4 52
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3821
;3821:		}
LABELV $1795
LABELV $1791
line 3823
;3822:
;3823:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1800
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $1800
line 3824
;3824:		  memcpy(color, parent->disableColor, sizeof(vec4_t)); // bk001207 - FIXME: Com_Memcpy
ADDRLP4 4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3825
;3825:		}
LABELV $1800
line 3827
;3826:	
;3827:		if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1802
line 3828
;3828:			Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3829
;3829:				if (item->text[0]) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1804
line 3831
;3830:					// +8 is an offset kludge to properly align owner draw items that have text combined with them
;3831:					DC->ownerDrawItem(item->textRect.x + item->textRect.w + 8, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3832
;3832:				} else {
ADDRGP4 $1803
JUMPV
LABELV $1804
line 3833
;3833:					DC->ownerDrawItem(item->textRect.x + item->textRect.w, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3834
;3834:				}
line 3835
;3835:			} else {
ADDRGP4 $1803
JUMPV
LABELV $1802
line 3836
;3836:			DC->ownerDrawItem(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, item->textalignx, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3837
;3837:		}
LABELV $1803
line 3838
;3838:	}
LABELV $1780
line 3839
;3839:}
LABELV $1777
endproc Item_OwnerDraw_Paint 68 56
export Item_Paint
proc Item_Paint 84 24
line 3842
;3840:
;3841:
;3842:void Item_Paint(itemDef_t *item) {
line 3844
;3843:  vec4_t red;
;3844:  menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3845
;3845:  red[0] = red[3] = 1;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 3846
;3846:  red[1] = red[2] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 3848
;3847:
;3848:  if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1810
line 3849
;3849:    return;
ADDRGP4 $1806
JUMPV
LABELV $1810
line 3852
;3850:  }
;3851:
;3852:  if (item->window.flags & WINDOW_ORBITING) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1812
line 3853
;3853:    if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1814
line 3856
;3854:      float rx, ry, a, c, s, w, h;
;3855:      
;3856:      item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3858
;3857:      // translate
;3858:      w = item->window.rectClient.w / 2;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3859
;3859:      h = item->window.rectClient.h / 2;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3860
;3860:      rx = item->window.rectClient.x + w - item->window.rectEffects.x;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ADDRLP4 60
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3861
;3861:      ry = item->window.rectClient.y + h - item->window.rectEffects.y;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3862
;3862:      a = 3 * M_PI / 180;
ADDRLP4 36
CNSTF4 1029076816
ASGNF4
line 3863
;3863:  	  c = cos(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 3864
;3864:      s = sin(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 72
INDIRF4
ASGNF4
line 3865
;3865:      item->window.rectClient.x = (rx * c - ry * s) + item->window.rectEffects.x - w;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
SUBF4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ADDRLP4 48
INDIRF4
SUBF4
ASGNF4
line 3866
;3866:      item->window.rectClient.y = (rx * s + ry * c) + item->window.rectEffects.y - h;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 3867
;3867:      Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3869
;3868:
;3869:    }
LABELV $1814
line 3870
;3870:  }
LABELV $1812
line 3873
;3871:
;3872:
;3873:  if (item->window.flags & WINDOW_INTRANSITION) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1816
line 3874
;3874:    if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1818
line 3875
;3875:      int done = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 3876
;3876:      item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3878
;3877:			// transition the x,y
;3878:			if (item->window.rectClient.x == item->window.rectEffects.x) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEF4 $1820
line 3879
;3879:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3880
;3880:			} else {
ADDRGP4 $1821
JUMPV
LABELV $1820
line 3881
;3881:				if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1822
line 3882
;3882:					item->window.rectClient.x += item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3883
;3883:					if (item->window.rectClient.x > item->window.rectEffects.x) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
LEF4 $1823
line 3884
;3884:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3885
;3885:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3886
;3886:					}
line 3887
;3887:				} else {
ADDRGP4 $1823
JUMPV
LABELV $1822
line 3888
;3888:					item->window.rectClient.x -= item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3889
;3889:					if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1826
line 3890
;3890:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3891
;3891:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3892
;3892:					}
LABELV $1826
line 3893
;3893:				}
LABELV $1823
line 3894
;3894:			}
LABELV $1821
line 3895
;3895:			if (item->window.rectClient.y == item->window.rectEffects.y) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEF4 $1828
line 3896
;3896:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3897
;3897:			} else {
ADDRGP4 $1829
JUMPV
LABELV $1828
line 3898
;3898:				if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1830
line 3899
;3899:					item->window.rectClient.y += item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3900
;3900:					if (item->window.rectClient.y > item->window.rectEffects.y) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
LEF4 $1831
line 3901
;3901:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3902
;3902:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3903
;3903:					}
line 3904
;3904:				} else {
ADDRGP4 $1831
JUMPV
LABELV $1830
line 3905
;3905:					item->window.rectClient.y -= item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3906
;3906:					if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1834
line 3907
;3907:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3908
;3908:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3909
;3909:					}
LABELV $1834
line 3910
;3910:				}
LABELV $1831
line 3911
;3911:			}
LABELV $1829
line 3912
;3912:			if (item->window.rectClient.w == item->window.rectEffects.w) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
NEF4 $1836
line 3913
;3913:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3914
;3914:			} else {
ADDRGP4 $1837
JUMPV
LABELV $1836
line 3915
;3915:				if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1838
line 3916
;3916:					item->window.rectClient.w += item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3917
;3917:					if (item->window.rectClient.w > item->window.rectEffects.w) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
LEF4 $1839
line 3918
;3918:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3919
;3919:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3920
;3920:					}
line 3921
;3921:				} else {
ADDRGP4 $1839
JUMPV
LABELV $1838
line 3922
;3922:					item->window.rectClient.w -= item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3923
;3923:					if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1842
line 3924
;3924:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3925
;3925:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3926
;3926:					}
LABELV $1842
line 3927
;3927:				}
LABELV $1839
line 3928
;3928:			}
LABELV $1837
line 3929
;3929:			if (item->window.rectClient.h == item->window.rectEffects.h) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
NEF4 $1844
line 3930
;3930:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3931
;3931:			} else {
ADDRGP4 $1845
JUMPV
LABELV $1844
line 3932
;3932:				if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1846
line 3933
;3933:					item->window.rectClient.h += item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3934
;3934:					if (item->window.rectClient.h > item->window.rectEffects.h) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
LEF4 $1847
line 3935
;3935:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3936
;3936:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3937
;3937:					}
line 3938
;3938:				} else {
ADDRGP4 $1847
JUMPV
LABELV $1846
line 3939
;3939:					item->window.rectClient.h -= item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3940
;3940:					if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1850
line 3941
;3941:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3942
;3942:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3943
;3943:					}
LABELV $1850
line 3944
;3944:				}
LABELV $1847
line 3945
;3945:			}
LABELV $1845
line 3947
;3946:
;3947:      Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3949
;3948:
;3949:      if (done == 4) {
ADDRLP4 28
INDIRI4
CNSTI4 4
NEI4 $1852
line 3950
;3950:        item->window.flags &= ~WINDOW_INTRANSITION;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 3951
;3951:      }
LABELV $1852
line 3953
;3952:
;3953:    }
LABELV $1818
line 3954
;3954:  }
LABELV $1816
line 3956
;3955:
;3956:	if (item->window.ownerDrawFlags && DC->ownerDrawVisible) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1854
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1854
line 3957
;3957:		if (!DC->ownerDrawVisible(item->window.ownerDrawFlags)) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1856
line 3958
;3958:			item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 3959
;3959:		} else {
ADDRGP4 $1857
JUMPV
LABELV $1856
line 3960
;3960:			item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 3961
;3961:		}
LABELV $1857
line 3962
;3962:	}
LABELV $1854
line 3964
;3963:
;3964:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE)) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1858
line 3965
;3965:		if (!Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1860
line 3966
;3966:			return;
ADDRGP4 $1806
JUMPV
LABELV $1860
line 3968
;3967:		}
;3968:	}
LABELV $1858
line 3970
;3969:
;3970:  if (item->window.flags & WINDOW_TIMEDVISIBLE) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $1862
line 3972
;3971:
;3972:	}
LABELV $1862
line 3974
;3973:
;3974:  if (!(item->window.flags & WINDOW_VISIBLE)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $1864
line 3975
;3975:    return;
ADDRGP4 $1806
JUMPV
LABELV $1864
line 3979
;3976:  }
;3977:
;3978:  // paint the rect first.. 
;3979:  Window_Paint(&item->window, parent->fadeAmount , parent->fadeClamp, parent->fadeCycle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 3981
;3980:
;3981:  if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $1866
line 3983
;3982:		vec4_t color;
;3983:		rectDef_t *r = Item_CorrectedTextRect(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 52
INDIRP4
ASGNP4
line 3984
;3984:    color[1] = color[3] = 1;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 36+12
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 56
INDIRF4
ASGNF4
line 3985
;3985:    color[0] = color[2] = 0;
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 36+8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 60
INDIRF4
ASGNF4
line 3986
;3986:    DC->drawRect(r->x, r->y, r->w, r->h, 1, color);
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3987
;3987:  }
LABELV $1866
line 3991
;3988:
;3989:  //DC->drawRect(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, 1, red);
;3990:
;3991:  switch (item->type) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1872
ADDRLP4 32
INDIRI4
CNSTI4 13
GTI4 $1872
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1886
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1886
address $1875
address $1875
address $1872
address $1872
address $1878
address $1872
address $1880
address $1881
address $1874
address $1878
address $1885
address $1882
address $1883
address $1884
code
LABELV $1874
line 3993
;3992:    case ITEM_TYPE_OWNERDRAW:
;3993:      Item_OwnerDraw_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_OwnerDraw_Paint
CALLV
pop
line 3994
;3994:      break;
ADDRGP4 $1872
JUMPV
LABELV $1875
line 3997
;3995:    case ITEM_TYPE_TEXT:
;3996:    case ITEM_TYPE_BUTTON:
;3997:      Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3998
;3998:      break;
ADDRGP4 $1872
JUMPV
line 4000
;3999:    case ITEM_TYPE_RADIOBUTTON:
;4000:      break;
line 4002
;4001:    case ITEM_TYPE_CHECKBOX:
;4002:      break;
LABELV $1878
line 4005
;4003:    case ITEM_TYPE_EDITFIELD:
;4004:    case ITEM_TYPE_NUMERICFIELD:
;4005:      Item_TextField_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextField_Paint
CALLV
pop
line 4006
;4006:      break;
ADDRGP4 $1872
JUMPV
line 4008
;4007:    case ITEM_TYPE_COMBO:
;4008:      break;
LABELV $1880
line 4010
;4009:    case ITEM_TYPE_LISTBOX:
;4010:      Item_ListBox_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ListBox_Paint
CALLV
pop
line 4011
;4011:      break;
ADDRGP4 $1872
JUMPV
LABELV $1881
line 4016
;4012:    //case ITEM_TYPE_IMAGE:
;4013:    //  Item_Image_Paint(item);
;4014:    //  break;
;4015:    case ITEM_TYPE_MODEL:
;4016:      Item_Model_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Model_Paint
CALLV
pop
line 4017
;4017:      break;
ADDRGP4 $1872
JUMPV
LABELV $1882
line 4019
;4018:    case ITEM_TYPE_YESNO:
;4019:      Item_YesNo_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_YesNo_Paint
CALLV
pop
line 4020
;4020:      break;
ADDRGP4 $1872
JUMPV
LABELV $1883
line 4022
;4021:    case ITEM_TYPE_MULTI:
;4022:      Item_Multi_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Multi_Paint
CALLV
pop
line 4023
;4023:      break;
ADDRGP4 $1872
JUMPV
LABELV $1884
line 4025
;4024:    case ITEM_TYPE_BIND:
;4025:      Item_Bind_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Bind_Paint
CALLV
pop
line 4026
;4026:      break;
ADDRGP4 $1872
JUMPV
LABELV $1885
line 4028
;4027:    case ITEM_TYPE_SLIDER:
;4028:      Item_Slider_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Slider_Paint
CALLV
pop
line 4029
;4029:      break;
line 4031
;4030:    default:
;4031:      break;
LABELV $1872
line 4034
;4032:  }
;4033:
;4034:}
LABELV $1806
endproc Item_Paint 84 24
export Menu_Init
proc Menu_Init 0 12
line 4036
;4035:
;4036:void Menu_Init(menuDef_t *menu) {
line 4037
;4037:	memset(menu, 0, sizeof(menuDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 644
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4038
;4038:	menu->cursorItem = -1;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 4039
;4039:	menu->fadeAmount = DC->Assets.fadeAmount;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61960
ADDP4
INDIRF4
ASGNF4
line 4040
;4040:	menu->fadeClamp = DC->Assets.fadeClamp;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61952
ADDP4
INDIRF4
ASGNF4
line 4041
;4041:	menu->fadeCycle = DC->Assets.fadeCycle;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61956
ADDP4
INDIRI4
ASGNI4
line 4042
;4042:	Window_Init(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4043
;4043:}
LABELV $1887
endproc Menu_Init 0 12
export Menu_GetFocusedItem
proc Menu_GetFocusedItem 8 0
line 4045
;4044:
;4045:itemDef_t *Menu_GetFocusedItem(menuDef_t *menu) {
line 4047
;4046:  int i;
;4047:  if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1889
line 4048
;4048:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1894
JUMPV
LABELV $1891
line 4049
;4049:      if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1895
line 4050
;4050:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1888
JUMPV
LABELV $1895
line 4052
;4051:      }
;4052:    }
LABELV $1892
line 4048
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1894
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1891
line 4053
;4053:  }
LABELV $1889
line 4054
;4054:  return NULL;
CNSTP4 0
RETP4
LABELV $1888
endproc Menu_GetFocusedItem 8 0
export Menu_GetFocused
proc Menu_GetFocused 12 0
line 4057
;4055:}
;4056:
;4057:menuDef_t *Menu_GetFocused() {
line 4059
;4058:  int i;
;4059:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1901
JUMPV
LABELV $1898
line 4060
;4060:    if (Menus[i].window.flags & WINDOW_HASFOCUS && Menus[i].window.flags & WINDOW_VISIBLE) {
ADDRLP4 4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $1902
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $1902
line 4061
;4061:      return &Menus[i];
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $1897
JUMPV
LABELV $1902
line 4063
;4062:    }
;4063:  }
LABELV $1899
line 4059
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1901
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1898
line 4064
;4064:  return NULL;
CNSTP4 0
RETP4
LABELV $1897
endproc Menu_GetFocused 12 0
export Menu_ScrollFeeder
proc Menu_ScrollFeeder 12 16
line 4067
;4065:}
;4066:
;4067:void Menu_ScrollFeeder(menuDef_t *menu, int feeder, qboolean down) {
line 4068
;4068:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1907
line 4070
;4069:		int i;
;4070:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1912
JUMPV
LABELV $1909
line 4071
;4071:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1913
line 4072
;4072:				Item_ListBox_HandleKey(menu->items[i], (down) ? K_DOWNARROW : K_UPARROW, qtrue, qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1916
ADDRLP4 4
CNSTI4 133
ASGNI4
ADDRGP4 $1917
JUMPV
LABELV $1916
ADDRLP4 4
CNSTI4 132
ASGNI4
LABELV $1917
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 4073
;4073:				return;
ADDRGP4 $1906
JUMPV
LABELV $1913
line 4075
;4074:			}
;4075:		}
LABELV $1910
line 4070
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1912
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1909
line 4076
;4076:	}
LABELV $1907
line 4077
;4077:}
LABELV $1906
endproc Menu_ScrollFeeder 12 16
export Menu_SetFeederSelection
proc Menu_SetFeederSelection 8 8
line 4081
;4078:
;4079:
;4080:
;4081:void Menu_SetFeederSelection(menuDef_t *menu, int feeder, int index, const char *name) {
line 4082
;4082:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1919
line 4083
;4083:		if (name == NULL) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1921
line 4084
;4084:			menu = Menu_GetFocused();
ADDRLP4 0
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 4085
;4085:		} else {
ADDRGP4 $1922
JUMPV
LABELV $1921
line 4086
;4086:			menu = Menus_FindByName(name);
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 4087
;4087:		}
LABELV $1922
line 4088
;4088:	}
LABELV $1919
line 4090
;4089:
;4090:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1923
line 4092
;4091:		int i;
;4092:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1928
JUMPV
LABELV $1925
line 4093
;4093:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1929
line 4094
;4094:				if (index == 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1931
line 4095
;4095:					listBoxDef_t *listPtr = (listBoxDef_t*)menu->items[i]->typeData;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4096
;4096:					listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 4097
;4097:					listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4098
;4098:				}
LABELV $1931
line 4099
;4099:				menu->items[i]->cursorPos = index;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 4100
;4100:				DC->feederSelection(menu->items[i]->special, menu->items[i]->cursorPos);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 4101
;4101:				return;
ADDRGP4 $1918
JUMPV
LABELV $1929
line 4103
;4102:			}
;4103:		}
LABELV $1926
line 4092
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1928
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1925
line 4104
;4104:	}
LABELV $1923
line 4105
;4105:}
LABELV $1918
endproc Menu_SetFeederSelection 8 8
export Menus_AnyFullScreenVisible
proc Menus_AnyFullScreenVisible 12 0
line 4107
;4106:
;4107:qboolean Menus_AnyFullScreenVisible() {
line 4109
;4108:  int i;
;4109:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1937
JUMPV
LABELV $1934
line 4110
;4110:    if (Menus[i].window.flags & WINDOW_VISIBLE && Menus[i].fullScreen) {
ADDRLP4 4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $1938
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+184
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1938
line 4111
;4111:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1933
JUMPV
LABELV $1938
line 4113
;4112:    }
;4113:  }
LABELV $1935
line 4109
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1937
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1934
line 4114
;4114:  return qfalse;
CNSTI4 0
RETI4
LABELV $1933
endproc Menus_AnyFullScreenVisible 12 0
export Menus_ActivateByName
proc Menus_ActivateByName 28 8
line 4117
;4115:}
;4116:
;4117:menuDef_t *Menus_ActivateByName(const char *p) {
line 4119
;4118:  int i;
;4119:  menuDef_t *m = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4120
;4120:	menuDef_t *focus = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4121
;4121:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1946
JUMPV
LABELV $1943
line 4122
;4122:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1947
line 4123
;4123:	    m = &Menus[i];
ADDRLP4 4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 4124
;4124:			Menus_Activate(m);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 4125
;4125:			if (openMenuCount < MAX_OPEN_MENUS && focus != NULL) {
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 16
GEI4 $1948
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1948
line 4126
;4126:				menuStack[openMenuCount++] = focus;
ADDRLP4 24
ADDRGP4 openMenuCount
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 menuStack
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4127
;4127:			}
line 4128
;4128:    } else {
ADDRGP4 $1948
JUMPV
LABELV $1947
line 4129
;4129:      Menus[i].window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 20
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 4130
;4130:    }
LABELV $1948
line 4131
;4131:  }
LABELV $1944
line 4121
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1946
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1943
line 4132
;4132:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 4133
;4133:  return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $1942
endproc Menus_ActivateByName 28 8
export Item_Init
proc Item_Init 0 12
line 4137
;4134:}
;4135:
;4136:
;4137:void Item_Init(itemDef_t *item) {
line 4138
;4138:	memset(item, 0, sizeof(itemDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 540
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4139
;4139:	item->textscale = 0.55f;
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 1057803469
ASGNF4
line 4140
;4140:	Window_Init(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4141
;4141:}
LABELV $1953
endproc Item_Init 0 12
export Menu_HandleMouseMove
proc Menu_HandleMouseMove 52 12
line 4143
;4142:
;4143:void Menu_HandleMouseMove(menuDef_t *menu, float x, float y) {
line 4145
;4144:  int i, pass;
;4145:  qboolean focusSet = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 4148
;4146:
;4147:  itemDef_t *overItem;
;4148:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1955
line 4149
;4149:    return;
ADDRGP4 $1954
JUMPV
LABELV $1955
line 4152
;4150:  }
;4151:
;4152:  if (!(menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1957
line 4153
;4153:    return;
ADDRGP4 $1954
JUMPV
LABELV $1957
line 4156
;4154:  }
;4155:
;4156:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1959
line 4158
;4157:		//Item_MouseMove(itemCapture, x, y);
;4158:		return;
ADDRGP4 $1954
JUMPV
LABELV $1959
line 4161
;4159:	}
;4160:
;4161:	if (g_waitingForKey || g_editingField) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1963
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1961
LABELV $1963
line 4162
;4162:		return;
ADDRGP4 $1954
JUMPV
LABELV $1961
line 4167
;4163:	}
;4164:
;4165:  // FIXME: this is the whole issue of focus vs. mouse over.. 
;4166:  // need a better overall solution as i don't like going through everything twice
;4167:  for (pass = 0; pass < 2; pass++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1964
line 4168
;4168:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1971
JUMPV
LABELV $1968
line 4172
;4169:      // turn off focus each item
;4170:      // menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;4171:
;4172:      if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1972
line 4173
;4173:        continue;
ADDRGP4 $1969
JUMPV
LABELV $1972
line 4177
;4174:      }
;4175:
;4176:			// items can be enabled and disabled based on cvars
;4177:			if (menu->items[i]->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_ENABLE)) {
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1974
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $1974
line 4178
;4178:				continue;
ADDRGP4 $1969
JUMPV
LABELV $1974
line 4181
;4179:			}
;4180:
;4181:			if (menu->items[i]->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_SHOW)) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1976
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 32
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $1976
line 4182
;4182:				continue;
ADDRGP4 $1969
JUMPV
LABELV $1976
line 4187
;4183:			}
;4184:
;4185:
;4186:
;4187:      if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1978
line 4188
;4188:				if (pass == 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1979
line 4189
;4189:					overItem = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4190
;4190:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1982
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1982
line 4191
;4191:						if (!Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $1984
line 4192
;4192:							continue;
ADDRGP4 $1969
JUMPV
LABELV $1984
line 4194
;4193:						}
;4194:					}
LABELV $1982
line 4196
;4195:					// if we are over an item
;4196:					if (IsVisible(overItem->window.flags)) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 IsVisible
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1979
line 4198
;4197:						// different one
;4198:						Item_MouseEnter(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_MouseEnter
CALLV
pop
line 4202
;4199:						// Item_SetMouseOver(overItem, qtrue);
;4200:
;4201:						// if item is not a decoration see if it can take focus
;4202:						if (!focusSet) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1979
line 4203
;4203:							focusSet = Item_SetFocus(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 4204
;4204:						}
line 4205
;4205:					}
line 4206
;4206:				}
line 4207
;4207:      } else if (menu->items[i]->window.flags & WINDOW_MOUSEOVER) {
ADDRGP4 $1979
JUMPV
LABELV $1978
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1990
line 4208
;4208:          Item_MouseLeave(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_MouseLeave
CALLV
pop
line 4209
;4209:          Item_SetMouseOver(menu->items[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Item_SetMouseOver
CALLV
pop
line 4210
;4210:      }
LABELV $1990
LABELV $1979
line 4211
;4211:    }
LABELV $1969
line 4168
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1971
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1968
line 4212
;4212:  }
LABELV $1965
line 4167
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $1964
line 4214
;4213:
;4214:}
LABELV $1954
endproc Menu_HandleMouseMove 52 12
export Menu_Paint
proc Menu_Paint 48 24
line 4216
;4215:
;4216:void Menu_Paint(menuDef_t *menu, qboolean forcePaint) {
line 4219
;4217:	int i;
;4218:
;4219:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1993
line 4220
;4220:		return;
ADDRGP4 $1992
JUMPV
LABELV $1993
line 4223
;4221:	}
;4222:
;4223:	if (!(menu->window.flags & WINDOW_VISIBLE) &&  !forcePaint) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $1995
ADDRFP4 4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1995
line 4224
;4224:		return;
ADDRGP4 $1992
JUMPV
LABELV $1995
line 4227
;4225:	}
;4226:
;4227:	if (menu->window.ownerDrawFlags && DC->ownerDrawVisible && !DC->ownerDrawVisible(menu->window.ownerDrawFlags)) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1997
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1997
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1997
line 4228
;4228:		return;
ADDRGP4 $1992
JUMPV
LABELV $1997
line 4231
;4229:	}
;4230:	
;4231:	if (forcePaint) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1999
line 4232
;4232:		menu->window.flags |= WINDOW_FORCED;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1048576
BORI4
ASGNI4
line 4233
;4233:	}
LABELV $1999
line 4236
;4234:
;4235:	// draw the background if necessary
;4236:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2001
line 4239
;4237:		// implies a background shader
;4238:		// FIXME: make sure we have a default shader if fullscreen is set with no background
;4239:		DC->drawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, menu->window.background );
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4240
;4240:	} else if (menu->window.background) {
ADDRGP4 $2002
JUMPV
LABELV $2001
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2003
line 4243
;4241:		// this allows a background shader without being full screen
;4242:		//UI_DrawHandlePic(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, menu->backgroundShader);
;4243:	}
LABELV $2003
LABELV $2002
line 4246
;4244:
;4245:	// paint the background and or border
;4246:	Window_Paint(&menu->window, menu->fadeAmount, menu->fadeClamp, menu->fadeCycle );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 4248
;4247:
;4248:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2008
JUMPV
LABELV $2005
line 4249
;4249:		Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 4250
;4250:	}
LABELV $2006
line 4248
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2008
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2005
line 4252
;4251:
;4252:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2009
line 4254
;4253:		vec4_t color;
;4254:		color[0] = color[2] = color[3] = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 4255
;4255:		color[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 4256
;4256:		DC->drawRect(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, 1, color);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4257
;4257:	}
LABELV $2009
line 4258
;4258:}
LABELV $1992
endproc Menu_Paint 48 24
export Item_ValidateTypeData
proc Item_ValidateTypeData 8 12
line 4265
;4259:
;4260:/*
;4261:===============
;4262:Item_ValidateTypeData
;4263:===============
;4264:*/
;4265:void Item_ValidateTypeData(itemDef_t *item) {
line 4266
;4266:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2015
line 4267
;4267:		return;
ADDRGP4 $2014
JUMPV
LABELV $2015
line 4270
;4268:	}
;4269:
;4270:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2017
line 4271
;4271:		item->typeData = UI_Alloc(sizeof(listBoxDef_t));
CNSTI4 232
ARGI4
ADDRLP4 0
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4272
;4272:		memset(item->typeData, 0, sizeof(listBoxDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 232
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4273
;4273:	} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD || item->type == ITEM_TYPE_YESNO || item->type == ITEM_TYPE_BIND || item->type == ITEM_TYPE_SLIDER || item->type == ITEM_TYPE_TEXT) {
ADDRGP4 $2018
JUMPV
LABELV $2017
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 9
EQI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2019
LABELV $2025
line 4274
;4274:		item->typeData = UI_Alloc(sizeof(editFieldDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4275
;4275:		memset(item->typeData, 0, sizeof(editFieldDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4276
;4276:		if (item->type == ITEM_TYPE_EDITFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2020
line 4277
;4277:			if (!((editFieldDef_t *) item->typeData)->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2020
line 4278
;4278:				((editFieldDef_t *) item->typeData)->maxPaintChars = MAX_EDITFIELD;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 256
ASGNI4
line 4279
;4279:			}
line 4280
;4280:		}
line 4281
;4281:	} else if (item->type == ITEM_TYPE_MULTI) {
ADDRGP4 $2020
JUMPV
LABELV $2019
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 12
NEI4 $2030
line 4282
;4282:		item->typeData = UI_Alloc(sizeof(multiDef_t));
CNSTI4 392
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4283
;4283:	} else if (item->type == ITEM_TYPE_MODEL) {
ADDRGP4 $2031
JUMPV
LABELV $2030
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2032
line 4284
;4284:		item->typeData = UI_Alloc(sizeof(modelDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4285
;4285:	}
LABELV $2032
LABELV $2031
LABELV $2020
LABELV $2018
line 4286
;4286:}
LABELV $2014
endproc Item_ValidateTypeData 8 12
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 4303
;4287:
;4288:/*
;4289:===============
;4290:Keyword Hash
;4291:===============
;4292:*/
;4293:
;4294:#define KEYWORDHASH_SIZE	512
;4295:
;4296:typedef struct keywordHash_s
;4297:{
;4298:	char *keyword;
;4299:	qboolean (*func)(itemDef_t *item, int handle);
;4300:	struct keywordHash_s *next;
;4301:} keywordHash_t;
;4302:
;4303:int KeywordHash_Key(char *keyword) {
line 4306
;4304:	int register hash, i;
;4305:
;4306:	hash = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4307
;4307:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2038
JUMPV
LABELV $2035
line 4308
;4308:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $2039
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $2039
line 4309
;4309:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $2040
JUMPV
LABELV $2039
line 4311
;4310:		else
;4311:			hash += keyword[i] * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $2040
line 4312
;4312:	}
LABELV $2036
line 4307
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2038
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2035
line 4313
;4313:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE-1);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 0
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 4314
;4314:	return hash;
ADDRLP4 0
INDIRI4
RETI4
LABELV $2034
endproc KeywordHash_Key 20 0
export KeywordHash_Add
proc KeywordHash_Add 8 4
line 4317
;4315:}
;4316:
;4317:void KeywordHash_Add(keywordHash_t *table[], keywordHash_t *key) {
line 4320
;4318:	int hash;
;4319:
;4320:	hash = KeywordHash_Key(key->keyword);
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 4326
;4321:/*
;4322:	if (table[hash]) {
;4323:		int collision = qtrue;
;4324:	}
;4325:*/
;4326:	key->next = table[hash];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 4327
;4327:	table[hash] = key;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 4328
;4328:}
LABELV $2041
endproc KeywordHash_Add 8 4
export KeywordHash_Find
proc KeywordHash_Find 16 8
line 4331
;4329:
;4330:keywordHash_t *KeywordHash_Find(keywordHash_t *table[], char *keyword)
;4331:{
line 4335
;4332:	keywordHash_t *key;
;4333:	int hash;
;4334:
;4335:	hash = KeywordHash_Key(keyword);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 4336
;4336:	for (key = table[hash]; key; key = key->next) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2046
JUMPV
LABELV $2043
line 4337
;4337:		if (!Q_stricmp(key->keyword, keyword))
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2047
line 4338
;4338:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $2042
JUMPV
LABELV $2047
line 4339
;4339:	}
LABELV $2044
line 4336
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $2046
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2043
line 4340
;4340:	return NULL;
CNSTP4 0
RETP4
LABELV $2042
endproc KeywordHash_Find 16 8
export ItemParse_name
proc ItemParse_name 4 8
line 4350
;4341:}
;4342:
;4343:/*
;4344:===============
;4345:Item Keyword Parse functions
;4346:===============
;4347:*/
;4348:
;4349:// name <string>
;4350:qboolean ItemParse_name( itemDef_t *item, int handle ) {
line 4351
;4351:	if (!PC_String_Parse(handle, &item->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2050
line 4352
;4352:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2049
JUMPV
LABELV $2050
line 4354
;4353:	}
;4354:	return qtrue;
CNSTI4 1
RETI4
LABELV $2049
endproc ItemParse_name 4 8
export ItemParse_focusSound
proc ItemParse_focusSound 12 8
line 4358
;4355:}
;4356:
;4357:// name <string>
;4358:qboolean ItemParse_focusSound( itemDef_t *item, int handle ) {
line 4360
;4359:	const char *temp;
;4360:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2053
line 4361
;4361:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2052
JUMPV
LABELV $2053
line 4363
;4362:	}
;4363:	item->focusSound = DC->registerSound(temp, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4364
;4364:	return qtrue;
CNSTI4 1
RETI4
LABELV $2052
endproc ItemParse_focusSound 12 8
export ItemParse_text
proc ItemParse_text 4 8
line 4369
;4365:}
;4366:
;4367:
;4368:// text <string>
;4369:qboolean ItemParse_text( itemDef_t *item, int handle ) {
line 4370
;4370:	if (!PC_String_Parse(handle, &item->text)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2056
line 4371
;4371:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2055
JUMPV
LABELV $2056
line 4373
;4372:	}
;4373:	return qtrue;
CNSTI4 1
RETI4
LABELV $2055
endproc ItemParse_text 4 8
export ItemParse_group
proc ItemParse_group 4 8
line 4377
;4374:}
;4375:
;4376:// group <string>
;4377:qboolean ItemParse_group( itemDef_t *item, int handle ) {
line 4378
;4378:	if (!PC_String_Parse(handle, &item->window.group)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2059
line 4379
;4379:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2058
JUMPV
LABELV $2059
line 4381
;4380:	}
;4381:	return qtrue;
CNSTI4 1
RETI4
LABELV $2058
endproc ItemParse_group 4 8
export ItemParse_asset_model
proc ItemParse_asset_model 20 8
line 4385
;4382:}
;4383:
;4384:// asset_model <string>
;4385:qboolean ItemParse_asset_model( itemDef_t *item, int handle ) {
line 4388
;4386:	const char *temp;
;4387:	modelDef_t *modelPtr;
;4388:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4389
;4389:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4391
;4390:
;4391:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2062
line 4392
;4392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2061
JUMPV
LABELV $2062
line 4394
;4393:	}
;4394:	item->asset = DC->registerModel(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4395
;4395:	modelPtr->angle = rand() % 360;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 360
MODI4
ASGNI4
line 4396
;4396:	return qtrue;
CNSTI4 1
RETI4
LABELV $2061
endproc ItemParse_asset_model 20 8
export ItemParse_asset_shader
proc ItemParse_asset_shader 12 8
line 4400
;4397:}
;4398:
;4399:// asset_shader <string>
;4400:qboolean ItemParse_asset_shader( itemDef_t *item, int handle ) {
line 4403
;4401:	const char *temp;
;4402:
;4403:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2065
line 4404
;4404:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2064
JUMPV
LABELV $2065
line 4406
;4405:	}
;4406:	item->asset = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4407
;4407:	return qtrue;
CNSTI4 1
RETI4
LABELV $2064
endproc ItemParse_asset_shader 12 8
export ItemParse_model_origin
proc ItemParse_model_origin 16 8
line 4411
;4408:}
;4409:
;4410:// model_origin <number> <number> <number>
;4411:qboolean ItemParse_model_origin( itemDef_t *item, int handle ) {
line 4413
;4412:	modelDef_t *modelPtr;
;4413:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4414
;4414:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4416
;4415:
;4416:	if (PC_Float_Parse(handle, &modelPtr->origin[0])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2068
line 4417
;4417:		if (PC_Float_Parse(handle, &modelPtr->origin[1])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2070
line 4418
;4418:			if (PC_Float_Parse(handle, &modelPtr->origin[2])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2072
line 4419
;4419:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2067
JUMPV
LABELV $2072
line 4421
;4420:			}
;4421:		}
LABELV $2070
line 4422
;4422:	}
LABELV $2068
line 4423
;4423:	return qfalse;
CNSTI4 0
RETI4
LABELV $2067
endproc ItemParse_model_origin 16 8
export ItemParse_model_fovx
proc ItemParse_model_fovx 8 8
line 4427
;4424:}
;4425:
;4426:// model_fovx <number>
;4427:qboolean ItemParse_model_fovx( itemDef_t *item, int handle ) {
line 4429
;4428:	modelDef_t *modelPtr;
;4429:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4430
;4430:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4432
;4431:
;4432:	if (!PC_Float_Parse(handle, &modelPtr->fov_x)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2075
line 4433
;4433:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2074
JUMPV
LABELV $2075
line 4435
;4434:	}
;4435:	return qtrue;
CNSTI4 1
RETI4
LABELV $2074
endproc ItemParse_model_fovx 8 8
export ItemParse_model_fovy
proc ItemParse_model_fovy 8 8
line 4439
;4436:}
;4437:
;4438:// model_fovy <number>
;4439:qboolean ItemParse_model_fovy( itemDef_t *item, int handle ) {
line 4441
;4440:	modelDef_t *modelPtr;
;4441:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4442
;4442:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4444
;4443:
;4444:	if (!PC_Float_Parse(handle, &modelPtr->fov_y)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2078
line 4445
;4445:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2077
JUMPV
LABELV $2078
line 4447
;4446:	}
;4447:	return qtrue;
CNSTI4 1
RETI4
LABELV $2077
endproc ItemParse_model_fovy 8 8
export ItemParse_model_rotation
proc ItemParse_model_rotation 8 8
line 4451
;4448:}
;4449:
;4450:// model_rotation <integer>
;4451:qboolean ItemParse_model_rotation( itemDef_t *item, int handle ) {
line 4453
;4452:	modelDef_t *modelPtr;
;4453:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4454
;4454:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4456
;4455:
;4456:	if (!PC_Int_Parse(handle, &modelPtr->rotationSpeed)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2081
line 4457
;4457:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2080
JUMPV
LABELV $2081
line 4459
;4458:	}
;4459:	return qtrue;
CNSTI4 1
RETI4
LABELV $2080
endproc ItemParse_model_rotation 8 8
export ItemParse_model_angle
proc ItemParse_model_angle 8 8
line 4463
;4460:}
;4461:
;4462:// model_angle <integer>
;4463:qboolean ItemParse_model_angle( itemDef_t *item, int handle ) {
line 4465
;4464:	modelDef_t *modelPtr;
;4465:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4466
;4466:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4468
;4467:
;4468:	if (!PC_Int_Parse(handle, &modelPtr->angle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2084
line 4469
;4469:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2083
JUMPV
LABELV $2084
line 4471
;4470:	}
;4471:	return qtrue;
CNSTI4 1
RETI4
LABELV $2083
endproc ItemParse_model_angle 8 8
export ItemParse_rect
proc ItemParse_rect 4 8
line 4475
;4472:}
;4473:
;4474:// rect <rectangle>
;4475:qboolean ItemParse_rect( itemDef_t *item, int handle ) {
line 4476
;4476:	if (!PC_Rect_Parse(handle, &item->window.rectClient)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2087
line 4477
;4477:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2086
JUMPV
LABELV $2087
line 4479
;4478:	}
;4479:	return qtrue;
CNSTI4 1
RETI4
LABELV $2086
endproc ItemParse_rect 4 8
export ItemParse_style
proc ItemParse_style 4 8
line 4483
;4480:}
;4481:
;4482:// style <integer>
;4483:qboolean ItemParse_style( itemDef_t *item, int handle ) {
line 4484
;4484:	if (!PC_Int_Parse(handle, &item->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2090
line 4485
;4485:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2089
JUMPV
LABELV $2090
line 4487
;4486:	}
;4487:	return qtrue;
CNSTI4 1
RETI4
LABELV $2089
endproc ItemParse_style 4 8
export ItemParse_decoration
proc ItemParse_decoration 4 0
line 4491
;4488:}
;4489:
;4490:// decoration
;4491:qboolean ItemParse_decoration( itemDef_t *item, int handle ) {
line 4492
;4492:	item->window.flags |= WINDOW_DECORATION;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 4493
;4493:	return qtrue;
CNSTI4 1
RETI4
LABELV $2092
endproc ItemParse_decoration 4 0
export ItemParse_notselectable
proc ItemParse_notselectable 4 4
line 4497
;4494:}
;4495:
;4496:// notselectable
;4497:qboolean ItemParse_notselectable( itemDef_t *item, int handle ) {
line 4499
;4498:	listBoxDef_t *listPtr;
;4499:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4500
;4500:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4501
;4501:	if (item->type == ITEM_TYPE_LISTBOX && listPtr) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2094
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2094
line 4502
;4502:		listPtr->notselectable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 4503
;4503:	}
LABELV $2094
line 4504
;4504:	return qtrue;
CNSTI4 1
RETI4
LABELV $2093
endproc ItemParse_notselectable 4 4
export ItemParse_wrapped
proc ItemParse_wrapped 4 0
line 4508
;4505:}
;4506:
;4507:// manually wrapped
;4508:qboolean ItemParse_wrapped( itemDef_t *item, int handle ) {
line 4509
;4509:	item->window.flags |= WINDOW_WRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 4510
;4510:	return qtrue;
CNSTI4 1
RETI4
LABELV $2096
endproc ItemParse_wrapped 4 0
export ItemParse_autowrapped
proc ItemParse_autowrapped 4 0
line 4514
;4511:}
;4512:
;4513:// auto wrapped
;4514:qboolean ItemParse_autowrapped( itemDef_t *item, int handle ) {
line 4515
;4515:	item->window.flags |= WINDOW_AUTOWRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 4516
;4516:	return qtrue;
CNSTI4 1
RETI4
LABELV $2097
endproc ItemParse_autowrapped 4 0
export ItemParse_horizontalscroll
proc ItemParse_horizontalscroll 4 0
line 4521
;4517:}
;4518:
;4519:
;4520:// horizontalscroll
;4521:qboolean ItemParse_horizontalscroll( itemDef_t *item, int handle ) {
line 4522
;4522:	item->window.flags |= WINDOW_HORIZONTAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4523
;4523:	return qtrue;
CNSTI4 1
RETI4
LABELV $2098
endproc ItemParse_horizontalscroll 4 0
export ItemParse_type
proc ItemParse_type 4 8
line 4527
;4524:}
;4525:
;4526:// type <integer>
;4527:qboolean ItemParse_type( itemDef_t *item, int handle ) {
line 4528
;4528:	if (!PC_Int_Parse(handle, &item->type)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2100
line 4529
;4529:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2099
JUMPV
LABELV $2100
line 4531
;4530:	}
;4531:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4532
;4532:	return qtrue;
CNSTI4 1
RETI4
LABELV $2099
endproc ItemParse_type 4 8
export ItemParse_elementwidth
proc ItemParse_elementwidth 8 8
line 4537
;4533:}
;4534:
;4535:// elementwidth, used for listbox image elements
;4536:// uses textalignx for storage
;4537:qboolean ItemParse_elementwidth( itemDef_t *item, int handle ) {
line 4540
;4538:	listBoxDef_t *listPtr;
;4539:
;4540:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4541
;4541:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4542
;4542:	if (!PC_Float_Parse(handle, &listPtr->elementWidth)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2103
line 4543
;4543:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2102
JUMPV
LABELV $2103
line 4545
;4544:	}
;4545:	return qtrue;
CNSTI4 1
RETI4
LABELV $2102
endproc ItemParse_elementwidth 8 8
export ItemParse_elementheight
proc ItemParse_elementheight 8 8
line 4550
;4546:}
;4547:
;4548:// elementheight, used for listbox image elements
;4549:// uses textaligny for storage
;4550:qboolean ItemParse_elementheight( itemDef_t *item, int handle ) {
line 4553
;4551:	listBoxDef_t *listPtr;
;4552:
;4553:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4554
;4554:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4555
;4555:	if (!PC_Float_Parse(handle, &listPtr->elementHeight)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2106
line 4556
;4556:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2105
JUMPV
LABELV $2106
line 4558
;4557:	}
;4558:	return qtrue;
CNSTI4 1
RETI4
LABELV $2105
endproc ItemParse_elementheight 8 8
export ItemParse_feeder
proc ItemParse_feeder 4 8
line 4562
;4559:}
;4560:
;4561:// feeder <float>
;4562:qboolean ItemParse_feeder( itemDef_t *item, int handle ) {
line 4563
;4563:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2109
line 4564
;4564:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2108
JUMPV
LABELV $2109
line 4566
;4565:	}
;4566:	return qtrue;
CNSTI4 1
RETI4
LABELV $2108
endproc ItemParse_feeder 4 8
export ItemParse_elementtype
proc ItemParse_elementtype 8 8
line 4571
;4567:}
;4568:
;4569:// elementtype, used to specify what type of elements a listbox contains
;4570:// uses textstyle for storage
;4571:qboolean ItemParse_elementtype( itemDef_t *item, int handle ) {
line 4574
;4572:	listBoxDef_t *listPtr;
;4573:
;4574:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4575
;4575:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2112
line 4576
;4576:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2111
JUMPV
LABELV $2112
line 4577
;4577:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4578
;4578:	if (!PC_Int_Parse(handle, &listPtr->elementStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2114
line 4579
;4579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2111
JUMPV
LABELV $2114
line 4581
;4580:	}
;4581:	return qtrue;
CNSTI4 1
RETI4
LABELV $2111
endproc ItemParse_elementtype 8 8
export ItemParse_columns
proc ItemParse_columns 40 8
line 4585
;4582:}
;4583:
;4584:// columns sets a number of columns and an x pos and width per.. 
;4585:qboolean ItemParse_columns( itemDef_t *item, int handle ) {
line 4589
;4586:	int num, i;
;4587:	listBoxDef_t *listPtr;
;4588:
;4589:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4590
;4590:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2117
line 4591
;4591:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2116
JUMPV
LABELV $2117
line 4592
;4592:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4593
;4593:	if (PC_Int_Parse(handle, &num)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2119
line 4594
;4594:		if (num > MAX_LB_COLUMNS) {
ADDRLP4 8
INDIRI4
CNSTI4 16
LEI4 $2121
line 4595
;4595:			num = MAX_LB_COLUMNS;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 4596
;4596:		}
LABELV $2121
line 4597
;4597:		listPtr->numColumns = num;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4598
;4598:		for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2126
JUMPV
LABELV $2123
line 4601
;4599:			int pos, width, maxChars;
;4600:
;4601:			if (PC_Int_Parse(handle, &pos) && PC_Int_Parse(handle, &width) && PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2127
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 32
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2127
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2127
line 4602
;4602:				listPtr->columnInfo[i].pos = pos;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4603
;4603:				listPtr->columnInfo[i].width = width;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 4604
;4604:				listPtr->columnInfo[i].maxChars = maxChars;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 4605
;4605:			} else {
ADDRGP4 $2128
JUMPV
LABELV $2127
line 4606
;4606:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2116
JUMPV
LABELV $2128
line 4608
;4607:			}
;4608:		}
LABELV $2124
line 4598
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2126
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2123
line 4609
;4609:	} else {
ADDRGP4 $2120
JUMPV
LABELV $2119
line 4610
;4610:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2116
JUMPV
LABELV $2120
line 4612
;4611:	}
;4612:	return qtrue;
CNSTI4 1
RETI4
LABELV $2116
endproc ItemParse_columns 40 8
export ItemParse_border
proc ItemParse_border 4 8
line 4615
;4613:}
;4614:
;4615:qboolean ItemParse_border( itemDef_t *item, int handle ) {
line 4616
;4616:	if (!PC_Int_Parse(handle, &item->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2130
line 4617
;4617:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2129
JUMPV
LABELV $2130
line 4619
;4618:	}
;4619:	return qtrue;
CNSTI4 1
RETI4
LABELV $2129
endproc ItemParse_border 4 8
export ItemParse_bordersize
proc ItemParse_bordersize 4 8
line 4622
;4620:}
;4621:
;4622:qboolean ItemParse_bordersize( itemDef_t *item, int handle ) {
line 4623
;4623:	if (!PC_Float_Parse(handle, &item->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2133
line 4624
;4624:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2132
JUMPV
LABELV $2133
line 4626
;4625:	}
;4626:	return qtrue;
CNSTI4 1
RETI4
LABELV $2132
endproc ItemParse_bordersize 4 8
export ItemParse_visible
proc ItemParse_visible 12 8
line 4629
;4627:}
;4628:
;4629:qboolean ItemParse_visible( itemDef_t *item, int handle ) {
line 4632
;4630:	int i;
;4631:
;4632:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2136
line 4633
;4633:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2135
JUMPV
LABELV $2136
line 4635
;4634:	}
;4635:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2138
line 4636
;4636:		item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 4637
;4637:	}
LABELV $2138
line 4638
;4638:	return qtrue;
CNSTI4 1
RETI4
LABELV $2135
endproc ItemParse_visible 12 8
export ItemParse_ownerdraw
proc ItemParse_ownerdraw 4 8
line 4641
;4639:}
;4640:
;4641:qboolean ItemParse_ownerdraw( itemDef_t *item, int handle ) {
line 4642
;4642:	if (!PC_Int_Parse(handle, &item->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2141
line 4643
;4643:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2140
JUMPV
LABELV $2141
line 4645
;4644:	}
;4645:	item->type = ITEM_TYPE_OWNERDRAW;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 8
ASGNI4
line 4646
;4646:	return qtrue;
CNSTI4 1
RETI4
LABELV $2140
endproc ItemParse_ownerdraw 4 8
export ItemParse_align
proc ItemParse_align 4 8
line 4649
;4647:}
;4648:
;4649:qboolean ItemParse_align( itemDef_t *item, int handle ) {
line 4650
;4650:	if (!PC_Int_Parse(handle, &item->alignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2144
line 4651
;4651:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2143
JUMPV
LABELV $2144
line 4653
;4652:	}
;4653:	return qtrue;
CNSTI4 1
RETI4
LABELV $2143
endproc ItemParse_align 4 8
export ItemParse_textalign
proc ItemParse_textalign 4 8
line 4656
;4654:}
;4655:
;4656:qboolean ItemParse_textalign( itemDef_t *item, int handle ) {
line 4657
;4657:	if (!PC_Int_Parse(handle, &item->textalignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2147
line 4658
;4658:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2146
JUMPV
LABELV $2147
line 4660
;4659:	}
;4660:	return qtrue;
CNSTI4 1
RETI4
LABELV $2146
endproc ItemParse_textalign 4 8
export ItemParse_textalignx
proc ItemParse_textalignx 4 8
line 4663
;4661:}
;4662:
;4663:qboolean ItemParse_textalignx( itemDef_t *item, int handle ) {
line 4664
;4664:	if (!PC_Float_Parse(handle, &item->textalignx)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2150
line 4665
;4665:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2149
JUMPV
LABELV $2150
line 4667
;4666:	}
;4667:	return qtrue;
CNSTI4 1
RETI4
LABELV $2149
endproc ItemParse_textalignx 4 8
export ItemParse_textaligny
proc ItemParse_textaligny 4 8
line 4670
;4668:}
;4669:
;4670:qboolean ItemParse_textaligny( itemDef_t *item, int handle ) {
line 4671
;4671:	if (!PC_Float_Parse(handle, &item->textaligny)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2153
line 4672
;4672:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2152
JUMPV
LABELV $2153
line 4674
;4673:	}
;4674:	return qtrue;
CNSTI4 1
RETI4
LABELV $2152
endproc ItemParse_textaligny 4 8
export ItemParse_textscale
proc ItemParse_textscale 4 8
line 4677
;4675:}
;4676:
;4677:qboolean ItemParse_textscale( itemDef_t *item, int handle ) {
line 4678
;4678:	if (!PC_Float_Parse(handle, &item->textscale)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2156
line 4679
;4679:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2155
JUMPV
LABELV $2156
line 4681
;4680:	}
;4681:	return qtrue;
CNSTI4 1
RETI4
LABELV $2155
endproc ItemParse_textscale 4 8
export ItemParse_textstyle
proc ItemParse_textstyle 4 8
line 4684
;4682:}
;4683:
;4684:qboolean ItemParse_textstyle( itemDef_t *item, int handle ) {
line 4685
;4685:	if (!PC_Int_Parse(handle, &item->textStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2159
line 4686
;4686:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2158
JUMPV
LABELV $2159
line 4688
;4687:	}
;4688:	return qtrue;
CNSTI4 1
RETI4
LABELV $2158
endproc ItemParse_textstyle 4 8
export ItemParse_backcolor
proc ItemParse_backcolor 12 8
line 4691
;4689:}
;4690:
;4691:qboolean ItemParse_backcolor( itemDef_t *item, int handle ) {
line 4695
;4692:	int i;
;4693:	float f;
;4694:
;4695:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2162
line 4696
;4696:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2166
line 4697
;4697:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2161
JUMPV
LABELV $2166
line 4699
;4698:		}
;4699:		item->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4700
;4700:	}
LABELV $2163
line 4695
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2162
line 4701
;4701:	return qtrue;
CNSTI4 1
RETI4
LABELV $2161
endproc ItemParse_backcolor 12 8
export ItemParse_forecolor
proc ItemParse_forecolor 16 8
line 4704
;4702:}
;4703:
;4704:qboolean ItemParse_forecolor( itemDef_t *item, int handle ) {
line 4708
;4705:	int i;
;4706:	float f;
;4707:
;4708:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2169
line 4709
;4709:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2173
line 4710
;4710:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2168
JUMPV
LABELV $2173
line 4712
;4711:		}
;4712:		item->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4713
;4713:		item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 4714
;4714:	}
LABELV $2170
line 4708
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2169
line 4715
;4715:	return qtrue;
CNSTI4 1
RETI4
LABELV $2168
endproc ItemParse_forecolor 16 8
export ItemParse_bordercolor
proc ItemParse_bordercolor 12 8
line 4718
;4716:}
;4717:
;4718:qboolean ItemParse_bordercolor( itemDef_t *item, int handle ) {
line 4722
;4719:	int i;
;4720:	float f;
;4721:
;4722:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2176
line 4723
;4723:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2180
line 4724
;4724:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2175
JUMPV
LABELV $2180
line 4726
;4725:		}
;4726:		item->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4727
;4727:	}
LABELV $2177
line 4722
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2176
line 4728
;4728:	return qtrue;
CNSTI4 1
RETI4
LABELV $2175
endproc ItemParse_bordercolor 12 8
export ItemParse_outlinecolor
proc ItemParse_outlinecolor 4 8
line 4731
;4729:}
;4730:
;4731:qboolean ItemParse_outlinecolor( itemDef_t *item, int handle ) {
line 4732
;4732:	if (!PC_Color_Parse(handle, &item->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2183
line 4733
;4733:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2182
JUMPV
LABELV $2183
line 4735
;4734:	}
;4735:	return qtrue;
CNSTI4 1
RETI4
LABELV $2182
endproc ItemParse_outlinecolor 4 8
export ItemParse_background
proc ItemParse_background 12 8
line 4738
;4736:}
;4737:
;4738:qboolean ItemParse_background( itemDef_t *item, int handle ) {
line 4741
;4739:	const char *temp;
;4740:
;4741:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2186
line 4742
;4742:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2185
JUMPV
LABELV $2186
line 4744
;4743:	}
;4744:	item->window.background = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4745
;4745:	return qtrue;
CNSTI4 1
RETI4
LABELV $2185
endproc ItemParse_background 12 8
export ItemParse_cinematic
proc ItemParse_cinematic 4 8
line 4748
;4746:}
;4747:
;4748:qboolean ItemParse_cinematic( itemDef_t *item, int handle ) {
line 4749
;4749:	if (!PC_String_Parse(handle, &item->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2189
line 4750
;4750:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2188
JUMPV
LABELV $2189
line 4752
;4751:	}
;4752:	return qtrue;
CNSTI4 1
RETI4
LABELV $2188
endproc ItemParse_cinematic 4 8
export ItemParse_doubleClick
proc ItemParse_doubleClick 8 8
line 4755
;4753:}
;4754:
;4755:qboolean ItemParse_doubleClick( itemDef_t *item, int handle ) {
line 4758
;4756:	listBoxDef_t *listPtr;
;4757:
;4758:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4759
;4759:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2192
line 4760
;4760:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2191
JUMPV
LABELV $2192
line 4763
;4761:	}
;4762:
;4763:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4765
;4764:
;4765:	if (!PC_Script_Parse(handle, &listPtr->doubleClick)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2194
line 4766
;4766:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2191
JUMPV
LABELV $2194
line 4768
;4767:	}
;4768:	return qtrue;
CNSTI4 1
RETI4
LABELV $2191
endproc ItemParse_doubleClick 8 8
export ItemParse_onFocus
proc ItemParse_onFocus 4 8
line 4771
;4769:}
;4770:
;4771:qboolean ItemParse_onFocus( itemDef_t *item, int handle ) {
line 4772
;4772:	if (!PC_Script_Parse(handle, &item->onFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2197
line 4773
;4773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2196
JUMPV
LABELV $2197
line 4775
;4774:	}
;4775:	return qtrue;
CNSTI4 1
RETI4
LABELV $2196
endproc ItemParse_onFocus 4 8
export ItemParse_leaveFocus
proc ItemParse_leaveFocus 4 8
line 4778
;4776:}
;4777:
;4778:qboolean ItemParse_leaveFocus( itemDef_t *item, int handle ) {
line 4779
;4779:	if (!PC_Script_Parse(handle, &item->leaveFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2200
line 4780
;4780:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2199
JUMPV
LABELV $2200
line 4782
;4781:	}
;4782:	return qtrue;
CNSTI4 1
RETI4
LABELV $2199
endproc ItemParse_leaveFocus 4 8
export ItemParse_mouseEnter
proc ItemParse_mouseEnter 4 8
line 4785
;4783:}
;4784:
;4785:qboolean ItemParse_mouseEnter( itemDef_t *item, int handle ) {
line 4786
;4786:	if (!PC_Script_Parse(handle, &item->mouseEnter)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2203
line 4787
;4787:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2202
JUMPV
LABELV $2203
line 4789
;4788:	}
;4789:	return qtrue;
CNSTI4 1
RETI4
LABELV $2202
endproc ItemParse_mouseEnter 4 8
export ItemParse_mouseExit
proc ItemParse_mouseExit 4 8
line 4792
;4790:}
;4791:
;4792:qboolean ItemParse_mouseExit( itemDef_t *item, int handle ) {
line 4793
;4793:	if (!PC_Script_Parse(handle, &item->mouseExit)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2206
line 4794
;4794:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2205
JUMPV
LABELV $2206
line 4796
;4795:	}
;4796:	return qtrue;
CNSTI4 1
RETI4
LABELV $2205
endproc ItemParse_mouseExit 4 8
export ItemParse_mouseEnterText
proc ItemParse_mouseEnterText 4 8
line 4799
;4797:}
;4798:
;4799:qboolean ItemParse_mouseEnterText( itemDef_t *item, int handle ) {
line 4800
;4800:	if (!PC_Script_Parse(handle, &item->mouseEnterText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2209
line 4801
;4801:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2208
JUMPV
LABELV $2209
line 4803
;4802:	}
;4803:	return qtrue;
CNSTI4 1
RETI4
LABELV $2208
endproc ItemParse_mouseEnterText 4 8
export ItemParse_mouseExitText
proc ItemParse_mouseExitText 4 8
line 4806
;4804:}
;4805:
;4806:qboolean ItemParse_mouseExitText( itemDef_t *item, int handle ) {
line 4807
;4807:	if (!PC_Script_Parse(handle, &item->mouseExitText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2212
line 4808
;4808:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2211
JUMPV
LABELV $2212
line 4810
;4809:	}
;4810:	return qtrue;
CNSTI4 1
RETI4
LABELV $2211
endproc ItemParse_mouseExitText 4 8
export ItemParse_action
proc ItemParse_action 4 8
line 4813
;4811:}
;4812:
;4813:qboolean ItemParse_action( itemDef_t *item, int handle ) {
line 4814
;4814:	if (!PC_Script_Parse(handle, &item->action)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2215
line 4815
;4815:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2214
JUMPV
LABELV $2215
line 4817
;4816:	}
;4817:	return qtrue;
CNSTI4 1
RETI4
LABELV $2214
endproc ItemParse_action 4 8
export ItemParse_special
proc ItemParse_special 4 8
line 4820
;4818:}
;4819:
;4820:qboolean ItemParse_special( itemDef_t *item, int handle ) {
line 4821
;4821:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2218
line 4822
;4822:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2217
JUMPV
LABELV $2218
line 4824
;4823:	}
;4824:	return qtrue;
CNSTI4 1
RETI4
LABELV $2217
endproc ItemParse_special 4 8
export ItemParse_cvarTest
proc ItemParse_cvarTest 4 8
line 4827
;4825:}
;4826:
;4827:qboolean ItemParse_cvarTest( itemDef_t *item, int handle ) {
line 4828
;4828:	if (!PC_String_Parse(handle, &item->cvarTest)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2221
line 4829
;4829:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2220
JUMPV
LABELV $2221
line 4831
;4830:	}
;4831:	return qtrue;
CNSTI4 1
RETI4
LABELV $2220
endproc ItemParse_cvarTest 4 8
export ItemParse_cvar
proc ItemParse_cvar 8 8
line 4834
;4832:}
;4833:
;4834:qboolean ItemParse_cvar( itemDef_t *item, int handle ) {
line 4837
;4835:	editFieldDef_t *editPtr;
;4836:
;4837:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4838
;4838:	if (!PC_String_Parse(handle, &item->cvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2224
line 4839
;4839:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2223
JUMPV
LABELV $2224
line 4841
;4840:	}
;4841:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2226
line 4842
;4842:		editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4843
;4843:		editPtr->minVal = -1;
ADDRLP4 0
INDIRP4
CNSTF4 3212836864
ASGNF4
line 4844
;4844:		editPtr->maxVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 4845
;4845:		editPtr->defVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 4846
;4846:	}
LABELV $2226
line 4847
;4847:	return qtrue;
CNSTI4 1
RETI4
LABELV $2223
endproc ItemParse_cvar 8 8
export ItemParse_maxChars
proc ItemParse_maxChars 12 8
line 4850
;4848:}
;4849:
;4850:qboolean ItemParse_maxChars( itemDef_t *item, int handle ) {
line 4854
;4851:	editFieldDef_t *editPtr;
;4852:	int maxChars;
;4853:
;4854:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4855
;4855:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2229
line 4856
;4856:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2228
JUMPV
LABELV $2229
line 4858
;4857:
;4858:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2231
line 4859
;4859:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2228
JUMPV
LABELV $2231
line 4861
;4860:	}
;4861:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4862
;4862:	editPtr->maxChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4863
;4863:	return qtrue;
CNSTI4 1
RETI4
LABELV $2228
endproc ItemParse_maxChars 12 8
export ItemParse_maxPaintChars
proc ItemParse_maxPaintChars 12 8
line 4866
;4864:}
;4865:
;4866:qboolean ItemParse_maxPaintChars( itemDef_t *item, int handle ) {
line 4870
;4867:	editFieldDef_t *editPtr;
;4868:	int maxChars;
;4869:
;4870:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4871
;4871:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2234
line 4872
;4872:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2234
line 4874
;4873:
;4874:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2236
line 4875
;4875:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2236
line 4877
;4876:	}
;4877:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4878
;4878:	editPtr->maxPaintChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4879
;4879:	return qtrue;
CNSTI4 1
RETI4
LABELV $2233
endproc ItemParse_maxPaintChars 12 8
export ItemParse_cvarFloat
proc ItemParse_cvarFloat 20 8
line 4884
;4880:}
;4881:
;4882:
;4883:
;4884:qboolean ItemParse_cvarFloat( itemDef_t *item, int handle ) {
line 4887
;4885:	editFieldDef_t *editPtr;
;4886:
;4887:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4888
;4888:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2239
line 4889
;4889:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2238
JUMPV
LABELV $2239
line 4890
;4890:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4891
;4891:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2241
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2241
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2241
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2241
line 4894
;4892:		PC_Float_Parse(handle, &editPtr->defVal) &&
;4893:		PC_Float_Parse(handle, &editPtr->minVal) &&
;4894:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 4895
;4895:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2238
JUMPV
LABELV $2241
line 4897
;4896:	}
;4897:	return qfalse;
CNSTI4 0
RETI4
LABELV $2238
endproc ItemParse_cvarFloat 20 8
export ItemParse_cvarStrList
proc ItemParse_cvarStrList 1068 8
line 4900
;4898:}
;4899:
;4900:qboolean ItemParse_cvarStrList( itemDef_t *item, int handle ) {
line 4905
;4901:	pc_token_t token;
;4902:	multiDef_t *multiPtr;
;4903:	int pass;
;4904:	
;4905:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4906
;4906:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2244
line 4907
;4907:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2244
line 4908
;4908:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4909
;4909:	multiPtr->count = 0;
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4910
;4910:	multiPtr->strDef = qtrue;
ADDRLP4 1040
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 4912
;4911:
;4912:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2246
line 4913
;4913:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2246
line 4914
;4914:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2248
line 4915
;4915:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2248
line 4918
;4916:	}
;4917:
;4918:	pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRGP4 $2252
JUMPV
LABELV $2251
line 4919
;4919:	while ( 1 ) {
line 4920
;4920:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2254
line 4921
;4921:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2256
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4922
;4922:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2254
line 4925
;4923:		}
;4924:
;4925:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2257
line 4926
;4926:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2257
line 4929
;4927:		}
;4928:
;4929:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2264
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2260
LABELV $2264
line 4930
;4930:			continue;
ADDRGP4 $2252
JUMPV
LABELV $2260
line 4933
;4931:		}
;4932:
;4933:		if (pass == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2265
line 4934
;4934:			multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 4935
;4935:			pass = 1;
ADDRLP4 1044
CNSTI4 1
ASGNI4
line 4936
;4936:		} else {
ADDRGP4 $2266
JUMPV
LABELV $2265
line 4937
;4937:			multiPtr->cvarStr[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 4938
;4938:			pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 4939
;4939:			multiPtr->count++;
ADDRLP4 1064
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4940
;4940:			if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2269
line 4941
;4941:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2269
line 4943
;4942:			}
;4943:		}
LABELV $2266
line 4945
;4944:
;4945:	}
LABELV $2252
line 4919
ADDRGP4 $2251
JUMPV
line 4946
;4946:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2243
endproc ItemParse_cvarStrList 1068 8
export ItemParse_cvarFloatList
proc ItemParse_cvarFloatList 1072 8
line 4949
;4947:}
;4948:
;4949:qboolean ItemParse_cvarFloatList( itemDef_t *item, int handle ) {
line 4953
;4950:	pc_token_t token;
;4951:	multiDef_t *multiPtr;
;4952:	
;4953:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4954
;4954:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2272
line 4955
;4955:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2272
line 4956
;4956:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4957
;4957:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4958
;4958:	multiPtr->strDef = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 4960
;4959:
;4960:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2274
line 4961
;4961:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2274
line 4962
;4962:	if (*token.string != '{') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2280
line 4963
;4963:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2279
line 4966
;4964:	}
;4965:
;4966:	while ( 1 ) {
line 4967
;4967:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2282
line 4968
;4968:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2256
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4969
;4969:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2282
line 4972
;4970:		}
;4971:
;4972:		if (*token.string == '}') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2284
line 4973
;4973:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2284
line 4976
;4974:		}
;4975:
;4976:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2291
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2287
LABELV $2291
line 4977
;4977:			continue;
ADDRGP4 $2280
JUMPV
LABELV $2287
line 4980
;4978:		}
;4979:
;4980:		multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 4+16
ARGP4
ADDRLP4 1052
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 1052
INDIRP4
ASGNP4
line 4981
;4981:		if (!PC_Float_Parse(handle, &multiPtr->cvarValue[multiPtr->count])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ARGP4
ADDRLP4 1064
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2293
line 4982
;4982:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2293
line 4985
;4983:		}
;4984:
;4985:		multiPtr->count++;
ADDRLP4 1068
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4986
;4986:		if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2295
line 4987
;4987:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2271
JUMPV
LABELV $2295
line 4990
;4988:		}
;4989:
;4990:	}
LABELV $2280
line 4966
ADDRGP4 $2279
JUMPV
line 4991
;4991:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2271
endproc ItemParse_cvarFloatList 1072 8
export ItemParse_addColorRange
proc ItemParse_addColorRange 48 12
line 4996
;4992:}
;4993:
;4994:
;4995:
;4996:qboolean ItemParse_addColorRange( itemDef_t *item, int handle ) {
line 4999
;4997:	colorRangeDef_t color;
;4998:
;4999:	if (PC_Float_Parse(handle, &color.low) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+16
ARGP4
ADDRLP4 24
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2298
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRLP4 28
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2298
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2298
line 5001
;5000:		PC_Float_Parse(handle, &color.high) &&
;5001:		PC_Color_Parse(handle, &color.color) ) {
line 5002
;5002:		if (item->numColors < MAX_COLOR_RANGES) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 10
GEI4 $2302
line 5003
;5003:			memcpy(&item->colorRanges[item->numColors], &color, sizeof(color));
ADDRLP4 36
CNSTI4 24
ASGNI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
MULI4
ADDRLP4 40
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 5004
;5004:			item->numColors++;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5005
;5005:		}
LABELV $2302
line 5006
;5006:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2297
JUMPV
LABELV $2298
line 5008
;5007:	}
;5008:	return qfalse;
CNSTI4 0
RETI4
LABELV $2297
endproc ItemParse_addColorRange 48 12
export ItemParse_ownerdrawFlag
proc ItemParse_ownerdrawFlag 12 8
line 5011
;5009:}
;5010:
;5011:qboolean ItemParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 5013
;5012:	int i;
;5013:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2305
line 5014
;5014:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2304
JUMPV
LABELV $2305
line 5016
;5015:	}
;5016:	item->window.ownerDrawFlags |= i;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 5017
;5017:	return qtrue;
CNSTI4 1
RETI4
LABELV $2304
endproc ItemParse_ownerdrawFlag 12 8
export ItemParse_enableCvar
proc ItemParse_enableCvar 4 8
line 5020
;5018:}
;5019:
;5020:qboolean ItemParse_enableCvar( itemDef_t *item, int handle ) {
line 5021
;5021:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2308
line 5022
;5022:		item->cvarFlags = CVAR_ENABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 1
ASGNI4
line 5023
;5023:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2307
JUMPV
LABELV $2308
line 5025
;5024:	}
;5025:	return qfalse;
CNSTI4 0
RETI4
LABELV $2307
endproc ItemParse_enableCvar 4 8
export ItemParse_disableCvar
proc ItemParse_disableCvar 4 8
line 5028
;5026:}
;5027:
;5028:qboolean ItemParse_disableCvar( itemDef_t *item, int handle ) {
line 5029
;5029:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2311
line 5030
;5030:		item->cvarFlags = CVAR_DISABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 2
ASGNI4
line 5031
;5031:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2310
JUMPV
LABELV $2311
line 5033
;5032:	}
;5033:	return qfalse;
CNSTI4 0
RETI4
LABELV $2310
endproc ItemParse_disableCvar 4 8
export ItemParse_showCvar
proc ItemParse_showCvar 4 8
line 5036
;5034:}
;5035:
;5036:qboolean ItemParse_showCvar( itemDef_t *item, int handle ) {
line 5037
;5037:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2314
line 5038
;5038:		item->cvarFlags = CVAR_SHOW;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 4
ASGNI4
line 5039
;5039:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2313
JUMPV
LABELV $2314
line 5041
;5040:	}
;5041:	return qfalse;
CNSTI4 0
RETI4
LABELV $2313
endproc ItemParse_showCvar 4 8
export ItemParse_hideCvar
proc ItemParse_hideCvar 4 8
line 5044
;5042:}
;5043:
;5044:qboolean ItemParse_hideCvar( itemDef_t *item, int handle ) {
line 5045
;5045:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2317
line 5046
;5046:		item->cvarFlags = CVAR_HIDE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 8
ASGNI4
line 5047
;5047:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2316
JUMPV
LABELV $2317
line 5049
;5048:	}
;5049:	return qfalse;
CNSTI4 0
RETI4
LABELV $2316
endproc ItemParse_hideCvar 4 8
data
export itemParseKeywords
align 4
LABELV itemParseKeywords
address $2319
address ItemParse_name
byte 4 0
address $2320
address ItemParse_text
byte 4 0
address $2321
address ItemParse_group
byte 4 0
address $2322
address ItemParse_asset_model
byte 4 0
address $2323
address ItemParse_asset_shader
byte 4 0
address $2324
address ItemParse_model_origin
byte 4 0
address $2325
address ItemParse_model_fovx
byte 4 0
address $2326
address ItemParse_model_fovy
byte 4 0
address $2327
address ItemParse_model_rotation
byte 4 0
address $2328
address ItemParse_model_angle
byte 4 0
address $2329
address ItemParse_rect
byte 4 0
address $2330
address ItemParse_style
byte 4 0
address $2331
address ItemParse_decoration
byte 4 0
address $2332
address ItemParse_notselectable
byte 4 0
address $2333
address ItemParse_wrapped
byte 4 0
address $2334
address ItemParse_autowrapped
byte 4 0
address $2335
address ItemParse_horizontalscroll
byte 4 0
address $2336
address ItemParse_type
byte 4 0
address $2337
address ItemParse_elementwidth
byte 4 0
address $2338
address ItemParse_elementheight
byte 4 0
address $2339
address ItemParse_feeder
byte 4 0
address $2340
address ItemParse_elementtype
byte 4 0
address $2341
address ItemParse_columns
byte 4 0
address $2342
address ItemParse_border
byte 4 0
address $2343
address ItemParse_bordersize
byte 4 0
address $2344
address ItemParse_visible
byte 4 0
address $2345
address ItemParse_ownerdraw
byte 4 0
address $2346
address ItemParse_align
byte 4 0
address $2347
address ItemParse_textalign
byte 4 0
address $2348
address ItemParse_textalignx
byte 4 0
address $2349
address ItemParse_textaligny
byte 4 0
address $2350
address ItemParse_textscale
byte 4 0
address $2351
address ItemParse_textstyle
byte 4 0
address $359
address ItemParse_backcolor
byte 4 0
address $362
address ItemParse_forecolor
byte 4 0
address $365
address ItemParse_bordercolor
byte 4 0
address $2352
address ItemParse_outlinecolor
byte 4 0
address $2353
address ItemParse_background
byte 4 0
address $2354
address ItemParse_onFocus
byte 4 0
address $2355
address ItemParse_leaveFocus
byte 4 0
address $2356
address ItemParse_mouseEnter
byte 4 0
address $2357
address ItemParse_mouseExit
byte 4 0
address $2358
address ItemParse_mouseEnterText
byte 4 0
address $2359
address ItemParse_mouseExitText
byte 4 0
address $2360
address ItemParse_action
byte 4 0
address $2361
address ItemParse_special
byte 4 0
address $2362
address ItemParse_cvar
byte 4 0
address $2363
address ItemParse_maxChars
byte 4 0
address $2364
address ItemParse_maxPaintChars
byte 4 0
address $2365
address ItemParse_focusSound
byte 4 0
address $2366
address ItemParse_cvarFloat
byte 4 0
address $2367
address ItemParse_cvarStrList
byte 4 0
address $2368
address ItemParse_cvarFloatList
byte 4 0
address $2369
address ItemParse_addColorRange
byte 4 0
address $2370
address ItemParse_ownerdrawFlag
byte 4 0
address $2371
address ItemParse_enableCvar
byte 4 0
address $2372
address ItemParse_cvarTest
byte 4 0
address $2373
address ItemParse_disableCvar
byte 4 0
address $2374
address ItemParse_showCvar
byte 4 0
address $2375
address ItemParse_hideCvar
byte 4 0
address $2376
address ItemParse_cinematic
byte 4 0
address $2377
address ItemParse_doubleClick
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Item_SetupKeywordHash
code
proc Item_SetupKeywordHash 4 12
line 5126
;5050:}
;5051:
;5052:
;5053:keywordHash_t itemParseKeywords[] = {
;5054:	{"name", ItemParse_name, NULL},
;5055:	{"text", ItemParse_text, NULL},
;5056:	{"group", ItemParse_group, NULL},
;5057:	{"asset_model", ItemParse_asset_model, NULL},
;5058:	{"asset_shader", ItemParse_asset_shader, NULL},
;5059:	{"model_origin", ItemParse_model_origin, NULL},
;5060:	{"model_fovx", ItemParse_model_fovx, NULL},
;5061:	{"model_fovy", ItemParse_model_fovy, NULL},
;5062:	{"model_rotation", ItemParse_model_rotation, NULL},
;5063:	{"model_angle", ItemParse_model_angle, NULL},
;5064:	{"rect", ItemParse_rect, NULL},
;5065:	{"style", ItemParse_style, NULL},
;5066:	{"decoration", ItemParse_decoration, NULL},
;5067:	{"notselectable", ItemParse_notselectable, NULL},
;5068:	{"wrapped", ItemParse_wrapped, NULL},
;5069:	{"autowrapped", ItemParse_autowrapped, NULL},
;5070:	{"horizontalscroll", ItemParse_horizontalscroll, NULL},
;5071:	{"type", ItemParse_type, NULL},
;5072:	{"elementwidth", ItemParse_elementwidth, NULL},
;5073:	{"elementheight", ItemParse_elementheight, NULL},
;5074:	{"feeder", ItemParse_feeder, NULL},
;5075:	{"elementtype", ItemParse_elementtype, NULL},
;5076:	{"columns", ItemParse_columns, NULL},
;5077:	{"border", ItemParse_border, NULL},
;5078:	{"bordersize", ItemParse_bordersize, NULL},
;5079:	{"visible", ItemParse_visible, NULL},
;5080:	{"ownerdraw", ItemParse_ownerdraw, NULL},
;5081:	{"align", ItemParse_align, NULL},
;5082:	{"textalign", ItemParse_textalign, NULL},
;5083:	{"textalignx", ItemParse_textalignx, NULL},
;5084:	{"textaligny", ItemParse_textaligny, NULL},
;5085:	{"textscale", ItemParse_textscale, NULL},
;5086:	{"textstyle", ItemParse_textstyle, NULL},
;5087:	{"backcolor", ItemParse_backcolor, NULL},
;5088:	{"forecolor", ItemParse_forecolor, NULL},
;5089:	{"bordercolor", ItemParse_bordercolor, NULL},
;5090:	{"outlinecolor", ItemParse_outlinecolor, NULL},
;5091:	{"background", ItemParse_background, NULL},
;5092:	{"onFocus", ItemParse_onFocus, NULL},
;5093:	{"leaveFocus", ItemParse_leaveFocus, NULL},
;5094:	{"mouseEnter", ItemParse_mouseEnter, NULL},
;5095:	{"mouseExit", ItemParse_mouseExit, NULL},
;5096:	{"mouseEnterText", ItemParse_mouseEnterText, NULL},
;5097:	{"mouseExitText", ItemParse_mouseExitText, NULL},
;5098:	{"action", ItemParse_action, NULL},
;5099:	{"special", ItemParse_special, NULL},
;5100:	{"cvar", ItemParse_cvar, NULL},
;5101:	{"maxChars", ItemParse_maxChars, NULL},
;5102:	{"maxPaintChars", ItemParse_maxPaintChars, NULL},
;5103:	{"focusSound", ItemParse_focusSound, NULL},
;5104:	{"cvarFloat", ItemParse_cvarFloat, NULL},
;5105:	{"cvarStrList", ItemParse_cvarStrList, NULL},
;5106:	{"cvarFloatList", ItemParse_cvarFloatList, NULL},
;5107:	{"addColorRange", ItemParse_addColorRange, NULL},
;5108:	{"ownerdrawFlag", ItemParse_ownerdrawFlag, NULL},
;5109:	{"enableCvar", ItemParse_enableCvar, NULL},
;5110:	{"cvarTest", ItemParse_cvarTest, NULL},
;5111:	{"disableCvar", ItemParse_disableCvar, NULL},
;5112:	{"showCvar", ItemParse_showCvar, NULL},
;5113:	{"hideCvar", ItemParse_hideCvar, NULL},
;5114:	{"cinematic", ItemParse_cinematic, NULL},
;5115:	{"doubleclick", ItemParse_doubleClick, NULL},
;5116:	{NULL, NULL, NULL}
;5117:};
;5118:
;5119:keywordHash_t *itemParseKeywordHash[KEYWORDHASH_SIZE];
;5120:
;5121:/*
;5122:===============
;5123:Item_SetupKeywordHash
;5124:===============
;5125:*/
;5126:void Item_SetupKeywordHash(void) {
line 5129
;5127:	int i;
;5128:
;5129:	memset(itemParseKeywordHash, 0, sizeof(itemParseKeywordHash));
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5130
;5130:	for (i = 0; itemParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2382
JUMPV
LABELV $2379
line 5131
;5131:		KeywordHash_Add(itemParseKeywordHash, &itemParseKeywords[i]);
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 itemParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 5132
;5132:	}
LABELV $2380
line 5130
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2382
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 itemParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2379
line 5133
;5133:}
LABELV $2378
endproc Item_SetupKeywordHash 4 12
export Item_Parse
proc Item_Parse 1060 12
line 5140
;5134:
;5135:/*
;5136:===============
;5137:Item_Parse
;5138:===============
;5139:*/
;5140:qboolean Item_Parse(int handle, itemDef_t *item) {
line 5145
;5141:	pc_token_t token;
;5142:	keywordHash_t *key;
;5143:
;5144:
;5145:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2384
line 5146
;5146:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2383
JUMPV
LABELV $2384
line 5147
;5147:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2390
line 5148
;5148:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2383
JUMPV
LABELV $2389
line 5150
;5149:	}
;5150:	while ( 1 ) {
line 5151
;5151:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2392
line 5152
;5152:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2256
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5153
;5153:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2383
JUMPV
LABELV $2392
line 5156
;5154:		}
;5155:
;5156:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2394
line 5157
;5157:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2383
JUMPV
LABELV $2394
line 5160
;5158:		}
;5159:
;5160:		key = KeywordHash_Find(itemParseKeywordHash, token.string);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 5161
;5161:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2398
line 5162
;5162:			PC_SourceError(handle, "unknown menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2400
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5163
;5163:			continue;
ADDRGP4 $2390
JUMPV
LABELV $2398
line 5165
;5164:		}
;5165:		if ( !key->func(item, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2402
line 5166
;5166:			PC_SourceError(handle, "couldn't parse menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2404
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5167
;5167:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2383
JUMPV
LABELV $2402
line 5169
;5168:		}
;5169:	}
LABELV $2390
line 5150
ADDRGP4 $2389
JUMPV
line 5170
;5170:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2383
endproc Item_Parse 1060 12
export Item_InitControls
proc Item_InitControls 4 0
line 5176
;5171:}
;5172:
;5173:
;5174:// Item_InitControls
;5175:// init's special control types
;5176:void Item_InitControls(itemDef_t *item) {
line 5177
;5177:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2407
line 5178
;5178:		return;
ADDRGP4 $2406
JUMPV
LABELV $2407
line 5180
;5179:	}
;5180:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2409
line 5181
;5181:		listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 5182
;5182:		item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 5183
;5183:		if (listPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2411
line 5184
;5184:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5185
;5185:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 5186
;5186:			listPtr->endPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 5187
;5187:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5188
;5188:		}
LABELV $2411
line 5189
;5189:	}
LABELV $2409
line 5190
;5190:}
LABELV $2406
endproc Item_InitControls 4 0
export MenuParse_font
proc MenuParse_font 12 12
line 5198
;5191:
;5192:/*
;5193:===============
;5194:Menu Keyword Parse functions
;5195:===============
;5196:*/
;5197:
;5198:qboolean MenuParse_font( itemDef_t *item, int handle ) {
line 5199
;5199:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5200
;5200:	if (!PC_String_Parse(handle, &menu->font)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2414
line 5201
;5201:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2413
JUMPV
LABELV $2414
line 5203
;5202:	}
;5203:	if (!DC->Assets.fontRegistered) {
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2416
line 5204
;5204:		DC->registerFont(menu->font, 48, &DC->Assets.textFont);
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLV
pop
line 5205
;5205:		DC->Assets.fontRegistered = qtrue;
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
CNSTI4 1
ASGNI4
line 5206
;5206:	}
LABELV $2416
line 5207
;5207:	return qtrue;
CNSTI4 1
RETI4
LABELV $2413
endproc MenuParse_font 12 12
export MenuParse_name
proc MenuParse_name 12 8
line 5210
;5208:}
;5209:
;5210:qboolean MenuParse_name( itemDef_t *item, int handle ) {
line 5211
;5211:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5212
;5212:	if (!PC_String_Parse(handle, &menu->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2419
line 5213
;5213:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2418
JUMPV
LABELV $2419
line 5215
;5214:	}
;5215:	if (Q_stricmp(menu->window.name, "main") == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2423
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2421
line 5218
;5216:		// default main as having focus
;5217:		//menu->window.flags |= WINDOW_HASFOCUS;
;5218:	}
LABELV $2421
line 5219
;5219:	return qtrue;
CNSTI4 1
RETI4
LABELV $2418
endproc MenuParse_name 12 8
export MenuParse_fullscreen
proc MenuParse_fullscreen 8 8
line 5222
;5220:}
;5221:
;5222:qboolean MenuParse_fullscreen( itemDef_t *item, int handle ) {
line 5223
;5223:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5224
;5224:	if (!PC_Int_Parse(handle, (int*) &menu->fullScreen)) { // bk001206 - cast qboolean
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2425
line 5225
;5225:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2424
JUMPV
LABELV $2425
line 5227
;5226:	}
;5227:	return qtrue;
CNSTI4 1
RETI4
LABELV $2424
endproc MenuParse_fullscreen 8 8
export MenuParse_rect
proc MenuParse_rect 8 8
line 5230
;5228:}
;5229:
;5230:qboolean MenuParse_rect( itemDef_t *item, int handle ) {
line 5231
;5231:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5232
;5232:	if (!PC_Rect_Parse(handle, &menu->window.rect)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2428
line 5233
;5233:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2427
JUMPV
LABELV $2428
line 5235
;5234:	}
;5235:	return qtrue;
CNSTI4 1
RETI4
LABELV $2427
endproc MenuParse_rect 8 8
export MenuParse_style
proc MenuParse_style 8 8
line 5238
;5236:}
;5237:
;5238:qboolean MenuParse_style( itemDef_t *item, int handle ) {
line 5239
;5239:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5240
;5240:	if (!PC_Int_Parse(handle, &menu->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2431
line 5241
;5241:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2430
JUMPV
LABELV $2431
line 5243
;5242:	}
;5243:	return qtrue;
CNSTI4 1
RETI4
LABELV $2430
endproc MenuParse_style 8 8
export MenuParse_visible
proc MenuParse_visible 16 8
line 5246
;5244:}
;5245:
;5246:qboolean MenuParse_visible( itemDef_t *item, int handle ) {
line 5248
;5247:	int i;
;5248:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5250
;5249:
;5250:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2434
line 5251
;5251:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2433
JUMPV
LABELV $2434
line 5253
;5252:	}
;5253:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2436
line 5254
;5254:		menu->window.flags |= WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 5255
;5255:	}
LABELV $2436
line 5256
;5256:	return qtrue;
CNSTI4 1
RETI4
LABELV $2433
endproc MenuParse_visible 16 8
export MenuParse_onOpen
proc MenuParse_onOpen 8 8
line 5259
;5257:}
;5258:
;5259:qboolean MenuParse_onOpen( itemDef_t *item, int handle ) {
line 5260
;5260:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5261
;5261:	if (!PC_Script_Parse(handle, &menu->onOpen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2439
line 5262
;5262:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2438
JUMPV
LABELV $2439
line 5264
;5263:	}
;5264:	return qtrue;
CNSTI4 1
RETI4
LABELV $2438
endproc MenuParse_onOpen 8 8
export MenuParse_onClose
proc MenuParse_onClose 8 8
line 5267
;5265:}
;5266:
;5267:qboolean MenuParse_onClose( itemDef_t *item, int handle ) {
line 5268
;5268:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5269
;5269:	if (!PC_Script_Parse(handle, &menu->onClose)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2442
line 5270
;5270:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2441
JUMPV
LABELV $2442
line 5272
;5271:	}
;5272:	return qtrue;
CNSTI4 1
RETI4
LABELV $2441
endproc MenuParse_onClose 8 8
export MenuParse_onESC
proc MenuParse_onESC 8 8
line 5275
;5273:}
;5274:
;5275:qboolean MenuParse_onESC( itemDef_t *item, int handle ) {
line 5276
;5276:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5277
;5277:	if (!PC_Script_Parse(handle, &menu->onESC)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2445
line 5278
;5278:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2445
line 5280
;5279:	}
;5280:	return qtrue;
CNSTI4 1
RETI4
LABELV $2444
endproc MenuParse_onESC 8 8
export MenuParse_border
proc MenuParse_border 8 8
line 5285
;5281:}
;5282:
;5283:
;5284:
;5285:qboolean MenuParse_border( itemDef_t *item, int handle ) {
line 5286
;5286:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5287
;5287:	if (!PC_Int_Parse(handle, &menu->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2448
line 5288
;5288:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2447
JUMPV
LABELV $2448
line 5290
;5289:	}
;5290:	return qtrue;
CNSTI4 1
RETI4
LABELV $2447
endproc MenuParse_border 8 8
export MenuParse_borderSize
proc MenuParse_borderSize 8 8
line 5293
;5291:}
;5292:
;5293:qboolean MenuParse_borderSize( itemDef_t *item, int handle ) {
line 5294
;5294:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5295
;5295:	if (!PC_Float_Parse(handle, &menu->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2451
line 5296
;5296:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2450
JUMPV
LABELV $2451
line 5298
;5297:	}
;5298:	return qtrue;
CNSTI4 1
RETI4
LABELV $2450
endproc MenuParse_borderSize 8 8
export MenuParse_backcolor
proc MenuParse_backcolor 16 8
line 5301
;5299:}
;5300:
;5301:qboolean MenuParse_backcolor( itemDef_t *item, int handle ) {
line 5304
;5302:	int i;
;5303:	float f;
;5304:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5306
;5305:
;5306:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2454
line 5307
;5307:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2458
line 5308
;5308:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2453
JUMPV
LABELV $2458
line 5310
;5309:		}
;5310:		menu->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5311
;5311:	}
LABELV $2455
line 5306
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2454
line 5312
;5312:	return qtrue;
CNSTI4 1
RETI4
LABELV $2453
endproc MenuParse_backcolor 16 8
export MenuParse_forecolor
proc MenuParse_forecolor 20 8
line 5315
;5313:}
;5314:
;5315:qboolean MenuParse_forecolor( itemDef_t *item, int handle ) {
line 5318
;5316:	int i;
;5317:	float f;
;5318:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5320
;5319:
;5320:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2461
line 5321
;5321:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2465
line 5322
;5322:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2460
JUMPV
LABELV $2465
line 5324
;5323:		}
;5324:		menu->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 5325
;5325:		menu->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 5326
;5326:	}
LABELV $2462
line 5320
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2461
line 5327
;5327:	return qtrue;
CNSTI4 1
RETI4
LABELV $2460
endproc MenuParse_forecolor 20 8
export MenuParse_bordercolor
proc MenuParse_bordercolor 16 8
line 5330
;5328:}
;5329:
;5330:qboolean MenuParse_bordercolor( itemDef_t *item, int handle ) {
line 5333
;5331:	int i;
;5332:	float f;
;5333:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5335
;5334:
;5335:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2468
line 5336
;5336:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2472
line 5337
;5337:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2467
JUMPV
LABELV $2472
line 5339
;5338:		}
;5339:		menu->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5340
;5340:	}
LABELV $2469
line 5335
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2468
line 5341
;5341:	return qtrue;
CNSTI4 1
RETI4
LABELV $2467
endproc MenuParse_bordercolor 16 8
export MenuParse_focuscolor
proc MenuParse_focuscolor 16 8
line 5344
;5342:}
;5343:
;5344:qboolean MenuParse_focuscolor( itemDef_t *item, int handle ) {
line 5347
;5345:	int i;
;5346:	float f;
;5347:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5349
;5348:
;5349:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2475
line 5350
;5350:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2479
line 5351
;5351:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2474
JUMPV
LABELV $2479
line 5353
;5352:		}
;5353:		menu->focusColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5354
;5354:	}
LABELV $2476
line 5349
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2475
line 5355
;5355:	return qtrue;
CNSTI4 1
RETI4
LABELV $2474
endproc MenuParse_focuscolor 16 8
export MenuParse_disablecolor
proc MenuParse_disablecolor 16 8
line 5358
;5356:}
;5357:
;5358:qboolean MenuParse_disablecolor( itemDef_t *item, int handle ) {
line 5361
;5359:	int i;
;5360:	float f;
;5361:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5362
;5362:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2482
line 5363
;5363:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2486
line 5364
;5364:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2481
JUMPV
LABELV $2486
line 5366
;5365:		}
;5366:		menu->disableColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5367
;5367:	}
LABELV $2483
line 5362
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2482
line 5368
;5368:	return qtrue;
CNSTI4 1
RETI4
LABELV $2481
endproc MenuParse_disablecolor 16 8
export MenuParse_outlinecolor
proc MenuParse_outlinecolor 8 8
line 5372
;5369:}
;5370:
;5371:
;5372:qboolean MenuParse_outlinecolor( itemDef_t *item, int handle ) {
line 5373
;5373:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5374
;5374:	if (!PC_Color_Parse(handle, &menu->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2489
line 5375
;5375:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2488
JUMPV
LABELV $2489
line 5377
;5376:	}
;5377:	return qtrue;
CNSTI4 1
RETI4
LABELV $2488
endproc MenuParse_outlinecolor 8 8
export MenuParse_background
proc MenuParse_background 16 8
line 5380
;5378:}
;5379:
;5380:qboolean MenuParse_background( itemDef_t *item, int handle ) {
line 5382
;5381:	const char *buff;
;5382:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5384
;5383:
;5384:	if (!PC_String_Parse(handle, &buff)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2492
line 5385
;5385:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2491
JUMPV
LABELV $2492
line 5387
;5386:	}
;5387:	menu->window.background = DC->registerShaderNoMip(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5388
;5388:	return qtrue;
CNSTI4 1
RETI4
LABELV $2491
endproc MenuParse_background 16 8
export MenuParse_cinematic
proc MenuParse_cinematic 8 8
line 5391
;5389:}
;5390:
;5391:qboolean MenuParse_cinematic( itemDef_t *item, int handle ) {
line 5392
;5392:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5394
;5393:
;5394:	if (!PC_String_Parse(handle, &menu->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2495
line 5395
;5395:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2494
JUMPV
LABELV $2495
line 5397
;5396:	}
;5397:	return qtrue;
CNSTI4 1
RETI4
LABELV $2494
endproc MenuParse_cinematic 8 8
export MenuParse_ownerdrawFlag
proc MenuParse_ownerdrawFlag 16 8
line 5400
;5398:}
;5399:
;5400:qboolean MenuParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 5402
;5401:	int i;
;5402:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5404
;5403:
;5404:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2498
line 5405
;5405:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2497
JUMPV
LABELV $2498
line 5407
;5406:	}
;5407:	menu->window.ownerDrawFlags |= i;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 5408
;5408:	return qtrue;
CNSTI4 1
RETI4
LABELV $2497
endproc MenuParse_ownerdrawFlag 16 8
export MenuParse_ownerdraw
proc MenuParse_ownerdraw 8 8
line 5411
;5409:}
;5410:
;5411:qboolean MenuParse_ownerdraw( itemDef_t *item, int handle ) {
line 5412
;5412:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5414
;5413:
;5414:	if (!PC_Int_Parse(handle, &menu->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2501
line 5415
;5415:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2500
JUMPV
LABELV $2501
line 5417
;5416:	}
;5417:	return qtrue;
CNSTI4 1
RETI4
LABELV $2500
endproc MenuParse_ownerdraw 8 8
export MenuParse_popup
proc MenuParse_popup 8 0
line 5422
;5418:}
;5419:
;5420:
;5421:// decoration
;5422:qboolean MenuParse_popup( itemDef_t *item, int handle ) {
line 5423
;5423:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5424
;5424:	menu->window.flags |= WINDOW_POPUP;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2097152
BORI4
ASGNI4
line 5425
;5425:	return qtrue;
CNSTI4 1
RETI4
LABELV $2503
endproc MenuParse_popup 8 0
export MenuParse_outOfBounds
proc MenuParse_outOfBounds 8 0
line 5429
;5426:}
;5427:
;5428:
;5429:qboolean MenuParse_outOfBounds( itemDef_t *item, int handle ) {
line 5430
;5430:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5432
;5431:
;5432:	menu->window.flags |= WINDOW_OOB_CLICK;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 5433
;5433:	return qtrue;
CNSTI4 1
RETI4
LABELV $2504
endproc MenuParse_outOfBounds 8 0
export MenuParse_soundLoop
proc MenuParse_soundLoop 8 8
line 5436
;5434:}
;5435:
;5436:qboolean MenuParse_soundLoop( itemDef_t *item, int handle ) {
line 5437
;5437:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5439
;5438:
;5439:	if (!PC_String_Parse(handle, &menu->soundName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2506
line 5440
;5440:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2505
JUMPV
LABELV $2506
line 5442
;5441:	}
;5442:	return qtrue;
CNSTI4 1
RETI4
LABELV $2505
endproc MenuParse_soundLoop 8 8
export MenuParse_fadeClamp
proc MenuParse_fadeClamp 8 8
line 5445
;5443:}
;5444:
;5445:qboolean MenuParse_fadeClamp( itemDef_t *item, int handle ) {
line 5446
;5446:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5448
;5447:
;5448:	if (!PC_Float_Parse(handle, &menu->fadeClamp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2509
line 5449
;5449:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2508
JUMPV
LABELV $2509
line 5451
;5450:	}
;5451:	return qtrue;
CNSTI4 1
RETI4
LABELV $2508
endproc MenuParse_fadeClamp 8 8
export MenuParse_fadeAmount
proc MenuParse_fadeAmount 8 8
line 5454
;5452:}
;5453:
;5454:qboolean MenuParse_fadeAmount( itemDef_t *item, int handle ) {
line 5455
;5455:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5457
;5456:
;5457:	if (!PC_Float_Parse(handle, &menu->fadeAmount)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2512
line 5458
;5458:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2511
JUMPV
LABELV $2512
line 5460
;5459:	}
;5460:	return qtrue;
CNSTI4 1
RETI4
LABELV $2511
endproc MenuParse_fadeAmount 8 8
export MenuParse_fadeCycle
proc MenuParse_fadeCycle 8 8
line 5464
;5461:}
;5462:
;5463:
;5464:qboolean MenuParse_fadeCycle( itemDef_t *item, int handle ) {
line 5465
;5465:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5467
;5466:
;5467:	if (!PC_Int_Parse(handle, &menu->fadeCycle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2515
line 5468
;5468:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2514
JUMPV
LABELV $2515
line 5470
;5469:	}
;5470:	return qtrue;
CNSTI4 1
RETI4
LABELV $2514
endproc MenuParse_fadeCycle 8 8
export MenuParse_itemDef
proc MenuParse_itemDef 40 8
line 5474
;5471:}
;5472:
;5473:
;5474:qboolean MenuParse_itemDef( itemDef_t *item, int handle ) {
line 5475
;5475:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5476
;5476:	if (menu->itemCount < MAX_MENUITEMS) {
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 96
GEI4 $2518
line 5477
;5477:		menu->items[menu->itemCount] = UI_Alloc(sizeof(itemDef_t));
CNSTI4 540
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5478
;5478:		Item_Init(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Init
CALLV
pop
line 5479
;5479:		if (!Item_Parse(handle, menu->items[menu->itemCount])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2520
line 5480
;5480:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2517
JUMPV
LABELV $2520
line 5482
;5481:		}
;5482:		Item_InitControls(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_InitControls
CALLV
pop
line 5483
;5483:		menu->items[menu->itemCount++]->parent = menu;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 5484
;5484:	}
LABELV $2518
line 5485
;5485:	return qtrue;
CNSTI4 1
RETI4
LABELV $2517
endproc MenuParse_itemDef 40 8
data
export menuParseKeywords
align 4
LABELV menuParseKeywords
address $2522
address MenuParse_font
byte 4 0
address $2319
address MenuParse_name
byte 4 0
address $2523
address MenuParse_fullscreen
byte 4 0
address $2329
address MenuParse_rect
byte 4 0
address $2330
address MenuParse_style
byte 4 0
address $2344
address MenuParse_visible
byte 4 0
address $2524
address MenuParse_onOpen
byte 4 0
address $2525
address MenuParse_onClose
byte 4 0
address $2526
address MenuParse_onESC
byte 4 0
address $2342
address MenuParse_border
byte 4 0
address $2527
address MenuParse_borderSize
byte 4 0
address $359
address MenuParse_backcolor
byte 4 0
address $362
address MenuParse_forecolor
byte 4 0
address $365
address MenuParse_bordercolor
byte 4 0
address $2528
address MenuParse_focuscolor
byte 4 0
address $2529
address MenuParse_disablecolor
byte 4 0
address $2352
address MenuParse_outlinecolor
byte 4 0
address $2353
address MenuParse_background
byte 4 0
address $2345
address MenuParse_ownerdraw
byte 4 0
address $2370
address MenuParse_ownerdrawFlag
byte 4 0
address $2530
address MenuParse_outOfBounds
byte 4 0
address $2531
address MenuParse_soundLoop
byte 4 0
address $2532
address MenuParse_itemDef
byte 4 0
address $2376
address MenuParse_cinematic
byte 4 0
address $2533
address MenuParse_popup
byte 4 0
address $2534
address MenuParse_fadeClamp
byte 4 0
address $2535
address MenuParse_fadeCycle
byte 4 0
address $2536
address MenuParse_fadeAmount
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Menu_SetupKeywordHash
code
proc Menu_SetupKeywordHash 4 12
line 5527
;5486:}
;5487:
;5488:keywordHash_t menuParseKeywords[] = {
;5489:	{"font", MenuParse_font, NULL},
;5490:	{"name", MenuParse_name, NULL},
;5491:	{"fullscreen", MenuParse_fullscreen, NULL},
;5492:	{"rect", MenuParse_rect, NULL},
;5493:	{"style", MenuParse_style, NULL},
;5494:	{"visible", MenuParse_visible, NULL},
;5495:	{"onOpen", MenuParse_onOpen, NULL},
;5496:	{"onClose", MenuParse_onClose, NULL},
;5497:	{"onESC", MenuParse_onESC, NULL},
;5498:	{"border", MenuParse_border, NULL},
;5499:	{"borderSize", MenuParse_borderSize, NULL},
;5500:	{"backcolor", MenuParse_backcolor, NULL},
;5501:	{"forecolor", MenuParse_forecolor, NULL},
;5502:	{"bordercolor", MenuParse_bordercolor, NULL},
;5503:	{"focuscolor", MenuParse_focuscolor, NULL},
;5504:	{"disablecolor", MenuParse_disablecolor, NULL},
;5505:	{"outlinecolor", MenuParse_outlinecolor, NULL},
;5506:	{"background", MenuParse_background, NULL},
;5507:	{"ownerdraw", MenuParse_ownerdraw, NULL},
;5508:	{"ownerdrawFlag", MenuParse_ownerdrawFlag, NULL},
;5509:	{"outOfBoundsClick", MenuParse_outOfBounds, NULL},
;5510:	{"soundLoop", MenuParse_soundLoop, NULL},
;5511:	{"itemDef", MenuParse_itemDef, NULL},
;5512:	{"cinematic", MenuParse_cinematic, NULL},
;5513:	{"popup", MenuParse_popup, NULL},
;5514:	{"fadeClamp", MenuParse_fadeClamp, NULL},
;5515:	{"fadeCycle", MenuParse_fadeCycle, NULL},
;5516:	{"fadeAmount", MenuParse_fadeAmount, NULL},
;5517:	{NULL, NULL, NULL}
;5518:};
;5519:
;5520:keywordHash_t *menuParseKeywordHash[KEYWORDHASH_SIZE];
;5521:
;5522:/*
;5523:===============
;5524:Menu_SetupKeywordHash
;5525:===============
;5526:*/
;5527:void Menu_SetupKeywordHash(void) {
line 5530
;5528:	int i;
;5529:
;5530:	memset(menuParseKeywordHash, 0, sizeof(menuParseKeywordHash));
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5531
;5531:	for (i = 0; menuParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2541
JUMPV
LABELV $2538
line 5532
;5532:		KeywordHash_Add(menuParseKeywordHash, &menuParseKeywords[i]);
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 menuParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 5533
;5533:	}
LABELV $2539
line 5531
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2541
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 menuParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2538
line 5534
;5534:}
LABELV $2537
endproc Menu_SetupKeywordHash 4 12
export Menu_Parse
proc Menu_Parse 1060 12
line 5541
;5535:
;5536:/*
;5537:===============
;5538:Menu_Parse
;5539:===============
;5540:*/
;5541:qboolean Menu_Parse(int handle, menuDef_t *menu) {
line 5545
;5542:	pc_token_t token;
;5543:	keywordHash_t *key;
;5544:
;5545:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2543
line 5546
;5546:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2543
line 5547
;5547:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2549
line 5548
;5548:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2548
line 5551
;5549:	}
;5550:    
;5551:	while ( 1 ) {
line 5553
;5552:
;5553:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5554
;5554:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2551
line 5555
;5555:			PC_SourceError(handle, "end of file inside menu\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2553
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5556
;5556:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2551
line 5559
;5557:		}
;5558:
;5559:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2554
line 5560
;5560:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2554
line 5563
;5561:		}
;5562:
;5563:		key = KeywordHash_Find(menuParseKeywordHash, token.string);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 5564
;5564:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2558
line 5565
;5565:			PC_SourceError(handle, "unknown menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2560
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5566
;5566:			continue;
ADDRGP4 $2549
JUMPV
LABELV $2558
line 5568
;5567:		}
;5568:		if ( !key->func((itemDef_t*)menu, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2562
line 5569
;5569:			PC_SourceError(handle, "couldn't parse menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2564
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5570
;5570:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2562
line 5572
;5571:		}
;5572:	}
LABELV $2549
line 5551
ADDRGP4 $2548
JUMPV
line 5573
;5573:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2542
endproc Menu_Parse 1060 12
export Menu_New
proc Menu_New 12 8
line 5581
;5574:}
;5575:
;5576:/*
;5577:===============
;5578:Menu_New
;5579:===============
;5580:*/
;5581:void Menu_New(int handle) {
line 5582
;5582:	menuDef_t *menu = &Menus[menuCount];
ADDRLP4 0
CNSTI4 644
ADDRGP4 menuCount
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 5584
;5583:
;5584:	if (menuCount < MAX_MENUS) {
ADDRGP4 menuCount
INDIRI4
CNSTI4 64
GEI4 $2567
line 5585
;5585:		Menu_Init(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_Init
CALLV
pop
line 5586
;5586:		if (Menu_Parse(handle, menu)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menu_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2569
line 5587
;5587:			Menu_PostParse(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_PostParse
CALLV
pop
line 5588
;5588:			menuCount++;
ADDRLP4 8
ADDRGP4 menuCount
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5589
;5589:		}
LABELV $2569
line 5590
;5590:	}
LABELV $2567
line 5591
;5591:}
LABELV $2566
endproc Menu_New 12 8
export Menu_Count
proc Menu_Count 0 0
line 5593
;5592:
;5593:int Menu_Count() {
line 5594
;5594:	return menuCount;
ADDRGP4 menuCount
INDIRI4
RETI4
LABELV $2571
endproc Menu_Count 0 0
lit
align 4
LABELV $2581
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Menu_PaintAll
code
proc Menu_PaintAll 32 32
line 5597
;5595:}
;5596:
;5597:void Menu_PaintAll() {
line 5599
;5598:	int i;
;5599:	if (captureFunc) {
ADDRGP4 captureFunc
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2573
line 5600
;5600:		captureFunc(captureData);
ADDRGP4 captureData
INDIRP4
ARGP4
ADDRGP4 captureFunc
INDIRP4
CALLV
pop
line 5601
;5601:	}
LABELV $2573
line 5603
;5602:
;5603:	for (i = 0; i < Menu_Count(); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2578
JUMPV
LABELV $2575
line 5604
;5604:		Menu_Paint(&Menus[i], qfalse);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5605
;5605:	}
LABELV $2576
line 5603
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2578
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2575
line 5607
;5606:
;5607:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2579
line 5608
;5608:		vec4_t v = {1, 1, 1, 1};
ADDRLP4 8
ADDRGP4 $2581
INDIRB
ASGNB 16
line 5609
;5609:		DC->drawText(5, 25, .5, v, va("fps: %f", DC->FPS), 0, 0, 0);
ADDRGP4 $2582
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 73416
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1084227584
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 5610
;5610:	}
LABELV $2579
line 5611
;5611:}
LABELV $2572
endproc Menu_PaintAll 32 32
export Menu_Reset
proc Menu_Reset 0 0
line 5613
;5612:
;5613:void Menu_Reset() {
line 5614
;5614:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 5615
;5615:}
LABELV $2583
endproc Menu_Reset 0 0
export Display_GetContext
proc Display_GetContext 0 0
line 5617
;5616:
;5617:displayContextDef_t *Display_GetContext() {
line 5618
;5618:	return DC;
ADDRGP4 DC
INDIRP4
RETP4
LABELV $2584
endproc Display_GetContext 0 0
export Display_CaptureItem
proc Display_CaptureItem 8 12
line 5626
;5619:}
;5620: 
;5621:#ifndef MISSIONPACK // bk001206
;5622:static float captureX;
;5623:static float captureY;
;5624:#endif
;5625:
;5626:void *Display_CaptureItem(int x, int y) {
line 5629
;5627:	int i;
;5628:
;5629:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2589
JUMPV
LABELV $2586
line 5632
;5630:		// turn off focus each item
;5631:		// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5632:		if (Rect_ContainsPoint(&Menus[i].window.rect, x, y)) {
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2590
line 5633
;5633:			return &Menus[i];
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $2585
JUMPV
LABELV $2590
line 5635
;5634:		}
;5635:	}
LABELV $2587
line 5629
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2589
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2586
line 5636
;5636:	return NULL;
CNSTP4 0
RETP4
LABELV $2585
endproc Display_CaptureItem 8 12
export Display_MouseMove
proc Display_MouseMove 16 12
line 5641
;5637:}
;5638:
;5639:
;5640:// FIXME: 
;5641:qboolean Display_MouseMove(void *p, int x, int y) {
line 5643
;5642:	int i;
;5643:	menuDef_t *menu = p;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5645
;5644:
;5645:	if (menu == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2593
line 5646
;5646:    menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 5647
;5647:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2595
line 5648
;5648:			if (menu->window.flags & WINDOW_POPUP) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $2597
line 5649
;5649:				Menu_HandleMouseMove(menu, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 5650
;5650:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2592
JUMPV
LABELV $2597
line 5652
;5651:			}
;5652:		}
LABELV $2595
line 5653
;5653:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2602
JUMPV
LABELV $2599
line 5654
;5654:			Menu_HandleMouseMove(&Menus[i], x, y);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 5655
;5655:		}
LABELV $2600
line 5653
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2602
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2599
line 5656
;5656:	} else {
ADDRGP4 $2594
JUMPV
LABELV $2593
line 5657
;5657:		menu->window.rect.x += x;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 5658
;5658:		menu->window.rect.y += y;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 5659
;5659:		Menu_UpdatePosition(menu);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 5660
;5660:	}
LABELV $2594
line 5661
;5661: 	return qtrue;
CNSTI4 1
RETI4
LABELV $2592
endproc Display_MouseMove 16 12
export Display_CursorType
proc Display_CursorType 28 12
line 5665
;5662:
;5663:}
;5664:
;5665:int Display_CursorType(int x, int y) {
line 5667
;5666:	int i;
;5667:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2607
JUMPV
LABELV $2604
line 5669
;5668:		rectDef_t r2;
;5669:		r2.x = Menus[i].window.rect.x - 3;
ADDRLP4 4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5670
;5670:		r2.y = Menus[i].window.rect.y - 3;
ADDRLP4 4+4
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+4
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5671
;5671:		r2.w = r2.h = 7;
ADDRLP4 20
CNSTF4 1088421888
ASGNF4
ADDRLP4 4+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 20
INDIRF4
ASGNF4
line 5672
;5672:		if (Rect_ContainsPoint(&r2, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2612
line 5673
;5673:			return CURSOR_SIZER;
CNSTI4 4
RETI4
ADDRGP4 $2603
JUMPV
LABELV $2612
line 5675
;5674:		}
;5675:	}
LABELV $2605
line 5667
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2607
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2604
line 5676
;5676:	return CURSOR_ARROW;
CNSTI4 2
RETI4
LABELV $2603
endproc Display_CursorType 28 12
export Display_HandleKey
proc Display_HandleKey 12 12
line 5680
;5677:}
;5678:
;5679:
;5680:void Display_HandleKey(int key, qboolean down, int x, int y) {
line 5681
;5681:	menuDef_t *menu = Display_CaptureItem(x, y);
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5682
;5682:	if (menu == NULL) {  
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2615
line 5683
;5683:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 5684
;5684:	}
LABELV $2615
line 5685
;5685:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2617
line 5686
;5686:		Menu_HandleKey(menu, key, down );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 5687
;5687:	}
LABELV $2617
line 5688
;5688:}
LABELV $2614
endproc Display_HandleKey 12 12
proc Window_CacheContents 12 20
line 5690
;5689:
;5690:static void Window_CacheContents(windowDef_t *window) {
line 5691
;5691:	if (window) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2620
line 5692
;5692:		if (window->cinematicName) {
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2622
line 5693
;5693:			int cin = DC->playCinematic(window->cinematicName, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5694
;5694:			DC->stopCinematic(cin);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 5695
;5695:		}
LABELV $2622
line 5696
;5696:	}
LABELV $2620
line 5697
;5697:}
LABELV $2619
endproc Window_CacheContents 12 20
proc Item_CacheContents 0 4
line 5700
;5698:
;5699:
;5700:static void Item_CacheContents(itemDef_t *item) {
line 5701
;5701:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2625
line 5702
;5702:		Window_CacheContents(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5703
;5703:	}
LABELV $2625
line 5705
;5704:
;5705:}
LABELV $2624
endproc Item_CacheContents 0 4
proc Menu_CacheContents 8 8
line 5707
;5706:
;5707:static void Menu_CacheContents(menuDef_t *menu) {
line 5708
;5708:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2628
line 5710
;5709:		int i;
;5710:		Window_CacheContents(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5711
;5711:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2633
JUMPV
LABELV $2630
line 5712
;5712:			Item_CacheContents(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_CacheContents
CALLV
pop
line 5713
;5713:		}
LABELV $2631
line 5711
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2633
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2630
line 5715
;5714:
;5715:		if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2634
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2634
line 5716
;5716:			DC->registerSound(menu->soundName, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
pop
line 5717
;5717:		}
LABELV $2634
line 5718
;5718:	}
LABELV $2628
line 5720
;5719:
;5720:}
LABELV $2627
endproc Menu_CacheContents 8 8
export Display_CacheAll
proc Display_CacheAll 4 4
line 5722
;5721:
;5722:void Display_CacheAll() {
line 5724
;5723:	int i;
;5724:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2640
JUMPV
LABELV $2637
line 5725
;5725:		Menu_CacheContents(&Menus[i]);
CNSTI4 644
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CacheContents
CALLV
pop
line 5726
;5726:	}
LABELV $2638
line 5724
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2640
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2637
line 5727
;5727:}
LABELV $2636
endproc Display_CacheAll 4 4
proc Menu_OverActiveItem 32 12
line 5730
;5728:
;5729:
;5730:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y) {
line 5731
;5731: 	if (menu && menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED)) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2642
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $2642
line 5732
;5732:		if (Rect_ContainsPoint(&menu->window.rect, x, y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2644
line 5734
;5733:			int i;
;5734:			for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2649
JUMPV
LABELV $2646
line 5738
;5735:				// turn off focus each item
;5736:				// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5737:
;5738:				if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2650
line 5739
;5739:					continue;
ADDRGP4 $2647
JUMPV
LABELV $2650
line 5742
;5740:				}
;5741:
;5742:				if (menu->items[i]->window.flags & WINDOW_DECORATION) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2652
line 5743
;5743:					continue;
ADDRGP4 $2647
JUMPV
LABELV $2652
line 5746
;5744:				}
;5745:
;5746:				if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2654
line 5747
;5747:					itemDef_t *overItem = menu->items[i];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 5748
;5748:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2656
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2656
line 5749
;5749:						if (Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2647
line 5750
;5750:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2641
JUMPV
line 5751
;5751:						} else {
line 5752
;5752:							continue;
LABELV $2656
line 5754
;5753:						}
;5754:					} else {
line 5755
;5755:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2641
JUMPV
LABELV $2654
line 5758
;5756:					}
;5757:				}
;5758:			}
LABELV $2647
line 5734
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2649
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2646
line 5760
;5759:
;5760:		}
LABELV $2644
line 5761
;5761:	}
LABELV $2642
line 5762
;5762:	return qfalse;
CNSTI4 0
RETI4
LABELV $2641
endproc Menu_OverActiveItem 32 12
bss
export menuParseKeywordHash
align 4
LABELV menuParseKeywordHash
skip 2048
export itemParseKeywordHash
align 4
LABELV itemParseKeywordHash
skip 2048
export g_nameBind2
align 1
LABELV g_nameBind2
skip 32
export g_nameBind1
align 1
LABELV g_nameBind1
skip 32
align 4
LABELV strHandle
skip 8192
align 1
LABELV strPool
skip 393216
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 1048576
export menuStack
align 4
LABELV menuStack
skip 64
export Menus
align 4
LABELV Menus
skip 41216
align 4
LABELV scrollInfo
skip 32
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Script_Parse
import Display_ExpandMacros
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
LABELV $2582
byte 1 102
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $2564
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2560
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2553
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $2536
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2535
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2534
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2533
byte 1 112
byte 1 111
byte 1 112
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2532
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $2531
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $2530
byte 1 111
byte 1 117
byte 1 116
byte 1 79
byte 1 102
byte 1 66
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2529
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2528
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2527
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2526
byte 1 111
byte 1 110
byte 1 69
byte 1 83
byte 1 67
byte 1 0
align 1
LABELV $2525
byte 1 111
byte 1 110
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $2524
byte 1 111
byte 1 110
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2523
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2522
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2423
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2404
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2400
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2377
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2376
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $2375
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2374
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2373
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2372
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 84
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2371
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2370
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2369
byte 1 97
byte 1 100
byte 1 100
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2368
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2367
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 83
byte 1 116
byte 1 114
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2366
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2365
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $2364
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2363
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2362
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2361
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2360
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2359
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2358
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2357
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2356
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2355
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2354
byte 1 111
byte 1 110
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2353
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $2352
byte 1 111
byte 1 117
byte 1 116
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2351
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2350
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2349
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $2348
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 120
byte 1 0
align 1
LABELV $2347
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $2346
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $2345
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $2344
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2343
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2342
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2341
byte 1 99
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $2340
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2339
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2338
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2337
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2336
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2335
byte 1 104
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2334
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2333
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2332
byte 1 110
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2331
byte 1 100
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2330
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2329
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $2328
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2327
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2326
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 121
byte 1 0
align 1
LABELV $2325
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 120
byte 1 0
align 1
LABELV $2324
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2323
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2322
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $2321
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2320
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2319
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2256
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $1610
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $1580
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $1579
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $1549
byte 1 105
byte 1 110
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1516
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $1515
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $1514
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1513
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1512
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1511
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $1510
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1509
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1508
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1507
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 80
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1506
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1505
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 83
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1504
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 119
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1503
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 69
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1502
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1501
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1500
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 67
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $1499
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 80
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $1498
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1497
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1496
byte 1 100
byte 1 101
byte 1 110
byte 1 121
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1495
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1494
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1493
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1492
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1491
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 52
byte 1 0
align 1
LABELV $1490
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1489
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $1488
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $1487
byte 1 43
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1486
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $1485
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $1484
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $1483
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $1482
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 57
byte 1 0
align 1
LABELV $1481
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 56
byte 1 0
align 1
LABELV $1480
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 55
byte 1 0
align 1
LABELV $1479
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 54
byte 1 0
align 1
LABELV $1478
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 53
byte 1 0
align 1
LABELV $1477
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 52
byte 1 0
align 1
LABELV $1476
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 51
byte 1 0
align 1
LABELV $1475
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 50
byte 1 0
align 1
LABELV $1474
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $1473
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $1472
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1471
byte 1 43
byte 1 109
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1470
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1469
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1468
byte 1 43
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 102
byte 1 101
byte 1 0
align 1
LABELV $1467
byte 1 43
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1466
byte 1 43
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1465
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1464
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1463
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1462
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1461
byte 1 43
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1460
byte 1 43
byte 1 102
byte 1 111
byte 1 114
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $1459
byte 1 43
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1458
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $1457
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1440
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $1439
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1283
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1279
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1132
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $956
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $902
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $564
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $563
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $562
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $561
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $560
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $559
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $558
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $557
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $556
byte 1 115
byte 1 101
byte 1 116
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $555
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $554
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $553
byte 1 115
byte 1 101
byte 1 116
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $552
byte 1 115
byte 1 101
byte 1 116
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $551
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $550
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $549
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $548
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $547
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $546
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $545
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $544
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $537
byte 1 37
byte 1 115
byte 1 32
byte 1 59
byte 1 32
byte 1 0
align 1
LABELV $530
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $526
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $365
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $362
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $359
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $201
byte 1 32
byte 1 0
align 1
LABELV $198
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $193
byte 1 125
byte 1 0
align 1
LABELV $184
byte 1 123
byte 1 0
align 1
LABELV $148
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $115
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $92
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $88
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $77
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $76
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $75
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $74
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 47
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $55
byte 1 0
align 1
LABELV $46
byte 1 85
byte 1 73
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 46
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 33
byte 1 10
byte 1 0
