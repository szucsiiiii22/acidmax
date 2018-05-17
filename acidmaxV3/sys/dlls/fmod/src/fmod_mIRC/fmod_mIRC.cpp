//fmod_mIRC copyright 2002-2003 - Banditos Software
//Last updated 8/05/03

//-includes-  (standard)
#include <windows.h>

//-includes-  (project)
#include "fmod_mIRC_proto.h"	//keep these
#include "fmod_mIRC_exports.h"	//includes in
#include "fmod_mIRC.h"			//this order

//-libraries- (personal)
//#pragma comment(lib,"fmod_mIRC_link.lib")    //link this file manually
//#pragma comment(lib,"/NODEFAULTLIB")         //turn import all default libraries off

extern	"C" {
	int	_cdecl _ftol2()
	{
		int		result;
		short	cw1, cw2;
		_asm
		{
			fnstcw	[cw1]
			wait
			mov		ax, [cw1]
			or		ah, 0x0C
			mov		[cw2],ax
			fldcw	[cw2]
			fistp	[result]
			fldcw	[cw1]
		}
		return (result);
	}
}

extern	"C" int	_fltused = 0;
extern "C" int WINAPI _DllMainCRTStartup(HANDLE,DWORD,void*) { return 1; }
extern int __cdecl _purecall() { return 0; }
void* __cdecl operator new(size_t n) { return HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY,n); }
void __cdecl operator delete(void* p) { if (p) HeapFree(GetProcessHeap(),0,p); }

HWND cback_hwnd;
HWND cback_awnd;
HWND hwnd_mIRC;
int cback_method = 1;
char FMOD_ERROR[256];
HANDLE hFileMap;
LPSTR mData;
song_sample		sample[MAX_SAMPLE];
song_stream		stream[MAX_STREAM];
song_music		music[MAX_MUSIC];
fmmplugin      *plug_inst[MAX_PLUGIN];
fmodstruct     *fmod_inst = 0;

#pragma comment(linker, "/EXPORT:DLL_Info=_DLL_Info@24")
char * DLL_info() { return "fmod_mIRC by captainEO"; }
#pragma comment(linker, "/EXPORT:DLL_Version=_DLL_Version@24")
mIRC(DLL_Version) { lstrcpy(data,VERSION); return 3; }
#pragma comment(linker, "/EXPORT:DLL_Edition=_DLL_Edition@24")
mIRC(DLL_Edition) { lstrcpy(data,EDITION); return 3; }

//-Plugin Load
//0 doesn't detect it as a plugin file
//1 if sucessfully loaded
//2 the file is not found or cannot access fer some reason
int Plugin_Load(int plugnum,char pathandfile[900]) {
	if (-1==GetFileAttributes(pathandfile)) { return 2; }
	else {
		HMODULE plugintemp;
		plugintemp = LoadLibrary(pathandfile);
		//does file meet requirements
		if (GetProcAddress(plugintemp,"_fmplugin_load@8")!=NULL) {
			if (GetProcAddress(plugintemp,"_fmplugin_unload@0")!=NULL) {
				if (GetProcAddress(plugintemp,"_fmplugin_msg@4")!=NULL) {
					if (plug_inst[plugnum]!=NULL) {
						plug_inst[plugnum]->fmplugin_unload();
						FreeLibrary(plug_inst[plugnum]->module);
						delete plug_inst[plugnum]; plug_inst[plugnum]=NULL;
					}
					plug_inst[plugnum] = new fmmplugin;
					plug_inst[plugnum]->module=plugintemp;
					return 1;
				}
			}
		}
		return 0;
	}
}

#ifdef EXPORT_Plugin_Load
#pragma comment(linker, "/EXPORT:Plugin_Load=_Plugin_Load@24")
mIRC(Plugin_Load) {
	char *temp1 = StrGetToken(data,1," ");
	int plugnum = xatoi(temp1);

	char *path = StrGetToken(data,2,"\"");
	int r = Plugin_Load(plugnum,path);

	if      (r==0) { lstrcpy(data,"0 Not a valid plugin file."); }
	else if (r==1) { lstrcpy(data,"1 Plugin "); lstrcat(data,path); lstrcat(data," sucessfully loaded to plugin-slot:"); lstrcat(data,temp1);
		plug_inst[plugnum]->fmplugin_load   = (fmplugin_load)   GetProcAddress(plug_inst[plugnum]->module,"_fmplugin_load@8");
		plug_inst[plugnum]->fmplugin_unload = (fmplugin_unload) GetProcAddress(plug_inst[plugnum]->module,"_fmplugin_unload@0");
		plug_inst[plugnum]->fmplugin_msg    = (fmplugin_msg)    GetProcAddress(plug_inst[plugnum]->module,"_fmplugin_msg@4");
		plug_inst[plugnum]->fmplugin_load(fmod_inst,hwnd_mIRC);
	}
	else if (r==2) { lstrcpy(data,"0 The file is not found or could not be accessed."); }

	delete[] temp1; temp1=NULL;
	delete[] path; path=NULL;
	return 3;
}
#endif

#ifdef EXPORT_Plugin_UnLoad
#pragma comment(linker, "/EXPORT:Plugin_UnLoad=_Plugin_UnLoad@24")
mIRC(Plugin_UnLoad) {
	char *temp1 = StrGetToken(data,1," ");
	int plugnum = xatoi(temp1);
	if (plug_inst[plugnum]!=NULL) {
		plug_inst[plugnum]->fmplugin_unload();
		FreeLibrary(plug_inst[plugnum]->module);
		delete plug_inst[plugnum]; plug_inst[plugnum]=NULL;
	}
	else { lstrcpy(data,"0 There is no plugin loaded in this slot."); }
	return 3;
}
#endif

#ifdef EXPORT_Plugin_Send
#pragma comment(linker, "/EXPORT:Plugin_Send=_Plugin_Send@24")
char msgbuf[901];
mIRC(Plugin_Send) {
	char *temp1 = StrGetToken(data,1," ");
	int plugnum = xatoi(temp1);
	delete[] temp1; temp1=NULL;

	if (plug_inst[plugnum]==NULL) { lstrcpy(data,"0 The plugin slot has nothing loaded in it."); }
	else {
		char *msg = text_gettokenex(data,2,-1," ",true);
		lstrcpy(msgbuf,msg);
		plug_inst[plugnum]->fmplugin_msg(msgbuf);
		lstrcpy(data,msgbuf);
		delete[] msg; msg=NULL;
	}

	return 3;
}
#endif

int fmod_IsConnected() {
	if (fmod_inst!=0) { return 1; }
	lstrcpy(FMOD_ERROR,"0 fmod_mIRC is not connected to a fmod.dll");
	return 0;
}
//1 for music,2 for sample,3 for stream
int fmod_IsSlotReady(int index,int type) {
	if (type==1 && music[index].music==NULL) { lstrcpy(FMOD_ERROR,"0 There is no -MUSIC- file loaded for this slot."); return 0; }
	else if (type==2 && sample[index].sample==NULL) { lstrcpy(FMOD_ERROR,"0 There is no -SAMPLE- file loaded for this slot."); return 0; }
	else if (type==3 && stream[index].stream==NULL) { lstrcpy(FMOD_ERROR,"0 There is no -STREAM- file loaded for this slot."); return 0; }
	return 1;
}

void fmod_CopyError() {
	switch (fmod_inst->FSOUND_GetError()) {
		case 0:             lstrcpy(FMOD_ERROR,"1 No errors"); break;
		case 1:             lstrcpy(FMOD_ERROR,"0 Cannot call this command after FSOUND_Init. Call FSOUND_Close first."); break;
		case 2:				lstrcpy(FMOD_ERROR,"0 This command failed because FSOUND_Init or FSOUND_SetOutput was not called"); break;
		case 3:             lstrcpy(FMOD_ERROR,"0 Error initializing output device."); break;
		case 4:			    lstrcpy(FMOD_ERROR,"0 Error initializing output device, but more specifically, the output device is already in use and cannot be reused."); break;
		case 5:             lstrcpy(FMOD_ERROR,"0 Playing the sound failed."); break;
		case 6:				lstrcpy(FMOD_ERROR,"0 Soundcard does not support the features needed for this soundsystem (16bit stereo output)"); break;
		case 7:				lstrcpy(FMOD_ERROR,"0 Error setting cooperative level for hardware."); break;
		case 8:				lstrcpy(FMOD_ERROR,"0 Error creating hardware sound buffer."); break;
		case 9:				lstrcpy(FMOD_ERROR,"0 File not found"); break;
		case 10:			lstrcpy(FMOD_ERROR,"0 Unknown file format"); break;
		case 11:			lstrcpy(FMOD_ERROR,"0 Error loading file"); break;
		case 12:			lstrcpy(FMOD_ERROR,"0 Not enough memory or resources"); break;
		case 13:			lstrcpy(FMOD_ERROR,"0 The version number of this file format is not supported"); break;
		case 14:			lstrcpy(FMOD_ERROR,"0 An invalid parameter was passed to this function"); break;
		case 15:			lstrcpy(FMOD_ERROR,"0 Tried to use an EAX command on a non EAX enabled channel or output."); break;
		case 16:			lstrcpy(FMOD_ERROR,"0 Failed to allocate a new channel"); break;
		case 17:			lstrcpy(FMOD_ERROR,"0 Recording is not supported on this machine"); break;
		case 18:			lstrcpy(FMOD_ERROR,"0 Windows Media Player not installed so cannot play wma or use internet streaming."); break;
		case 19:			lstrcpy(FMOD_ERROR,"0 An error occured trying to open the specified CD device"); break;
		default:			lstrcpy(FMOD_ERROR,"");
	}
}

#pragma comment(linker, "/EXPORT:FMOD_Connect=_FMOD_Connect@24")
mIRC(FMOD_Connect) {
	hwnd_mIRC = mWnd;
	if (fmod_inst!=0) {	lstrcpy(data,"0 Fmod is already successfully connected"); }
	else {
		fmod_inst = loaddll(data);
		wsprintf(data,"1 %p",fmod_inst);
	}
	return 3;
}

//mfmod_GetSongNum -start-
//Music callbacks
#ifdef EXPORT_MUSIC_SetInstCallback
char *cback_inst_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif
#ifdef EXPORT_MUSIC_SetOrderCallback
char *cback_order_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif
#ifdef EXPORT_MUSIC_SetRowCallback
char *cback_row_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif
#ifdef EXPORT_MUSIC_SetZxxCallback
char *cback_zxx_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif
//Stream callback
#ifdef EXPORT_SOUND_Stream_SetEndCallback
char *cback_end_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif
#ifdef EXPORT_SOUND_Stream_SetSynchCallback
char *cback_synch_send;
#ifndef EXPORT_mfmod_GetSongNum
#define EXPORT_mfmod_GetSongNum
#endif
#endif

