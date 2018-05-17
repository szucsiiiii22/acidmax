
#define mIRC(m) extern "C" int _stdcall m(HWND mWnd, HWND aWnd, char *data, char *parms, BOOL show, BOOL nopause)
#define NUMCHANNELS		    128
#define FSOUND_BUFFERSIZE   200
#define fmod_m1RC			DLL_Info
#define MAX_MUSIC  64
#define MAX_SAMPLE 64
#define MAX_STREAM 64
#define MAX_PLUGIN 64

#define VERSION "1.00"
#define EDITION "standard release"

typedef struct { DWORD  mVersion; HWND   mHwnd; BOOL   mKeep; } LOADINFO;
typedef struct { FSOUND_SAMPLE *sample;	int	channel; } song_sample;
typedef struct { FSOUND_STREAM *stream; int	channel; } song_stream;
typedef struct { FMUSIC_MODULE *music; } song_music;

long   xatol(char *p);
int    xatoi(char *i);
float  xatof(char i[]);
char * xftoa(float i);
char * text_gettokenex(char *i,int toknum_start,int toknum_end,const char *delim,bool delimreal);
char * StrGetToken(char i[],int toknum,const char delim[]);

char * time_length(int ms);

int  Plugin_Load(int plugnum,char *pathandfile);

typedef void (__stdcall *fmplugin_load)(fmodstruct *,HWND);
typedef void (__stdcall *fmplugin_unload)();
typedef void (__stdcall *fmplugin_msg)(char *);

typedef struct {
	HMODULE module;

	fmplugin_load   fmplugin_load;
	fmplugin_unload fmplugin_unload;
	fmplugin_msg    fmplugin_msg;
} fmmplugin;

