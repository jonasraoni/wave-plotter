{*
 * Wave Plotter: Delphi/pascal component to draw waves (sine, square, triangle)
 * Jonas Raoni Soares da Silva <http://raoni.org>
 * https://github.com/jonasraoni/wave-plotter
 *}

unit FGerador;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, ExtCtrls, StdCtrls, Buttons, XPMan, ComCtrls, Grids,
  ValEdit, WavePlotter;

type
  TfrmGerador = class(TForm)
    Panel1: TPanel;
    Label11: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    cbVolts: TComboBox;
    cbInterval: TComboBox;
    Panel2: TPanel;
    pgOsciloscopio: TPageControl;
    tsGerador: TTabSheet;
    GroupBox1: TGroupBox;
    SBQuadrada: TSpeedButton;
    SBSenoide: TSpeedButton;
    SBTriangular: TSpeedButton;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    eAmplitude: TEdit;
    spbAmp: TSpinButton;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label8: TLabel;
    spbOffset: TSpinButton;
    eOffSet: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    sb1: TSpeedButton;
    sb10: TSpeedButton;
    sb100: TSpeedButton;
    sbHz: TSpeedButton;
    sbKhz: TSpeedButton;
    sbMhz: TSpeedButton;
    shape: TShape;
    lblFrequencia: TLabel;
    Label1: TLabel;
    eFator: TEdit;
    tbFator: TTrackBar;
    tsEquacao: TTabSheet;
    lblGanho: TLabel;
    GroupBox5: TGroupBox;
    Panel4: TPanel;
    vlVariaveis: TValueListEditor;
    GroupBox6: TGroupBox;
    eExpression: TMemo;
    wavePlotter: TWaveShape;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure sb1Click(Sender: TObject);
    procedure spbOffsetDownClick(Sender: TObject);
    procedure spbOffsetUpClick(Sender: TObject);
    procedure tbFatorChange(Sender: TObject);
    procedure spbAmpUpClick(Sender: TObject);
    procedure spbAmpDownClick(Sender: TObject);
    procedure SBSenoideClick(Sender: TObject);
    procedure eExpressionChange(Sender: TObject);
    procedure vlVariaveisValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure cbIntervalChange(Sender: TObject);
    procedure wavePlotterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbVoltsChange(Sender: TObject);
  private
  public
    procedure plot;
    procedure UpdateExpression;
  end;

var
  frmGerador: TfrmGerador;
  waveInfo, waveInfo2: TWave;

const
  INTERVAL_SET: array[0..8] of extended = ( 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10 );
  VOLTS_SET: array[0..8] of extended = ( 0.2, 0.4, 0.8, 2, 4, 8, 20, 40, 80 );

implementation

uses evaluator;

{$R *.dfm}

procedure TfrmGerador.FormCreate(Sender: TObject);
begin
  waveInfo := wavePlotter.waves[ wavePlotter.add ];
  waveInfo2 := wavePlotter.waves[ wavePlotter.add ];

  cbIntervalChange( self );
  cbVoltsChange( self );

  waveInfo.waveType := wtSin;
  waveInfo.color := clRed;
  waveInfo.gain := 1;
  waveInfo.amplitude := 1;
  waveInfo.offset := 0;
  tbFator.position := 0;

  plot;

end;

procedure TfrmGerador.sb1Click(Sender: TObject);
var
  f: Int64;
  suffix: string;
begin
  f := 1;
  if sb10.Down then
    f := 10
  else if sb100.Down then
    f := 100;

  suffix := 'Hz';

  if sbKhz.Down then begin
    f := f * 1000;
    suffix := 'MHz';
  end
  else if sbMhz.Down then begin
    f := f * 1000000;
    suffix := 'GHz';
  end;
  waveInfo.frequency := f * (tbFator.max - tbFator.position) / 100;
  lblFrequencia.Caption :=  formatHertz( waveInfo.frequency );

  plot;
end;