#ifdef EXPORT_mfmod_GetSongNum
int mfmod_GetSongNum(char type,char *pointer) {
	int c=0;
	bool f=false;
	char zoom[50];
	if (type=='m') {
		while (c<MAX_MUSIC && !f) {
			wsprintf(zoom,"%p",music[c].music);
			char *temp = StrGetToken(zoom,1," ");
			if (lstrcmp(temp,pointer)==0) { f=true; }
			delete [] temp;
			temp = NULL;
			c++;
		}
	}
	else if (type=='s') {
		while (c<MAX_SAMPLE && !f) {
			wsprintf(zoom,"%p",sample[c].sample);
			if (lstrcmp(zoom,pointer)==0) { f=true; }
			c++;
		}
	}
	else if (type=='t') {
		while (c<MAX_STREAM && !f) {
			wsprintf(zoom,"%p",stream[c].stream);
			if (lstrcmp(zoom,pointer)==0) { f=true; }
			c++;
		}
	}
	if (f==false) { return -1; }
	else { return c - 1; }
}
#endif
//mfmod_GetSongNum -end-


//-FMUSIC
//--Music control Functions
#ifdef EXPORT_MUSIC_FreeSong
#pragma comment(linker, "/EXPORT:MUSIC_FreeSong=_MUSIC_FreeSong@24")
mIRC(MUSIC_FreeSong) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c <0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = 0;
	if (music[c].music!=0) {
		r = fmod_inst->FMUSIC_FreeSong(music[c].music);
		if (r==1) { music[c].music=NULL; }
		if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	}
	else { lstrcpy(data,"0 You can't free a song that isn't loaded"); }
	wsprintf(data,"%i",r);
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_LoadSong
#pragma comment(linker, "/EXPORT:MUSIC_LoadSong=_MUSIC_LoadSong@24")
mIRC(MUSIC_LoadSong) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp = StrGetToken(data,1," ");
	int c = xatoi(temp); delete[] temp; temp=NULL;
	char *ct = StrGetToken(data,2,"\"");
	lstrcpy(data,"0");
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (ct != NULL) {
		FMUSIC_MODULE *mtemp = fmod_inst->FMUSIC_LoadSong(ct);
		if (mtemp == NULL) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
		else {
			if(fmod_inst->FMUSIC_IsPlaying(music[c].music)==TRUE) { fmod_inst->FMUSIC_StopSong(music[c].music); }
			if (music[c].music!=0) { fmod_inst->FMUSIC_FreeSong(music[c].music); }
			music[c].music = mtemp;
			wsprintf(data,"1 %p",music[c].music);
		}
	}
	delete[] ct;
	ct=NULL;
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_LoadSongEx
/*
#pragma comment(linker, "/EXPORT:MUSIC_LoadSongEx=_MUSIC_LoadSongEx@24")
mIRC(MUSIC_LoadSongEx) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FMUSIC_LoadSongEx();
	return 3;
}
*/
#endif

#ifdef EXPORT_MUSIC_OptimizeChannels
/*
#pragma comment(linker, "/EXPORT:MUSIC_OptimizeChannels=_MUSIC_OptimizeChannels@24")
mIRC(MUSIC_OptimizeChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	char *temp2 = StrGetToken(data,2," "); int max = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int min = xatoi(temp3); delete[] temp3; temp3=NULL;
	if (max==NULL) { max=0; }
	if (min==NULL) { min=0; }
	signed char r = fmod_inst->FMUSIC_OptimizeChannels(music[c].music,max,min);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
*/
#endif

