Attribute VB_Name = "mdlTypes"
Public Enum eStatus
    sIdle = 0
    sPlaying = 1
    sPaused = 2
    sRewinding = 3
    sFastForward = 4
End Enum
Private Type gIniFiles
    iSettings As String
    iWindowpos As String
    iErrors As String
    iVisibleWindows As String
    iUpdate As String
End Type
Private Type gSettings
    sAlwaysOnTop As Boolean
    sStartWithWindows As Boolean
    sAutoPlayOnStart As Boolean
    sAutoFullScreenOnPlay As Boolean
    sShowIconInSystray As Boolean
    sSingleClickToExitFullScreen As Boolean
    sRememberWindowPosition As Boolean
    sUseDVDInterface As Boolean
    sShowSplash As Boolean
    sShowErrors As Boolean
    sCaptureMode As Boolean
    sShowStatusBar As Boolean
    sShowDVDTime As Boolean
    sAutoPlayOnInsert As Boolean
    sMenuVisibleOnMainForm As Boolean
    sUseOnScreenDisplay As Boolean
    sAutoPlayMenuOnAutoPlay As Boolean
    sCmd As String
    sCheckForUpdates As Boolean
    sPlayOnRootMenuFail As Boolean
    sSubpictureOn As Boolean
End Type
Public Enum EventTypes
    ePlay = 1
    eStopped = 2
    ePaused = 3
    eNewDisc = 4
    eDiscEjected = 5
    eNoDisc = 6
    eNoDrive = 7
    eRewind = 8
    eFastForward = 9
    eNavigatingMenu = 10
End Enum
Private Type gPlayer
'    pMovieInfo As gMovieInfo
    pTitle As String
    pTime As String
    pMute As Boolean
    pFullscreen As Boolean
    pChapter As String
    pStatus As eStatus
    pLength As String
    pIntSpeed As Integer
    pRewinding As Boolean
    pFastForwarding As Boolean
    pPlaybackPositionShown As Boolean
    pRewindSpeed As Integer
    pFastforwardSpeed As Integer
    pChapterCount As Integer
End Type
Private Type gWizardFile
    wEnabled As Boolean
    wPath As String
    wFile As String
    wDestinationPath As String
End Type
Private Type gWizardFiles
    wDescription As String
    wPath As String
    wCount As Integer
    wFile(100) As gWizardFile
    wTimeLeft As String
    wStatus As String
    wBusy As Boolean
End Type
Global lPlayer As gPlayer
Global lINIFiles As gIniFiles
Global lSettings As gSettings
Global lCaptureVersion As Boolean
Global lPlayerVisToggle As Boolean
Global lFrame As Integer
Global lWizardFiles As gWizardFiles