fmodstruct *loaddll(char *path) {
	fmodstruct *fmod_inst;
	fmod_inst = new fmodstruct;
	fmod_inst->module = LoadLibrary(path);

	#ifdef EXPORT_MUSIC_FreeSong
	fmod_inst->FMUSIC_FreeSong  = (FMUSIC_FreeSong) GetProcAddress(fmod_inst->module,"_FMUSIC_FreeSong@4");
	#endif
	#ifdef EXPORT_MUSIC_LoadSong
	fmod_inst->FMUSIC_LoadSong	= (FMUSIC_LoadSong)	GetProcAddress(fmod_inst->module,"_FMUSIC_LoadSong@4");
	#endif
	#ifdef EXPORT_MUSIC_LoadSongEx
	fmod_inst->FMUSIC_LoadSongEx = (FMUSIC_LoadSongEx) GetProcAddress(fmod_inst->module,"_FMUSIC_LoadSongEx@24");
	#endif
	#ifdef EXPORT_MUSIC_OptimizeChannels
	fmod_inst->FMUSIC_OptimizeChannels = (FMUSIC_OptimizeChannels) GetProcAddress(fmod_inst->module,"_FMUSIC_OptimizeChannels@12");
	#endif
	#ifdef EXPORT_MUSIC_PlaySong
	fmod_inst->FMUSIC_PlaySong	= (FMUSIC_PlaySong)	GetProcAddress(fmod_inst->module,"_FMUSIC_PlaySong@4");
	#endif
	#ifdef EXPORT_MUSIC_SetInstCallback
	fmod_inst->FMUSIC_SetInstCallback = (FMUSIC_SetInstCallback) GetProcAddress(fmod_inst->module,"_FMUSIC_SetInstCallback@12");
	#endif
	//#ifdef EXPORT_MUSIC_SetCallbackMethods
	//#endif
	#ifdef EXPORT_MUSIC_SetLooping
	fmod_inst->FMUSIC_SetLooping = (FMUSIC_SetLooping) GetProcAddress(fmod_inst->module,"_FMUSIC_SetLooping@8");
	#endif
	#ifdef EXPORT_MUSIC_SetMasterSpeed
	fmod_inst->FMUSIC_SetMasterSpeed = (FMUSIC_SetMasterSpeed) GetProcAddress(fmod_inst->module,"_FMUSIC_SetMasterSpeed@8");
	#endif
	#ifdef EXPORT_MUSIC_SetMasterVolume
	fmod_inst->FMUSIC_SetMasterVolume = (FMUSIC_SetMasterVolume) GetProcAddress(fmod_inst->module,"_FMUSIC_SetMasterVolume@8");
	#endif
	#ifdef EXPORT_MUSIC_SetOrder
	fmod_inst->FMUSIC_SetOrder = (FMUSIC_SetOrder) GetProcAddress(fmod_inst->module,"_FMUSIC_SetOrder@8");
	#endif
	#ifdef EXPORT_MUSIC_SetOrderCallback
	fmod_inst->FMUSIC_SetOrderCallback = (FMUSIC_SetOrderCallback) GetProcAddress(fmod_inst->module,"_FMUSIC_SetOrderCallback@12");
	#endif
	#ifdef EXPORT_MUSIC_SetPanSeperation
	fmod_inst->FMUSIC_SetPanSeperation = (FMUSIC_SetPanSeperation) GetProcAddress(fmod_inst->module,"_FMUSIC_SetPanSeperation@8");
	#endif
	#ifdef EXPORT_MUSIC_SetPaused
	fmod_inst->FMUSIC_SetPaused = (FMUSIC_SetPaused) GetProcAddress(fmod_inst->module,"_FMUSIC_SetPaused@8");
	#endif
	#ifdef EXPORT_MUSIC_SetReverb
	fmod_inst->FMUSIC_SetReverb = (FMUSIC_SetReverb) GetProcAddress(fmod_inst->module,"_FMUSIC_SetReverb@4");
	#endif
	#ifdef EXPORT_MUSIC_SetRowCallback
	fmod_inst->FMUSIC_SetRowCallback = (FMUSIC_SetRowCallback) GetProcAddress(fmod_inst->module,"_FMUSIC_SetRowCallback@12");
	#endif
	#ifdef EXPORT_MUSIC_SetUserData
	fmod_inst->FMUSIC_SetUserData = (FMUSIC_SetUserData) GetProcAddress(fmod_inst->module,"_FMUSIC_SetUserData@8");
	#endif
	#ifdef EXPORT_MUSIC_SetZxxCallback
	fmod_inst->FMUSIC_SetZxxCallback = (FMUSIC_SetZxxCallback) GetProcAddress(fmod_inst->module,"_FMUSIC_SetZxxCallback@8");
	#endif
	#ifdef EXPORT_MUSIC_StopAllSongs
	fmod_inst->FMUSIC_StopAllSongs = (FMUSIC_StopAllSongs) GetProcAddress(fmod_inst->module,"_FMUSIC_StopAllSongs@0");
	#endif
	#ifdef EXPORT_MUSIC_StopSong
	fmod_inst->FMUSIC_StopSong = (FMUSIC_StopSong) GetProcAddress(fmod_inst->module,"_FMUSIC_StopSong@4");
	#endif
	#ifdef EXPORT_MUSIC_GetBPM
	fmod_inst->FMUSIC_GetBPM = (FMUSIC_GetBPM) GetProcAddress(fmod_inst->module,"_FMUSIC_GetBPM@4");
	#endif
	#ifdef EXPORT_MUSIC_GetGlobalVolume
	fmod_inst->FMUSIC_GetGlobalVolume = (FMUSIC_GetGlobalVolume) GetProcAddress(fmod_inst->module,"_FMUSIC_GetGlobalVolume@4");
	#endif
	#ifdef EXPORT_MUSIC_GetMasterVolume
	fmod_inst->FMUSIC_GetMasterVolume = (FMUSIC_GetMasterVolume) GetProcAddress(fmod_inst->module,"_FMUSIC_GetMasterVolume@4");
	#endif
	#ifdef EXPORT_MUSIC_GetName
	fmod_inst->FMUSIC_GetName = (FMUSIC_GetName) GetProcAddress(fmod_inst->module,"_FMUSIC_GetName@4");
	#endif
	#ifdef EXPORT_MUSIC_GetNumChannels
	fmod_inst->FMUSIC_GetNumChannels = (FMUSIC_GetNumChannels) GetProcAddress(fmod_inst->module,"_FMUSIC_GetNumChannels@4");
	#endif
	#ifdef EXPORT_MUSIC_GetNumInstruments
	fmod_inst->FMUSIC_GetNumInstruments = (FMUSIC_GetNumInstruments) GetProcAddress(fmod_inst->module,"_FMUSIC_GetNumInstruments@4");
	#endif
	#ifdef EXPORT_MUSIC_GetNumOrders
	fmod_inst->FMUSIC_GetNumOrders = (FMUSIC_GetNumOrders) GetProcAddress(fmod_inst->module,"_FMUSIC_GetNumOrders@4");
	#endif
	#ifdef EXPORT_MUSIC_GetNumPatterns
	fmod_inst->FMUSIC_GetNumPatterns = (FMUSIC_GetNumPatterns) GetProcAddress(fmod_inst->module,"_FMUSIC_GetNumPatterns@4");
	#endif
	#ifdef EXPORT_MUSIC_GetNumSamples
	fmod_inst->FMUSIC_GetNumSamples = (FMUSIC_GetNumSamples) GetProcAddress(fmod_inst->module,"_FMUSIC_GetNumSamples@4");
	#endif
	#ifdef EXPORT_MUSIC_GetOrder
	fmod_inst->FMUSIC_GetOrder = (FMUSIC_GetOrder) GetProcAddress(fmod_inst->module,"_FMUSIC_SetOrder@8");
	#endif
	#ifdef EXPORT_MUSIC_GetPattern
	fmod_inst->FMUSIC_GetPattern = (FMUSIC_GetPattern) GetProcAddress(fmod_inst->module,"_FMUSIC_GetPattern@4");
	#endif
	#ifdef EXPORT_MUSIC_GetPatternLength
	fmod_inst->FMUSIC_GetPatternLength = (FMUSIC_GetPatternLength) GetProcAddress(fmod_inst->module,"_FMUSIC_GetPatternLength@8");
	#endif
	#ifdef EXPORT_MUSIC_GetPaused
	fmod_inst->FMUSIC_GetPaused = (FMUSIC_GetPaused) GetProcAddress(fmod_inst->module,"_FMUSIC_GetPaused@4");
	#endif
	#ifdef EXPORT_MUSIC_GetRow
	fmod_inst->FMUSIC_GetRow = (FMUSIC_GetRow) GetProcAddress(fmod_inst->module,"_FMUSIC_GetRow@4");
	#endif
	#ifdef EXPORT_MUSIC_GetSample
	fmod_inst->FMUSIC_GetSample = (FMUSIC_GetSample) GetProcAddress(fmod_inst->module,"_FMUSIC_GetSample@8");
	#endif
	#ifdef EXPORT_MUSIC_GetSpeed
	fmod_inst->FMUSIC_GetSpeed = (FMUSIC_GetSpeed) GetProcAddress(fmod_inst->module,"_FMUSIC_GetSpeed@4");
	#endif
	#ifdef EXPORT_MUSIC_GetTime
	fmod_inst->FMUSIC_GetTime = (FMUSIC_GetTime) GetProcAddress(fmod_inst->module,"_FMUSIC_GetTime@4");
	#endif
	#ifdef EXPORT_MUSIC_GetType
	fmod_inst->FMUSIC_GetType = (FMUSIC_GetType) GetProcAddress(fmod_inst->module,"_FMUSIC_GetType@4");
	#endif
	#ifdef EXPORT_MUSIC_GetUserData
	fmod_inst->FMUSIC_GetUserData = (FMUSIC_GetUserData) GetProcAddress(fmod_inst->module,"_FMUSIC_GetUserData@4");
	#endif
	#ifdef EXPORT_MUSIC_IsFinished
	fmod_inst->FMUSIC_IsFinished = (FMUSIC_IsFinished) GetProcAddress(fmod_inst->module,"_FMUSIC_IsFinished@4");
	#endif
	#ifdef EXPORT_MUSIC_IsPlaying
	fmod_inst->FMUSIC_IsPlaying = (FMUSIC_IsPlaying) GetProcAddress(fmod_inst->module,"_FMUSIC_IsPlaying@4");
	#endif
	#ifdef EXPORT_SOUND_Init
	fmod_inst->FSOUND_Init		= (FSOUND_Init)		GetProcAddress(fmod_inst->module,"_FSOUND_Init@12");
	#endif
	#ifdef EXPORT_SOUND_Close
	fmod_inst->FSOUND_Close = (FSOUND_Close) GetProcAddress(fmod_inst->module,"_FSOUND_Close@0");
	#endif
	#ifdef EXPORT_SOUND_SetBufferSize
	fmod_inst->FSOUND_SetBufferSize = (FSOUND_SetBufferSize) GetProcAddress(fmod_inst->module,"_FSOUND_SetBufferSize@4");
	#endif
	#ifdef EXPORT_SOUND_SetDriver
	fmod_inst->FSOUND_SetDriver = (FSOUND_SetDriver) GetProcAddress(fmod_inst->module,"_FSOUND_SetDriver@4");
	#endif
	#ifdef EXPORT_SOUND_SetHWND
	fmod_inst->FSOUND_SetHWND = (FSOUND_SetHWND) GetProcAddress(fmod_inst->module,"_FSOUND_SetHWND@4");
	#endif
	#ifdef EXPORT_SOUND_SetMaxHardwareChannels
	fmod_inst->FSOUND_SetMaxHardwareChannels = (FSOUND_SetMaxHardwareChannels) GetProcAddress(fmod_inst->module,"_FSOUND_SetMaxHardwareChannels@4");
	#endif
	#ifdef EXPORT_SOUND_SetMinHardwareChannels
	fmod_inst->FSOUND_SetMinHardwareChannels = (FSOUND_SetMinHardwareChannels) GetProcAddress(fmod_inst->module,"_FSOUND_SetMinHardwareChannels@4");
	#endif
	#ifdef EXPORT_SOUND_SetMixer
	fmod_inst->FSOUND_SetMixer = (FSOUND_SetMixer) GetProcAddress(fmod_inst->module,"_FSOUND_SetMixer@4");
	#endif
	#ifdef EXPORT_SOUND_SetOutput
	fmod_inst->FSOUND_SetOutput = (FSOUND_SetOutput) GetProcAddress(fmod_inst->module,"_FSOUND_SetOutput@4");
	#endif
	//#ifdef EXPORT_SOUND_SpecifyEffectsImage
	//fmod_inst->FSOUND_SpecifyEffectsImage = (FSOUND_SpecifyEffectsImage) GetProcAddress(fmod_inst->module,"_FSOUND_
	//#endif
	#ifdef EXPORT_SOUND_GetChannelsPlaying
	fmod_inst->FSOUND_GetChannelsPlaying = (FSOUND_GetChannelsPlaying) GetProcAddress(fmod_inst->module,"_FSOUND_GetChannelsPlaying@0");
	#endif
	#ifdef EXPORT_SOUND_GetMaxSamples
	fmod_inst->FSOUND_GetMaxSamples = (FSOUND_GetMaxSamples) GetProcAddress(fmod_inst->module,"_FSOUND_GetMaxSamples@0");
	#endif
	#ifdef EXPORT_SOUND_GetMaxChannels
	fmod_inst->FSOUND_GetMaxChannels = (FSOUND_GetMaxChannels) GetProcAddress(fmod_inst->module,"_FSOUND_GetMaxChannels@0");
	#endif
	#ifdef EXPORT_SOUND_GetNumDrivers
	fmod_inst->FSOUND_GetNumDrivers = (FSOUND_GetNumDrivers) GetProcAddress(fmod_inst->module,"_FSOUND_GetNumDrivers@0");
	#endif
	#ifdef EXPORT_SOUND_GetOutput
	fmod_inst->FSOUND_GetOutput = (FSOUND_GetOutput) GetProcAddress(fmod_inst->module,"_FSOUND_GetOutput@0");
	#endif
	#ifdef EXPORT_SOUND_GetOutputHandle
	fmod_inst->FSOUND_GetOutputHandle = (FSOUND_GetOutputHandle) GetProcAddress(fmod_inst->module,"_FSOUND_GetOutputHandle@0");
	#endif
	#ifdef EXPORT_SOUND_GetOutputRate
	fmod_inst->FSOUND_GetOutputRate = (FSOUND_GetOutputRate) GetProcAddress(fmod_inst->module,"_FSOUND_GetOutputRate@0");
	#endif
	#ifdef EXPORT_SOUND_GetDriver
	fmod_inst->FSOUND_GetDriver = (FSOUND_GetDriver) GetProcAddress(fmod_inst->module,"_FSOUND_GetDriver@0");
	#endif
	#ifdef EXPORT_SOUND_GetDriverName
	fmod_inst->FSOUND_GetDriverName = (FSOUND_GetDriverName) GetProcAddress(fmod_inst->module,"_FSOUND_GetDriverName@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_Alloc
	fmod_inst->FSOUND_Sample_Alloc = (FSOUND_Sample_Alloc) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Alloc@28");
	#endif
	#ifdef EXPORT_SOUND_Sample_Free
	fmod_inst->FSOUND_Sample_Free = (FSOUND_Sample_Free) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Free@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_Get
	fmod_inst->FSOUND_Sample_Get = (FSOUND_Sample_Get) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Get@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_GetDefaults
	fmod_inst->FSOUND_Sample_GetDefaults = (FSOUND_Sample_GetDefaults) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_GetDefaults@20");
	#endif
	#ifdef EXPORT_SOUND_Sample_GetLength
	fmod_inst->FSOUND_Sample_GetLength = (FSOUND_Sample_GetLength) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_GetLength@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_GetLoopPoints
	fmod_inst->FSOUND_Sample_GetLoopPoints = (FSOUND_Sample_GetLoopPoints) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_GetLoopPoints@12");
	#endif
	#ifdef EXPORT_SOUND_Sample_GetMode
	fmod_inst->FSOUND_Sample_GetMode = (FSOUND_Sample_GetMode) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_GetMode@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_GetName
	fmod_inst->FSOUND_Sample_GetName = (FSOUND_Sample_GetName) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_GetName@4");
	#endif
	#ifdef EXPORT_SOUND_Sample_Load
	fmod_inst->FSOUND_Sample_Load = (FSOUND_Sample_Load) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Load@16");
	#endif
	#ifdef EXPORT_SOUND_Sample_Lock
	fmod_inst->FSOUND_Sample_Lock = (FSOUND_Sample_Lock) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Lock@28");
	#endif
	#ifdef EXPORT_SOUND_Sample_SetDefaults
	fmod_inst->FSOUND_Sample_SetDefaults = (FSOUND_Sample_SetDefaults) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_SetDefaults@20");
	#endif
	#ifdef EXPORT_SOUND_Sample_SetMaxPlaybacks
	fmod_inst->FSOUND_Sample_SetMaxPlaybacks = (FSOUND_Sample_SetMaxPlaybacks) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_SetMaxPlaybacks@8");
	#endif
	#ifdef EXPORT_SOUND_Sample_SetMinMaxDistance
	fmod_inst->FSOUND_Sample_SetMinMaxDistance = (FSOUND_Sample_SetMinMaxDistance) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_SetMinMaxDistance@12");
	#endif
	#ifdef EXPORT_SOUND_Sample_SetMode
	fmod_inst->FSOUND_Sample_SetMode = (FSOUND_Sample_SetMode) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_SetMode@8");
	#endif
	#ifdef EXPORT_SOUND_Sample_SetLoopPoints
	fmod_inst->FSOUND_Sample_SetLoopPoints = (FSOUND_Sample_SetLoopPoints) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_SetLoopPoints@12");
	#endif
	#ifdef EXPORT_SOUND_Sample_Unlock
	fmod_inst->FSOUND_Sample_Unlock = (FSOUND_Sample_Unlock) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Unlock@20");
	#endif
	#ifdef EXPORT_SOUND_Sample_Upload
	fmod_inst->FSOUND_Sample_Upload = (FSOUND_Sample_Upload) GetProcAddress(fmod_inst->module,"_FSOUND_Sample_Upload@12");
	#endif
	#ifdef EXPORT_SOUND_PlaySound
	fmod_inst->FSOUND_PlaySound = (FSOUND_PlaySound) GetProcAddress(fmod_inst->module,"_FSOUND_PlaySound@8");
	#endif
	#ifdef EXPORT_SOUND_PlaySoundEx
	fmod_inst->FSOUND_PlaySoundEx = (FSOUND_PlaySoundEx) GetProcAddress(fmod_inst->module,"_FSOUND_PlaySoundEx@16");
	#endif
	#ifdef EXPORT_SOUND_StopSound
	fmod_inst->FSOUND_StopSound = (FSOUND_StopSound) GetProcAddress(fmod_inst->module,"_FSOUND_StopSound@4");
	#endif
	#ifdef EXPORT_SOUND_SetFrequency
	fmod_inst->FSOUND_SetFrequency = (FSOUND_SetFrequency) GetProcAddress(fmod_inst->module,"_FSOUND_SetFrequency@8");
	#endif
	//#ifdef EXPORT_SOUND_SetLevels
	//fmod_inst->FSOUND_SetLevels = (FSOUND_SetLevels) GetProcAddress(fmod_inst->module,"_FSOUND_
	//#endif
	#ifdef EXPORT_SOUND_SetLoopMode
	fmod_inst->FSOUND_SetLoopMode = (FSOUND_SetLoopMode) GetProcAddress(fmod_inst->module,"_FSOUND_SetLoopMode@8");
	#endif
	#ifdef EXPORT_SOUND_SetMute
	fmod_inst->FSOUND_SetMute = (FSOUND_SetMute) GetProcAddress(fmod_inst->module,"_FSOUND_SetMute@8");
	#endif
	#ifdef EXPORT_SOUND_SetPan
	fmod_inst->FSOUND_SetPan = (FSOUND_SetPan) GetProcAddress(fmod_inst->module,"_FSOUND_SetPan@8");
	#endif
	#ifdef EXPORT_SOUND_SetPaused
	fmod_inst->FSOUND_SetPaused = (FSOUND_SetPaused) GetProcAddress(fmod_inst->module,"_FSOUND_SetPaused@8");
	#endif
	#ifdef EXPORT_SOUND_SetPriority
	fmod_inst->FSOUND_SetPriority = (FSOUND_SetPriority) GetProcAddress(fmod_inst->module,"_FSOUND_SetPriority@8");
	#endif
	#ifdef EXPORT_SOUND_SetReserved
	fmod_inst->FSOUND_SetReserved = (FSOUND_SetReserved) GetProcAddress(fmod_inst->module,"_FSOUND_SetReserved@8");
	#endif
	#ifdef EXPORT_SOUND_SetSurround
	fmod_inst->FSOUND_SetSurround = (FSOUND_SetSurround) GetProcAddress(fmod_inst->module,"_FSOUND_SetSurround@8");
	#endif
	#ifdef EXPORT_SOUND_SetVolume
	fmod_inst->FSOUND_SetVolume = (FSOUND_SetVolume) GetProcAddress(fmod_inst->module,"_FSOUND_SetVolume@8");
	#endif
	#ifdef EXPORT_SOUND_SetVolumeAbsolute
	fmod_inst->FSOUND_SetVolumeAbsolute = (FSOUND_SetVolumeAbsolute) GetProcAddress(fmod_inst->module,"_FSOUND_SetVolumeAbsolute@8");
	#endif
	#ifdef EXPORT_SOUND_GetVolume
	fmod_inst->FSOUND_GetVolume = (FSOUND_GetVolume) GetProcAddress(fmod_inst->module,"_FSOUND_GetVolume@4");
	#endif
	#ifdef EXPORT_SOUND_SetCurrentPosition
	fmod_inst->FSOUND_SetCurrentPosition = (FSOUND_SetCurrentPosition) GetProcAddress(fmod_inst->module,"_FSOUND_SetCurrentPosition@8");
	#endif
	#ifdef EXPORT_SOUND_GetCurrentPosition
	fmod_inst->FSOUND_GetCurrentPosition = (FSOUND_GetCurrentPosition) GetProcAddress(fmod_inst->module,"_FSOUND_GetCurrentPosition@4");
	#endif
	#ifdef EXPORT_SOUND_GetCurrentSample
	fmod_inst->FSOUND_GetCurrentSample = (FSOUND_GetCurrentSample) GetProcAddress(fmod_inst->module,"_FSOUND_GetCurrentSample@4");
	#endif
	#ifdef EXPORT_SOUND_GetCurrentLevels
	fmod_inst->FSOUND_GetCurrentLevels = (FSOUND_GetCurrentLevels) GetProcAddress(fmod_inst->module,"_FSOUND_GetCurrentLevels@12");
	#endif
	#ifdef EXPORT_SOUND_GetFrequency
	fmod_inst->FSOUND_GetFrequency = (FSOUND_GetFrequency) GetProcAddress(fmod_inst->module,"_FSOUND_GetFrequency@4");
	#endif
	#ifdef EXPORT_SOUND_GetLoopMode
	fmod_inst->FSOUND_GetLoopMode = (FSOUND_GetLoopMode) GetProcAddress(fmod_inst->module,"_FSOUND_GetLoopMode@4");
	#endif
	#ifdef EXPORT_SOUND_GetMixer
	fmod_inst->FSOUND_GetMixer = (FSOUND_GetMixer) GetProcAddress(fmod_inst->module,"_FSOUND_GetMixer@0");
	#endif
	#ifdef EXPORT_SOUND_GetMute
	fmod_inst->FSOUND_GetMute = (FSOUND_GetMute) GetProcAddress(fmod_inst->module,"_FSOUND_GetMute@4");
	#endif
	#ifdef EXPORT_SOUND_GetPan
	fmod_inst->FSOUND_GetPan = (FSOUND_GetPan) GetProcAddress(fmod_inst->module,"_FSOUND_GetPan@4");
	#endif
	#ifdef EXPORT_SOUND_GetPaused
	fmod_inst->FSOUND_GetPaused = (FSOUND_GetPaused) GetProcAddress(fmod_inst->module,"_FSOUND_GetPaused@4");
	#endif
	#ifdef EXPORT_SOUND_GetPriority
	fmod_inst->FSOUND_GetPriority = (FSOUND_GetPriority) GetProcAddress(fmod_inst->module,"_FSOUND_GetPriority@4");
	#endif
	#ifdef EXPORT_SOUND_GetReserved
	fmod_inst->FSOUND_GetReserved = (FSOUND_GetReserved) GetProcAddress(fmod_inst->module,"_FSOUND_GetReserved@4");
	#endif
	#ifdef EXPORT_SOUND_GetSurround
	fmod_inst->FSOUND_GetSurround = (FSOUND_GetSurround) GetProcAddress(fmod_inst->module,"_FSOUND_GetSurround@4");
	#endif
	#ifdef EXPORT_SOUND_IsPlaying
	fmod_inst->FSOUND_IsPlaying = (FSOUND_IsPlaying) GetProcAddress(fmod_inst->module,"_FSOUND_IsPlaying@4");
	#endif
	#ifdef EXPORT_SOUND_3D_Listener_GetAttributes
	fmod_inst->FSOUND_3D_Listener_GetAttributes = (FSOUND_3D_Listener_GetAttributes) GetProcAddress(fmod_inst->module,"_FSOUND_3D_Listener_GetAttributes@32");
	#endif
	#ifdef EXPORT_SOUND_3D_Listener_SetAttributes
	fmod_inst->FSOUND_3D_Listener_SetAttributes = (FSOUND_3D_Listener_SetAttributes) GetProcAddress(fmod_inst->module,"_FSOUND_3D_Listener_SetAttributes@32");
	#endif
	#ifdef EXPORT_SOUND_3D_GetAttributes
	fmod_inst->FSOUND_3D_GetAttributes = (FSOUND_3D_GetAttributes) GetProcAddress(fmod_inst->module,"_FSOUND_3D_GetAttributes@12");
	#endif
	#ifdef EXPORT_SOUND_3D_Listener_SetCurrent
	fmod_inst->FSOUND_3D_Listener_SetCurrent = (FSOUND_3D_Listener_SetCurrent) GetProcAddress(fmod_inst->module,"_FSOUND_3D_Listener_SetCurrent@8");
	#endif
	#ifdef EXPORT_SOUND_3D_SetDistanceFactor
	fmod_inst->FSOUND_3D_SetDistanceFactor = (FSOUND_3D_SetDistanceFactor) GetProcAddress(fmod_inst->module,"_FSOUND_3D_SetDistanceFactor@4");
	#endif
	#ifdef EXPORT_SOUND_3D_SetDopplerFactor
	fmod_inst->FSOUND_3D_SetDopplerFactor = (FSOUND_3D_SetDopplerFactor) GetProcAddress(fmod_inst->module,"_FSOUND_3D_SetDopplerFactor@4");
	#endif
	#ifdef EXPORT_SOUND_3D_SetRolloffFactor
	fmod_inst->FSOUND_3D_SetRolloffFactor = (FSOUND_3D_SetRolloffFactor) GetProcAddress(fmod_inst->module,"_FSOUND_3D_SetRolloffFactor@4");
	#endif
	#ifdef EXPORT_SOUND_3D_SetAttributes
	fmod_inst->FSOUND_3D_SetAttributes = (FSOUND_3D_SetAttributes) GetProcAddress(fmod_inst->module,"_FSOUND_3D_SetAttributes@12");
	#endif
	#ifdef EXPORT_SOUND_Update
	fmod_inst->FSOUND_Update = (FSOUND_Update) GetProcAddress(fmod_inst->module,"_FSOUND_Update@0");
	#endif
	#ifdef EXPORT_SOUND_Stream_AddSynchPoint
	fmod_inst->FSOUND_Stream_AddSynchPoint = (FSOUND_Stream_AddSynchPoint) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_AddSynchPoint@12");
	#endif
	#ifdef EXPORT_SOUND_Stream_Close
	fmod_inst->FSOUND_Stream_Close = (FSOUND_Stream_Close) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Close@4");
	#endif 
	#ifdef EXPORT_SOUND_Stream_Create
	fmod_inst->FSOUND_Stream_Create = (FSOUND_Stream_Create) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Create@20");
	#endif
	#ifdef EXPORT_SOUND_Stream_CreateDSP
	fmod_inst->FSOUND_Stream_CreateDSP = (FSOUND_Stream_CreateDSP) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_CreateDSP@16");
	#endif
	#ifdef EXPORT_SOUND_Stream_DeleteSynchPoint
	fmod_inst->FSOUND_Stream_DeleteSynchPoint = (FSOUND_Stream_DeleteSynchPoint) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_DeleteSynchPoint@8");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetLength
	fmod_inst->FSOUND_Stream_GetLength = (FSOUND_Stream_GetLength) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetLength@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetLengthMs
	fmod_inst->FSOUND_Stream_GetLengthMs = (FSOUND_Stream_GetLengthMs) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetLengthMs@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetNumSubStreams
	fmod_inst->FSOUND_Stream_GetNumSubStreams = (FSOUND_Stream_GetNumSubStreams) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetNumSubStreams@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetNumSynchPoints
	fmod_inst->FSOUND_Stream_GetNumSynchPoints = (FSOUND_Stream_GetNumSynchPoints) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetNumSynchPoints@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetOpenState
	fmod_inst->FSOUND_Stream_GetOpenState = (FSOUND_Stream_GetOpenState) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetOpenState@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetPosition
	fmod_inst->FSOUND_Stream_GetPosition = (FSOUND_Stream_GetPosition) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetPosition@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetSample
	fmod_inst->FSOUND_Stream_GetSample = (FSOUND_Stream_GetSample) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetSample@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_GetTime
	fmod_inst->FSOUND_Stream_GetTime = (FSOUND_Stream_GetTime) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_GetTime@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_Open
	fmod_inst->FSOUND_Stream_Open = (FSOUND_Stream_Open) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Open@16");
	#endif
	#ifdef EXPORT_SOUND_Stream_Play
	fmod_inst->FSOUND_Stream_Play = (FSOUND_Stream_Play) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Play@8");
	#endif
	#ifdef EXPORT_SOUND_Stream_PlayEx
	fmod_inst->FSOUND_Stream_PlayEx = (FSOUND_Stream_PlayEx) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_PlayEx@16");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetBufferSize
	fmod_inst->FSOUND_Stream_SetBufferSize = (FSOUND_Stream_SetBufferSize) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetBufferSize@4");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetEndCallback
	fmod_inst->FSOUND_Stream_SetEndCallback = (FSOUND_Stream_SetEndCallback) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetEndCallback@12");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetLoopPoints
	fmod_inst->FSOUND_Stream_SetLoopPoints = (FSOUND_Stream_SetLoopPoints) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetLoopPoints@12");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetPosition
	fmod_inst->FSOUND_Stream_SetPosition = (FSOUND_Stream_SetPosition) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetPosition@8");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetSubStream
	fmod_inst->FSOUND_Stream_SetSubStream = (FSOUND_Stream_SetSubStream) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetSubStream@8");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetSynchCallback
	fmod_inst->FSOUND_Stream_SetSynchCallback = (FSOUND_Stream_SetSynchCallback) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetSynchCallback@12");
	#endif
	#ifdef EXPORT_SOUND_Stream_SetTime
	fmod_inst->FSOUND_Stream_SetTime = (FSOUND_Stream_SetTime) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_SetTime@8");
	#endif
	#ifdef EXPORT_SOUND_Stream_Stop
	fmod_inst->FSOUND_Stream_Stop = (FSOUND_Stream_Stop) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Stop@4");
	#endif
	#ifdef EXPORT_SOUND_CD_Eject
	fmod_inst->FSOUND_CD_Eject = (FSOUND_CD_Eject) GetProcAddress(fmod_inst->module,"_FSOUND_CD_Eject@4");
	#endif
	#ifdef EXPORT_SOUND_CD_GetNumTracks
	fmod_inst->FSOUND_CD_GetNumTracks = (FSOUND_CD_GetNumTracks) GetProcAddress(fmod_inst->module,"_FSOUND_CD_GetNumTracks@4");
	#endif
	#ifdef EXPORT_SOUND_CD_GetPaused
	fmod_inst->FSOUND_CD_GetPaused = (FSOUND_CD_GetPaused) GetProcAddress(fmod_inst->module,"_FSOUND_CD_GetPaused@4");
	#endif
	#ifdef EXPORT_SOUND_CD_GetTrack
	fmod_inst->FSOUND_CD_GetTrack = (FSOUND_CD_GetTrack) GetProcAddress(fmod_inst->module,"_FSOUND_CD_GetTrack@4");
	#endif
	#ifdef EXPORT_SOUND_CD_GetTrackLength
	fmod_inst->FSOUND_CD_GetTrackLength = (FSOUND_CD_GetTrackLength) GetProcAddress(fmod_inst->module,"_FSOUND_CD_GetTrackLength@8");
	#endif
	#ifdef EXPORT_SOUND_CD_GetTrackTime
	fmod_inst->FSOUND_CD_GetTrackTime = (FSOUND_CD_GetTrackTime) GetProcAddress(fmod_inst->module,"_FSOUND_CD_GetTrackTime@4");
	#endif
	#ifdef EXPORT_SOUND_CD_Play
	fmod_inst->FSOUND_CD_Play = (FSOUND_CD_Play) GetProcAddress(fmod_inst->module,"_FSOUND_CD_Play@8");
	#endif
	#ifdef EXPORT_SOUND_CD_SetPaused
	fmod_inst->FSOUND_CD_SetPaused = (FSOUND_CD_SetPaused) GetProcAddress(fmod_inst->module,"_FSOUND_CD_SetPaused@8");
	#endif
	#ifdef EXPORT_SOUND_CD_SetPlayMode
	fmod_inst->FSOUND_CD_SetPlayMode = (FSOUND_CD_SetPlayMode) GetProcAddress(fmod_inst->module,"_FSOUND_CD_SetPlayMode@8");
	#endif
	#ifdef EXPORT_SOUND_CD_SetVolume
	fmod_inst->FSOUND_CD_SetVolume = (FSOUND_CD_SetVolume) GetProcAddress(fmod_inst->module,"_FSOUND_CD_SetVolume@8");
	#endif
	#ifdef EXPORT_SOUND_CD_Stop
	fmod_inst->FSOUND_CD_Stop = (FSOUND_CD_Stop) GetProcAddress(fmod_inst->module,"_FSOUND_CD_Stop@4");
	#endif
	#ifdef EXPORT_SOUND_DSP_ClearMixBuffer
	fmod_inst->FSOUND_DSP_ClearMixBuffer = (FSOUND_DSP_ClearMixBuffer) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_ClearMixBuffer@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_Create
	fmod_inst->FSOUND_DSP_Create = (FSOUND_DSP_Create) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_Create@12");
	#endif
	#ifdef EXPORT_SOUND_DSP_Free
	fmod_inst->FSOUND_DSP_Free = (FSOUND_DSP_Free) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_Free@4");
	#endif
	#ifdef EXPORT_SOUND_DSP_SetActive
	fmod_inst->FSOUND_DSP_SetActive = (FSOUND_DSP_SetActive) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_SetActive@8");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetActive
	fmod_inst->FSOUND_DSP_GetActive = (FSOUND_DSP_GetActive) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetActive@4");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetBufferLength
	fmod_inst->FSOUND_DSP_GetBufferLength = (FSOUND_DSP_GetBufferLength) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetBufferLength@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetBufferLengthTotal
	fmod_inst->FSOUND_DSP_GetBufferLengthTotal = (FSOUND_DSP_GetBufferLengthTotal) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetBufferLengthTotal@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_SetPriority
	fmod_inst->FSOUND_DSP_SetPriority = (FSOUND_DSP_SetPriority) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_SetPriority@8");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetPriority
	fmod_inst->FSOUND_DSP_GetPriority = (FSOUND_DSP_GetPriority) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetPriority@4");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetClearUnit
	fmod_inst->FSOUND_DSP_GetClearUnit = (FSOUND_DSP_GetClearUnit) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetClearUnit@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetClipAndCopyUnit
	fmod_inst->FSOUND_DSP_GetClipAndCopyUnit = (FSOUND_DSP_GetClipAndCopyUnit) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetClipAndCopyUnit@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetMusicUnit
	fmod_inst->FSOUND_DSP_GetMusicUnit = (FSOUND_DSP_GetMusicUnit) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetMusicUnit@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetSFXUnit
	fmod_inst->FSOUND_DSP_GetSFXUnit = (FSOUND_DSP_GetSFXUnit) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetSFXUnit@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetFFTUnit
	fmod_inst->FSOUND_DSP_GetFFTUnit = (FSOUND_DSP_GetFFTUnit) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetFFTUnit@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_GetSpectrum
	fmod_inst->FSOUND_DSP_GetSpectrum = (FSOUND_DSP_GetSpectrum) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_GetSpectrum@0");
	#endif
	#ifdef EXPORT_SOUND_DSP_MixBuffers
	fmod_inst->FSOUND_DSP_MixBuffers = (FSOUND_DSP_MixBuffers) GetProcAddress(fmod_inst->module,"_FSOUND_DSP_MixBuffers@28");
	#endif
	#ifdef EXPORT_SOUND_FX_Disable
	fmod_inst->FSOUND_FX_Disable = (FSOUND_FX_Disable) GetProcAddress(fmod_inst->module,"_FSOUND_FX_Disable@4");
	#endif
	#ifdef EXPORT_SOUND_FX_Enable
	fmod_inst->FSOUND_FX_Enable = (FSOUND_FX_Enable) GetProcAddress(fmod_inst->module,"_FSOUND_FX_Enable@8");
	#endif
	#ifdef EXPORT_SOUND_FX_SetChorus
	fmod_inst->FSOUND_FX_SetChorus = (FSOUND_FX_SetChorus) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetChorus@32");
	#endif
	#ifdef EXPORT_SOUND_FX_SetCompressor
	fmod_inst->FSOUND_FX_SetCompressor = (FSOUND_FX_SetCompressor) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetCompressor@28");
	#endif
	#ifdef EXPORT_SOUND_FX_SetDistortion
	fmod_inst->FSOUND_FX_SetDistortion = (FSOUND_FX_SetDistortion) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetDistortion@24");
	#endif
	#ifdef EXPORT_SOUND_FX_SetEcho
	fmod_inst->FSOUND_FX_SetEcho = (FSOUND_FX_SetEcho) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetEcho@24");
	#endif
	#ifdef EXPORT_SOUND_FX_SetFlanger
	fmod_inst->FSOUND_FX_SetFlanger = (FSOUND_FX_SetFlanger) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetFlanger@32");
	#endif
	#ifdef EXPORT_SOUND_FX_SetGargle
	fmod_inst->FSOUND_FX_SetGargle = (FSOUND_FX_SetGargle) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetGargle@12");
	#endif
	#ifdef EXPORT_SOUND_FX_SetI3DL2Reverb
	fmod_inst->FSOUND_FX_SetI3DL2Reverb = (FSOUND_FX_SetI3DL2Reverb) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetI3DL2Reverb@52");
	#endif
	#ifdef EXPORT_SOUND_FX_SetParamEQ
	fmod_inst->FSOUND_FX_SetParamEQ = (FSOUND_FX_SetParamEQ) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetParamEQ@16");
	#endif
	#ifdef EXPORT_SOUND_FX_SetWavesReverb
	fmod_inst->FSOUND_FX_SetWavesReverb = (FSOUND_FX_SetWavesReverb) GetProcAddress(fmod_inst->module,"_FSOUND_FX_SetWavesReverb@20");
	#endif
	#ifdef EXPORT_SOUND_Record_GetDriver
	fmod_inst->FSOUND_Record_GetDriver = (FSOUND_Record_GetDriver) GetProcAddress(fmod_inst->module,"_FSOUND_Record_GetDriver@0");
	#endif
	#ifdef EXPORT_SOUND_Record_GetDriverName
	fmod_inst->FSOUND_Record_GetDriverName = (FSOUND_Record_GetDriverName) GetProcAddress(fmod_inst->module,"_FSOUND_Record_GetDriverName@4");
	#endif
	#ifdef EXPORT_SOUND_Record_GetNumDrivers
	fmod_inst->FSOUND_Record_GetNumDrivers = (FSOUND_Record_GetNumDrivers) GetProcAddress(fmod_inst->module,"_FSOUND_Record_GetNumDrivers@0");
	#endif
	#ifdef EXPORT_SOUND_Record_GetPosition
	fmod_inst->FSOUND_Record_GetPosition = (FSOUND_Record_GetPosition) GetProcAddress(fmod_inst->module,"_FSOUND_Record_GetPosition@0");
	#endif
	#ifdef EXPORT_SOUND_Record_SetDriver
	fmod_inst->FSOUND_Record_SetDriver = (FSOUND_Record_SetDriver) GetProcAddress(fmod_inst->module,"_FSOUND_Record_SetDriver@4");
	#endif
	#ifdef EXPORT_SOUND_Record_StartSample
	fmod_inst->FSOUND_Record_StartSample = (FSOUND_Record_StartSample) GetProcAddress(fmod_inst->module,"_FSOUND_Record_StartSample@8");
	#endif
	#ifdef EXPORT_SOUND_Record_Stop
	fmod_inst->FSOUND_Record_Stop = (FSOUND_Record_Stop) GetProcAddress(fmod_inst->module,"_FSOUND_Record_Stop@0");
	#endif
	#ifdef EXPORT_SOUND_Reverb_SetProperties
	fmod_inst->FSOUND_Reverb_SetProperties = (FSOUND_Reverb_SetProperties) GetProcAddress(fmod_inst->module,"_FSOUND_Reverb_SetProperties@4");
	#endif
	#ifdef EXPORT_SOUND_Reverb_GetProperties
	fmod_inst->FSOUND_Reverb_GetProperties = (FSOUND_Reverb_GetProperties) GetProcAddress(fmod_inst->module,"_FSOUND_Reverb_GetProperties@4");
	#endif
	#ifdef EXPORT_SOUND_Reverb_SetChannelProperties
	fmod_inst->FSOUND_Reverb_SetChannelProperties = (FSOUND_Reverb_SetChannelProperties) GetProcAddress(fmod_inst->module,"_FSOUND_Reverb_SetChannelProperties@8");
	#endif
	#ifdef EXPORT_SOUND_Reverb_GetChannelProperties
	fmod_inst->FSOUND_Reverb_GetChannelProperties = (FSOUND_Reverb_GetChannelProperties) GetProcAddress(fmod_inst->module,"_FSOUND_Reverb_GetChannelProperties@8");
	#endif
	#ifdef EXPORT_SOUND_File_SetCallbacks
	fmod_inst->FSOUND_File_SetCallbacks = (FSOUND_File_SetCallbacks) GetProcAddress(fmod_inst->module,"_FSOUND_File_SetCallbacks@20");
	#endif
	#ifdef EXPORT_SOUND_GetCPUUsage
	fmod_inst->FSOUND_GetCPUUsage = (FSOUND_GetCPUUsage) GetProcAddress(fmod_inst->module,"_FSOUND_GetCPUUsage@0");
	#endif
	#ifdef EXPORT_SOUND_GetDriverCaps
	fmod_inst->FSOUND_GetDriverCaps = (FSOUND_GetDriverCaps) GetProcAddress(fmod_inst->module,"_FSOUND_GetDriverCaps@8");
	#endif
	#ifdef EXPORT_SOUND_GetError
	fmod_inst->FSOUND_GetError = (FSOUND_GetError) GetProcAddress(fmod_inst->module,"_FSOUND_GetError@0");
	#endif
	#ifdef EXPORT_SOUND_GetMemoryStats
	fmod_inst->FSOUND_GetMemoryStats = (FSOUND_GetMemoryStats) GetProcAddress(fmod_inst->module,"_FSOUND_GetMemoryStats@8");
	#endif
	#ifdef EXPORT_SOUND_GetNumHardwareChannels
	fmod_inst->FSOUND_GetNumHardwareChannels = (FSOUND_GetNumHardwareChannels) GetProcAddress(fmod_inst->module,"_FSOUND_GetNumHardwareChannels@0");
	#endif
	#ifdef EXPORT_SOUND_GetSFXMasterVolume
	fmod_inst->FSOUND_GetSFXMasterVolume = (FSOUND_GetSFXMasterVolume) GetProcAddress(fmod_inst->module,"_FSOUND_GetSFXMasterVolume@0");
	#endif
	#ifdef EXPORT_SOUND_GetVersion
	fmod_inst->FSOUND_GetVersion = (FSOUND_GetVersion) GetProcAddress(fmod_inst->module,"_FSOUND_GetVersion@0");
	#endif
	#ifdef EXPORT_SOUND_SetMemorySystem
	fmod_inst->FSOUND_SetMemorySystem = (FSOUND_SetMemorySystem) GetProcAddress(fmod_inst->module,"_FSOUND_SetMemorySystem@20");
	#endif
	#ifdef EXPORT_SOUND_SetPanSeperation
	fmod_inst->FSOUND_SetPanSeperation = (FSOUND_SetPanSeperation) GetProcAddress(fmod_inst->module,"_FSOUND_SetPanSeperation@4");
	#endif
	#ifdef EXPORT_SOUND_SetSFXMasterVolume
	fmod_inst->FSOUND_SetSFXMasterVolume = (FSOUND_SetSFXMasterVolume) GetProcAddress(fmod_inst->module,"_FSOUND_SetSFXMasterVolume@4");
	#endif
	#ifdef EXPORT_SOUND_SetSpeakerMode
	fmod_inst->FSOUND_SetSpeakerMode = (FSOUND_SetSpeakerMode) GetProcAddress(fmod_inst->module,"_FSOUND_SetSpeakerMode@4");
	#endif

	#ifdef EXPORT_SOUND_Stream_Net_GetBufferProperties
	//_FSOUND_Stream_Net_GetBufferProperties@12
	#endif

	#ifdef EXPORT_SOUND_Stream_Net_GetInfo
	//_FSOUND_Stream_Net_GetInfo@4
	#endif

	#ifdef EXPORT_SOUND_Stream_Net_GetLastServerStatus
	//fmod_inst->FSOUND_Stream_Net_GetLastServerStatus = (FSOUND_Stream_Net_GetLastServerStatus) GetProcAddress(fmod_inst->module,"_FSOUND_Stream_Net_GetLastServerStatus@0");
	#endif

	#ifdef EXPORT_SOUND_Stream_Net_SetBufferProperties
	//_FSOUND_Stream_Net_SetBufferProperties@12
	#endif

	#ifdef EXPORT_SOUND_Stream_Net_SetProxy
	//_FSOUND_Stream_Net_SetProxy@4
	#endif

	return fmod_inst;
}
//signed char (__stdcall *FSOUND_Stream_SetSubStreamSentence)(FSOUND_STREAM *stream, int *sentencelist, int numitems);
//signed char (__stdcall *FSOUND_Stream_SetMode)(FSOUND_STREAM *stream, unsigned int mode);
//unsigned int (__stdcall *FSOUND_Stream_GetMode)(FSOUND_STREAM *stream);
//signed char (__stdcall *FSOUND_Stream_SetLoopCount)(FSOUND_STREAM *stream, int count);
//signed char (__stdcall *FSOUND_CD_SetTrackTime)(char drive, unsigned int ms);
//int (__stdcall *FSOUND_CD_GetVolume)(char drive);
//int (__stdcall *FMUSIC_GetOpenState)(FMUSIC_MODULE *mod);
//signed char (__stdcall *FMUSIC_SetSample)(FMUSIC_MODULE *mod, int sampno, FSOUND_SAMPLE *sptr);
//int (__stdcall *FMUSIC_GetRealChannel)(FMUSIC_MODULE *mod, int modchannel);
//is sound_setlevels taken out?
//EXPORT_SOUND_SpecifyEffectsImage taken out too?
//fix EXPORT_MUSIC_SetCallbackMethods