procedure TfrmGerador.spbOffsetDownClick(Sender: TObject);
begin
  waveInfo.offSet := waveInfo.offSet - 0.1;
  if WaveInfo.offSet < -8 then
    WaveInfo.offSet := -8;
  eOffSet.Text := FormatFloat( '#0.0', waveInfo.offset );

  plot;
end;

procedure TfrmGerador.spbOffsetUpClick(Sender: TObject);
begin
  WaveInfo.OffSet := WaveInfo.OffSet + 0.1;
  if WaveInfo.offSet > 8 then
    WaveInfo.offSet := 8;
  eOffSet.Text := FormatFloat( '#0.0', WaveInfo.OffSet );
  plot;
end;

procedure TfrmGerador.tbFatorChange(Sender: TObject);
begin
  eFator.Text := FloatToStr( ( 100 - TTrackBar( Sender ).Position ) / 100 );
  sb1Click( self );
end;

procedure TfrmGerador.spbAmpUpClick(Sender: TObject);
begin
  WaveInfo.Amplitude := waveInfo.Amplitude + 0.1;
  if WaveInfo.Amplitude > 8 then
    WaveInfo.Amplitude := 8;
  eAmplitude.Text := FormatFloat( '#0.0', WaveInfo.Amplitude );
  plot;
end;

procedure TfrmGerador.spbAmpDownClick(Sender: TObject);
begin
  WaveInfo.Amplitude := WaveInfo.Amplitude - 0.1;
  if WaveInfo.Amplitude < 0 then
    WaveInfo.Amplitude := 0;
  eAmplitude.Text := FormatFloat( '#0.0', WaveInfo.Amplitude );
  plot;
end;

procedure TfrmGerador.SBSenoideClick(Sender: TObject);
begin
  waveInfo.WaveType := TWaveType( TControl( sender ).tag );
  plot;
end;

procedure TfrmGerador.eExpressionChange(Sender: TObject);
var
  i: integer;
  s: string;
begin
  s := '';
  vlVariaveis.strings.clear;
  for i := 1 to length( eExpression.Text ) do begin
    if eExpression.text[i] in ['A'..'z'] then
      s := s + eExpression.text[i]
    else if s <> '' then begin
      vlVariaveis.InsertRow( s, '1', false );
      s := '';
    end;
  end;
  if s <> '' then
    vlVariaveis.InsertRow( s, '1', false );

  UpdateExpression;
end;

procedure TfrmGerador.vlVariaveisValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
  vlVariaveis.values[ keyName ] := floatToStr( strToFloatDef( keyValue, 0 ) );
  UpdateExpression;  
end;

procedure TfrmGerador.plot;
begin
  waveInfo.assignTo( waveInfo2 );
  with waveInfo2 do begin
    waveInfo2.inverted := true;
    waveInfo2.offset := 0;
    waveInfo2.color := clLime;
    waveInfo2.gain := 1;
  end;
  wavePlotter.invalidate;
end;

procedure TfrmGerador.cbIntervalChange(Sender: TObject);
begin
  wavePlotter.interval := INTERVAL_SET[ cbInterval.itemIndex ];
end;

procedure TfrmGerador.wavePlotterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  caption := format( 'volts: %s  :  secs: %s', [ formatNumber( 'V', '####0.000', wavePlotter.voltsAt[ y ] ) , formatNumber( 's', '####0.000', wavePlotter.secondsAt[ x ] ) ] );
end;

procedure TfrmGerador.cbVoltsChange(Sender: TObject);
begin
  wavePlotter.volts := VOLTS_SET[ cbVolts.ItemIndex ];
end;

procedure TfrmGerador.UpdateExpression;
var
  s: string;
  i: integer;
begin
  s := eExpression.text;
  for i := 0 to vlVariaveis.rowCount - 1 do
    s := stringReplace( s, vlVariaveis.keys[ i ], vlVariaveis.values[ vlVariaveis.keys[ i ] ], [ rfReplaceAll ] );
  try
    waveInfo.gain := evalExpression( pchar( s ) );
  except
  end;
  lblGanho.Caption := 'Ganho de ' + FormatFloat( '#,##0.00', waveInfo.gain * 100 ) + '%';
  plot;
end;

end.
