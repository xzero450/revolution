export Com_Clamp
code
proc Com_Clamp 0 0
file "../q_shared.c"
line 6
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// q_shared.c -- stateless support routines that are included in each code dll
;4:#include "q_shared.h"
;5:
;6:float Com_Clamp( float min, float max, float value ) {
line 7
;7:	if ( value < min ) {
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $24
line 8
;8:		return min;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $23
JUMPV
LABELV $24
line 10
;9:	}
;10:	if ( value > max ) {
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $26
line 11
;11:		return max;
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $23
JUMPV
LABELV $26
line 13
;12:	}
;13:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $23
endproc Com_Clamp 0 0
export COM_SkipPath
proc COM_SkipPath 4 0
line 23
;14:}
;15:
;16:
;17:/*
;18:============
;19:COM_SkipPath
;20:============
;21:*/
;22:char *COM_SkipPath (char *pathname)
;23:{
line 26
;24:	char	*last;
;25:	
;26:	last = pathname;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $30
JUMPV
LABELV $29
line 28
;27:	while (*pathname)
;28:	{
line 29
;29:		if (*pathname=='/')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $32
line 30
;30:			last = pathname+1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $32
line 31
;31:		pathname++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 32
;32:	}
LABELV $30
line 27
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $29
line 33
;33:	return last;
ADDRLP4 0
INDIRP4
RETP4
LABELV $28
endproc COM_SkipPath 4 0
export COM_StripExtension
proc COM_StripExtension 12 0
line 41
;34:}
;35:
;36:/*
;37:============
;38:COM_StripExtension
;39:============
;40:*/
;41:void COM_StripExtension( const char *in, char *out ) {
ADDRGP4 $36
JUMPV
LABELV $35
line 42
;42:	while ( *in && *in != '.' ) {
line 43
;43:		*out++ = *in++;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI1
ASGNI1
line 44
;44:	}
LABELV $36
line 42
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $38
ADDRLP4 0
INDIRI4
CNSTI4 46
NEI4 $35
LABELV $38
line 45
;45:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 46
;46:}
LABELV $34
endproc COM_StripExtension 12 0
export COM_DefaultExtension
proc COM_DefaultExtension 76 20
line 54
;47:
;48:
;49:/*
;50:==================
;51:COM_DefaultExtension
;52:==================
;53:*/
;54:void COM_DefaultExtension (char *path, int maxSize, const char *extension ) {
line 62
;55:	char	oldPath[MAX_QPATH];
;56:	char    *src;
;57:
;58://
;59:// if path doesn't have a .EXT, append extension
;60:// (extension should include the .)
;61://
;62:	src = path + strlen(path) - 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 68
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI4 -1
ADDP4
ASGNP4
ADDRGP4 $41
JUMPV
LABELV $40
line 64
;63:
;64:	while (*src != '/' && src != path) {
line 65
;65:		if ( *src == '.' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $43
line 66
;66:			return;                 // it has an extension
ADDRGP4 $39
JUMPV
LABELV $43
line 68
;67:		}
;68:		src--;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 69
;69:	}
LABELV $41
line 64
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $45
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $40
LABELV $45
line 71
;70:
;71:	Q_strncpyz( oldPath, path, sizeof( oldPath ) );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 72
;72:	Com_sprintf( path, maxSize, "%s%s", oldPath, extension );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $46
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 73
;73:}
LABELV $39
endproc COM_DefaultExtension 76 20
export ShortSwap
proc ShortSwap 2 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 105
;74:
;75:/*
;76:============================================================================
;77:
;78:					BYTE ORDER FUNCTIONS
;79:
;80:============================================================================
;81:*/
;82:/*
;83:// can't just use function pointers, or dll linkage can
;84:// mess up when qcommon is included in multiple places
;85:static short	(*_BigShort) (short l);
;86:static short	(*_LittleShort) (short l);
;87:static int		(*_BigLong) (int l);
;88:static int		(*_LittleLong) (int l);
;89:static qint64	(*_BigLong64) (qint64 l);
;90:static qint64	(*_LittleLong64) (qint64 l);
;91:static float	(*_BigFloat) (const float *l);
;92:static float	(*_LittleFloat) (const float *l);
;93:
;94:short	BigShort(short l){return _BigShort(l);}
;95:short	LittleShort(short l) {return _LittleShort(l);}
;96:int		BigLong (int l) {return _BigLong(l);}
;97:int		LittleLong (int l) {return _LittleLong(l);}
;98:qint64 	BigLong64 (qint64 l) {return _BigLong64(l);}
;99:qint64 	LittleLong64 (qint64 l) {return _LittleLong64(l);}
;100:float	BigFloat (const float *l) {return _BigFloat(l);}
;101:float	LittleFloat (const float *l) {return _LittleFloat(l);}
;102:*/
;103:
;104:short   ShortSwap (short l)
;105:{
line 108
;106:	byte    b1,b2;
;107:
;108:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 109
;109:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 111
;110:
;111:	return (b1<<8) + b2;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
ADDI4
CVII2 4
CVII4 2
RETI4
LABELV $47
endproc ShortSwap 2 0
export ShortNoSwap
proc ShortNoSwap 0 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 115
;112:}
;113:
;114:short	ShortNoSwap (short l)
;115:{
line 116
;116:	return l;
ADDRFP4 0
INDIRI2
CVII4 2
RETI4
LABELV $48
endproc ShortNoSwap 0 0
export LongSwap
proc LongSwap 4 0
line 120
;117:}
;118:
;119:int    LongSwap (int l)
;120:{
line 123
;121:	byte    b1,b2,b3,b4;
;122:
;123:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 124
;124:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 125
;125:	b3 = (l>>16)&255;
ADDRLP4 2
ADDRFP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 126
;126:	b4 = (l>>24)&255;
ADDRLP4 3
ADDRFP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 128
;127:
;128:	return ((int)b1<<24) + ((int)b2<<16) + ((int)b3<<8) + b4;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 24
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
CNSTI4 16
LSHI4
ADDI4
ADDRLP4 2
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDI4
ADDRLP4 3
INDIRU1
CVUI4 1
ADDI4
RETI4
LABELV $49
endproc LongSwap 4 0
export LongNoSwap
proc LongNoSwap 0 0
line 132
;129:}
;130:
;131:int	LongNoSwap (int l)
;132:{
line 133
;133:	return l;
ADDRFP4 0
INDIRI4
RETI4
LABELV $50
endproc LongNoSwap 0 0
export Long64Swap
proc Long64Swap 8 0
line 137
;134:}
;135:
;136:qint64 Long64Swap (qint64 ll)
;137:{
line 140
;138:	qint64	result;
;139:
;140:	result.b0 = ll.b7;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 7
ADDP4
INDIRU1
ASGNU1
line 141
;141:	result.b1 = ll.b6;
ADDRLP4 0+1
ADDRFP4 4
INDIRP4
CNSTI4 6
ADDP4
INDIRU1
ASGNU1
line 142
;142:	result.b2 = ll.b5;
ADDRLP4 0+2
ADDRFP4 4
INDIRP4
CNSTI4 5
ADDP4
INDIRU1
ASGNU1
line 143
;143:	result.b3 = ll.b4;
ADDRLP4 0+3
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRU1
ASGNU1
line 144
;144:	result.b4 = ll.b3;
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 3
ADDP4
INDIRU1
ASGNU1
line 145
;145:	result.b5 = ll.b2;
ADDRLP4 0+5
ADDRFP4 4
INDIRP4
CNSTI4 2
ADDP4
INDIRU1
ASGNU1
line 146
;146:	result.b6 = ll.b1;
ADDRLP4 0+6
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
ASGNU1
line 147
;147:	result.b7 = ll.b0;
ADDRLP4 0+7
ADDRFP4 4
INDIRP4
INDIRU1
ASGNU1
line 149
;148:
;149:	return result;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 8
LABELV $51
endproc Long64Swap 8 0
export Long64NoSwap
proc Long64NoSwap 0 0
line 153
;150:}
;151:
;152:qint64 Long64NoSwap (qint64 ll)
;153:{
line 154
;154:	return ll;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 8
LABELV $60
endproc Long64NoSwap 0 0
export FloatSwap
proc FloatSwap 12 4
line 162
;155:}
;156:
;157:typedef union {
;158:    float	f;
;159:    unsigned int i;
;160:} _FloatByteUnion;
;161:
;162:float FloatSwap (const float *f) {
line 166
;163:	const _FloatByteUnion *in;
;164:	_FloatByteUnion out;
;165:
;166:	in = (_FloatByteUnion *)f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 167
;167:	out.i = LongSwap(in->i);
ADDRLP4 0
INDIRP4
INDIRU4
CVUI4 4
ARGI4
ADDRLP4 8
ADDRGP4 LongSwap
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIU4 4
ASGNU4
line 169
;168:
;169:	return out.f;
ADDRLP4 4
INDIRF4
RETF4
LABELV $63
endproc FloatSwap 12 4
export FloatNoSwap
proc FloatNoSwap 0 0
line 173
;170:}
;171:
;172:float FloatNoSwap (const float *f)
;173:{
line 174
;174:	return *f;
ADDRFP4 0
INDIRP4
INDIRF4
RETF4
LABELV $64
endproc FloatNoSwap 0 0
export COM_BeginParseSession
proc COM_BeginParseSession 0 16
line 227
;175:}
;176:
;177:/*
;178:================
;179:Swap_Init
;180:================
;181:*/
;182:/*
;183:void Swap_Init (void)
;184:{
;185:	byte	swaptest[2] = {1,0};
;186:
;187:// set the byte swapping variables in a portable manner	
;188:	if ( *(short *)swaptest == 1)
;189:	{
;190:		_BigShort = ShortSwap;
;191:		_LittleShort = ShortNoSwap;
;192:		_BigLong = LongSwap;
;193:		_LittleLong = LongNoSwap;
;194:		_BigLong64 = Long64Swap;
;195:		_LittleLong64 = Long64NoSwap;
;196:		_BigFloat = FloatSwap;
;197:		_LittleFloat = FloatNoSwap;
;198:	}
;199:	else
;200:	{
;201:		_BigShort = ShortNoSwap;
;202:		_LittleShort = ShortSwap;
;203:		_BigLong = LongNoSwap;
;204:		_LittleLong = LongSwap;
;205:		_BigLong64 = Long64NoSwap;
;206:		_LittleLong64 = Long64Swap;
;207:		_BigFloat = FloatNoSwap;
;208:		_LittleFloat = FloatSwap;
;209:	}
;210:
;211:}
;212:*/
;213:
;214:/*
;215:============================================================================
;216:
;217:PARSING
;218:
;219:============================================================================
;220:*/
;221:
;222:static	char	com_token[MAX_TOKEN_CHARS];
;223:static	char	com_parsename[MAX_TOKEN_CHARS];
;224:static	int		com_lines;
;225:
;226:void COM_BeginParseSession( const char *name )
;227:{
line 228
;228:	com_lines = 0;
ADDRGP4 com_lines
CNSTI4 0
ASGNI4
line 229
;229:	Com_sprintf(com_parsename, sizeof(com_parsename), "%s", name);
ADDRGP4 com_parsename
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $66
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 230
;230:}
LABELV $65
endproc COM_BeginParseSession 0 16
export COM_GetCurrentParseLine
proc COM_GetCurrentParseLine 0 0
line 233
;231:
;232:int COM_GetCurrentParseLine( void )
;233:{
line 234
;234:	return com_lines;
ADDRGP4 com_lines
INDIRI4
RETI4
LABELV $67
endproc COM_GetCurrentParseLine 0 0
export COM_Parse
proc COM_Parse 4 8
line 238
;235:}
;236:
;237:char *COM_Parse( char **data_p )
;238:{
line 239
;239:	return COM_ParseExt( data_p, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $68
endproc COM_Parse 4 8
bss
align 1
LABELV $70
skip 4096
export COM_ParseError
code
proc COM_ParseError 4 16
line 243
;240:}
;241:
;242:void COM_ParseError( char *format, ... )
;243:{
line 247
;244:	va_list argptr;
;245:	static char string[4096];
;246:
;247:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 248
;248:	vsprintf (string, format, argptr);
ADDRGP4 $70
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 249
;249:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 251
;250:
;251:	Com_Printf("ERROR: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $72
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $70
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 252
;252:}
LABELV $69
endproc COM_ParseError 4 16
bss
align 1
LABELV $74
skip 4096
export COM_ParseWarning
code
proc COM_ParseWarning 4 16
line 255
;253:
;254:void COM_ParseWarning( char *format, ... )
;255:{
line 259
;256:	va_list argptr;
;257:	static char string[4096];
;258:
;259:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 260
;260:	vsprintf (string, format, argptr);
ADDRGP4 $74
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 261
;261:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 263
;262:
;263:	Com_Printf("WARNING: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $76
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $74
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 264
;264:}
LABELV $73
endproc COM_ParseWarning 4 16
proc SkipWhitespace 8 0
line 278
;265:
;266:/*
;267:==============
;268:COM_Parse
;269:
;270:Parse a token out of a string
;271:Will never return NULL, just empty strings
;272:
;273:If "allowLineBreaks" is qtrue then an empty
;274:string will be returned if the next token is
;275:a newline.
;276:==============
;277:*/
;278:static char *SkipWhitespace( char *data, qboolean *hasNewLines ) {
ADDRGP4 $79
JUMPV
LABELV $78
line 281
;279:	int c;
;280:
;281:	while( (c = *data) <= ' ') {
line 282
;282:		if( !c ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $81
line 283
;283:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $77
JUMPV
LABELV $81
line 285
;284:		}
;285:		if( c == '\n' ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $83
line 286
;286:			com_lines++;
ADDRLP4 4
ADDRGP4 com_lines
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 287
;287:			*hasNewLines = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 288
;288:		}
LABELV $83
line 289
;289:		data++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 290
;290:	}
LABELV $79
line 281
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $78
line 292
;291:
;292:	return data;
ADDRFP4 0
INDIRP4
RETP4
LABELV $77
endproc SkipWhitespace 8 0
export COM_Compress
proc COM_Compress 48 0
line 295
;293:}
;294:
;295:int COM_Compress( char *data_p ) {
line 298
;296:	char *in, *out;
;297:	int c;
;298:	qboolean newline = qfalse, whitespace = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 300
;299:
;300:	in = out = data_p;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 301
;301:	if (in) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $86
ADDRGP4 $89
JUMPV
LABELV $88
line 302
;302:		while ((c = *in) != 0) {
line 304
;303:			// skip double slash comments
;304:			if ( c == '/' && in[1] == '/' ) {
ADDRLP4 24
CNSTI4 47
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $91
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
NEI4 $91
ADDRGP4 $94
JUMPV
LABELV $93
line 305
;305:				while (*in && *in != '\n') {
line 306
;306:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 307
;307:				}
LABELV $94
line 305
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $96
ADDRLP4 28
INDIRI4
CNSTI4 10
NEI4 $93
LABELV $96
line 309
;308:			// skip /* */ comments
;309:			} else if ( c == '/' && in[1] == '*' ) {
ADDRGP4 $92
JUMPV
LABELV $91
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $97
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $97
ADDRGP4 $100
JUMPV
LABELV $99
line 311
;310:				while ( *in && ( *in != '*' || in[1] != '/' ) ) 
;311:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $100
line 310
ADDRLP4 32
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $102
ADDRLP4 32
INDIRI4
CNSTI4 42
NEI4 $99
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $99
LABELV $102
line 312
;312:				if ( *in ) 
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $98
line 313
;313:					in += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 315
;314:                        // record when we hit a newline
;315:                        } else if ( c == '\n' || c == '\r' ) {
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $107
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $105
LABELV $107
line 316
;316:                            newline = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 317
;317:                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 319
;318:                        // record when we hit whitespace
;319:                        } else if ( c == ' ' || c == '\t') {
ADDRGP4 $106
JUMPV
LABELV $105
ADDRLP4 4
INDIRI4
CNSTI4 32
EQI4 $110
ADDRLP4 4
INDIRI4
CNSTI4 9
NEI4 $108
LABELV $110
line 320
;320:                            whitespace = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 321
;321:                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 323
;322:                        // an actual token
;323:			} else {
ADDRGP4 $109
JUMPV
LABELV $108
line 325
;324:                            // if we have a pending newline, emit it (and it counts as whitespace)
;325:                            if (newline) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $111
line 326
;326:                                *out++ = '\n';
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI1 10
ASGNI1
line 327
;327:                                newline = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 328
;328:                                whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 329
;329:                            } if (whitespace) {
LABELV $111
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $113
line 330
;330:                                *out++ = ' ';
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI1 32
ASGNI1
line 331
;331:                                whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 332
;332:                            }
LABELV $113
line 335
;333:                            
;334:                            // copy quoted strings unmolested
;335:                            if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $115
line 336
;336:                                    *out++ = c;
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 337
;337:                                    in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $118
JUMPV
LABELV $117
line 338
;338:                                    while (1) {
line 339
;339:                                        c = *in;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 340
;340:                                        if (c && c != '"') {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $119
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $119
line 341
;341:                                            *out++ = c;
ADDRLP4 44
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 342
;342:                                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 343
;343:                                        } else {
line 344
;344:                                            break;
LABELV $121
line 346
;345:                                        }
;346:                                    }
LABELV $118
line 338
ADDRGP4 $117
JUMPV
LABELV $119
line 347
;347:                                    if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $116
line 348
;348:                                        *out++ = c;
ADDRLP4 40
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 349
;349:                                        in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 350
;350:                                    }
line 351
;351:                            } else {
ADDRGP4 $116
JUMPV
LABELV $115
line 352
;352:                                *out = c;
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 353
;353:                                out++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 354
;354:                                in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 355
;355:                            }
LABELV $116
line 356
;356:			}
LABELV $109
LABELV $106
LABELV $98
LABELV $92
line 357
;357:		}
LABELV $89
line 302
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $88
line 358
;358:	}
LABELV $86
line 359
;359:	*out = 0;
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 360
;360:	return out - data_p;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
RETI4
LABELV $85
endproc COM_Compress 48 0
export COM_ParseExt
proc COM_ParseExt 36 8
line 364
;361:}
;362:
;363:char *COM_ParseExt( char **data_p, qboolean allowLineBreaks )
;364:{
line 365
;365:	int c = 0, len;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 366
;366:	qboolean hasNewLines = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 369
;367:	char *data;
;368:
;369:	data = *data_p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 370
;370:	len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 371
;371:	com_token[0] = 0;
ADDRGP4 com_token
CNSTI1 0
ASGNI1
line 374
;372:
;373:	// make sure incoming data is valid
;374:	if ( !data )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $128
line 375
;375:	{
line 376
;376:		*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 377
;377:		return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $124
JUMPV
LABELV $127
line 381
;378:	}
;379:
;380:	while ( 1 )
;381:	{
line 383
;382:		// skip whitespace
;383:		data = SkipWhitespace( data, &hasNewLines );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 SkipWhitespace
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 384
;384:		if ( !data )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $130
line 385
;385:		{
line 386
;386:			*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 387
;387:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $124
JUMPV
LABELV $130
line 389
;388:		}
;389:		if ( hasNewLines && !allowLineBreaks )
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $132
ADDRFP4 4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $132
line 390
;390:		{
line 391
;391:			*data_p = data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 392
;392:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $124
JUMPV
LABELV $132
line 395
;393:		}
;394:
;395:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 398
;396:
;397:		// skip double slash comments
;398:		if ( c == '/' && data[1] == '/' )
ADDRLP4 24
CNSTI4 47
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $134
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
NEI4 $134
line 399
;399:		{
line 400
;400:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $137
JUMPV
LABELV $136
line 401
;401:			while (*data && *data != '\n') {
line 402
;402:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 403
;403:			}
LABELV $137
line 401
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $139
ADDRLP4 28
INDIRI4
CNSTI4 10
NEI4 $136
LABELV $139
line 404
;404:		}
ADDRGP4 $135
JUMPV
LABELV $134
line 406
;405:		// skip /* */ comments
;406:		else if ( c=='/' && data[1] == '*' ) 
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $129
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $129
line 407
;407:		{
line 408
;408:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $142
line 410
;409:			while ( *data && ( *data != '*' || data[1] != '/' ) ) 
;410:			{
line 411
;411:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 412
;412:			}
LABELV $143
line 409
ADDRLP4 32
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $145
ADDRLP4 32
INDIRI4
CNSTI4 42
NEI4 $142
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $142
LABELV $145
line 413
;413:			if ( *data ) 
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $141
line 414
;414:			{
line 415
;415:				data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 416
;416:			}
line 417
;417:		}
line 419
;418:		else
;419:		{
line 420
;420:			break;
LABELV $141
LABELV $135
line 422
;421:		}
;422:	}
LABELV $128
line 380
ADDRGP4 $127
JUMPV
LABELV $129
line 425
;423:
;424:	// handle quoted strings
;425:	if (c == '\"')
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $148
line 426
;426:	{
line 427
;427:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $151
JUMPV
LABELV $150
line 429
;428:		while (1)
;429:		{
line 430
;430:			c = *data++;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 431
;431:			if (c=='\"' || !c)
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $155
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $153
LABELV $155
line 432
;432:			{
line 433
;433:				com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 434
;434:				*data_p = ( char * ) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 435
;435:				return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $124
JUMPV
LABELV $153
line 437
;436:			}
;437:			if (len < MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
GEI4 $156
line 438
;438:			{
line 439
;439:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 440
;440:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 441
;441:			}
LABELV $156
line 442
;442:		}
LABELV $151
line 428
ADDRGP4 $150
JUMPV
line 443
;443:	}
LABELV $148
LABELV $158
line 447
;444:
;445:	// parse a regular word
;446:	do
;447:	{
line 448
;448:		if (len < MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
GEI4 $161
line 449
;449:		{
line 450
;450:			com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 451
;451:			len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 452
;452:		}
LABELV $161
line 453
;453:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 454
;454:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 455
;455:		if ( c == '\n' )
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $163
line 456
;456:			com_lines++;
ADDRLP4 16
ADDRGP4 com_lines
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $163
line 457
;457:	} while (c>32);
LABELV $159
ADDRLP4 4
INDIRI4
CNSTI4 32
GTI4 $158
line 459
;458:
;459:	if (len == MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
NEI4 $165
line 460
;460:	{
line 462
;461://		Com_Printf ("Token exceeded %i chars, discarded.\n", MAX_TOKEN_CHARS);
;462:		len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 463
;463:	}
LABELV $165
line 464
;464:	com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 466
;465:
;466:	*data_p = ( char * ) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 467
;467:	return com_token;
ADDRGP4 com_token
RETP4
LABELV $124
endproc COM_ParseExt 36 8
export GetToken
proc GetToken 24 0
line 471
;468:}
;469:
;470:token_type GetToken(char *token, char **line)
;471:{
line 473
;472:	char *ptr;
;473:	token_type ret = T_TOKEN;
ADDRLP4 4
CNSTI4 5
ASGNI4
line 475
;474:
;475:	if((**line) == '\0')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $168
line 476
;476:	{
line 477
;477:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 478
;478:		return T_EOF;
CNSTI4 0
RETI4
ADDRGP4 $167
JUMPV
LABELV $168
line 481
;479:	}
;480:
;481:	ptr = token;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $172
JUMPV
LABELV $171
line 486
;482:
;483:t_start:
;484:	//scan off leading spaces, tabs, commas and newlines
;485:	while(((**line) == ' ') || ((**line) == '\t') || ((**line) == '\n') || ((**line) == 0xd) || ((**line) == ','))
;486:		(*line)++;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $172
line 485
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 32
EQI4 $171
ADDRLP4 12
INDIRI4
CNSTI4 9
EQI4 $171
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $171
ADDRLP4 12
INDIRI4
CNSTI4 13
EQI4 $171
ADDRLP4 12
INDIRI4
CNSTI4 44
EQI4 $171
line 488
;487:
;488:	if((**line) == ';')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $174
line 489
;489:	{
line 490
;490:		(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 491
;491:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 492
;492:		return T_SEMI;
CNSTI4 1
RETI4
ADDRGP4 $167
JUMPV
LABELV $174
line 494
;493:	}
;494:	else if((**line) == '{')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $176
line 495
;495:	{
line 496
;496:		(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 497
;497:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 498
;498:		return T_BEGIN_BRACKET;
CNSTI4 2
RETI4
ADDRGP4 $167
JUMPV
LABELV $176
line 500
;499:	}
;500:	else if((**line) == '}')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $178
line 501
;501:	{
line 502
;502:		(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 503
;503:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 504
;504:		return T_END_BRACKET;
CNSTI4 3
RETI4
ADDRGP4 $167
JUMPV
LABELV $178
line 506
;505:	}
;506:	else if((**line) == '#')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 35
NEI4 $180
line 507
;507:	{
ADDRGP4 $183
JUMPV
LABELV $182
line 510
;508:		//comments
;509:		while(((**line) != '\n') && ((**line) != 0xd))
;510:		{
line 511
;511:			if((**line) == '\0')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $185
line 512
;512:			{
line 513
;513:				*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 514
;514:				return T_EOF;
CNSTI4 0
RETI4
ADDRGP4 $167
JUMPV
LABELV $185
line 517
;515:			}
;516:
;517:			(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 518
;518:		}
LABELV $183
line 509
ADDRLP4 16
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 10
EQI4 $187
ADDRLP4 16
INDIRI4
CNSTI4 13
NEI4 $182
LABELV $187
line 520
;519:
;520:		goto t_start;
ADDRGP4 $172
JUMPV
LABELV $180
line 522
;521:	}
;522:	else if((**line) == '"')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 34
NEI4 $188
line 523
;523:	{
line 524
;524:		(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $191
JUMPV
LABELV $190
line 528
;525:
;526:		//string
;527:		while((**line) != '"')
;528:		{
line 529
;529:			if((**line) == '\0')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $193
line 530
;530:			{
line 531
;531:				*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 532
;532:				return T_EOF;
CNSTI4 0
RETI4
ADDRGP4 $167
JUMPV
LABELV $193
line 535
;533:			}
;534:
;535:			(*ptr) = (**line);
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
ASGNI1
line 536
;536:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 537
;537:			(*line)++;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 538
;538:		}
LABELV $191
line 527
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 34
NEI4 $190
line 540
;539:
;540:		(*line)++;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 541
;541:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 542
;542:		return T_STRING;
CNSTI4 4
RETI4
ADDRGP4 $167
JUMPV
LABELV $188
line 544
;543:	}
;544:	else if((**line) == '\0')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $198
line 545
;545:	{
line 546
;546:		*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 547
;547:		return T_EOF;
CNSTI4 0
RETI4
ADDRGP4 $167
JUMPV
LABELV $197
line 552
;548:	}
;549:
;550:	//parse the token
;551:	while(((**line) != ' ') && ((**line) != '\t') && ((**line) != '\n') && ((**line) != 0xd) && ((**line) != ',') && ((**line) != ';') && ((**line) != '{') && ((**line) != '}'))
;552:	{
line 553
;553:		if((**line) == '\0')
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $200
line 554
;554:			break;
ADDRGP4 $199
JUMPV
LABELV $200
line 563
;555:/*
;556:		if(((**line) == ';'))
;557:		{
;558:			(*line)++;			//skip over the semi
;559:			ret = T_SEMI;
;560:			break;
;561:		}
;562:*/
;563:		(*ptr) = (**line);
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
ASGNI1
line 564
;564:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 565
;565:		(*line)++;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 566
;566:	}
LABELV $198
line 551
ADDRLP4 16
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 32
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 9
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 10
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 44
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 59
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 123
EQI4 $208
ADDRLP4 16
INDIRI4
CNSTI4 125
NEI4 $197
LABELV $208
LABELV $199
line 568
;567:
;568:	*ptr = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 570
;569:	
;570:	return ret;
ADDRLP4 4
INDIRI4
RETI4
LABELV $167
endproc GetToken 24 0
export HelpParse
proc HelpParse 180 8
line 575
;571:}
;572:
;573:char explanation[2048];
;574:char *HelpParse(char *needle, char *haystack, qboolean listcmds)
;575:{
line 580
;576:	char *ptr;
;577:	char token[128];
;578:	int i, j, k, l, m, tmpi;
;579:
;580:	ptr = haystack;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
line 583
;581:
;582:	//this loops through each command listed in the file
;583:	j = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 584
;584:	l = 0;		//counter for columns in listcmds
ADDRLP4 152
CNSTI4 0
ASGNI4
line 585
;585:	explanation[0] = '\0';
ADDRGP4 explanation
CNSTI1 0
ASGNI1
ADDRGP4 $211
JUMPV
line 587
;586:	while(*ptr != '\0')
;587:	{
LABELV $213
line 589
;588:		while((*ptr == ' ') || (*ptr == '\t') || (*ptr == '\n') || (*ptr == 0xd))
;589:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $214
line 588
ADDRLP4 156
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 32
EQI4 $213
ADDRLP4 156
INDIRI4
CNSTI4 9
EQI4 $213
ADDRLP4 156
INDIRI4
CNSTI4 10
EQI4 $213
ADDRLP4 156
INDIRI4
CNSTI4 13
EQI4 $213
line 591
;590:
;591:		if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $216
line 592
;592:		{
line 593
;593:			if(listcmds)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $218
line 594
;594:				return explanation;
ADDRGP4 explanation
RETP4
ADDRGP4 $209
JUMPV
LABELV $218
line 596
;595:			else
;596:				return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $216
line 600
;597:		}
;598:
;599:		//get the command name
;600:		i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $221
JUMPV
LABELV $220
line 602
;601:		while((*ptr != ' ') && (*ptr != '\t') && (*ptr != '\n') && (*ptr != 0xd) && (*ptr != '{'))
;602:		{
line 603
;603:			if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $223
line 604
;604:			{
line 605
;605:				if(listcmds)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $225
line 606
;606:					return explanation;
ADDRGP4 explanation
RETP4
ADDRGP4 $209
JUMPV
LABELV $225
line 608
;607:				else
;608:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $223
line 611
;609:			}
;610:
;611:			if(i >= 127)
ADDRLP4 4
INDIRI4
CNSTI4 127
LTI4 $227
line 612
;612:			{
line 613
;613:				Com_Printf(""S_COLOR_RED"ERROR: Memory array overflow (token)\n");
ADDRGP4 $229
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 614
;614:				return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $227
line 617
;615:			}
;616:
;617:			token[i] = *ptr;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 618
;618:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 619
;619:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 620
;620:		}
LABELV $221
line 601
ADDRLP4 160
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 32
EQI4 $233
ADDRLP4 160
INDIRI4
CNSTI4 9
EQI4 $233
ADDRLP4 160
INDIRI4
CNSTI4 10
EQI4 $233
ADDRLP4 160
INDIRI4
CNSTI4 13
EQI4 $233
ADDRLP4 160
INDIRI4
CNSTI4 123
NEI4 $220
LABELV $233
line 622
;621:
;622:		if(listcmds)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $234
line 623
;623:		{
line 624
;624:			for(k = 0; k < i; k++)
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $239
JUMPV
LABELV $236
line 625
;625:			{
line 626
;626:				if(j >= 2047)
ADDRLP4 136
INDIRI4
CNSTI4 2047
LTI4 $240
line 627
;627:				{
line 628
;628:					Com_Printf(""S_COLOR_RED"ERROR: Memory array overflow (explanation buffering)\n");
ADDRGP4 $242
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 629
;629:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $240
line 632
;630:				}
;631:
;632:				explanation[j] = token[k];
ADDRLP4 136
INDIRI4
ADDRGP4 explanation
ADDP4
ADDRLP4 140
INDIRI4
ADDRLP4 8
ADDP4
INDIRI1
ASGNI1
line 633
;633:				j++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 634
;634:			}
LABELV $237
line 624
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $239
ADDRLP4 140
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $236
line 636
;635:
;636:			if(j >= 2046)
ADDRLP4 136
INDIRI4
CNSTI4 2046
LTI4 $243
line 637
;637:			{
line 638
;638:				Com_Printf(""S_COLOR_RED"ERROR: Memory array overflow (explanation)\n");
ADDRGP4 $245
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 639
;639:				return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $243
line 642
;640:			}
;641:
;642:			if(l != 2)
ADDRLP4 152
INDIRI4
CNSTI4 2
EQI4 $246
line 643
;643:			{
line 645
;644:				//TODO: this allows only commands/cvars of length 25 chars or less to be displayed
;645:				if(i > 25)
ADDRLP4 4
INDIRI4
CNSTI4 25
LEI4 $248
line 646
;646:					tmpi = 25;
ADDRLP4 148
CNSTI4 25
ASGNI4
ADDRGP4 $249
JUMPV
LABELV $248
line 648
;647:				else
;648:					tmpi = i;
ADDRLP4 148
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $249
line 650
;649:
;650:				for(m = 0; m < (25 - tmpi); m++)
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $253
JUMPV
LABELV $250
line 651
;651:				{
line 652
;652:					explanation[j] = ' ';
ADDRLP4 136
INDIRI4
ADDRGP4 explanation
ADDP4
CNSTI1 32
ASGNI1
line 653
;653:					j++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 654
;654:				}
LABELV $251
line 650
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $253
ADDRLP4 144
INDIRI4
CNSTI4 25
ADDRLP4 148
INDIRI4
SUBI4
LTI4 $250
line 656
;655:
;656:				l++;
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 657
;657:			}
ADDRGP4 $247
JUMPV
LABELV $246
line 659
;658:			else
;659:			{
line 660
;660:				explanation[j] = '\n';
ADDRLP4 136
INDIRI4
ADDRGP4 explanation
ADDP4
CNSTI1 10
ASGNI1
line 661
;661:				j++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 662
;662:				l = 0;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 663
;663:			}
LABELV $247
line 665
;664:
;665:			explanation[j] = '\0';
ADDRLP4 136
INDIRI4
ADDRGP4 explanation
ADDP4
CNSTI1 0
ASGNI1
line 666
;666:		}
LABELV $234
line 668
;667:
;668:		token[i] = '\0';
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
ADDRGP4 $255
JUMPV
LABELV $254
line 671
;669:
;670:		while((*ptr == ' ') || (*ptr == '\t') || (*ptr == '\n') || (*ptr == 0xd))
;671:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $255
line 670
ADDRLP4 164
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 32
EQI4 $254
ADDRLP4 164
INDIRI4
CNSTI4 9
EQI4 $254
ADDRLP4 164
INDIRI4
CNSTI4 10
EQI4 $254
ADDRLP4 164
INDIRI4
CNSTI4 13
EQI4 $254
line 673
;672:
;673:		if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $257
line 674
;674:		{
line 675
;675:			if(listcmds)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $259
line 676
;676:				return explanation;
ADDRGP4 explanation
RETP4
ADDRGP4 $209
JUMPV
LABELV $259
line 678
;677:			else
;678:				return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $257
line 681
;679:		}
;680:
;681:		if(*ptr != '{')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $261
line 682
;682:		{
line 683
;683:			Com_Printf(""S_COLOR_RED"ERROR: Parse error, expected '{' after %s\n", token);
ADDRGP4 $263
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 684
;684:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $261
line 687
;685:		}
;686:
;687:		if(Q_stricmp(token, needle) || listcmds)
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
CNSTI4 0
ASGNI4
ADDRLP4 168
INDIRI4
ADDRLP4 172
INDIRI4
NEI4 $266
ADDRFP4 8
INDIRI4
ADDRLP4 172
INDIRI4
EQI4 $264
LABELV $266
line 688
;688:		{
ADDRGP4 $268
JUMPV
LABELV $267
line 691
;689:			//skip the explanation
;690:			while(*ptr != '}')
;691:			{
line 692
;692:				if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $270
line 693
;693:				{
line 694
;694:					Com_Printf(""S_COLOR_RED"ERROR: Parse error, missing '}' after %s\n", token);
ADDRGP4 $272
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 695
;695:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $270
line 698
;696:				}
;697:
;698:				ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 699
;699:			}
LABELV $268
line 690
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $267
line 700
;700:		}
ADDRGP4 $265
JUMPV
LABELV $264
line 702
;701:		else
;702:		{
line 703
;703:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $274
JUMPV
LABELV $273
line 705
;704:			while((*ptr == ' ') || (*ptr == '\t') || (*ptr == '\n') || (*ptr == 0xd))
;705:				ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $274
line 704
ADDRLP4 176
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 32
EQI4 $273
ADDRLP4 176
INDIRI4
CNSTI4 9
EQI4 $273
ADDRLP4 176
INDIRI4
CNSTI4 10
EQI4 $273
ADDRLP4 176
INDIRI4
CNSTI4 13
EQI4 $273
line 707
;706:
;707:			if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $276
line 708
;708:				return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $276
line 711
;709:
;710:			//take the explanation and run
;711:			i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $278
line 713
;712:			while(*ptr != '}')
;713:			{
line 714
;714:				if(*ptr == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $281
line 715
;715:				{
line 716
;716:					Com_Printf(""S_COLOR_RED"ERROR: Parse error, missing '}' after %s\n", token);
ADDRGP4 $272
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 717
;717:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $281
line 720
;718:				}
;719:
;720:				if(i >= 2047)
ADDRLP4 4
INDIRI4
CNSTI4 2047
LTI4 $283
line 721
;721:				{
line 722
;722:					Com_Printf(""S_COLOR_RED"ERROR: Memory array overflow (explanation single)\n");
ADDRGP4 $285
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 723
;723:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $209
JUMPV
LABELV $283
line 726
;724:				}
;725:
;726:				explanation[i] = *ptr;
ADDRLP4 4
INDIRI4
ADDRGP4 explanation
ADDP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 727
;727:				i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 728
;728:				ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 729
;729:			}
LABELV $279
line 712
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $278
line 731
;730:
;731:			explanation[i] = '\0';
ADDRLP4 4
INDIRI4
ADDRGP4 explanation
ADDP4
CNSTI1 0
ASGNI1
line 732
;732:			return explanation;
ADDRGP4 explanation
RETP4
ADDRGP4 $209
JUMPV
LABELV $265
line 735
;733:		}
;734:
;735:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 736
;736:	}
LABELV $211
line 586
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $214
line 738
;737:
;738:	if(listcmds)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $286
line 739
;739:		return explanation;
ADDRGP4 explanation
RETP4
ADDRGP4 $209
JUMPV
LABELV $286
line 741
;740:	else
;741:		return NULL;
CNSTP4 0
RETP4
LABELV $209
endproc HelpParse 180 8
export FixedName
proc FixedName 20 12
line 751
;742:}
;743:
;744:/*
;745:=============
;746:FixedName
;747:I fixed this for you M^onk^K
;748:It was returning 18 charcaters when 14 were requested
;749:=============
;750:*/
;751:int FixedName ( char *fixedname, char *name, int size ) {
line 752
;752:	int i = 0, j = 0, numColorCodesUsed = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
line 753
;753:	qboolean wasCaret = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 756
;754:
;755:	//Make sure the fixed name is clear
;756:	memset(fixedname, 0, sizeof(fixedname));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
ADDRGP4 $290
JUMPV
LABELV $289
line 758
;757:
;758:	while( i < size-1 && j < strlen(name)) {
line 759
;759:		if ( name[j] == '^' ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $292
line 760
;760:			if ( wasCaret )//We had a previous caret that we need to account for
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $294
line 761
;761:				i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $294
line 762
;762:			wasCaret = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 763
;763:		} else if ( wasCaret ) {
ADDRGP4 $293
JUMPV
LABELV $292
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $296
line 765
;764:			//The last charcater was a caret, this one isn't.
;765:			wasCaret = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 766
;766:			numColorCodesUsed++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 767
;767:			i--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 768
;768:		}
LABELV $296
LABELV $293
line 769
;769:		fixedname[j] = name[j];
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 770
;770:		j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 772
;771:
;772:		if ( !wasCaret )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $298
line 773
;773:			i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $298
line 774
;774:	}
LABELV $290
line 758
ADDRLP4 8
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
GEI4 $300
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $289
LABELV $300
line 775
;775:	return numColorCodesUsed;
ADDRLP4 12
INDIRI4
RETI4
LABELV $288
endproc FixedName 20 12
export findCharacter
proc findCharacter 1032 12
line 783
;776:}
;777:
;778:/*
;779:==================
;780:findCharacter
;781:==================
;782:*/
;783:qboolean findCharacter ( char *toSearch, char *toFind ) {
line 784
;784:	int		l = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 787
;785:	char	searchThrough[1024];
;786:
;787:	Com_sprintf(searchThrough, sizeof(searchThrough), toSearch);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 788
;788:	for ( l = 0; l != strlen(searchThrough); l++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $305
JUMPV
LABELV $302
line 789
;789:			if ( searchThrough[l] == toFind[0] ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
NEI4 $306
line 790
;790:				return qtrue; //Use this to break the while loop
CNSTI4 1
RETI4
ADDRGP4 $301
JUMPV
LABELV $306
line 792
;791:			}
;792:		}
LABELV $303
line 788
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $305
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
NEI4 $302
line 793
;793:	return qfalse;
CNSTI4 0
RETI4
LABELV $301
endproc findCharacter 1032 12
export tokenToVec4
proc tokenToVec4 68 12
line 797
;794:}
;795:
;796:
;797:void tokenToVec4 ( char *token, vec4_t *color ) {
line 800
;798:	vec4_t		parsedColor;
;799:	char		colorSet[32];
;800:	int			i = 0, j = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
line 801
;801:	int			areaOfVec = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 803
;802:
;803:	memset( &colorSet, 0, sizeof(colorSet));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
LABELV $309
line 805
;804:
;805:	do {
line 806
;806:		if ( (token[i] == ' ' || token[i] == ',') && i != 0 ) {
ADDRLP4 60
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 32
EQI4 $314
ADDRLP4 60
INDIRI4
CNSTI4 44
NEI4 $312
LABELV $314
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $312
line 807
;807:			parsedColor[areaOfVec] = atof(colorSet);
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
ADDRLP4 64
INDIRF4
ASGNF4
line 808
;808:			areaOfVec++;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 809
;809:			memset(&colorSet, 0, sizeof(colorSet));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 810
;810:			j = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 811
;811:		} else {
ADDRGP4 $313
JUMPV
LABELV $312
line 812
;812:			colorSet[j] = token[i];
ADDRLP4 36
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 813
;813:			j++;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 814
;814:		}
LABELV $313
line 816
;815:
;816:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 817
;817:	} while ( token[i] != '\n' || token[i] != ';' );
LABELV $310
ADDRLP4 60
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 10
NEI4 $309
ADDRLP4 60
INDIRI4
CNSTI4 59
NEI4 $309
line 820
;818:
;819:
;820:	memcpy((*color), parsedColor, sizeof((*color)));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 822
;821:		
;822:}
LABELV $308
endproc tokenToVec4 68 12
export stristr
proc stristr 12 4
line 829
;823:
;824:/*
;825:==================
;826:stristr
;827:==================
;828:*/
;829:char *stristr(char *str, char *charset) {
ADDRGP4 $317
JUMPV
LABELV $316
line 832
;830:	int i;
;831:
;832:	while(*str) {
line 833
;833:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $322
JUMPV
LABELV $319
line 834
;834:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $323
ADDRGP4 $321
JUMPV
LABELV $323
line 835
;835:		}
LABELV $320
line 833
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $322
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $325
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
NEI4 $319
LABELV $325
LABELV $321
line 836
;836:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $326
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $315
JUMPV
LABELV $326
line 837
;837:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 838
;838:	}
LABELV $317
line 832
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $316
line 839
;839:	return NULL;
CNSTP4 0
RETP4
LABELV $315
endproc stristr 12 4
export COM_MatchToken
proc COM_MatchToken 12 16
line 902
;840:}
;841:
;842:#if 0
;843:// no longer used
;844:/*
;845:===============
;846:COM_ParseInfos
;847:===============
;848:*/
;849:int COM_ParseInfos( char *buf, int max, char infos[][MAX_INFO_STRING] ) {
;850:	char	*token;
;851:	int		count;
;852:	char	key[MAX_TOKEN_CHARS];
;853:
;854:	count = 0;
;855:
;856:	while ( 1 ) {
;857:		token = COM_Parse( &buf );
;858:		if ( !token[0] ) {
;859:			break;
;860:		}
;861:		if ( strcmp( token, "{" ) ) {
;862:			Com_Printf( "Missing { in info file\n" );
;863:			break;
;864:		}
;865:
;866:		if ( count == max ) {
;867:			Com_Printf( "Max infos exceeded\n" );
;868:			break;
;869:		}
;870:
;871:		infos[count][0] = 0;
;872:		while ( 1 ) {
;873:			token = COM_ParseExt( &buf, qtrue );
;874:			if ( !token[0] ) {
;875:				Com_Printf( "Unexpected end of info file\n" );
;876:				break;
;877:			}
;878:			if ( !strcmp( token, "}" ) ) {
;879:				break;
;880:			}
;881:			Q_strncpyz( key, token, sizeof( key ) );
;882:
;883:			token = COM_ParseExt( &buf, qfalse );
;884:			if ( !token[0] ) {
;885:				strcpy( token, "<NULL>" );
;886:			}
;887:			Info_SetValueForKey( infos[count], key, token );
;888:		}
;889:		count++;
;890:	}
;891:
;892:	return count;
;893:}
;894:#endif
;895:
;896:
;897:/*
;898:==================
;899:COM_MatchToken
;900:==================
;901:*/
;902:void COM_MatchToken( char **buf_p, char *match ) {
line 905
;903:	char	*token;
;904:
;905:	token = COM_Parse( buf_p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 906
;906:	if ( strcmp( token, match ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $329
line 907
;907:		Com_Error( ERR_DROP, "MatchToken: %s != %s", token, match );
CNSTI4 1
ARGI4
ADDRGP4 $331
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 908
;908:	}
LABELV $329
line 909
;909:}
LABELV $328
endproc COM_MatchToken 12 16
export ColorIndex
proc ColorIndex 12 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII1 4
ASGNI1
line 912
;910:
;911://Returns the index in g_color_table[] corresponding to the colour code.
;912:int ColorIndex( char ccode ) {// CPMA
line 914
;913:
;914:	if ( ccode >= '0' && ccode <= '9' ) {
ADDRLP4 0
ADDRFP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 48
LTI4 $333
ADDRLP4 0
INDIRI4
CNSTI4 57
GTI4 $333
line 915
;915:		return (ccode - '0');
ADDRFP4 0
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
RETI4
ADDRGP4 $332
JUMPV
LABELV $333
line 916
;916:	} else if ( ccode >= 'a' && ccode <= 'z' ) {
ADDRLP4 4
ADDRFP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $335
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $335
line 917
;917:		return (2 * (ccode - 'a') + 10);
ADDRFP4 0
INDIRI1
CVII4 1
CNSTI4 1
LSHI4
CNSTI4 194
SUBI4
CNSTI4 10
ADDI4
RETI4
ADDRGP4 $332
JUMPV
LABELV $335
line 918
;918:	} else if ( ccode >= 'A' && ccode <= 'Z' ) {
ADDRLP4 8
ADDRFP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $337
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $337
line 919
;919:		return (2 * (ccode - 'A') + 11);
ADDRFP4 0
INDIRI1
CVII4 1
CNSTI4 1
LSHI4
CNSTI4 130
SUBI4
CNSTI4 11
ADDI4
RETI4
ADDRGP4 $332
JUMPV
LABELV $337
line 920
;920:	} else {
line 921
;921:		return 7;
CNSTI4 7
RETI4
LABELV $332
endproc ColorIndex 12 0
export SkipBracedSection
proc SkipBracedSection 12 8
line 935
;922:	}
;923:}
;924:
;925:
;926:/*
;927:=================
;928:SkipBracedSection
;929:
;930:The next token should be an open brace.
;931:Skips until a matching close brace is found.
;932:Internal brace depths are properly skipped.
;933:=================
;934:*/
;935:void SkipBracedSection (char **program) {
line 939
;936:	char			*token;
;937:	int				depth;
;938:
;939:	depth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $340
line 940
;940:	do {
line 941
;941:		token = COM_ParseExt( program, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 942
;942:		if( token[1] == 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $343
line 943
;943:			if( token[0] == '{' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $345
line 944
;944:				depth++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 945
;945:			}
ADDRGP4 $346
JUMPV
LABELV $345
line 946
;946:			else if( token[0] == '}' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $347
line 947
;947:				depth--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 948
;948:			}
LABELV $347
LABELV $346
line 949
;949:		}
LABELV $343
line 950
;950:	} while( depth && *program );
LABELV $341
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $349
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $340
LABELV $349
line 951
;951:}
LABELV $339
endproc SkipBracedSection 12 8
export SkipRestOfLine
proc SkipRestOfLine 16 0
line 958
;952:
;953:/*
;954:=================
;955:SkipRestOfLine
;956:=================
;957:*/
;958:void SkipRestOfLine ( char **data ) {
line 962
;959:	char	*p;
;960:	int		c;
;961:
;962:	p = *data;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRGP4 $352
JUMPV
LABELV $351
line 963
;963:	while ( (c = *p++) != 0 ) {
line 964
;964:		if ( c == '\n' ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $354
line 965
;965:			com_lines++;
ADDRLP4 8
ADDRGP4 com_lines
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 966
;966:			break;
ADDRGP4 $353
JUMPV
LABELV $354
line 968
;967:		}
;968:	}
LABELV $352
line 963
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $351
LABELV $353
line 970
;969:
;970:	*data = p;
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 971
;971:}
LABELV $350
endproc SkipRestOfLine 16 0
export Parse1DMatrix
proc Parse1DMatrix 16 8
line 974
;972:
;973:
;974:void Parse1DMatrix (char **buf_p, int x, float *m) {
line 978
;975:	char	*token;
;976:	int		i;
;977:
;978:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 980
;979:
;980:	for (i = 0 ; i < x ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $361
JUMPV
LABELV $358
line 981
;981:		token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 982
;982:		m[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 983
;983:	}
LABELV $359
line 980
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $361
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $358
line 985
;984:
;985:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 986
;986:}
LABELV $356
endproc Parse1DMatrix 16 8
export Parse2DMatrix
proc Parse2DMatrix 8 12
line 988
;987:
;988:void Parse2DMatrix (char **buf_p, int y, int x, float *m) {
line 991
;989:	int		i;
;990:
;991:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 993
;992:
;993:	for (i = 0 ; i < y ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $367
JUMPV
LABELV $364
line 994
;994:		Parse1DMatrix (buf_p, x, m + i * x);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 12
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse1DMatrix
CALLV
pop
line 995
;995:	}
LABELV $365
line 993
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $367
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $364
line 997
;996:
;997:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 998
;998:}
LABELV $363
endproc Parse2DMatrix 8 12
export Parse3DMatrix
proc Parse3DMatrix 12 16
line 1000
;999:
;1000:void Parse3DMatrix (char **buf_p, int z, int y, int x, float *m) {
line 1003
;1001:	int		i;
;1002:
;1003:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 1005
;1004:
;1005:	for (i = 0 ; i < z ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $369
line 1006
;1006:		Parse2DMatrix (buf_p, y, x, m + i * x*y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse2DMatrix
CALLV
pop
line 1007
;1007:	}
LABELV $370
line 1005
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $372
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $369
line 1009
;1008:
;1009:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 1010
;1010:}
LABELV $368
endproc Parse3DMatrix 12 16
export Q_isprint
proc Q_isprint 4 0
line 1022
;1011:
;1012:
;1013:/*
;1014:============================================================================
;1015:
;1016:					LIBRARY REPLACEMENT FUNCTIONS
;1017:
;1018:============================================================================
;1019:*/
;1020:
;1021:int Q_isprint( int c )
;1022:{
line 1023
;1023:	if ( c >= 0x20 && c <= 0x7E )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $374
ADDRLP4 0
INDIRI4
CNSTI4 126
GTI4 $374
line 1024
;1024:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $373
JUMPV
LABELV $374
line 1025
;1025:	return ( 0 );
CNSTI4 0
RETI4
LABELV $373
endproc Q_isprint 4 0
export Q_islower
proc Q_islower 4 0
line 1029
;1026:}
;1027:
;1028:int Q_islower( int c )
;1029:{
line 1030
;1030:	if (c >= 'a' && c <= 'z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $377
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $377
line 1031
;1031:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $376
JUMPV
LABELV $377
line 1032
;1032:	return ( 0 );
CNSTI4 0
RETI4
LABELV $376
endproc Q_islower 4 0
export Q_isupper
proc Q_isupper 4 0
line 1036
;1033:}
;1034:
;1035:int Q_isupper( int c )
;1036:{
line 1037
;1037:	if (c >= 'A' && c <= 'Z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $380
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $380
line 1038
;1038:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $379
JUMPV
LABELV $380
line 1039
;1039:	return ( 0 );
CNSTI4 0
RETI4
LABELV $379
endproc Q_isupper 4 0
export Q_isalpha
proc Q_isalpha 8 0
line 1043
;1040:}
;1041:
;1042:int Q_isalpha( int c )
;1043:{
line 1044
;1044:	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $386
ADDRLP4 0
INDIRI4
CNSTI4 122
LEI4 $385
LABELV $386
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $383
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $383
LABELV $385
line 1045
;1045:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $382
JUMPV
LABELV $383
line 1046
;1046:	return ( 0 );
CNSTI4 0
RETI4
LABELV $382
endproc Q_isalpha 8 0
export Q_strrchr
proc Q_strrchr 12 0
line 1050
;1047:}
;1048:
;1049:char* Q_strrchr( const char* string, int c )
;1050:{
line 1051
;1051:	char cc = c;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 1053
;1052:	char *s;
;1053:	char *sp=(char *)0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 1055
;1054:
;1055:	s = (char*)string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $389
JUMPV
LABELV $388
line 1058
;1056:
;1057:	while (*s)
;1058:	{
line 1059
;1059:		if (*s == cc)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI1
CVII4 1
NEI4 $391
line 1060
;1060:			sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $391
line 1061
;1061:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1062
;1062:	}
LABELV $389
line 1057
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $388
line 1063
;1063:	if (cc == 0)
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $393
line 1064
;1064:		sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $393
line 1066
;1065:
;1066:	return sp;
ADDRLP4 8
INDIRP4
RETP4
LABELV $387
endproc Q_strrchr 12 0
export Q_strncpyz
proc Q_strncpyz 0 12
line 1076
;1067:}
;1068:
;1069:/*
;1070:=============
;1071:Q_strncpyz
;1072: 
;1073:Safe strncpy that ensures a trailing zero
;1074:=============
;1075:*/
;1076:void Q_strncpyz( char *dest, const char *src, int destsize ) {
line 1078
;1077:  // bk001129 - also NULL dest
;1078:  if ( !dest ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $396
line 1079
;1079:    Com_Error( ERR_FATAL, "Q_strncpyz: NULL dest" );
CNSTI4 0
ARGI4
ADDRGP4 $398
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1080
;1080:  }
LABELV $396
line 1081
;1081:	if ( !src ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $399
line 1082
;1082:		Com_Error( ERR_FATAL, "Q_strncpyz: NULL src" );
CNSTI4 0
ARGI4
ADDRGP4 $401
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1083
;1083:	}
LABELV $399
line 1084
;1084:	if ( destsize < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $402
line 1085
;1085:		Com_Error(ERR_FATAL,"Q_strncpyz: destsize < 1" ); 
CNSTI4 0
ARGI4
ADDRGP4 $404
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1086
;1086:	}
LABELV $402
line 1088
;1087:
;1088:	strncpy( dest, src, destsize-1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1089
;1089:  dest[destsize-1] = 0;
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1090
;1090:}
LABELV $395
endproc Q_strncpyz 0 12
export Q_stricmpn
proc Q_stricmpn 32 0
line 1092
;1091:                 
;1092:int Q_stricmpn (const char *s1, const char *s2, int n) {
line 1096
;1093:	int		c1, c2;
;1094:
;1095:	// bk001129 - moved in 1.17 fix not in id codebase
;1096:        if ( s1 == NULL ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $406
line 1097
;1097:           if ( s2 == NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $408
line 1098
;1098:             return 0;
CNSTI4 0
RETI4
ADDRGP4 $405
JUMPV
LABELV $408
line 1100
;1099:           else
;1100:             return -1;
CNSTI4 -1
RETI4
ADDRGP4 $405
JUMPV
LABELV $406
line 1102
;1101:        }
;1102:        else if ( s2==NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $410
line 1103
;1103:          return 1;
CNSTI4 1
RETI4
ADDRGP4 $405
JUMPV
LABELV $410
LABELV $412
line 1107
;1104:
;1105:
;1106:	
;1107:	do {
line 1108
;1108:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1109
;1109:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1111
;1110:
;1111:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $415
line 1112
;1112:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $405
JUMPV
LABELV $415
line 1115
;1113:		}
;1114:		
;1115:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $417
line 1116
;1116:			if (c1 >= 'a' && c1 <= 'z') {
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $419
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $419
line 1117
;1117:				c1 -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 1118
;1118:			}
LABELV $419
line 1119
;1119:			if (c2 >= 'a' && c2 <= 'z') {
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $421
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $421
line 1120
;1120:				c2 -= ('a' - 'A');
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 1121
;1121:			}
LABELV $421
line 1122
;1122:			if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $423
line 1123
;1123:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $426
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRGP4 $427
JUMPV
LABELV $426
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $427
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $405
JUMPV
LABELV $423
line 1125
;1124:			}
;1125:		}
LABELV $417
line 1126
;1126:	} while (c1);
LABELV $413
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $412
line 1128
;1127:	
;1128:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $405
endproc Q_stricmpn 32 0
export Q_strncmp
proc Q_strncmp 24 0
line 1131
;1129:}
;1130:
;1131:int Q_strncmp (const char *s1, const char *s2, int n) {
LABELV $429
line 1134
;1132:	int		c1, c2;
;1133:	
;1134:	do {
line 1135
;1135:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1136
;1136:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1138
;1137:
;1138:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $432
line 1139
;1139:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $428
JUMPV
LABELV $432
line 1142
;1140:		}
;1141:		
;1142:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $434
line 1143
;1143:			return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $437
ADDRLP4 20
CNSTI4 -1
ASGNI4
ADDRGP4 $438
JUMPV
LABELV $437
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $438
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $428
JUMPV
LABELV $434
line 1145
;1144:		}
;1145:	} while (c1);
LABELV $430
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $429
line 1147
;1146:	
;1147:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $428
endproc Q_strncmp 24 0
export Q_stricmp
proc Q_stricmp 12 12
line 1150
;1148:}
;1149:
;1150:int Q_stricmp (const char *s1, const char *s2) {
line 1151
;1151:	return (s1 && s2) ? Q_stricmpn (s1, s2, 99999) : -1;
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $441
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $441
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 99999
ARGI4
ADDRLP4 8
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
ADDRGP4 $442
JUMPV
LABELV $441
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $442
ADDRLP4 0
INDIRI4
RETI4
LABELV $439
endproc Q_stricmp 12 12
export Q_strlwr
proc Q_strlwr 12 4
line 1155
;1152:}
;1153:
;1154:
;1155:char *Q_strlwr( char *s1 ) {
line 1158
;1156:    char	*s;
;1157:
;1158:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $445
JUMPV
LABELV $444
line 1159
;1159:	while ( *s ) {
line 1160
;1160:		*s = tolower(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 1161
;1161:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1162
;1162:	}
LABELV $445
line 1159
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $444
line 1163
;1163:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $443
endproc Q_strlwr 12 4
export Q_strupr
proc Q_strupr 12 4
line 1166
;1164:}
;1165:
;1166:char *Q_strupr( char *s1 ) {
line 1169
;1167:    char	*s;
;1168:
;1169:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $449
JUMPV
LABELV $448
line 1170
;1170:	while ( *s ) {
line 1171
;1171:		*s = toupper(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 1172
;1172:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1173
;1173:	}
LABELV $449
line 1170
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $448
line 1174
;1174:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $447
endproc Q_strupr 12 4
export Q_strcat
proc Q_strcat 12 12
line 1179
;1175:}
;1176:
;1177:
;1178:// never goes past bounds or leaves without a terminating 0
;1179:void Q_strcat( char *dest, int size, const char *src ) {
line 1182
;1180:	int		l1;
;1181:
;1182:	l1 = strlen( dest );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1183
;1183:	if ( l1 >= size ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $452
line 1184
;1184:		Com_Error( ERR_FATAL, "Q_strcat: already overflowed" );
CNSTI4 0
ARGI4
ADDRGP4 $454
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1185
;1185:	}
LABELV $452
line 1186
;1186:	Q_strncpyz( dest + l1, src, size - l1 );
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1187
;1187:}
LABELV $451
endproc Q_strcat 12 12
export Q_PrintStrlen
proc Q_PrintStrlen 20 0
line 1190
;1188:
;1189:
;1190:int Q_PrintStrlen( const char *string ) {
line 1194
;1191:	int			len;
;1192:	const char	*p;
;1193:
;1194:	if( !string ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $456
line 1195
;1195:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $455
JUMPV
LABELV $456
line 1198
;1196:	}
;1197:
;1198:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1199
;1199:	p = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $459
JUMPV
LABELV $458
line 1200
;1200:	while( *p ) {
line 1201
;1201:		if( Q_IsColorString( p ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $461
ADDRLP4 12
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $461
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $461
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $461
line 1202
;1202:			p += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 1203
;1203:			continue;
ADDRGP4 $459
JUMPV
LABELV $461
line 1205
;1204:		}
;1205:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1206
;1206:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1207
;1207:	}
LABELV $459
line 1200
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $458
line 1209
;1208:
;1209:	return len;
ADDRLP4 4
INDIRI4
RETI4
LABELV $455
endproc Q_PrintStrlen 20 0
export Q_CleanStr
proc Q_CleanStr 32 0
line 1213
;1210:}
;1211:
;1212:
;1213:char *Q_CleanStr( char *string ) {
line 1218
;1214:	char*	d;
;1215:	char*	s;
;1216:	int		c;
;1217:
;1218:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1219
;1219:	d = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $465
JUMPV
LABELV $464
line 1220
;1220:	while ((c = *s) != 0 ) {
line 1221
;1221:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $467
ADDRLP4 16
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 16
INDIRI4
NEI4 $467
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $467
ADDRLP4 20
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $467
line 1222
;1222:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1223
;1223:		} else if ( c >= 0x20 && c <= 0x7E ) {
ADDRGP4 $468
JUMPV
LABELV $467
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $469
ADDRLP4 4
INDIRI4
CNSTI4 126
GTI4 $469
line 1224
;1224:			*d++ = c;
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 1225
;1225:		}
LABELV $469
LABELV $468
line 1226
;1226:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1227
;1227:	}
LABELV $465
line 1220
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $464
line 1228
;1228:	*d = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1230
;1229:
;1230:	return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $463
endproc Q_CleanStr 32 0
export Q_CleanString
proc Q_CleanString 36 0
line 1233
;1231:}
;1232:
;1233:char *Q_CleanString( char *string ) {
line 1238
;1234:	char*	d;
;1235:	char*	s;
;1236:	int		c;
;1237:
;1238:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1239
;1239:	d = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $473
JUMPV
LABELV $472
line 1240
;1240:	while ((c = *s) != 0 ) {
line 1241
;1241:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $475
ADDRLP4 16
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 16
INDIRI4
NEI4 $475
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $475
ADDRLP4 20
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $475
line 1242
;1242:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1243
;1243:			s++;//Remove the number too
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1244
;1244:		} else if ( (*s == ';') || (*s == ':') || (*s == '/') || (*s == '\\') || (*s == '?') || (*s == '*') || (*s == '<') || (*s == '>') || (*s == '\"') || (*s == '|') ) {
ADDRGP4 $476
JUMPV
LABELV $475
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 59
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 58
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 47
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 92
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 63
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 42
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 60
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 62
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 34
EQI4 $487
ADDRLP4 24
INDIRI4
CNSTI4 124
NEI4 $477
LABELV $487
line 1245
;1245:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1246
;1246:		} else if ( c >= 0x20 && c <= 0x7E ) {
ADDRGP4 $478
JUMPV
LABELV $477
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $488
ADDRLP4 4
INDIRI4
CNSTI4 126
GTI4 $488
line 1247
;1247:			*d++ = c;
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 1248
;1248:		}
LABELV $488
LABELV $478
LABELV $476
line 1249
;1249:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1250
;1250:	}
LABELV $473
line 1240
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $472
line 1251
;1251:	*d = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1253
;1252:
;1253:	return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $471
endproc Q_CleanString 36 0
export Q_CopyStringUntil
proc Q_CopyStringUntil 20 0
line 1256
;1254:}
;1255:
;1256:char *Q_CopyStringUntil( char *string, char *stop ) {
line 1261
;1257:	char*	d;
;1258:	char*	s;
;1259:	int		c;
;1260:
;1261:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1262
;1262:	d = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $492
JUMPV
LABELV $491
line 1263
;1263:	while ((c = *s) != 0 ) {
line 1264
;1264:		if ( (*s == (*stop)) ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
NEI4 $494
line 1265
;1265:			break;
ADDRGP4 $493
JUMPV
LABELV $494
line 1266
;1266:		} else if ( c >= 0x20 && c <= 0x7E ) {
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $496
ADDRLP4 4
INDIRI4
CNSTI4 126
GTI4 $496
line 1267
;1267:			*d++ = c;
ADDRLP4 16
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 1268
;1268:		}
LABELV $496
line 1269
;1269:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1270
;1270:	}
LABELV $492
line 1263
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $491
LABELV $493
line 1271
;1271:	*d = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1273
;1272:
;1273:	return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $490
endproc Q_CopyStringUntil 20 0
export Com_sprintf
proc Com_sprintf 32012 12
line 1314
;1274:}
;1275:/*
;1276:char *Q_MakeModelString( char *string ) {
;1277:	char*	d;
;1278:	char*	s;
;1279:	int		c;
;1280:
;1281:	s = string;
;1282:	d = string;
;1283:	while ((c = *s) != 0 && (*s != '/') ) {
;1284:		if ( c >= 0x20 && c <= 0x7E ) {
;1285:			*d++ = c;
;1286:		}
;1287:		s++;
;1288:	}
;1289:	*d = '\0';
;1290:
;1291:	return string;
;1292:}
;1293:*/
;1294:
;1295:/*char *Q_CleanStrOfQuotes( char *string ) {
;1296:	char*	d;
;1297:	char*	s;
;1298:	int		c;
;1299:
;1300:	s = string;
;1301:	d = string;
;1302:	while ((c = *s) != 0 ) {
;1303:		if ( *s == '\"' ) {
;1304:			s++;
;1305:		}		
;1306:		s++;
;1307:	}
;1308:	*d = '\0';
;1309:
;1310:	return string;
;1311:}*/
;1312:
;1313:
;1314:void QDECL Com_sprintf( char *dest, int size, const char *fmt, ...) {
line 1319
;1315:	int		len;
;1316:	va_list		argptr;
;1317:	char	bigbuffer[32000];	// big, but small enough to fit in PPC stack
;1318:
;1319:	va_start (argptr,fmt);
ADDRLP4 4
ADDRFP4 8+4
ASGNP4
line 1320
;1320:	len = vsprintf (bigbuffer,fmt,argptr);
ADDRLP4 8
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32008
ADDRGP4 vsprintf
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32008
INDIRI4
ASGNI4
line 1321
;1321:	va_end (argptr);
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1322
;1322:	if ( len >= sizeof( bigbuffer ) ) {
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32000
LTU4 $500
line 1323
;1323:		Com_Error( ERR_FATAL, "Com_sprintf: overflowed bigbuffer" );
CNSTI4 0
ARGI4
ADDRGP4 $502
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1324
;1324:	}
LABELV $500
line 1325
;1325:	if (len >= size) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $503
line 1326
;1326:		Com_Printf ("Com_sprintf: overflow of %i in %i\n", len, size);
ADDRGP4 $505
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1332
;1327:#ifdef	_DEBUG
;1328:		__asm {
;1329:			int 3;
;1330:		}
;1331:#endif
;1332:	}
LABELV $503
line 1333
;1333:	Q_strncpyz (dest, bigbuffer, size );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1334
;1334:}
LABELV $498
endproc Com_sprintf 32012 12
bss
align 1
LABELV $507
skip 1024
export ConcatArgs
code
proc ConcatArgs 1048 12
line 1342
;1335:
;1336:
;1337:/*
;1338:==================
;1339:ConcatArgs
;1340:==================
;1341:*/
;1342:char	*ConcatArgs( int start ) {
line 1348
;1343:	int		i, c, tlen;
;1344:	static char	line[MAX_STRING_CHARS];
;1345:	int		len;
;1346:	char	arg[MAX_STRING_CHARS];
;1347:
;1348:	len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1349
;1349:	c = trap_Argc();
ADDRLP4 1040
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1040
INDIRI4
ASGNI4
line 1350
;1350:	for ( i = start ; i < c ; i++ ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 $511
JUMPV
LABELV $508
line 1351
;1351:		trap_Argv( i, arg, sizeof( arg ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1352
;1352:		tlen = strlen( arg );
ADDRLP4 12
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1044
INDIRI4
ASGNI4
line 1353
;1353:		if ( len + tlen >= MAX_STRING_CHARS - 1 ) {
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
CNSTI4 1023
LTI4 $512
line 1354
;1354:			break;
ADDRGP4 $510
JUMPV
LABELV $512
line 1356
;1355:		}
;1356:		memcpy( line + len, arg, tlen );
ADDRLP4 0
INDIRI4
ADDRGP4 $507
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1357
;1357:		len += tlen;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1358
;1358:		if ( i != c - 1 ) {
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
CNSTI4 1
SUBI4
EQI4 $514
line 1359
;1359:			line[len] = ' ';
ADDRLP4 0
INDIRI4
ADDRGP4 $507
ADDP4
CNSTI1 32
ASGNI1
line 1360
;1360:			len++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1361
;1361:		}
LABELV $514
line 1362
;1362:	}
LABELV $509
line 1350
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $511
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $508
LABELV $510
line 1364
;1363:
;1364:	line[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $507
ADDP4
CNSTI1 0
ASGNI1
line 1366
;1365:
;1366:	return line;
ADDRGP4 $507
RETP4
LABELV $506
endproc ConcatArgs 1048 12
export SanitizeString
proc SanitizeString 16 4
line 1376
;1367:}
;1368:
;1369:/*
;1370:==================
;1371:SanitizeString
;1372:
;1373:Remove case and control characters
;1374:==================
;1375:*/
;1376:void SanitizeString( char *in, char *out ) {
ADDRGP4 $518
JUMPV
LABELV $517
line 1377
;1377:	while ( *in ) {
line 1378
;1378:		if ( *in == 27 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 27
NEI4 $520
line 1379
;1379:			in += 2;		// skip color code
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 1380
;1380:			continue;
ADDRGP4 $518
JUMPV
LABELV $520
line 1382
;1381:		}
;1382:		if ( *in < 32 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
GEI4 $522
line 1383
;1383:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1384
;1384:			continue;
ADDRGP4 $518
JUMPV
LABELV $522
line 1386
;1385:		}
;1386:		*out++ = tolower( *in++ );
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 1387
;1387:	}
LABELV $518
line 1377
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $517
line 1389
;1388:
;1389:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1390
;1390:}
LABELV $516
endproc SanitizeString 16 4
bss
align 1
LABELV $525
skip 64000
data
align 4
LABELV $526
byte 4 0
export va
code
proc va 12 12
line 1401
;1391:
;1392:/*
;1393:============
;1394:va
;1395:
;1396:does a varargs printf into a temp buffer, so I don't need to have
;1397:varargs versions of all text functions.
;1398:FIXME: make this buffer size safe someday
;1399:============
;1400:*/
;1401:char	* QDECL va( char *format, ... ) {
line 1407
;1402:	va_list		argptr;
;1403:	static char		string[2][32000];	// in case va is called by nested functions
;1404:	static int		index = 0;
;1405:	char	*buf;
;1406:
;1407:	buf = string[index & 1];
ADDRLP4 4
CNSTI4 32000
ADDRGP4 $526
INDIRI4
CNSTI4 1
BANDI4
MULI4
ADDRGP4 $525
ADDP4
ASGNP4
line 1408
;1408:	index++;
ADDRLP4 8
ADDRGP4 $526
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1410
;1409:
;1410:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 1411
;1411:	vsprintf (buf, format,argptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 1412
;1412:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1414
;1413:
;1414:	return buf;
ADDRLP4 4
INDIRP4
RETP4
LABELV $524
endproc va 12 12
bss
align 1
LABELV $529
skip 16384
data
align 4
LABELV $530
byte 4 0
export Info_ValueForKey
code
proc Info_ValueForKey 8220 8
line 1435
;1415:}
;1416:
;1417:
;1418:/*
;1419:=====================================================================
;1420:
;1421:  INFO STRINGS
;1422:
;1423:=====================================================================
;1424:*/
;1425:
;1426:/*
;1427:===============
;1428:Info_ValueForKey
;1429:
;1430:Searches the string for the given
;1431:key and returns the associated value, or an empty string.
;1432:FIXME: overflow check?
;1433:===============
;1434:*/
;1435:char *Info_ValueForKey( const char *s, const char *key ) {
line 1442
;1436:	char	pkey[BIG_INFO_KEY];
;1437:	static	char value[2][BIG_INFO_VALUE];	// use two buffers so compares
;1438:											// work without stomping on each other
;1439:	static	int	valueindex = 0;
;1440:	char	*o;
;1441:	
;1442:	if ( !s || !key ) {
ADDRLP4 8196
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 8196
INDIRU4
EQU4 $533
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 8196
INDIRU4
NEU4 $531
LABELV $533
line 1443
;1443:		return "";
ADDRGP4 $534
RETP4
ADDRGP4 $528
JUMPV
LABELV $531
line 1446
;1444:	}
;1445:
;1446:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8200
INDIRI4
CNSTI4 8192
LTI4 $535
line 1447
;1447:		Com_Error( ERR_DROP, "Info_ValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $537
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1448
;1448:	}
LABELV $535
line 1450
;1449:
;1450:	valueindex ^= 1;
ADDRLP4 8204
ADDRGP4 $530
ASGNP4
ADDRLP4 8204
INDIRP4
ADDRLP4 8204
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 1451
;1451:	if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $541
line 1452
;1452:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $541
JUMPV
LABELV $540
line 1454
;1453:	while (1)
;1454:	{
line 1455
;1455:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $544
JUMPV
LABELV $543
line 1457
;1456:		while (*s != '\\')
;1457:		{
line 1458
;1458:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $546
line 1459
;1459:				return "";
ADDRGP4 $534
RETP4
ADDRGP4 $528
JUMPV
LABELV $546
line 1460
;1460:			*o++ = *s++;
ADDRLP4 8208
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8216
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 8208
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8212
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8208
INDIRP4
ADDRLP4 8212
INDIRP4
INDIRI1
ASGNI1
line 1461
;1461:		}
LABELV $544
line 1456
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $543
line 1462
;1462:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1463
;1463:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1465
;1464:
;1465:		o = value[valueindex];
ADDRLP4 0
ADDRGP4 $530
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $529
ADDP4
ASGNP4
ADDRGP4 $549
JUMPV
LABELV $548
line 1468
;1466:
;1467:		while (*s != '\\' && *s)
;1468:		{
line 1469
;1469:			*o++ = *s++;
ADDRLP4 8208
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8216
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 8208
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8212
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8208
INDIRP4
ADDRLP4 8212
INDIRP4
INDIRI1
ASGNI1
line 1470
;1470:		}
LABELV $549
line 1467
ADDRLP4 8208
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8208
INDIRI4
CNSTI4 92
EQI4 $551
ADDRLP4 8208
INDIRI4
CNSTI4 0
NEI4 $548
LABELV $551
line 1471
;1471:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1473
;1472:
;1473:		if (!Q_stricmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8212
INDIRI4
CNSTI4 0
NEI4 $552
line 1474
;1474:			return value[valueindex];
ADDRGP4 $530
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $529
ADDP4
RETP4
ADDRGP4 $528
JUMPV
LABELV $552
line 1476
;1475:
;1476:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $554
line 1477
;1477:			break;
ADDRGP4 $542
JUMPV
LABELV $554
line 1478
;1478:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1479
;1479:	}
LABELV $541
line 1453
ADDRGP4 $540
JUMPV
LABELV $542
line 1481
;1480:
;1481:	return "";
ADDRGP4 $534
RETP4
LABELV $528
endproc Info_ValueForKey 8220 8
export Info_NextPair
proc Info_NextPair 20 0
line 1492
;1482:}
;1483:
;1484:
;1485:/*
;1486:===================
;1487:Info_NextPair
;1488:
;1489:Used to itterate through all the key/value pairs in an info string
;1490:===================
;1491:*/
;1492:void Info_NextPair( const char **head, char *key, char *value ) {
line 1496
;1493:	char	*o;
;1494:	const char	*s;
;1495:
;1496:	s = *head;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 1498
;1497:
;1498:	if ( *s == '\\' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $557
line 1499
;1499:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1500
;1500:	}
LABELV $557
line 1501
;1501:	key[0] = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1502
;1502:	value[0] = 0;
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1504
;1503:
;1504:	o = key;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $560
JUMPV
LABELV $559
line 1505
;1505:	while ( *s != '\\' ) {
line 1506
;1506:		if ( !*s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $562
line 1507
;1507:			*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1508
;1508:			*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1509
;1509:			return;
ADDRGP4 $556
JUMPV
LABELV $562
line 1511
;1510:		}
;1511:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 1512
;1512:	}
LABELV $560
line 1505
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $559
line 1513
;1513:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1514
;1514:	s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1516
;1515:
;1516:	o = value;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $565
JUMPV
LABELV $564
line 1517
;1517:	while ( *s != '\\' && *s ) {
line 1518
;1518:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 1519
;1519:	}
LABELV $565
line 1517
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 92
EQI4 $567
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $564
LABELV $567
line 1520
;1520:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1522
;1521:
;1522:	*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1523
;1523:}
LABELV $556
endproc Info_NextPair 20 0
export Info_RemoveKey
proc Info_RemoveKey 2076 8
line 1531
;1524:
;1525:
;1526:/*
;1527:===================
;1528:Info_RemoveKey
;1529:===================
;1530:*/
;1531:void Info_RemoveKey( char *s, const char *key ) {
line 1537
;1532:	char	*start;
;1533:	char	pkey[MAX_INFO_KEY];
;1534:	char	value[MAX_INFO_VALUE];
;1535:	char	*o;
;1536:
;1537:	if ( strlen( s ) >= MAX_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 1024
LTI4 $569
line 1538
;1538:		Com_Error( ERR_DROP, "Info_RemoveKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $571
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1539
;1539:	}
LABELV $569
line 1541
;1540:
;1541:	if (strchr (key, '\\')) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 2060
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2060
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $575
line 1542
;1542:		return;
ADDRGP4 $568
JUMPV
LABELV $574
line 1546
;1543:	}
;1544:
;1545:	while (1)
;1546:	{
line 1547
;1547:		start = s;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
line 1548
;1548:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $577
line 1549
;1549:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $577
line 1550
;1550:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $580
JUMPV
LABELV $579
line 1552
;1551:		while (*s != '\\')
;1552:		{
line 1553
;1553:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $582
line 1554
;1554:				return;
ADDRGP4 $568
JUMPV
LABELV $582
line 1555
;1555:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 2072
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1556
;1556:		}
LABELV $580
line 1551
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $579
line 1557
;1557:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1558
;1558:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1560
;1559:
;1560:		o = value;
ADDRLP4 0
ADDRLP4 1032
ASGNP4
ADDRGP4 $585
JUMPV
LABELV $584
line 1562
;1561:		while (*s != '\\' && *s)
;1562:		{
line 1563
;1563:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $587
line 1564
;1564:				return;
ADDRGP4 $568
JUMPV
LABELV $587
line 1565
;1565:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 2072
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1566
;1566:		}
LABELV $585
line 1561
ADDRLP4 2064
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 92
EQI4 $589
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $584
LABELV $589
line 1567
;1567:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1569
;1568:
;1569:		if (!strcmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $590
line 1570
;1570:		{
line 1571
;1571:			strcpy (start, s);	// remove this part
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1572
;1572:			return;
ADDRGP4 $568
JUMPV
LABELV $590
line 1575
;1573:		}
;1574:
;1575:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $592
line 1576
;1576:			return;
ADDRGP4 $568
JUMPV
LABELV $592
line 1577
;1577:	}
LABELV $575
line 1545
ADDRGP4 $574
JUMPV
line 1579
;1578:
;1579:}
LABELV $568
endproc Info_RemoveKey 2076 8
export Info_RemoveKey_Big
proc Info_RemoveKey_Big 16412 8
line 1586
;1580:
;1581:/*
;1582:===================
;1583:Info_RemoveKey_Big
;1584:===================
;1585:*/
;1586:void Info_RemoveKey_Big( char *s, const char *key ) {
line 1592
;1587:	char	*start;
;1588:	char	pkey[BIG_INFO_KEY];
;1589:	char	value[BIG_INFO_VALUE];
;1590:	char	*o;
;1591:
;1592:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16392
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16392
INDIRI4
CNSTI4 8192
LTI4 $595
line 1593
;1593:		Com_Error( ERR_DROP, "Info_RemoveKey_Big: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $597
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1594
;1594:	}
LABELV $595
line 1596
;1595:
;1596:	if (strchr (key, '\\')) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 16396
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16396
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $601
line 1597
;1597:		return;
ADDRGP4 $594
JUMPV
LABELV $600
line 1601
;1598:	}
;1599:
;1600:	while (1)
;1601:	{
line 1602
;1602:		start = s;
ADDRLP4 8196
ADDRFP4 0
INDIRP4
ASGNP4
line 1603
;1603:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $603
line 1604
;1604:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $603
line 1605
;1605:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $606
JUMPV
LABELV $605
line 1607
;1606:		while (*s != '\\')
;1607:		{
line 1608
;1608:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $608
line 1609
;1609:				return;
ADDRGP4 $594
JUMPV
LABELV $608
line 1610
;1610:			*o++ = *s++;
ADDRLP4 16400
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16408
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 16400
INDIRP4
ADDRLP4 16408
INDIRI4
ADDP4
ASGNP4
ADDRLP4 16404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 16404
INDIRP4
ADDRLP4 16408
INDIRI4
ADDP4
ASGNP4
ADDRLP4 16400
INDIRP4
ADDRLP4 16404
INDIRP4
INDIRI1
ASGNI1
line 1611
;1611:		}
LABELV $606
line 1606
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $605
line 1612
;1612:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1613
;1613:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1615
;1614:
;1615:		o = value;
ADDRLP4 0
ADDRLP4 8200
ASGNP4
ADDRGP4 $611
JUMPV
LABELV $610
line 1617
;1616:		while (*s != '\\' && *s)
;1617:		{
line 1618
;1618:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $613
line 1619
;1619:				return;
ADDRGP4 $594
JUMPV
LABELV $613
line 1620
;1620:			*o++ = *s++;
ADDRLP4 16400
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16408
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 16400
INDIRP4
ADDRLP4 16408
INDIRI4
ADDP4
ASGNP4
ADDRLP4 16404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 16404
INDIRP4
ADDRLP4 16408
INDIRI4
ADDP4
ASGNP4
ADDRLP4 16400
INDIRP4
ADDRLP4 16404
INDIRP4
INDIRI1
ASGNI1
line 1621
;1621:		}
LABELV $611
line 1616
ADDRLP4 16400
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16400
INDIRI4
CNSTI4 92
EQI4 $615
ADDRLP4 16400
INDIRI4
CNSTI4 0
NEI4 $610
LABELV $615
line 1622
;1622:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1624
;1623:
;1624:		if (!strcmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16404
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16404
INDIRI4
CNSTI4 0
NEI4 $616
line 1625
;1625:		{
line 1626
;1626:			strcpy (start, s);	// remove this part
ADDRLP4 8196
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1627
;1627:			return;
ADDRGP4 $594
JUMPV
LABELV $616
line 1630
;1628:		}
;1629:
;1630:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $618
line 1631
;1631:			return;
ADDRGP4 $594
JUMPV
LABELV $618
line 1632
;1632:	}
LABELV $601
line 1600
ADDRGP4 $600
JUMPV
line 1634
;1633:
;1634:}
LABELV $594
endproc Info_RemoveKey_Big 16412 8
export Info_Validate
proc Info_Validate 8 8
line 1647
;1635:
;1636:
;1637:
;1638:
;1639:/*
;1640:==================
;1641:Info_Validate
;1642:
;1643:Some characters are illegal in info strings because they
;1644:can mess up the server's parsing
;1645:==================
;1646:*/
;1647:qboolean Info_Validate( const char *s ) {
line 1648
;1648:	if ( strchr( s, '\"' ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 0
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $621
line 1649
;1649:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $620
JUMPV
LABELV $621
line 1651
;1650:	}
;1651:	if ( strchr( s, ';' ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $623
line 1652
;1652:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $620
JUMPV
LABELV $623
line 1654
;1653:	}
;1654:	return qtrue;
CNSTI4 1
RETI4
LABELV $620
endproc Info_Validate 8 8
export Info_SetValueForKey
proc Info_SetValueForKey 1068 20
line 1664
;1655:}
;1656:
;1657:/*
;1658:==================
;1659:Info_SetValueForKey
;1660:
;1661:Changes or adds a key/value pair
;1662:==================
;1663:*/
;1664:void Info_SetValueForKey( char *s, const char *key, const char *value ) {
line 1667
;1665:	char	newi[MAX_INFO_STRING];
;1666:
;1667:	if ( strlen( s ) >= MAX_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 1024
LTI4 $626
line 1668
;1668:		Com_Error( ERR_DROP, "Info_SetValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $628
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1669
;1669:	}
LABELV $626
line 1671
;1670:
;1671:	if (strchr (key, '\\') || strchr (value, '\\'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 1028
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $631
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 1032
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $629
LABELV $631
line 1672
;1672:	{
line 1673
;1673:		Com_Printf ("Can't use keys or values with a \\\n");
ADDRGP4 $632
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1674
;1674:		return;
ADDRGP4 $625
JUMPV
LABELV $629
line 1677
;1675:	}
;1676:
;1677:	if (strchr (key, ';') || strchr (value, ';'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $635
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $633
LABELV $635
line 1678
;1678:	{
line 1679
;1679:		Com_Printf ("Can't use keys or values with a semicolon\n");
ADDRGP4 $636
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1680
;1680:		return;
ADDRGP4 $625
JUMPV
LABELV $633
line 1683
;1681:	}
;1682:
;1683:	if (strchr (key, '\"') || strchr (value, '\"'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1044
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $639
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1048
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $637
LABELV $639
line 1684
;1684:	{
line 1685
;1685:		Com_Printf ("Can't use keys or values with a \"\n");
ADDRGP4 $640
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1686
;1686:		return;
ADDRGP4 $625
JUMPV
LABELV $637
line 1689
;1687:	}
;1688:
;1689:	Info_RemoveKey (s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Info_RemoveKey
CALLV
pop
line 1690
;1690:	if (!value || !strlen(value))
ADDRLP4 1052
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $643
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $641
LABELV $643
line 1691
;1691:		return;
ADDRGP4 $625
JUMPV
LABELV $641
line 1693
;1692:
;1693:	Com_sprintf (newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $644
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1695
;1694:
;1695:	if (strlen(newi) + strlen(s) > MAX_INFO_STRING)
ADDRLP4 0
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
ADDRLP4 1064
INDIRI4
ADDI4
CNSTI4 1024
LEI4 $645
line 1696
;1696:	{
line 1697
;1697:		Com_Printf ("Info string length exceeded\n");
ADDRGP4 $647
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1698
;1698:		return;
ADDRGP4 $625
JUMPV
LABELV $645
line 1701
;1699:	}
;1700:
;1701:	strcat (newi, s);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1702
;1702:	strcpy (s, newi);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1703
;1703:}
LABELV $625
endproc Info_SetValueForKey 1068 20
export Info_SetValueForKey_Big
proc Info_SetValueForKey_Big 8236 20
line 1712
;1704:
;1705:/*
;1706:==================
;1707:Info_SetValueForKey_Big
;1708:
;1709:Changes or adds a key/value pair
;1710:==================
;1711:*/
;1712:void Info_SetValueForKey_Big( char *s, const char *key, const char *value ) {
line 1715
;1713:	char	newi[BIG_INFO_STRING];
;1714:
;1715:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8192
INDIRI4
CNSTI4 8192
LTI4 $649
line 1716
;1716:		Com_Error( ERR_DROP, "Info_SetValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $628
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1717
;1717:	}
LABELV $649
line 1719
;1718:
;1719:	if (strchr (key, '\\') || strchr (value, '\\'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 8196
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8196
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $653
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 8200
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8200
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $651
LABELV $653
line 1720
;1720:	{
line 1721
;1721:		Com_Printf ("Can't use keys or values with a \\\n");
ADDRGP4 $632
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1722
;1722:		return;
ADDRGP4 $648
JUMPV
LABELV $651
line 1725
;1723:	}
;1724:
;1725:	if (strchr (key, ';') || strchr (value, ';'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 8204
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $656
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 8208
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8208
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $654
LABELV $656
line 1726
;1726:	{
line 1727
;1727:		Com_Printf ("Can't use keys or values with a semicolon\n");
ADDRGP4 $636
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1728
;1728:		return;
ADDRGP4 $648
JUMPV
LABELV $654
line 1731
;1729:	}
;1730:
;1731:	if (strchr (key, '\"') || strchr (value, '\"'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 8212
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8212
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $659
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 8216
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8216
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $657
LABELV $659
line 1732
;1732:	{
line 1733
;1733:		Com_Printf ("Can't use keys or values with a \"\n");
ADDRGP4 $640
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1734
;1734:		return;
ADDRGP4 $648
JUMPV
LABELV $657
line 1737
;1735:	}
;1736:
;1737:	Info_RemoveKey_Big (s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Info_RemoveKey_Big
CALLV
pop
line 1738
;1738:	if (!value || !strlen(value))
ADDRLP4 8220
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8220
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $662
ADDRLP4 8220
INDIRP4
ARGP4
ADDRLP4 8224
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8224
INDIRI4
CNSTI4 0
NEI4 $660
LABELV $662
line 1739
;1739:		return;
ADDRGP4 $648
JUMPV
LABELV $660
line 1741
;1740:
;1741:	Com_sprintf (newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 0
ARGP4
CNSTI4 8192
ARGI4
ADDRGP4 $644
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1743
;1742:
;1743:	if (strlen(newi) + strlen(s) > BIG_INFO_STRING)
ADDRLP4 0
ARGP4
ADDRLP4 8228
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8228
INDIRI4
ADDRLP4 8232
INDIRI4
ADDI4
CNSTI4 8192
LEI4 $663
line 1744
;1744:	{
line 1745
;1745:		Com_Printf ("BIG Info string length exceeded\n");
ADDRGP4 $665
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1746
;1746:		return;
ADDRGP4 $648
JUMPV
LABELV $663
line 1749
;1747:	}
;1748:
;1749:	strcat (s, newi);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1750
;1750:}
LABELV $648
endproc Info_SetValueForKey_Big 8236 20
export CG_FileExists
proc CG_FileExists 8 12
line 1765
;1751:
;1752:
;1753:
;1754:
;1755://====================================================================
;1756:
;1757:
;1758:/*
;1759:==========================
;1760:CG_FileExists
;1761:Moved here so it can be used in game also..
;1762:==========================
;1763:*/
;1764://static
;1765:qboolean	CG_FileExists(const char *filename) {
line 1768
;1766:	int len;
;1767:
;1768:	len = trap_FS_FOpenFile( filename, 0, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1769
;1769:	if (len>0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $667
line 1770
;1770:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $667
line 1772
;1771:	}
;1772:	return qfalse;
CNSTI4 0
RETI4
LABELV $666
endproc CG_FileExists 8 12
export SnapVectorTowards
proc SnapVectorTowards 12 0
line 1787
;1773:}
;1774:
;1775://unlagged - attack prediction #3
;1776:// moved from g_weapon.c
;1777:/*
;1778:======================
;1779:SnapVectorTowards
;1780:
;1781:Round a vector to integers for more efficient network
;1782:transmission, but make sure that it rounds towards a given point
;1783:rather than blindly truncating.  This prevents it from truncating 
;1784:into a wall.
;1785:======================
;1786:*/
;1787:void SnapVectorTowards( vec3_t v, vec3_t to ) {
line 1790
;1788:	int		i;
;1789:
;1790:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $670
line 1791
;1791:		if ( to[i] <= v[i] ) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $674
line 1792
;1792:			v[i] = (int)v[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1793
;1793:		} else {
ADDRGP4 $675
JUMPV
LABELV $674
line 1794
;1794:			v[i] = (int)v[i] + 1;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
line 1795
;1795:		}
LABELV $675
line 1796
;1796:	}
LABELV $671
line 1790
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $670
line 1797
;1797:}
LABELV $669
endproc SnapVectorTowards 12 0
bss
export explanation
align 1
LABELV explanation
skip 2048
align 4
LABELV com_lines
skip 4
align 1
LABELV com_parsename
skip 1024
align 1
LABELV com_token
skip 1024
import Com_Printf
import Com_Error
import Info_RemoveKey_big
import trap_FS_FOpenFile
import trap_Argv
import trap_Argc
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
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
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
LABELV $665
byte 1 66
byte 1 73
byte 1 71
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $647
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $644
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $640
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $636
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 101
byte 1 109
byte 1 105
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $632
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 92
byte 1 10
byte 1 0
align 1
LABELV $628
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $597
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 95
byte 1 66
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $571
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $537
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $534
byte 1 0
align 1
LABELV $505
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
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
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $502
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
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
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 105
byte 1 103
byte 1 98
byte 1 117
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $454
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $404
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 60
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $401
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 114
byte 1 99
byte 1 0
align 1
LABELV $398
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $362
byte 1 41
byte 1 0
align 1
LABELV $357
byte 1 40
byte 1 0
align 1
LABELV $331
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $285
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 114
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 40
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $272
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 44
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 125
byte 1 39
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 44
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $245
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 114
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 40
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $242
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 114
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 40
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 98
byte 1 117
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $229
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 114
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 40
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $76
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
LABELV $72
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
LABELV $66
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $46
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