#ifdef EXPORT_MUSIC_PlaySong
#pragma comment(linker, "/EXPORT:MUSIC_PlaySong=_MUSIC_PlaySong@24")
mIRC(MUSIC_PlaySong) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FMUSIC_PlaySong(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetInstCallback
void __stdcall mfmod_music_instcback(FMUSIC_MODULE *music, unsigned char param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",music);
		int songnum = mfmod_GetSongNum('m',songpoint);
		wsprintf(mData,"$%s(%i %d)",cback_inst_send,songnum,param); 
	}
	else { wsprintf(mData,"$%s(%p %d)",cback_inst_send,music,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
}
#pragma comment(linker, "/EXPORT:MUSIC_SetInstCallback=_MUSIC_SetInstCallback@24")
mIRC(MUSIC_SetInstCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	char *temp2 = StrGetToken(data,3," "); int instnum = xatoi(temp2); delete[] temp2; temp2=NULL;
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_inst_send = cbacktext;
	signed char r = fmod_inst->FMUSIC_SetInstCallback(music[c].music,mfmod_music_instcback,instnum);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetCallbackMethods
#pragma comment(linker, "/EXPORT:MUSIC_SetCallbackMethods=_MUSIC_SetCallbackMethods@24")
mIRC(MUSIC_SetCallbackMethods) {
	char *temp = StrGetToken(data,1," "); int method = xatoi(temp); delete[] temp; temp=NULL;
	if (method!=NULL) {
		if (method==1 || method==2) {
			cback_method = method;
			lstrcpy(data,"1");
		}
		else { lstrcpy(data,"0"); }
	}
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetLooping
#pragma comment(linker, "/EXPORT:MUSIC_SetLooping=_MUSIC_SetLooping@24")
mIRC(MUSIC_SetLooping) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); signed char looping = xatoi(temp2); delete[] temp2; temp2=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	signed char r = fmod_inst->FMUSIC_SetLooping(music[c].music,looping);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetMasterSpeed
#pragma comment(linker, "/EXPORT:MUSIC_SetMasterSpeed=_MUSIC_SetMasterSpeed@24")
mIRC(MUSIC_SetMasterSpeed) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); float speed = xatof(temp2); delete[] temp2; temp2=NULL;
	if (speed==NULL || speed<0 || speed>10) { speed=1; }
	signed char r = fmod_inst->FMUSIC_SetMasterSpeed(music[c].music,speed);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetMasterVolume
#pragma comment(linker, "/EXPORT:MUSIC_SetMasterVolume=_MUSIC_SetMasterVolume@24")
mIRC(MUSIC_SetMasterVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int v = xatoi(temp2); delete[] temp2; temp2=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	signed char r = fmod_inst->FMUSIC_SetMasterVolume(music[c].music,v);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetOrder
#pragma comment(linker, "/EXPORT:MUSIC_SetOrder=_MUSIC_SetOrder@24")
mIRC(MUSIC_SetOrder) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int o = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FMUSIC_SetOrder(music[c].music,o);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetOrderCallback
void __stdcall mfmod_music_ordercback(FMUSIC_MODULE *music, unsigned char param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",music);
		int songnum = mfmod_GetSongNum('m',songpoint);
		wsprintf(mData,"$%s(%i %d)",cback_order_send,songnum,param); 
	}
	else { wsprintf(mData,"$%s(%p %d)",cback_order_send,music,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
}
#pragma comment(linker, "/EXPORT:MUSIC_SetOrderCallback=_MUSIC_SetOrderCallback@24")
mIRC(MUSIC_SetOrderCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	char *temp2 = StrGetToken(data,3," "); int o = xatoi(temp2); delete[] temp2; temp2=NULL;
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_order_send = cbacktext;
	signed char r = fmod_inst->FMUSIC_SetOrderCallback(music[c].music,mfmod_music_ordercback,o);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetPanSeperation
#pragma comment(linker, "/EXPORT:MUSIC_SetPanSeperation=_MUSIC_SetPanSeperation@24")
mIRC(MUSIC_SetPanSeperation) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); float sep = xatof(temp2); delete[] temp2; temp2=NULL;
	if (sep==NULL || sep<0 || sep>10) { sep=1; }
	signed char r = fmod_inst->FMUSIC_SetPanSeperation(music[c].music,sep);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetPaused
#pragma comment(linker, "/EXPORT:MUSIC_SetPaused=_MUSIC_SetPaused@24")
mIRC(MUSIC_SetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r;
	if (fmod_inst->FMUSIC_GetPaused(music[c].music)==1) {
		r = fmod_inst->FMUSIC_SetPaused(music[c].music,false);
	}
	else { r = fmod_inst->FMUSIC_SetPaused(music[c].music,true); }
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetReverb
#pragma comment(linker, "/EXPORT:MUSIC_SetReverb=_MUSIC_SetReverb@24")
mIRC(MUSIC_SetReverb) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char reverb = xatoi(data);
	signed char r = fmod_inst->FMUSIC_SetReverb(reverb);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetRowCallback
void __stdcall mfmod_music_rowcback(FMUSIC_MODULE *mod, unsigned char param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",mod);
		int songnum = mfmod_GetSongNum('m',songpoint);
		wsprintf(mData,"$%s(%i %d)",cback_row_send,songnum,param); 
	}
	else { wsprintf(mData,"$%s(%p %d)",cback_row_send,mod,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
}
#pragma comment(linker, "/EXPORT:MUSIC_SetRowCallback=_MUSIC_SetRowCallback@24")
mIRC(MUSIC_SetRowCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	char *temp2 = StrGetToken(data,3," "); int row = xatoi(temp2); delete[] temp2; temp2=NULL;
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_row_send = cbacktext;
	signed char r = fmod_inst->FMUSIC_SetRowCallback(music[c].music,mfmod_music_rowcback,row);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_SetUserData
/*
#pragma comment(linker, "/EXPORT:MUSIC_SetUserData=_MUSIC_SetUserData@24")
mIRC(MUSIC_SetUserData) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); unsigned int userdata = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FMUSIC_SetUserData(music[c].music,userdata);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
*/
#endif

#ifdef EXPORT_MUSIC_SetZxxCallback
void __stdcall mfmod_music_zxxcback(FMUSIC_MODULE *mod, unsigned char param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",mod);
		int songnum = mfmod_GetSongNum('m',songpoint);
		wsprintf(mData,"$%s(%i %d)",cback_zxx_send,songnum,param); 
	}
	else { wsprintf(mData,"$%s(%p %d)",cback_zxx_send,mod,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
}
#pragma comment(linker, "/EXPORT:MUSIC_SetZxxCallback=_MUSIC_SetZxxCallback@24")
mIRC(MUSIC_SetZxxCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_zxx_send = cbacktext;
	signed char r = fmod_inst->FMUSIC_SetZxxCallback(music[c].music,mfmod_music_zxxcback);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_StopAllSongs
/*
#pragma comment(linker, "/EXPORT:MUSIC_StopAllSongs=_MUSIC_StopAllSongs@24")
mIRC(MUSIC_StopAllSongs) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FMUSIC_StopAllSongs();
	lstrcpy(data,"1");
	return 3;
}
*/
#endif

#ifdef EXPORT_MUSIC_StopSong
#pragma comment(linker, "/EXPORT:MUSIC_StopSong=_MUSIC_StopSong@24")
mIRC(MUSIC_StopSong) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FMUSIC_StopSong(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif


//--Information Functions
#ifdef EXPORT_MUSIC_GetBPM
#pragma comment(linker, "/EXPORT:MUSIC_GetBPM=_MUSIC_GetBPM@24")
mIRC(MUSIC_GetBPM) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetBPM(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetGlobalVolume
#pragma comment(linker, "/EXPORT:MUSIC_GetGlobalVolume=_MUSIC_GetGlobalVolume@24")
mIRC(MUSIC_GetGlobalVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetGlobalVolume(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetMasterVolume
#pragma comment(linker, "/EXPORT:MUSIC_GetMasterVolume=_MUSIC_GetMasterVolume@24")
mIRC(MUSIC_GetMasterVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetMasterVolume(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetName
#pragma comment(linker, "/EXPORT:MUSIC_GetName=_MUSIC_GetName@24")
mIRC(MUSIC_GetName) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *songname = fmod_inst->FMUSIC_GetName(music[c].music);
	lstrcpy(data,songname);
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetNumChannels
#pragma comment(linker, "/EXPORT:MUSIC_GetNumChannels=_MUSIC_GetNumChannels@24")
mIRC(MUSIC_GetNumChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetNumChannels(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetNumInstruments
#pragma comment(linker, "/EXPORT:MUSIC_GetNumInstruments=_MUSIC_GetNumInstruments@24")
mIRC(MUSIC_GetNumInstruments) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetNumInstruments(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetNumOrders
#pragma comment(linker, "/EXPORT:MUSIC_GetNumOrders=_MUSIC_GetNumOrders@24")
mIRC(MUSIC_GetNumOrders) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetNumOrders(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetNumPatterns
#pragma comment(linker, "/EXPORT:MUSIC_GetNumPatterns=_MUSIC_GetNumPatterns@24")
mIRC(MUSIC_GetNumPatterns) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetNumPatterns(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetNumSamples
#pragma comment(linker, "/EXPORT:MUSIC_GetNumSamples=_MUSIC_GetNumSamples@24")
mIRC(MUSIC_GetNumSamples) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetNumSamples(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetOrder
#pragma comment(linker, "/EXPORT:MUSIC_GetOrder=_MUSIC_GetOrder@24")
mIRC(MUSIC_GetOrder) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetOrder(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetPattern
#pragma comment(linker, "/EXPORT:MUSIC_GetPattern=_MUSIC_GetPattern@24")
mIRC(MUSIC_GetPattern) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetPattern(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetPatternLength
#pragma comment(linker, "/EXPORT:MUSIC_GetPatternLength=_MUSIC_GetPatternLength@24")
mIRC(MUSIC_GetPatternLength) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int ordernum = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FMUSIC_GetPatternLength(music[c].music,ordernum);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetPaused
#pragma comment(linker, "/EXPORT:MUSIC_GetPaused=_MUSIC_GetPaused@24")
mIRC(MUSIC_GetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetPaused(music[c].music);
	if (r==0) { lstrcpy(data,"0"); }
	else { lstrcpy(data,"1"); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetRow
#pragma comment(linker, "/EXPORT:MUSIC_GetRow=_MUSIC_GetRow@24")
mIRC(MUSIC_GetRow) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetRow(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetSample
#pragma comment(linker, "/EXPORT:MUSIC_GetSample=_MUSIC_GetSample@24")
mIRC(MUSIC_GetSample) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int sampnum = xatoi(temp2); delete[] temp2; temp2=NULL;
	FSOUND_SAMPLE *r = fmod_inst->FMUSIC_GetSample(music[c].music,sampnum);
	wsprintf(data,"%p",r);
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetSpeed
#pragma comment(linker, "/EXPORT:MUSIC_GetSpeed=_MUSIC_GetSpeed@24")
mIRC(MUSIC_GetSpeed) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetSpeed(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetTime
#pragma comment(linker, "/EXPORT:MUSIC_GetTime=_MUSIC_GetTime@24")
mIRC(MUSIC_GetTime) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int flen = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FMUSIC_GetTime(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else if (flen==1) {
		char *tlen=time_length(r);
		lstrcpy(data,tlen);
		delete[] tlen; tlen=NULL;
	}
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetType
#pragma comment(linker, "/EXPORT:MUSIC_GetType=_MUSIC_GetType@24")
mIRC(MUSIC_GetType) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FMUSIC_GetType(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_GetUserData
#pragma comment(linker, "/EXPORT:MUSIC_GetUserData=_MUSIC_GetUserData@24")
mIRC(MUSIC_GetUserData) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	unsigned int r = fmod_inst->FMUSIC_GetUserData(music[c].music);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_IsFinished
#pragma comment(linker, "/EXPORT:MUSIC_IsFinished=_MUSIC_IsFinished@24")
mIRC(MUSIC_IsFinished) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FMUSIC_IsFinished(music[c].music);
	if (r==0) { lstrcpy(data,"0"); }
	else { lstrcpy(data,"1"); }
	return 3;
}
#endif

#ifdef EXPORT_MUSIC_IsPlaying
#pragma comment(linker, "/EXPORT:MUSIC_IsPlaying=_MUSIC_IsPlaying@24")
mIRC(MUSIC_IsPlaying) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (c==NULL || c<0 || c>=MAX_MUSIC) { c=0; }
	if (!fmod_IsSlotReady(c,1)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FMUSIC_IsPlaying(music[c].music);
	if (r==0) { lstrcpy(data,"0"); }
	else { lstrcpy(data,"1"); }
	return 3;
}
#endif

//-FSOUND
//--Initialization/Enumeration Functions (09/10, Complete)
#ifdef EXPORT_SOUND_Init
#pragma comment(linker, "/EXPORT:SOUND_Init=_SOUND_Init@24")
mIRC(SOUND_Init) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int mixrate = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int maxsoftchan = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); unsigned int flags =  xatoi(temp3); delete[] temp3; temp3=NULL;
	signed char r = fmod_inst->FSOUND_Init(mixrate,maxsoftchan,flags);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Close
#pragma comment(linker, "/EXPORT:SOUND_Close=_SOUND_Close@24")
mIRC(SOUND_Close) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Close();
	lstrcpy(data,"1");
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetBufferSize
#pragma comment(linker, "/EXPORT:SOUND_SetBufferSize=_SOUND_SetBufferSize@24")
mIRC(SOUND_SetBufferSize) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int lenms = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetBufferSize(lenms);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetDriver
#pragma comment(linker, "/EXPORT:SOUND_SetDriver=_SOUND_SetDriver@24")
mIRC(SOUND_SetDriver) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int drivernum = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetDriver(drivernum);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetHWND
#pragma comment(linker, "/EXPORT:SOUND_SetHWND=_SOUND_SetHWND@24")
mIRC(SOUND_SetHWND) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_SetHWND(data);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetMaxHardwareChannels
#pragma comment(linker, "/EXPORT:SOUND_SetMaxHardwareChannels=_SOUND_SetMaxHardwareChannels@24")
mIRC(SOUND_SetMaxHardwareChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int max = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetMaxHardwareChannels(max);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetMinHardwareChannels
#pragma comment(linker, "/EXPORT:SOUND_SetMinHardwareChannels=_SOUND_SetMinHardwareChannels@24")
mIRC(SOUND_SetMinHardwareChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int min = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetMinHardwareChannels(min);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetMixer
#pragma comment(linker, "/EXPORT:SOUND_SetMixer=_SOUND_SetMixer@24")
mIRC(SOUND_SetMixer) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int mixer = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetMixer(mixer);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetOutput
#pragma comment(linker, "/EXPORT:SOUND_SetOutput=_SOUND_SetOutput@24")
mIRC(SOUND_SetOutput) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int outputtype = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_SetOutput(outputtype);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SpecifyEffectsImage
/*
#pragma comment(linker, "/EXPORT:SOUND_SpecifyEffectsImage=_SOUND_SpecifyEffectsImage@24")
mIRC(SOUND_SpecifyEffectsImage) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_SpecifyEffectsImage();
	return 3;
}
*/
#endif

//--Information Functions (09/09)
#ifdef EXPORT_SOUND_GetChannelsPlaying
#pragma comment(linker, "/EXPORT:SOUND_GetChannelsPlaying=_SOUND_GetChannelsPlaying@24")
mIRC(SOUND_GetChannelsPlaying) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetChannelsPlaying();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetMaxSamples
#pragma comment(linker, "/EXPORT:SOUND_GetMaxSamples=_SOUND_GetMaxSamples@24")
mIRC(SOUND_GetMaxSamples) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetMaxSamples();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetMaxChannels
#pragma comment(linker, "/EXPORT:SOUND_GetMaxChannels=_SOUND_GetMaxChannels@24")
mIRC(SOUND_GetMaxChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetMaxChannels();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetNumDrivers
#pragma comment(linker, "/EXPORT:SOUND_GetNumDrivers=_SOUND_GetNumDrivers@24")
mIRC(SOUND_GetNumDrivers) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetNumDrivers();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetOutput
#pragma comment(linker, "/EXPORT:SOUND_GetOutput=_SOUND_GetOutput@24")
mIRC(SOUND_GetOutput) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetOutput();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetOutputHandle
#pragma comment(linker, "/EXPORT:SOUND_GetOutputHandle=_SOUND_GetOutputHandle@24")
mIRC(SOUND_GetOutputHandle) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	wsprintf(data,"%p",fmod_inst->FSOUND_GetOutputHandle());
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetOutputRate
#pragma comment(linker, "/EXPORT:SOUND_GetOutputRate=_SOUND_GetOutputRate@24")
mIRC(SOUND_GetOutputRate) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	wsprintf(data,"%i",fmod_inst->FSOUND_GetOutputRate());
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetDriver
#pragma comment(linker, "/EXPORT:SOUND_GetDriver=_SOUND_GetDriver@24")
mIRC(SOUND_GetDriver) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetDriver();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetDriverName
#pragma comment(linker, "/EXPORT:SOUND_GetDriverName=_SOUND_GetDriverName@24")
mIRC(SOUND_GetDriverName) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int id = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char *sup = fmod_inst->FSOUND_GetDriverName(id);
	if (sup!=NULL) { wsprintf(data,"%s",sup); }
	else { lstrcpy(data,""); }
	return 3;
}
#endif

//--Sample Functions (01/17)
#ifdef EXPORT_SOUND_Sample_Alloc
#pragma comment(linker, "/EXPORT:SOUND_Sample_Alloc=_SOUND_Sample_Alloc@24")
mIRC(SOUND_Sample_Alloc) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int index = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int length = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); unsigned int mode = xatoi(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); int deffreq = xatoi(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); int defvol = xatoi(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); int defpan = xatoi(temp6); delete[] temp6; temp6=NULL;
	char *temp7 = StrGetToken(data,7," "); int defpri = xatoi(temp7); delete[] temp7; temp7=NULL;
	FSOUND_SAMPLE *samptemp = fmod_inst->FSOUND_Sample_Alloc(index,length,mode,deffreq,defvol,defpan,defpri);
	if (samptemp == NULL) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else {
		if(fmod_inst->FSOUND_IsPlaying(sample[index].channel)==TRUE) { fmod_inst->FSOUND_StopSound(sample[index].channel); }
		sample[index].sample = samptemp;
		wsprintf(data,"1 %p",sample[index].sample);
	}
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_Free
#pragma comment(linker, "/EXPORT:SOUND_Sample_Free=_SOUND_Sample_Free@24")
mIRC(SOUND_Sample_Free) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	if (c!=NULL) {
		lstrcpy(data,"1");
		fmod_inst->FSOUND_Sample_Free(sample[c].sample);
		sample[c].sample=NULL;
	}
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_Get
#pragma comment(linker, "/EXPORT:SOUND_Sample_Get=_SOUND_Sample_Get@24")
mIRC(SOUND_Sample_Get) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int sampno = xatoi(temp1); delete[] temp1; temp1=NULL;
	FSOUND_SAMPLE *pointer = fmod_inst->FSOUND_Sample_Get(sampno);
	wsprintf(data,"%p",pointer);
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_GetDefaults
#pragma comment(linker, "/EXPORT:SOUND_Sample_GetDefaults=_SOUND_Sample_GetDefaults@24")
mIRC(SOUND_Sample_GetDefaults) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	FSOUND_SAMPLE *sptr = sample[c].sample;
	int *deffreq = 0;
	int *defvol = 0;
	int *defpan = 0;
	int *defpri = 0;
	signed char r = fmod_inst->FSOUND_Sample_GetDefaults(sptr,deffreq,defvol,defpan,defpri);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_GetLength
#pragma comment(linker, "/EXPORT:SOUND_Sample_GetLength=_SOUND_Sample_GetLength@24")
mIRC(SOUND_Sample_GetLength) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	unsigned int r = fmod_inst->FSOUND_Sample_GetLength(sample[c].sample);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_GetLoopPoints
#pragma comment(linker, "/EXPORT:SOUND_Sample_GetLoopPoints=_SOUND_Sample_GetLoopPoints@24")
mIRC(SOUND_Sample_GetLoopPoints) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	FSOUND_SAMPLE *sptr = sample[c].sample;
	int loopstart = NULL;
	int loopend = NULL;
	signed char r = fmod_inst->FSOUND_Sample_GetLoopPoints(sptr,&loopstart,&loopend);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_GetMode
#pragma comment(linker, "/EXPORT:SOUND_Sample_GetMode=_SOUND_Sample_GetMode@24")
mIRC(SOUND_Sample_GetMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	unsigned int r = fmod_inst->FSOUND_Sample_GetMode(sample[c].sample);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_GetName
#pragma comment(linker, "/EXPORT:SOUND_Sample_GetName=_SOUND_Sample_GetName@24")
mIRC(SOUND_Sample_GetName) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *name = fmod_inst->FSOUND_Sample_GetName(sample[c].sample);
	if (name!=NULL) { lstrcpy(data,name); }
	else { lstrcpy(data,""); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_Load
#pragma comment(linker, "/EXPORT:SOUND_Sample_Load=_SOUND_Sample_Load@24")
mIRC(SOUND_Sample_Load) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int index = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *file = StrGetToken(data,2,"\"");
	char *temp2 = StrGetToken(data,3,"\"");
	char *temp3 = StrGetToken(temp2,1," ");
	unsigned int mode = xatoi(temp3);
	delete[] temp2; temp2=NULL; delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,3,"\"");
	char *temp5 = StrGetToken(temp4,2," ");
	int length = xatoi(temp5);
	delete[] temp4; temp4=NULL; delete[] temp5; temp5=NULL;
	lstrcpy(data,"0");
	FSOUND_SAMPLE *samptemp = fmod_inst->FSOUND_Sample_Load(index,file,mode,length);
	if(sample[index].channel!=-1) {
		if(fmod_inst->FSOUND_IsPlaying(sample[index].channel)==1) { fmod_inst->FSOUND_StopSound(sample[index].channel); }
	}
	if (samptemp!=NULL) {
		if(fmod_inst->FSOUND_IsPlaying(sample[index].channel)==TRUE) { fmod_inst->FSOUND_StopSound(sample[index].channel); }
		if (sample[index].sample!=0) { fmod_inst->FSOUND_Sample_Free(sample[index].sample); }
		sample[index].sample = samptemp;
		wsprintf(data,"1 %p",sample[index].sample);
	}
	else { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	delete[] file; file=NULL;
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_Lock
/*
#pragma comment(linker, "/EXPORT:SOUND_Sample_Lock=_SOUND_Sample_Lock@24")
mIRC(SOUND_Sample_Lock) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_Sample_Lock(sample[index].sample,offset,length,ptr1,len1,len2);
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Sample_SetDefaults
#pragma comment(linker, "/EXPORT:SOUND_Sample_SetDefaults=_SOUND_Sample_SetDefaults@24")
mIRC(SOUND_Sample_SetDefaults) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int deffreq = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int defvol = xatoi(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); int defpan = xatoi(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); int defpri = xatoi(temp5); delete[] temp5; temp5=NULL;
	signed char r = fmod_inst->FSOUND_Sample_SetDefaults(sample[c].sample,deffreq,defvol,defpan,defpri);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_SetMaxPlaybacks
#pragma comment(linker, "/EXPORT:SOUND_Sample_SetMaxPlaybacks=_SOUND_Sample_SetMaxPlaybacks@24")
mIRC(SOUND_Sample_SetMaxPlaybacks) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int max = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Sample_SetMaxPlaybacks(sample[c].sample,max);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_SetMinMaxDistance
#pragma comment(linker, "/EXPORT:SOUND_Sample_SetMinMaxDistance=_SOUND_Sample_SetMinMaxDistance@24")
mIRC(SOUND_Sample_SetMinMaxDistance) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); float min = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float max = xatof(temp3); delete[] temp3; temp3=NULL;
	signed char r = fmod_inst->FSOUND_Sample_SetMinMaxDistance(sample[c].sample,min,max);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_SetMode
#pragma comment(linker, "/EXPORT:SOUND_Sample_SetMode=_SOUND_Sample_SetMode@24")
mIRC(SOUND_Sample_SetMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); unsigned int mode = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Sample_SetMode(sample[c].sample,mode);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_SetLoopPoints
#pragma comment(linker, "/EXPORT:SOUND_Sample_SetLoopPoints=_SOUND_Sample_SetLoopPoints@24")
mIRC(SOUND_Sample_SetLoopPoints) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int loopstart = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int loopend = xatoi(temp3); delete[] temp3; temp3=NULL;
	signed char r = fmod_inst->FSOUND_Sample_SetLoopPoints(sample[c].sample,loopstart,loopend);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Sample_Unlock
/*
#pragma comment(linker, "/EXPORT:SOUND_Sample_Unlock=_SOUND_Sample_Unlock@24")
mIRC(SOUND_Sample_Unlock) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Sample_Unlock();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Sample_Upload
/*
#pragma comment(linker, "/EXPORT:SOUND_Sample_Upload=_SOUND_Sample_Upload@24")
mIRC(SOUND_Sample_Upload) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Sample_Upload();
	return 3;
}
*/
#endif

//--Channel Functions (02/29)
#ifdef EXPORT_SOUND_PlaySound
#pragma comment(linker, "/EXPORT:SOUND_PlaySound=_SOUND_PlaySound@24")
mIRC(SOUND_PlaySound) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,2)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int channel = xatoi(temp2); delete[] temp2; temp2=NULL;
	if (sample[c].sample!=0) {
		int r = fmod_inst->FSOUND_PlaySound(channel,sample[c].sample);
		if (r==-1) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
		else {
			sample[c].channel = channel;
			wsprintf(data,"1 %i",r);
		}
	}
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_PlaySoundEx
/*
#pragma comment(linker, "/EXPORT:SOUND_PlaySoundEx=_SOUND_PlaySoundEx@24")
mIRC(SOUND_PlaySoundEx) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_PlaySoundEx();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_StopSound
#pragma comment(linker, "/EXPORT:SOUND_StopSound=_SOUND_StopSound@24")
mIRC(SOUND_StopSound) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	signed char r = fmod_inst->FSOUND_StopSound(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetFrequency
#pragma comment(linker, "/EXPORT:SOUND_SetFrequency=_SOUND_SetFrequency@24")
mIRC(SOUND_SetFrequency) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int freq = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetFrequency(channel,freq);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetLevels
/*
#pragma comment(linker, "/EXPORT:SOUND_SetLevels=_SOUND_SetLevels@24")
mIRC(SOUND_SetLevels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_SetLevels();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_SetLoopMode
#pragma comment(linker, "/EXPORT:SOUND_SetLoopMode=_SOUND_SetLoopMode@24")
mIRC(SOUND_SetLoopMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); unsigned int loopmode = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetLoopMode(channel,loopmode);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetMute
#pragma comment(linker, "/EXPORT:SOUND_SetMute=_SOUND_SetMute@24")
mIRC(SOUND_SetMute) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char mute = char(xatoi(temp2)); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetMute(channel,mute);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetPan
#pragma comment(linker, "/EXPORT:SOUND_SetPan=_SOUND_SetPan@24")
mIRC(SOUND_SetPan) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int pan = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetPan(channel,pan);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetPaused
#pragma comment(linker, "/EXPORT:SOUND_SetPaused=_SOUND_SetPaused@24")
mIRC(SOUND_SetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char paused = char(xatoi(temp2)); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetPaused(channel,paused);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetPriority
#pragma comment(linker, "/EXPORT:SOUND_SetPriority=_SOUND_SetPriority@24")
mIRC(SOUND_SetPriority) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int priority = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetPriority(channel,priority);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetReserved
#pragma comment(linker, "/EXPORT:SOUND_SetReserved=_SOUND_SetReserved@24")
mIRC(SOUND_SetReserved) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char reserved = char(xatoi(temp2)); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetReserved(channel,reserved);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetSurround
#pragma comment(linker, "/EXPORT:SOUND_SetSurround=_SOUND_SetSurround@24")
mIRC(SOUND_SetSurround) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char surround = char(xatoi(temp2)); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetSurround(channel,surround);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetVolume
#pragma comment(linker, "/EXPORT:SOUND_SetVolume=_SOUND_SetVolume@24")
mIRC(SOUND_SetVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int vol = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetVolume(channel,vol);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetVolumeAbsolute
#pragma comment(linker, "/EXPORT:SOUND_SetVolumeAbsolute=_SOUND_SetVolumeAbsolute@24")
mIRC(SOUND_SetVolumeAbsolute) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int vol = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetVolumeAbsolute(channel,vol);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetVolume
#pragma comment(linker, "/EXPORT:SOUND_GetVolume=_SOUND_GetVolume@24")
mIRC(SOUND_GetVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	int r = fmod_inst->FSOUND_GetVolume(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetCurrentPosition
#pragma comment(linker, "/EXPORT:SOUND_SetCurrentPosition=_SOUND_SetCurrentPosition@24")
mIRC(SOUND_SetCurrentPosition) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); unsigned int pos = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_SetCurrentPosition(channel,pos);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetCurrentPosition
#pragma comment(linker, "/EXPORT:SOUND_GetCurrentPosition=_SOUND_GetCurrentPosition@24")
mIRC(SOUND_GetCurrentPosition) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	unsigned int r = fmod_inst->FSOUND_GetCurrentPosition(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetCurrentSample
#pragma comment(linker, "/EXPORT:SOUND_GetCurrentSample=_SOUND_GetCurrentSample@24")
mIRC(SOUND_GetCurrentSample) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	FSOUND_SAMPLE *pointa = fmod_inst->FSOUND_GetCurrentSample(channel);
	wsprintf(data,"%p",pointa);
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetCurrentLevels
#pragma comment(linker, "/EXPORT:SOUND_GetCurrentLevels=_SOUND_GetCurrentLevels@24")
mIRC(SOUND_GetCurrentLevels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(StrGetToken(data,1," "));
	float l = NULL;
	float r = NULL;
	fmod_inst->FSOUND_GetCurrentLevels(channel,&l,&r);
	lstrcpy(data,"1 ");
	lstrcat(data,xftoa(l)); lstrcat(data," "); lstrcat(data,xftoa(r));
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetFrequency
#pragma comment(linker, "/EXPORT:SOUND_GetFrequency=_SOUND_GetFrequency@24")
mIRC(SOUND_GetFrequency) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	int r = fmod_inst->FSOUND_GetFrequency(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetLoopMode
#pragma comment(linker, "/EXPORT:SOUND_GetLoopMode=_SOUND_GetLoopMode@24")
mIRC(SOUND_GetLoopMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	unsigned int r = fmod_inst->FSOUND_GetLoopMode(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetMixer
#pragma comment(linker, "/EXPORT:SOUND_GetMixer=_SOUND_GetMixer@24")
mIRC(SOUND_GetMixer) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetMixer();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetMute
#pragma comment(linker, "/EXPORT:SOUND_GetMute=_SOUND_GetMute@24")
mIRC(SOUND_GetMute) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	signed char r = fmod_inst->FSOUND_GetMute(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetPan
#pragma comment(linker, "/EXPORT:SOUND_GetPan=_SOUND_GetPan@24")
mIRC(SOUND_GetPan) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	int r = fmod_inst->FSOUND_GetPan(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetPaused
#pragma comment(linker, "/EXPORT:SOUND_GetPaused=_SOUND_GetPaused@24")
mIRC(SOUND_GetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	signed char r = fmod_inst->FSOUND_GetPaused(channel);
	if (!r) { lstrcpy(data,"0"); }
	else { lstrcpy(data,"1"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetPriority
#pragma comment(linker, "/EXPORT:SOUND_GetPriority=_SOUND_GetPriority@24")
mIRC(SOUND_GetPriority) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	int r = fmod_inst->FSOUND_GetPriority(channel);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetReserved
#pragma comment(linker, "/EXPORT:SOUND_GetReserved=_SOUND_GetReserved@24")
mIRC(SOUND_GetReserved) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	signed char r = fmod_inst->FSOUND_GetReserved(channel);
	if (r) { lstrcpy(data,"1"); }
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetSurround
#pragma comment(linker, "/EXPORT:SOUND_GetSurround=_SOUND_GetSurround@24")
mIRC(SOUND_GetSurround) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	signed char r = fmod_inst->FSOUND_GetSurround(channel);
	if (r) { lstrcpy(data,"1"); }
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_IsPlaying
#pragma comment(linker, "/EXPORT:SOUND_IsPlaying=_SOUND_IsPlaying@24")
mIRC(SOUND_IsPlaying) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = xatoi(data);
	signed char r = fmod_inst->FSOUND_IsPlaying(channel);
	if (r) { lstrcpy(data,"1"); }
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

//--3D Sound Functions
#ifdef EXPORT_SOUND_3D_Listener_GetAttributes
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_Listener_GetAttributes=_SOUND_3D_Listener_GetAttributes@24")
mIRC(SOUND_3D_Listener_GetAttributes) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	float *pos;
	float *vel;
	float *fx;
	float *fy;
	float *fz;
	float *tx;
	float *ty;
	float *tz;
	fmod_inst->FSOUND_3D_Listener_GetAttributes();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_Listener_SetAttributes
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_Listener_SetAttributes=_SOUND_3D_Listener_SetAttributes@24")
mIRC(SOUND_3D_Listener_SetAttributes) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_Listener_SetAttributes();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_GetAttributes
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_GetAttributes=_SOUND_3D_GetAttributes@24")
mIRC(SOUND_3D_GetAttributes) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_GetAttributes();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_Listener_SetCurrent
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_Listener_SetCurrent=_SOUND_3D_Listener_SetCurrent@24")
mIRC(SOUND_3D_Listener_SetCurrent) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_Listener_SetCurrent();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_SetDistanceFactor
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_SetDistanceFactor=_SOUND_3D_SetDistanceFactor@24")
mIRC(SOUND_3D_SetDistanceFactor) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_SetDistanceFactor();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_SetDopplerFactor
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_SetDopplerFactor=_SOUND_3D_SetDopplerFactor@24")
mIRC(SOUND_3D_SetDopplerFactor) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_SetDopplerFactor();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_SetRolloffFactor
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_SetRolloffFactor=_SOUND_3D_SetRolloffFactor@24")
mIRC(SOUND_3D_SetRolloffFactor) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_SetRolloffFactor();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_3D_SetAttributes
/*
#pragma comment(linker, "/EXPORT:SOUND_3D_SetAttributes=_SOUND_3D_SetAttributes@24")
mIRC(SOUND_3D_SetAttributes) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_3D_SetAttributes();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Update
#pragma comment(linker, "/EXPORT:SOUND_Update=_SOUND_Update@24")
mIRC(SOUND_Update) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Update();
	lstrcpy(data,"1");
	return 3;
}
#endif


//--Stream Functions
#ifdef EXPORT_SOUND_Stream_AddSynchPoint
#pragma comment(linker, "/EXPORT:SOUND_Stream_AddSynchPoint=_SOUND_Stream_AddSynchPoint@24")
mIRC(SOUND_Stream_AddSynchPoint) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); unsigned int pcmoffset = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int userdata = xatoi(temp3); delete[] temp3; temp3=NULL;
	int r = fmod_inst->FSOUND_Stream_AddSynchPoint(stream[c].stream,pcmoffset,userdata);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Close
#pragma comment(linker, "/EXPORT:SOUND_Stream_Close=_SOUND_Stream_Close@24")
mIRC(SOUND_Stream_Close) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_Stream_Close(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	if (r==1) { stream[c].stream=0; stream[c].channel=-1; }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Create
/*
#pragma comment(linker, "/EXPORT:SOUND_Stream_Create=_SOUND_Stream_Create@24")
mIRC(SOUND_Stream_Create) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Stream_Create();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Stream_CreateDSP
/*
#pragma comment(linker, "/EXPORT:SOUND_Stream_CreateDSP=_SOUND_Stream_CreateDSP@24")
mIRC(SOUND_Stream_CreateDSP) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_Stream_CreateDSP();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Stream_DeleteSynchPoint
#pragma comment(linker, "/EXPORT:SOUND_Stream_DeleteSynchPoint=_SOUND_Stream_DeleteSynchPoint@24")
mIRC(SOUND_Stream_DeleteSynchPoint) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int index = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Stream_DeleteSynchPoint(stream[c].stream,index);
	if (r) { lstrcpy(data,"1"); }
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetLength
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetLength=_SOUND_Stream_GetLength@24")
mIRC(SOUND_Stream_GetLength) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Stream_GetLength(stream[c].stream);
	if (r==0) { lstrcpy(data,"0"); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetLengthMs
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetLengthMs=_SOUND_Stream_GetLengthMs@24")
mIRC(SOUND_Stream_GetLengthMs) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int flen = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FSOUND_Stream_GetLengthMs(stream[c].stream);
	if (r==0) { lstrcpy(data,"0"); }
	else if (flen==1) {
		char *tlen=time_length(r);
		lstrcpy(data,tlen);
		delete[] tlen; tlen=NULL;
	}
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetNumSubStreams
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetNumSubStreams=_SOUND_Stream_GetNumSubStreams@24")
mIRC(SOUND_Stream_GetNumSubStreams) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Stream_GetNumSubStreams(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetNumSynchPoints
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetNumSynchPoints=_SOUND_Stream_GetNumSynchPoints@24")
mIRC(SOUND_Stream_GetNumSynchPoints) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Stream_GetNumSynchPoints(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetOpenState
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetOpenState=_SOUND_Stream_GetOpenState@24")
mIRC(SOUND_Stream_GetOpenState) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Stream_GetOpenState(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetPosition
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetPosition=_SOUND_Stream_GetPosition@24")
mIRC(SOUND_Stream_GetPosition) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	unsigned int r = fmod_inst->FSOUND_Stream_GetPosition(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetSample
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetSample=_SOUND_Stream_GetSample@24")
mIRC(SOUND_Stream_GetSample) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	FSOUND_SAMPLE *sample = fmod_inst->FSOUND_Stream_GetSample(stream[c].stream);
	wsprintf(data,"%p",sample);
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_GetTime
#pragma comment(linker, "/EXPORT:SOUND_Stream_GetTime=_SOUND_Stream_GetTime@24")
mIRC(SOUND_Stream_GetTime) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int flen = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FSOUND_Stream_GetTime(stream[c].stream);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else if (flen==1) {
		char *tlen=time_length(r);
		lstrcpy(data,tlen);
		delete[] tlen; tlen=NULL;
	}
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Open
#pragma comment(linker, "/EXPORT:SOUND_Stream_Open=_SOUND_Stream_Open@24")
mIRC(SOUND_Stream_Open) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int index = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *filename = StrGetToken(data,2,"\"");
	char *temp2 = StrGetToken(data,3,"\"");
	char *temp3 = StrGetToken(temp2,1," ");
	unsigned int mode = xatoi(temp3);
	char *temp4 = StrGetToken(temp2,2," ");
	int memlength = xatoi(temp4);
	char *temp5 = StrGetToken(temp2,3," ");
	int dataoffset = xatoi(temp5);
	delete[] temp2; temp2=NULL; delete[] temp3; temp3=NULL; delete[] temp4; temp4=NULL; delete[] temp5; temp5=NULL;
	FSOUND_STREAM *strmtemp = fmod_inst->FSOUND_Stream_Open(filename,dataoffset,mode,memlength);
	if (stream[index].channel!=-1) {
		if(fmod_inst->FSOUND_IsPlaying(stream[index].channel)==1) { fmod_inst->FSOUND_StopSound(stream[index].channel); }
	}
	if (stream[index].stream!=0) { fmod_inst->FSOUND_Stream_Stop(stream[index].stream); }
	if (strmtemp!=NULL) {
		if(fmod_inst->FSOUND_Stream_GetOpenState(stream[index].stream)==0) { fmod_inst->FSOUND_Stream_Close(stream[index].stream); }
		stream[index].stream = strmtemp;
		wsprintf(data,"1 %p",stream[index].stream);
	}
	else { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	delete[] filename; filename=NULL;
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Play
#pragma comment(linker, "/EXPORT:SOUND_Stream_Play=_SOUND_Stream_Play@24")
mIRC(SOUND_Stream_Play) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int channel = xatoi(temp2); delete[] temp2; temp2=NULL;
	if (stream[c].stream==0) { lstrcpy(data,"0"); return 3; }
	stream[c].channel = fmod_inst->FSOUND_Stream_Play(channel,stream[c].stream);
	if (stream[c].channel==-1) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",stream[c].channel); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_PlayEx
/*
#pragma comment(linker, "/EXPORT:SOUND_Stream_PlayEx=_SOUND_Stream_PlayEx@24")
mIRC(SOUND_Stream_PlayEx) {
	//if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	//fmod_inst->FSOUND_Stream_PlayEx();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Stream_SetBufferSize
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetBufferSize=_SOUND_Stream_SetBufferSize@24")
mIRC(SOUND_Stream_SetBufferSize) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int ms = xatoi(data);
	signed char r = fmod_inst->FSOUND_Stream_SetBufferSize(ms);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetEndCallback
signed char __stdcall mfmod_stream_endcback(FSOUND_STREAM *stream, void *buff, int len, int param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",stream);
		int songnum = mfmod_GetSongNum('t',songpoint);
		wsprintf(mData,"$%s(%i %p %i %i)",cback_end_send,songnum,buff,len,param); 
	}
	else { wsprintf(mData,"$%s(%p %p %i %i)",cback_end_send,stream,buff,len,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
	return 1;
}
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetEndCallback=_SOUND_Stream_SetEndCallback@24")
mIRC(SOUND_Stream_SetEndCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_STREAM) { c=0; }
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	char *temp2 = StrGetToken(data,3," "); int userdata = xatoi(temp2); delete[] temp2; temp2=NULL;
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_end_send = cbacktext;
	signed char r = fmod_inst->FSOUND_Stream_SetEndCallback(stream[c].stream,mfmod_stream_endcback,userdata);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetLoopPoints
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetLoopPoints=_SOUND_Stream_SetLoopPoints@24")
mIRC(SOUND_Stream_SetLoopPoints) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int loopstart = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int loopend = xatoi(temp3); delete[] temp3; temp3=NULL;
	signed char r = fmod_inst->FSOUND_Stream_SetLoopPoints(stream[c].stream,loopstart,loopend);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetPosition
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetPosition=_SOUND_Stream_SetPosition@24")
mIRC(SOUND_Stream_SetPosition) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); unsigned int position = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Stream_SetPosition(stream[c].stream,position);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetSubStream
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetSubStream=_SOUND_Stream_SetSubStream@24")
mIRC(SOUND_Stream_SetSubStream) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int index = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Stream_SetSubStream(stream[c].stream,index);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetSynchCallback
signed char __stdcall mfmod_stream_synchcback(FSOUND_STREAM *stream, void *buff, int len, int param) {
	if (cback_method==1) {
		char songpoint[50];
		wsprintf(songpoint,"%p",stream);
		int songnum = mfmod_GetSongNum('t',songpoint);
		wsprintf(mData,"$%s(%i %p %i %i)",cback_synch_send,songnum,buff,len,param); 
	}
	else { wsprintf(mData,"$%s(%p %p %i %i)",cback_synch_send,stream,buff,len,param); }
	SendMessage(cback_hwnd, WM_USER + 201,0,0);
	return 1;
}
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetSynchCallback=_SOUND_Stream_SetSynchCallback@24")
mIRC(SOUND_Stream_SetSynchCallback) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (c==NULL || c<0 || c>=MAX_STREAM) { c=0; }
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *cbacktext = StrGetToken(data,2," ");
	char *temp2 = StrGetToken(data,3," "); int userdata = xatoi(temp2); delete[] temp2; temp2=NULL;
	cback_hwnd = mWnd;
	cback_awnd = aWnd;
	cback_synch_send = cbacktext;
	signed char r = fmod_inst->FSOUND_Stream_SetSynchCallback(stream[c].stream,mfmod_stream_synchcback,userdata);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_SetTime
#pragma comment(linker, "/EXPORT:SOUND_Stream_SetTime=_SOUND_Stream_SetTime@24")
mIRC(SOUND_Stream_SetTime) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int c = xatoi(temp1); delete[] temp1; temp1=NULL;
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp2 = StrGetToken(data,2," "); int ms = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Stream_SetTime(stream[c].stream,ms);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Stop
#pragma comment(linker, "/EXPORT:SOUND_Stream_Stop=_SOUND_Stream_Stop@24")
mIRC(SOUND_Stream_Stop) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int c = xatoi(data);
	if (!fmod_IsSlotReady(c,3)) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_Stream_Stop(stream[c].stream);
	stream[c].channel=-1;
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

//--CD Functions (11/11)
#ifdef EXPORT_SOUND_CD_Eject
#pragma comment(linker, "/EXPORT:SOUND_CD_Eject=_SOUND_CD_Eject@24")
mIRC(SOUND_CD_Eject) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_CD_Eject(data[0]);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_GetNumTracks
#pragma comment(linker, "/EXPORT:SOUND_CD_GetNumTracks=_SOUND_CD_GetNumTracks@24")
mIRC(SOUND_CD_GetNumTracks) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_CD_GetNumTracks(data[0]);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_GetPaused
#pragma comment(linker, "/EXPORT:SOUND_CD_GetPaused=_SOUND_CD_GetPaused@24")
mIRC(SOUND_CD_GetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_CD_GetPaused(data[0]);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_GetTrack
#pragma comment(linker, "/EXPORT:SOUND_CD_GetTrack=_SOUND_CD_GetTrack@24")
mIRC(SOUND_CD_GetTrack) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_CD_GetTrack(data[0]);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_GetTrackLength
#pragma comment(linker, "/EXPORT:SOUND_CD_GetTrackLength=_SOUND_CD_GetTrackLength@24")
mIRC(SOUND_CD_GetTrackLength) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int track = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int flen = xatoi(temp3); delete[] temp3; temp3=NULL;
	int r = fmod_inst->FSOUND_CD_GetTrackLength(drive,track);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else if (flen==1) {
		char *tlen=time_length(r);
		lstrcpy(data,tlen);
		delete[] tlen; tlen=NULL;
	}
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_GetTrackTime
#pragma comment(linker, "/EXPORT:SOUND_CD_GetTrackTime=_SOUND_CD_GetTrackTime@24")
mIRC(SOUND_CD_GetTrackTime) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); char flen = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FSOUND_CD_GetTrackTime(drive);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else if (flen==1) {
		char *tlen=time_length(r);
		lstrcpy(data,tlen);
		delete[] tlen; tlen=NULL;
	}
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_Play
#pragma comment(linker, "/EXPORT:SOUND_CD_Play=_SOUND_CD_Play@24")
mIRC(SOUND_CD_Play) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int track = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FSOUND_CD_Play(drive,track);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_SetPaused
#pragma comment(linker, "/EXPORT:SOUND_CD_SetPaused=_SOUND_CD_SetPaused@24")
mIRC(SOUND_CD_SetPaused) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char paused = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_CD_SetPaused(drive,paused);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_SetPlayMode
#pragma comment(linker, "/EXPORT:SOUND_CD_SetPlayMode=_SOUND_CD_SetPlayMode@24")
mIRC(SOUND_CD_SetPlayMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char mode = xatoi(temp2); delete[] temp2; temp2=NULL;
	if (mode!=NULL && drive!=NULL) {
		if (mode>=0 && mode<=3) {
			fmod_inst->FSOUND_CD_SetPlayMode(drive,mode);
			lstrcpy(data,"1"); 
		}
		else { lstrcpy(data,"0"); }
	}
	else { lstrcpy(data,"0"); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_SetVolume
#pragma comment(linker, "/EXPORT:SOUND_CD_SetVolume=_SOUND_CD_SetVolume@24")
mIRC(SOUND_CD_SetVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); char drive = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int vol = xatoi(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_CD_SetVolume(drive,vol);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_CD_Stop
#pragma comment(linker, "/EXPORT:SOUND_CD_Stop=_SOUND_CD_Stop@24")
mIRC(SOUND_CD_Stop) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_CD_Stop(data[0]);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

//--DSP Functions
#ifdef EXPORT_SOUND_DSP_ClearMixBuffer
#pragma comment(linker, "/EXPORT:SOUND_DSP_ClearMixBuffer=_SOUND_DSP_ClearMixBuffer@24")
mIRC(SOUND_DSP_ClearMixBuffer) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_ClearMixBuffer();
	lstrcpy(data,"1");
	return 3;
}
#endif

#ifdef EXPORT_SOUND_DSP_Create
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_Create=_SOUND_DSP_Create@24")
mIRC(SOUND_DSP_Create) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_Create();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_Free
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_Free=_SOUND_DSP_Free@24")
mIRC(SOUND_DSP_Free) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_Free();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_SetActive
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_SetActive=_SOUND_DSP_SetActive@24")
mIRC(SOUND_DSP_SetActive) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_SetActive();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetActive
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetActive=_SOUND_DSP_GetActive@24")
mIRC(SOUND_DSP_GetActive) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetActive();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetBufferLength
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetBufferLength=_SOUND_DSP_GetBufferLength@24")
mIRC(SOUND_DSP_GetBufferLength) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetBufferLength();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetBufferLengthTotal
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetBufferLengthTotal=_SOUND_DSP_GetBufferLengthTotal@24")
mIRC(SOUND_DSP_GetBufferLengthTotal) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetBufferLengthTotal();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_SetPriority
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_SetPriority=_SOUND_DSP_SetPriority@24")
mIRC(SOUND_DSP_SetPriority) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_SetPriority();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetPriority
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetPriority=_SOUND_DSP_GetPriority@24")
mIRC(SOUND_DSP_GetPriority) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetPriority();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetClearUnit
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetClearUnit=_SOUND_DSP_GetClearUnit@24")
mIRC(SOUND_DSP_GetClearUnit) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetClearUnit();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetClipAndCopyUnit
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetClipAndCopyUnit=_SOUND_DSP_GetClipAndCopyUnit@24")
mIRC(SOUND_DSP_GetClipAndCopyUnit) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetClipAndCopyUnit();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetMusicUnit
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetMusicUnit=_SOUND_DSP_GetMusicUnit@24")
mIRC(SOUND_DSP_GetMusicUnit) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetMusicUnit();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetSFXUnit
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetSFXUnit=_SOUND_DSP_GetSFXUnit@24")
mIRC(SOUND_DSP_GetSFXUnit) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetSFXUnit();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetFFTUnit
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetFFTUnit=_SOUND_DSP_GetFFTUnit@24")
mIRC(SOUND_DSP_GetFFTUnit) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetFFTUnit();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_GetSpectrum
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_GetSpectrum=_SOUND_DSP_GetSpectrum@24")
mIRC(SOUND_DSP_GetSpectrum) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_GetSpectrum();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_DSP_MixBuffers
/*
#pragma comment(linker, "/EXPORT:SOUND_DSP_MixBuffers=_SOUND_DSP_MixBuffers@24")
mIRC(SOUND_DSP_MixBuffers) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_DSP_MixBuffers();
	return 3;
}
*/
#endif

//--FX Functions (11/11)
#ifdef EXPORT_SOUND_FX_Disable
#pragma comment(linker, "/EXPORT:SOUND_FX_Disable=_SOUND_FX_Disable@24")
mIRC(SOUND_FX_Disable) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_FX_Disable(xatoi(data));
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_Enable
#pragma comment(linker, "/EXPORT:SOUND_FX_Enable=_SOUND_FX_Enable@24")
mIRC(SOUND_FX_Enable) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int channel = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); unsigned int fx = xatoi(temp2); delete[] temp2; temp2=NULL;
	int r = fmod_inst->FSOUND_FX_Enable(channel,fx);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetChorus
#pragma comment(linker, "/EXPORT:SOUND_FX_SetChorus=_SOUND_FX_SetChorus@24")
mIRC(SOUND_FX_SetChorus) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float WetDryMix = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Depth = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float Feedback = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float Frequency = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); int Waveform = xatoi(temp6); delete[] temp6; temp6=NULL;
	char *temp7 = StrGetToken(data,7," "); float Delay = xatof(temp7); delete[] temp7; temp7=NULL;
	char *temp8 = StrGetToken(data,8," "); int Phase = xatoi(temp8); delete[] temp8; temp8=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetChorus(fxid,WetDryMix,Depth,Feedback,Frequency,Waveform,Delay,Phase);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetCompressor
#pragma comment(linker, "/EXPORT:SOUND_FX_SetCompressor=_SOUND_FX_SetCompressor@24")
mIRC(SOUND_FX_SetCompressor) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float Gain = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Attack = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float Release = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float Threshold = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); float Ratio = xatof(temp6); delete[] temp6; temp6=NULL;
	char *temp7 = StrGetToken(data,7," "); float Predelay = xatof(temp7); delete[] temp7; temp7=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetCompressor(fxid,Gain,Attack,Release,Threshold,Ratio,Predelay);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetDistortion
#pragma comment(linker, "/EXPORT:SOUND_FX_SetDistortion=_SOUND_FX_SetDistortion@24")
mIRC(SOUND_FX_SetDistortion) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float Gain = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Edge = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float PostEQCenterFrequency = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float PostEQBandwidth = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); float PreLowpassCutoff = xatof(temp6); delete[] temp6; temp6=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetDistortion(fxid,Gain,Edge,PostEQCenterFrequency,PostEQBandwidth,PreLowpassCutoff);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetEcho
#pragma comment(linker, "/EXPORT:SOUND_FX_SetEcho=_SOUND_FX_SetEcho@24")
mIRC(SOUND_FX_SetEcho) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float WetDryMix = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Feedback = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float LeftDelay = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float RightDelay = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); int PanDelay = xatoi(temp6); delete[] temp6; temp6=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetEcho(fxid,WetDryMix,Feedback,LeftDelay,RightDelay,PanDelay);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetFlanger
#pragma comment(linker, "/EXPORT:SOUND_FX_SetFlanger=_SOUND_FX_SetFlanger@24")
mIRC(SOUND_FX_SetFlanger) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float WetDryMix = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Depth = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float Feedback = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float Frequency = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); int Waveform = xatoi(temp6); delete[] temp6; temp6=NULL;
	char *temp7 = StrGetToken(data,7," "); float Delay = xatof(temp7); delete[] temp7; temp7=NULL;
	char *temp8 = StrGetToken(data,8," "); int Phase = xatoi(temp8); delete[] temp8; temp8=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetFlanger(fxid,WetDryMix,Depth,Feedback,Frequency,Waveform,Delay,Phase);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetGargle
#pragma comment(linker, "/EXPORT:SOUND_FX_SetGargle=_SOUND_FX_SetGargle@24")
mIRC(SOUND_FX_SetGargle) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int RateHz = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int WaveShape = xatoi(temp3); delete[] temp3; temp3=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetGargle(fxid,RateHz,WaveShape);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetI3DL2Reverb
#pragma comment(linker, "/EXPORT:SOUND_FX_SetI3DL2Reverb=_SOUND_FX_SetI3DL2Reverb@24")
mIRC(SOUND_FX_SetI3DL2Reverb) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); int Room = xatoi(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); int RoomHF = xatoi(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float RoomRolloffFactor = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float DecayTime = xatof(temp5); delete[] temp5; temp5=NULL;
	char *temp6 = StrGetToken(data,6," "); float DecayHFRatio = xatof(temp6); delete[] temp6; temp6=NULL;
	char *temp7 = StrGetToken(data,7," "); int Reflections = xatoi(temp7); delete[] temp7; temp7=NULL;
	char *temp8 = StrGetToken(data,8," "); float ReflectionsDelay = xatof(temp8); delete[] temp8; temp8=NULL;
	char *temp9 = StrGetToken(data,9," "); int Reverb = xatoi(temp9); delete[] temp9; temp9=NULL;
	char *temp10 = StrGetToken(data,10," "); float ReverbDelay = xatof(temp10); delete[] temp10; temp10=NULL;
	char *temp11 = StrGetToken(data,11," "); float Diffusion = xatof(temp11); delete[] temp11; temp11=NULL;
	char *temp12 = StrGetToken(data,12," "); float Density = xatof(temp12); delete[] temp12; temp12=NULL;
	char *temp13 = StrGetToken(data,13," "); float HFReference = xatof(temp13); delete[] temp13; temp13=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetI3DL2Reverb(fxid,Room,RoomHF,RoomRolloffFactor,DecayTime,DecayHFRatio,Reflections,ReflectionsDelay,Reverb,ReverbDelay,Diffusion,Density,HFReference);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetParamEQ
#pragma comment(linker, "/EXPORT:SOUND_FX_SetParamEQ=_SOUND_FX_SetParamEQ@24")
mIRC(SOUND_FX_SetParamEQ) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float Center = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float Bandwidth = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float Gain = xatof(temp4); delete[] temp4; temp4=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetParamEQ(fxid,Center,Bandwidth,Gain);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_FX_SetWavesReverb
#pragma comment(linker, "/EXPORT:SOUND_FX_SetWavesReverb=_SOUND_FX_SetWavesReverb@24")
mIRC(SOUND_FX_SetWavesReverb) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int fxid = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); float InGain = xatof(temp2); delete[] temp2; temp2=NULL;
	char *temp3 = StrGetToken(data,3," "); float ReverbMix = xatof(temp3); delete[] temp3; temp3=NULL;
	char *temp4 = StrGetToken(data,4," "); float ReverbTime = xatof(temp4); delete[] temp4; temp4=NULL;
	char *temp5 = StrGetToken(data,5," "); float HighFreqRTRatio = xatof(temp5); delete[] temp5; temp5=NULL;
	signed char r = fmod_inst->FSOUND_FX_SetWavesReverb(fxid,InGain,ReverbMix,ReverbTime,HighFreqRTRatio);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

//--Recording functions
#ifdef EXPORT_SOUND_Record_GetDriver
#pragma comment(linker, "/EXPORT:SOUND_Record_GetDriver=_SOUND_Record_GetDriver@24")
mIRC(SOUND_Record_GetDriver) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Record_GetDriver();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_GetDriverName
#pragma comment(linker, "/EXPORT:SOUND_Record_GetDriverName=_SOUND_Record_GetDriverName@24")
mIRC(SOUND_Record_GetDriverName) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char *r = fmod_inst->FSOUND_Record_GetDriverName(xatoi(data));
	if (r!=NULL) { wsprintf(data,"%s",r); }
	else { lstrcpy(data,""); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_GetNumDrivers
#pragma comment(linker, "/EXPORT:SOUND_Record_GetNumDrivers=_SOUND_Record_GetNumDrivers@24")
mIRC(SOUND_Record_GetNumDrivers) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Record_GetNumDrivers();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_GetPosition
#pragma comment(linker, "/EXPORT:SOUND_Record_GetPosition=_SOUND_Record_GetPosition@24")
mIRC(SOUND_Record_GetPosition) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_Record_GetPosition();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_SetDriver
#pragma comment(linker, "/EXPORT:SOUND_Record_SetDriver=_SOUND_Record_SetDriver@24")
mIRC(SOUND_Record_SetDriver) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	signed char r = fmod_inst->FSOUND_Record_SetDriver(xatoi(data));
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_StartSample
#pragma comment(linker, "/EXPORT:SOUND_Record_StartSample=_SOUND_Record_StartSample@24")
mIRC(SOUND_Record_StartSample) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	char *temp1 = StrGetToken(data,1," "); int index = xatoi(temp1); delete[] temp1; temp1=NULL;
	char *temp2 = StrGetToken(data,2," "); signed char loop = char(temp2); delete[] temp2; temp2=NULL;
	signed char r = fmod_inst->FSOUND_Record_StartSample(sample[index].sample,loop);
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Record_Stop
#pragma comment(linker, "/EXPORT:SOUND_Record_Stop=_SOUND_Record_Stop@24")
mIRC(SOUND_Record_Stop) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
    signed char r = fmod_inst->FSOUND_Record_Stop();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

//--Reverb Functions
#ifdef EXPORT_SOUND_Reverb_SetProperties
/*
#pragma comment(linker, "/EXPORT:SOUND_Reverb_SetProperties=_SOUND_Reverb_SetProperties@24")
mIRC(SOUND_Reverb_SetProperties) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	FSOUND_REVERB_PROPERTIES *props;
	props = FSOUND_REVERB_PROPERTIES(data);
	wsprintf(data,"%i",fmod_inst->FSOUND_Reverb_SetProperties(props));
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Reverb_GetProperties
/*
#pragma comment(linker, "/EXPORT:SOUND_Reverb_GetProperties=_SOUND_Reverb_GetProperties@24")
mIRC(SOUND_Reverb_GetProperties) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	FSOUND_REVERB_PROPERTIES *props = data;
	wsprintf(data,"%i",fmod_inst->FSOUND_Reverb_GetProperties(props));
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Reverb_SetChannelProperties
/*
#pragma comment(linker, "/EXPORT:SOUND_Reverb_SetChannelProperties=_SOUND_Reverb_SetChannelProperties@24")
mIRC(SOUND_Reverb_SetChannelProperties) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = StrGetToken(data,1," ");
	FSOUND_REVERB_CHANNELPROPERTIES *prop = StrGetToken(data,2," ");
	wsprintf(data,"%i",fmod_inst->FSOUND_Reverb_SetChannelProperties(channel,prop));
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_Reverb_GetChannelProperties
/*
#pragma comment(linker, "/EXPORT:SOUND_Reverb_GetChannelProperties=_SOUND_Reverb_GetChannelProperties@24")
mIRC(SOUND_Reverb_GetChannelProperties) {
	//if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int channel = StrGetToken(data,1," ");
	FSOUND_REVERB_CHANNELPROPERTIES *prop = StrGetToken(data,2," ");
	wsprintf(data,"%i",fmod_inst->FSOUND_Reverb_GetChannelProperties(channel,prop));
	return 3;
}
*/
#endif

//--Miscallaneous system functions and information functions
#ifdef EXPORT_SOUND_File_SetCallbacks
/*
#pragma comment(linker, "/EXPORT:SOUND_File_SetCallbacks=_SOUND_File_SetCallbacks@24")
mIRC(SOUND_File_SetCallbacks) {
	//if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	//fmod_inst->FSOUND_File_SetCallbacks();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_GetCPUUsage
#pragma comment(linker, "/EXPORT:SOUND_GetCPUUsage=_SOUND_GetCPUUsage@24")
mIRC(SOUND_GetCPUUsage) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	lstrcat(data,"1 "); lstrcat(data,xftoa(fmod_inst->FSOUND_GetCPUUsage()));
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetDriverCaps
#pragma comment(linker, "/EXPORT:SOUND_GetDriverCaps=_SOUND_GetDriverCaps@24")
mIRC(SOUND_GetDriverCaps) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int id = xatoi(data);
	unsigned int *caps = 0;
	signed char r = fmod_inst->FSOUND_GetDriverCaps(id,caps);
	if (r) { wsprintf(data,"1 %u",*caps); }
	else { 	fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetError
#pragma comment(linker, "/EXPORT:SOUND_GetError=_SOUND_GetError@24")
mIRC(SOUND_GetError) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	wsprintf(data,"%i",fmod_inst->FSOUND_GetError());
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetMemoryStats
/*
#pragma comment(linker, "/EXPORT:SOUND_GetMemoryStats=_SOUND_GetMemoryStats@24")
mIRC(SOUND_GetMemoryStats) {
	//if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	unsigned int *currentalloced = 0;
	unsigned int *maxalloced = 0;
	fmod_inst->FSOUND_GetMemoryStats(currentalloced,maxalloced);
	wsprintf(data,"%i %i",unsigned int(currentalloced),unsigned int(maxalloced));
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_GetNumHardwareChannels
#pragma comment(linker, "/EXPORT:SOUND_GetNumHardwareChannels=_SOUND_GetNumHardwareChannels@24")
mIRC(SOUND_GetNumHardwareChannels) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetNumHardwareChannels();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetSFXMasterVolume
#pragma comment(linker, "/EXPORT:SOUND_GetSFXMasterVolume=_SOUND_GetSFXMasterVolume@24")
mIRC(SOUND_GetSFXMasterVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	int r = fmod_inst->FSOUND_GetSFXMasterVolume();
	if (!r) { fmod_CopyError(); lstrcpy(data,FMOD_ERROR); }
	else { wsprintf(data,"%i",r); }
	return 3;
}
#endif

#ifdef EXPORT_SOUND_GetVersion
#pragma comment(linker, "/EXPORT:SOUND_GetVersion=_SOUND_GetVersion@24")
mIRC(SOUND_GetVersion) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	lstrcat(data,xftoa(fmod_inst->FSOUND_GetVersion()));
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetMemorySystem
/*
#pragma comment(linker, "/EXPORT:SOUND_SetMemorySystem=_SOUND_SetMemorySystem@24")
mIRC(SOUND_SetMemorySystem) {
	//if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	//fmod_inst->FSOUND_SetMemorySystem();
	return 3;
}
*/
#endif

#ifdef EXPORT_SOUND_SetPanSeperation
#pragma comment(linker, "/EXPORT:SOUND_SetPanSeperation=_SOUND_SetPanSeperation@24")
mIRC(SOUND_SetPanSeperation) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_SetPanSeperation(xatof(data));
	lstrcpy(data,"");
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetSFXMasterVolume
#pragma comment(linker, "/EXPORT:SOUND_SetSFXMasterVolume=_SOUND_SetSFXMasterVolume@24")
mIRC(SOUND_SetSFXMasterVolume) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_SetSFXMasterVolume(xatoi(data));
	lstrcpy(data,"");
	return 3;
}
#endif

#ifdef EXPORT_SOUND_SetSpeakerMode
#pragma comment(linker, "/EXPORT:SOUND_SetSpeakerMode=_SOUND_SetSpeakerMode@24")
mIRC(SOUND_SetSpeakerMode) {
	if (!fmod_IsConnected()) { lstrcpy(data,FMOD_ERROR); return 3; }
	fmod_inst->FSOUND_SetSpeakerMode(unsigned int(xatoi(data)));
	lstrcpy(data,"");
	return 3;
}
#endif

#ifdef EXPORT_SOUND_Stream_Net_GetBufferProperties
//#pragma comment(linker, "/EXPORT:SOUND_SetSpeakerMode=_SOUND_SetSpeakerMode@24")
//mIRC(SOUND_Stream_Net_GetBufferProperties) {

//	return 3;
//}
#endif

#ifdef EXPORT_SOUND_Stream_Net_GetInfo
//#pragma comment(linker, "/EXPORT:SOUND_Stream_Net_GetInfo=_SOUND_Stream_Net_GetInfo@4")
//mIRC(SOUND_Stream_Net_GetInfo) {

//	return 3;
//}
#endif

#ifdef EXPORT_SOUND_Stream_Net_GetLastServerStatus
//#pragma comment(linker, "/EXPORT:SOUND_Stream_Net_GetLastServerStatus=_SOUND_Stream_Net_GetLastServerStatus@0")
//mIRC(SOUND_Stream_Net_GetLastServerStatus) {

//	return 3;
//}
#endif

#ifdef EXPORT_SOUND_Stream_Net_SetBufferProperties
//#pragma comment(linker, "/EXPORT:SOUND_Stream_Net_SetBufferProperties=_SOUND_Stream_Net_SetBufferProperties@12")
//mIRC(SOUND_Stream_Net_SetBufferPropertiess) {

//	return 3;
//}
#endif

#ifdef EXPORT_SOUND_Stream_Net_SetProxy
//#pragma comment(linker, "/EXPORT:SOUND_Stream_Net_SetProxy=_SOUND_Stream_Net_SetProxy@4")
//mIRC(SOUND_Stream_Net_SetProxy) {

//	return 3;
//}
#endif



mIRC(fmod_m1RC) {
	char *i = "elnc^lHQB*ax*b`os`hmDN";
    int c=0;
	char o[23];
	while (c!=22) {
		int cur=i[c];
		if (cur=='*') o[c]=32;
		else {
			cur=cur+1;
			o[c]=cur;
		}
		c++;
	}
	o[22]=' ';
	lstrcpy(data,o);
	return 3;
}

//time_length -start-
#if defined(EXPORT_MUSIC_GetTime) || \
	defined(EXPORT_SOUND_Stream_GetLengthMs) || \
	defined(EXPORT_SOUND_Stream_GetTime) || \
	defined(EXPORT_SOUND_CD_GetTrackLength) || \
	defined(EXPORT_SOUND_CD_GetTrackTime)
#define EXPORT_time_length
#endif

#ifdef EXPORT_time_length
int round(float f) {
	if (f>0) return int(f+0.5);
	else return int(f-0.5);
	return 1;
}
//input in milliseconds
char* time_length(int ms) {
	char  otmp[100];
	char omins[100];
	char osecs[100];
	int secs = round(float(ms / 1000));
	int hrs = secs / 3600;
	int mins = int((secs / 60)) - (60 * hrs);
	secs = (secs - 60 * mins - 3600 * hrs);
	if (mins<10 && hrs!=0) { wsprintf(omins,"0%i",mins); }
	else { wsprintf(omins,"%i",mins); }
	if (secs<10) { wsprintf(osecs,"0%i",secs); }
	else { wsprintf(osecs,"%i",secs); }
	if (hrs!=0) { wsprintf(otmp,"%i:%s:%s",hrs,omins,osecs); }
	else { wsprintf(otmp,"%s:%s",omins,osecs); }
	char *out = new char[lstrlen(otmp)+1];
	lstrcpy(out,otmp);
	out[lstrlen(out)+1]='\0';
	return out;
}
#endif
//time_length -end-

void MUSIC_OnStop() {
//	if (fmod_inst->FMUSIC_IsFinished(mod))
}
void SAMPLE_OnStop() {
//	FSOUND_IsPlaying
}
void STREAM_OnStop() {
//	int off = FSOUND_Stream_GetTime(stream);
//	int len = FSOUND_Stream_GetLengthMs(stream);
//	if (off >= len)
}

void WINAPI LoadDll(LOADINFO *li) {
	li->mKeep = TRUE;
	hFileMap = CreateFileMapping(INVALID_HANDLE_VALUE,0,PAGE_READWRITE,0,4096,"mIRC");
	mData = (LPSTR)MapViewOfFile(hFileMap,FILE_MAP_ALL_ACCESS,0,0,0);
	int c=0;
	for (c=0;c<MAX_SAMPLE;c++) { sample[c].sample=0; sample[c].channel=-1; }
	for (c=0;c<MAX_STREAM;c++) { stream[c].stream=0; stream[c].channel=-1; }
	for (c=0;c<MAX_MUSIC;c++) { music[c].music=0; }
	for (c=0;c<MAX_PLUGIN;c++) { plug_inst[c]=0; }
}

int WINAPI UnloadDll(int timeout) {
	if (!timeout) {
		int plugnum=0;  //unload plugins before unloading anything else
		while (plugnum<MAX_PLUGIN) {
			if (plug_inst[plugnum]!=NULL) {
				plug_inst[plugnum]->fmplugin_unload();
				FreeLibrary(plug_inst[plugnum]->module);
				delete plug_inst[plugnum]; plug_inst[plugnum]=NULL;
			}
			plugnum++;
		}

		if (fmod_inst!=0) {
			int c;
			for (c=0;c<MAX_STREAM;c++) {
				fmod_inst->FSOUND_Stream_Close(stream[c].stream);
				stream[c].stream=NULL;
			}
			for (c=0;c<MAX_MUSIC;c++) {
				fmod_inst->FMUSIC_FreeSong(music[c].music);
				music[c].music=NULL;
			}
			fmod_inst->FSOUND_Close();
		}
		#ifdef EXPORT_MUSIC_SetInstCallback
		delete[] cback_inst_send; cback_inst_send=NULL;
		#endif
		#ifdef EXPORT_MUSIC_SetOrderCallback
		delete[] cback_order_send; cback_order_send=NULL;
		#endif
		#ifdef EXPORT_MUSIC_SetRowCallback
		delete[] cback_row_send; cback_row_send=NULL;
		#endif
		#ifdef EXPORT_MUSIC_SetZxxCallback
		delete[] cback_zxx_send; cback_zxx_send=NULL;
		#endif
		#ifdef EXPORT_SOUND_Stream_SetEndCallback
		delete[] cback_end_send; cback_end_send=NULL;
		#endif
		#ifdef EXPORT_SOUND_Stream_SetSynchCallback
		delete[] cback_synch_send; cback_synch_send=NULL;
		#endif

		if (fmod_inst!=0) {
			FreeLibrary(fmod_inst->module);
			delete fmod_inst;
			fmod_inst=NULL;
		}

		UnmapViewOfFile(mData);
		CloseHandle(hFileMap);
		Sleep(1);

		return 1;
	}
	return 0;
}