Attribute VB_Name = "modHSL"
Option Explicit

'Author: Andrew Gray
'Date: 9/10/2001 8:18:23 PM
'Link: http://abstractvb.com/code.asp?F=50&P=1&A=926

Public Type HSL
    Hue                 As Integer
    Saturation          As Integer
    Luminance           As Integer
End Type

Public Type RGB
    Red                 As Integer
    Green               As Integer
    Blue                As Integer
End Type

Private Const HueMAX    As Long = 239
Private Const SatMAX    As Long = 240
Private Const LumMAX    As Long = 240

Private Const C_2_DIV_3 As Double = (2 / 3)
Private Const C_1_DIV_3 As Double = (1 / 3)

Public Function HSLtoRGB(ByVal Hue As Integer, _
                         ByVal Saturation As Integer, _
                         ByVal Luminance As Integer) As Long

    Dim RetVal      As RGB
    Dim pHue        As Double
    Dim pSat        As Double
    Dim pLum        As Double
    Dim pRed        As Double
    Dim pGreen      As Double
    Dim pBlue       As Double
    Dim temp1       As Double
    Dim temp2       As Double
    Dim temp3(2)    As Double
    Dim N           As Long
   
    pHue = Hue / HueMAX
    pSat = Saturation / SatMAX
    pLum = Luminance / LumMAX

    If pSat = 0 Then
        pRed = pLum
        pGreen = pLum
        pBlue = pLum
    Else
        If pLum < 0.5 Then
            temp2 = pLum * (1 + pSat)
        Else
            temp2 = pLum + pSat - pLum * pSat
        End If
        temp1 = 2 * pLum - temp2
   
        temp3(0) = pHue + C_1_DIV_3
        temp3(1) = pHue
        temp3(2) = pHue - C_1_DIV_3
      
        For N = 0 To 2
            If temp3(N) < 0# Then
                temp3(N) = temp3(N) + 1#
            ElseIf temp3(N) > 1# Then
                temp3(N) = temp3(N) - 1#
            End If
            
            If 6# * temp3(N) < 1# Then
                temp3(N) = temp1 + (temp2 - temp1) * 6# * temp3(N)
            Else
                If 2# * temp3(N) < 1# Then
                    temp3(N) = temp2
                Else
                    If 3# * temp3(N) < 2# Then
                        temp3(N) = temp1 + (temp2 - temp1) * (C_2_DIV_3 - temp3(N)) * 6#
                    Else
                        temp3(N) = temp1
                    End If
                End If
            End If
        Next N

        pRed = temp3(0)
        pGreen = temp3(1)
        pBlue = temp3(2)
    End If

    With RetVal
        .Red = Int(pRed * 255#)
        .Green = Int(pGreen * 255#)
        .Blue = Int(pBlue * 255#)
        
        If .Red < 0 Then .Red = 0
        If .Green < 0 Then .Green = 0
        If .Blue < 0 Then .Blue = 0
        
        HSLtoRGB = RGB(.Red, .Green, .Blue)
    End With
End Function
