Sub AlphabetTesting()


  ' Variables to track columns storing the desired value
  Dim ws As WorkSheet
  Dim ColTicker As Integer
  Dim ColOpenPrice As Integer
  Dim ColClosePrice As Integer
  Dim ColVol As Integer
  Dim SummaryTableIndex As Integer
  Dim ColSumTicker As Integer
  Dim ColSumOpenPrice As Integer
  Dim ColSumClosePrice As Integer
  Dim ColSumYearlyChange As Integer
  Dim ColSumPercentChange As Integer
  Dim ColSumTotalStockVol As Integer

  Dim Ticker As String
  Dim RunningTotal As Double
  Dim OpeningPrice As Double
  Dim ClosingPrice As Double
  Dim YearlyChange As Double
  Dim PercentChange As Double
  Dim LastRow As Long


  ' Initialize Variables

  ColTicker = 1
  ColOpenPrice = 3
  ColClosePrice = 6
  ColVol = 7
  SummaryTableIndex = 2
  ColSumTicker = 9
  ColSumOpenPrice = 10
  ColSumClosePrice = 11
  ColSumYearlyChange = 12
  ColSumPercentChange = 13
  ColSumTotalStockVol = 14

  RunningTotal = 0
  OpeningPrice = 0#
  ClosingPrice = 0#
  YearlyChange = 0#
  PercentChange = 0#


  For Each ws in ThisWorkbook.WorkSheets

  LastRow = ws.Range("A" & Rows.Count).End(xlUp).Row

  ' Create Summary Table
  ws.Range("I1").Value = "Ticker"
  ws.Range("J1").Value = "Opening Price"
  ws.Range("K1").Value = "Closing Price"
  ws.Range("L1").Value = "Yearly Change"
  ws.Range("M1").Value = "Percent Change"
  ws.Range("N1").Value = "Total Stock Volume"


    ' Write 1st value for OpeningPrice to Summary Table
    ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value = ws.Cells(2, ColOpenPrice).Value

    ' Loop through rows in the column
    For i = 2 To LastRow

      'If NOT at the LastRow
      If i <> LastRow Then
          
          
          If ws.Cells(i + 1, ColTicker).Value <> ws.Cells(i, ColTicker).Value Then
            ' Compare current cell & next cell. If DIFFERENT execute the following
            ' Write the findings to the Summary Table
            ' Increment the RunningTotal
            ' Move to the next row in the Summary Table
            ' Reset RunningTotal

              'Avoid an Overflow error if Opening Price = 0
              If ws.Cells(i + 1, ColOpenPrice).Value = 0 Then
                OpeningPrice = 0.0000001
              Else:
                OpeningPrice = ws.Cells(i + 1, ColOpenPrice).Value
              End If
              
              ClosingPrice = ws.Cells(i, ColClosePrice).Value
              RunningTotal = RunningTotal + ws.Cells(i, ColVol).Value

              ws.Cells(SummaryTableIndex, ColSumTotalStockVol).Value = RunningTotal
              ws.Cells(SummaryTableIndex, ColSumTicker).Value = ws.Cells(i, ColTicker).Value
              ws.Cells(SummaryTableIndex + 1, ColSumOpenPrice).Value = OpeningPrice
              ws.Cells(SummaryTableIndex, ColSumClosePrice).Value = ClosingPrice

              YearlyChange = ws.Cells(SummaryTableIndex, ColSumClosePrice).Value - ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value
              ws.Cells(SummaryTableIndex, ColSumYearlyChange).Value = YearlyChange
              PercentChange = (ws.Cells(SummaryTableIndex, ColSumClosePrice).Value - ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value) / (ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value)
              ws.Cells(SummaryTableIndex, ColSumPercentChange).Value = PercentChange
              ws.Cells(SummaryTableIndex, ColSumPercentChange).Style = "Percent"
              
              ' Conditional Formatting for Yearly Change
              ' Positive Value: Green
              If ws.Cells(SummaryTableIndex, ColSumYearlyChange).Value >= 0 Then
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Font.ColorIndex = 43
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Interior.ColorIndex = 51
              ' Negative Value: Red
              Else:
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Font.ColorIndex = 38
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Interior.ColorIndex = 30
              End If

              RunningTotal = 0
              OpeningPrice = 0
              ClosingPrice = 0
              SummaryTableIndex = SummaryTableIndex + 1
              
          Else:
            ' Compare current cell & next cell. If SAME:
            ' Increment the RunningTotal
              RunningTotal = RunningTotal + ws.Cells(i, ColVol).Value

          End If
          
      Else:
          'If this IS the LastRow
            ' Compare current cell & next cell. If SAME execute the following
            ' Write the findings to the Summary Table
            ' Increment the RunningTotal
              RunningTotal = RunningTotal + ws.Cells(i, ColVol).Value
              ws.Cells(SummaryTableIndex, ColSumTotalStockVol).Value = RunningTotal
              ws.Cells(SummaryTableIndex, ColSumTicker).Value = ws.Cells(i, ColTicker).Value
              ws.Cells(SummaryTableIndex, ColSumClosePrice).Value = ws.Cells(i, ColClosePrice).Value

              YearlyChange = ws.Cells(SummaryTableIndex, ColSumClosePrice).Value - ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value
              ws.Cells(SummaryTableIndex, ColSumYearlyChange).Value = YearlyChange
              PercentChange = (ws.Cells(SummaryTableIndex, ColSumClosePrice).Value - ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value) / (ws.Cells(SummaryTableIndex, ColSumOpenPrice).Value)
              ws.Cells(SummaryTableIndex, ColSumPercentChange).Value = PercentChange
              ws.Cells(SummaryTableIndex, ColSumPercentChange).Style = "Percent"

              ' Conditional Formatting for Yearly Change
              ' Positive Value: Green
              If ws.Cells(SummaryTableIndex, ColSumYearlyChange).Value >= 0 Then
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Font.ColorIndex = 43
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Interior.ColorIndex = 51
              ' Negative Value: Red
              Else:
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Font.ColorIndex = 38
                ws.Cells(SummaryTableIndex, ColSumYearlyChange).Interior.ColorIndex = 30
              End If

              RunningTotal = 0
              OpeningPrice = 0
              ClosingPrice = 0
              SummaryTableIndex = 2
      End If
    
    Next i

    ws.Range("J1").EntireColumn.Hidden = TRUE
    ws.Range("K1").EntireColumn.Hidden = TRUE

  Next ws



End Sub
