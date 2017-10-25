{*
 * Wave Plotter: Delphi/pascal component to draw waves (sine, square, triangle)
 * Jonas Raoni Soares da Silva <http://raoni.org>
 * https://github.com/jonasraoni/wave-plotter
 *}

unit FOsciloscopio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, WavePlotter, Buttons, Grids, ValEdit,
  ComCtrls, Spin;

type
  TfrmOsciloscopio = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbIntervalChange(Sender: TObject);
    procedure wavePlotterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure wavePlotterDblClick(Sender: TObject);
    procedure cbVoltsChange(Sender: TObject);
  private
  public
    procedure plot;
  end;

var
  frmOsciloscopio: TfrmOsciloscopio;
  waveInfo, waveInfo2: TWave;

const
  INTERVAL_SET: array[0..8] of extended = ( 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10 );
  VOLTS_SET: array[0..8] of extended = ( 0.2, 0.4, 0.8, 2, 4, 8, 20, 40, 80 );

implementation

uses FGerador;

{$R *.dfm}

procedure TfrmOsciloscopio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
  application.terminate;
end;

procedure TfrmOsciloscopio.FormCreate(Sender: TObject);
begin
  waveInfo := wavePlotter.waves[ wavePlotter.add ];
  waveInfo2 := wavePlotter.waves[ wavePlotter.add ];

  cbIntervalChange( self );
  cbVoltsChange( self );
end;

procedure TfrmOsciloscopio.plot;
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

procedure TfrmOsciloscopio.cbIntervalChange(Sender: TObject);
begin
  wavePlotter.interval := INTERVAL_SET[ cbInterval.itemIndex ];
end;

procedure TfrmOsciloscopio.wavePlotterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  caption := format( 'volts: %s  :  secs: %s', [ formatNumber( 'V', '####0.000', wavePlotter.voltsAt[ y ] ) , formatNumber( 's', '####0.000', wavePlotter.secondsAt[ x ] ) ] );
end;

procedure TfrmOsciloscopio.wavePlotterDblClick(Sender: TObject);
begin
  frmGerador.Show;
end;

procedure TfrmOsciloscopio.cbVoltsChange(Sender: TObject);
begin
  wavePlotter.volts := VOLTS_SET[ cbVolts.ItemIndex ];
end;

end.
