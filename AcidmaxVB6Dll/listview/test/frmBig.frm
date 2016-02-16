VERSION 5.00
Object = "*\A..\listview\RMListView.vbp"
Begin VB.Form frmBig 
   Caption         =   "Big Icons"
   ClientHeight    =   4620
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4875
   LinkTopic       =   "Form2"
   ScaleHeight     =   308
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   325
   StartUpPosition =   3  'Windows-Standard
   Begin RMListView.ListView ListView1 
      Height          =   2790
      Left            =   225
      TabIndex        =   1
      Top             =   525
      Width           =   4290
      _ExtentX        =   7567
      _ExtentY        =   4921
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      SolidFocusRect  =   0   'False
      PictureWidth    =   16
      PictureHeight   =   16
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Big Icons"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   225
      TabIndex        =   0
      Top             =   150
      Width           =   1110
   End
End
Attribute VB_Name = "frmBig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Dim i       As Long
    Dim lngItm  As Long
    
    With ListView1
        .Redraw = False
        
        ' look for icons of following size in ico files
        ' if no one of this size is found, use the the one
        ' next to this size and resize it when rendering it
        ' to the DC
        .PictureHeight = 48
        .PictureWidth = 48
        
        .AddPicture App.Path & "\icons\ChronoSync mAqua 1.ico"
        .AddPicture App.Path & "\icons\OKShield.ico"
        .AddPicture App.Path & "\icons\Seikosha - World.ico"
        .AddPicture App.Path & "\icons\Search.ico"
      
        .AddColumn "col1", "Spalte 1", TextAlignCenter, .PictureWidth + 8, False
        .AddColumn "col2", "Spalte 2", TextAlignLeft, 100
        .ColumnsVisible = False
        .ColumnsAutoSize = True

        .ItemText(.AddItem(, "", 0), 1) = "Icon 48x48 with Alpha"
        .ItemText(.AddItem(, "", 1), 1) = "Icon 48x48 with Alpha"
        .ItemText(.AddItem(, "", 2), 1) = "Icon 48x48 with Alpha"
        .ItemText(.AddItem(, "", 3), 1) = "Icon 48x48 with Alpha"
        
        .Redraw = True
    End With
End Sub

Private Sub Form_Resize()
    With ListView1
        If Me.ScaleWidth - .Left * 2 > 0 Then .Width = Me.ScaleWidth - .Left * 2
        If Me.ScaleHeight - (.Top - Label1.Height + 8) * 2 > 0 Then .Height = Me.ScaleHeight - (.Top - Label1.Height + 8) * 2
    End With
End Sub
