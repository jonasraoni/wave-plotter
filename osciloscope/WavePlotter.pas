{*
 * Wave Plotter: Delphi/pascal component to draw waves (sine, square, triangle)
 * Jonas Raoni Soares da Silva <http://raoni.org>
 * https://github.com/jonasraoni/wave-plotter
 *}

unit WavePlotter;

interface

uses
  forms, dialogs, SysUtils, Classes, Controls, Graphics;

const
  pi2 = pi * 2;

type
  TWaveType = ( wtSqr, wtPoly, wtSin );

  TWave = class( TPersistent )
  public
    waveType: TWaveType;
    color: TColor;
    inverted: boolean;
    offset, frequency, amplitude, gain: extended;

    procedure AssignTo(Dest: TPersistent); override;
  end;

  TWaveShape = class( TGraphicControl )
  protected
    fVolts: extended;
    fInterval: extended;
    fWaves: TList;
    fLineColor: TColor;
    fBorderV, fBorderH: integer;

    function getWave(const index: integer): TWave;
    function getBackgroundColor: TColor;
    function getFont: TFont;
    function getVoltsAt(const y: integer): extended;
    function getSecondsAt(const x: integer): extended;

    procedure setBackgroundColor(const Value: TColor);
    procedure setFont( const Value: TFont );
    procedure setLineColor(const Value: TColor);
    procedure setVolts(const Value: extended);
    procedure setInterval(const Value: extended);

  public
    constructor create( AOwner: TComponent ); override;
    destructor destroy; override;

    procedure clear;
    procedure delete( const index: integer );
    procedure Loaded; override;

    function add: integer;

    property waves[ const index: integer]: TWave read GetWave;

    property voltsAt[ const y: integer]: extended read getVoltsAt;
    property secondsAt[ const x: integer]: extended read getSecondsAt;

  published
    procedure paint; override;
    property backgroundColor: TColor read getBackgroundColor write setBackgroundColor default clBlack;
    property lineColor: TColor read fLineColor write setLineColor default clGray;
    property interval: extended read fInterval write setInterval;
    property volts: extended read fVolts write setVolts;
    property Font: TFont read getFont write setFont;

    //inherited
    //property Canvas;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    //property Font;
    property Enabled;
    property ParentColor;
    //property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

function formatHertz( n: extended ): string;
function formatNumber( const suffix, format: string; const n: extended ): string;
function max( const a, b: integer ): integer;

implementation

function formatHertz( n: extended ): string;
const
  FORMAT = '####0.00';
begin
  if n < 1000 then
    result := formatFloat( format, n ) + ' Hz'
  else if n / 1000 < 1000 then
    result := formatFloat( format, n / 1000 ) + ' KHz'
  else if n / 1000000 < 1000 then
    result := formatFloat( format, n / 1000000 ) + ' MHz'
  else
    result := formatFloat( format, n / 1000000000 ) + ' GHz'
end;

function formatNumber( const suffix, format: string; const n: extended ): string;
begin
  if n = 0 then
    result := '0' + suffix
  else if n * 1000000 < 1000 then
    result := formatFloat( format, n * 1000000 ) + ' µ' + suffix
  else if n * 1000 < 1000 then
    result := formatFloat( format, n * 1000 ) + ' m' + suffix
  else
    result := formatFloat( format, n ) + ' ' + suffix
end;

function max( const a, b: integer ): integer;
begin
  if a > b then
    result := a
  else
    result := b;
end;

{ TWaveShape }

function TWaveShape.add: integer;
begin
  result := fWaves.add( TWave.Create );
end;

procedure TWaveShape.clear;
begin
  while fWaves.count > 0 do begin
    TWave( fWaves[0] ).free;
    fWaves.delete( 0 );
  end;
end;

constructor TWaveShape.create(AOwner: TComponent);
begin
  inherited;
  fWaves := TList.create;
  fInterval := 1;
  fVolts := 4;

  font.color := clLime;

  color := clBlack;
  fLineColor := clGray;
  fBorderH := 0;
  fBorderV := 0;
end;

procedure TWaveShape.delete(const index: integer);
begin
  if ( index > -1 ) and ( index < fWaves.count ) then begin
    TWave( fWaves[index] ).free;
    fWaves.delete( index );
  end;
end;

destructor TWaveShape.destroy;
begin
  fWaves.free;
  inherited;
end;

function TWaveShape.getBackgroundColor: TColor;
begin
  result := color;
end;

function TWaveShape.getFont: TFont;
begin
  result := canvas.font;
end;

function TWaveShape.getSecondsAt(const x: integer): extended;
begin
  Result := clientHeight / fVolts
//  Result := x / clientWidth * fInterval;
end;

function TWaveShape.getVoltsAt(const y: integer): extended;
begin
  if y < clientHeight div 2 then
     result := ( clientHeight - ( y + clientHeight / 2 )  ) / ( clientHeight / 2 ) * fVolts
  else
    result := ( y - clientHeight / 2 ) / ( clientHeight / 2 ) * fVolts;
end;

function TWaveShape.getWave(const index: integer): TWave;
begin
  result := nil;
  if ( index > -1 ) and ( index < fWaves.count ) then
    result := TWave( fWaves[ index ] );
end;

procedure TWaveShape.Loaded;
begin
  inherited;
  canvas.font.assign( font );
end;

procedure TWaveShape.paint;
const
  HCELLS = 10;
  VCELLS = 8;
var
  k, x: integer;
  lastX, lastY: array of integer;
  y: extended;
  legend: string;
begin
  if not enabled then
    exit;
  canvas.brush.color := color;
  canvas.fillRect( clientRect );

  setLength( lastY, fWaves.count );
  setLength( lastX, fWaves.count );
  for k := 0 to high( lastY ) do begin
    lastY[k] := trunc( clientHeight / 2 + waves[k].offset );
    lastX[k] := fBorderH;
  end;

  with canvas do begin
    pen.color := fLineColor;
    pen.style := psDot;
  end;

  k := clientHeight div VCELLS;
  for x := 1 to VCELLS-1 do
    with canvas do begin
      moveTo( fBorderH, x * k + ( ( clientHeight - clientHeight div VCELLS * VCELLS ) div 2 ) );
      lineTo( clientWidth - fBorderH, x * k + ( ( clientHeight - clientHeight div VCELLS * VCELLS ) div 2 ) );

      if x < VCELLS div 2 then
        legend := formatNumber( 'V', '####0.000', ( VCELLS - ( x + VCELLS / 2 )  ) / ( VCELLS / 2 ) * fVolts )
      else
        legend := '-' + formatNumber( 'V', '####0.000', ( x - VCELLS / 2 ) / ( VCELLS / 2 ) * fVolts );
      textOut( 0, ( x * k + ( ( clientHeight - clientHeight div VCELLS * VCELLS ) div 2 ) ) - textHeight( legend ) div 2, legend );
    end;

  k := clientWidth div HCELLS;
  for x := 1 to HCELLS-1 do
    with canvas do begin
      moveTo( x * k + ( ( clientWidth - clientWidth div HCELLS * HCELLS ) div 2 ), fBorderH div 2 );
      lineTo( x * k + ( ( clientWidth - clientWidth div HCELLS * HCELLS ) div 2 ), clientHeight-fBorderH div 2 );
      if x mod 2 = 0 then begin
        legend := formatNumber( 's', '####0.000', fInterval * ( x / HCELLS ) );
        textOut( ( x * k + ( ( clientWidth - clientWidth div HCELLS * HCELLS ) div 2 ) ) - textWidth( legend ) div 2, clientHeight - textHeight( legend ) , legend );
      end;
    end;

  canvas.pen.style := psSolid;

  for x := fBorderH to max( clientWidth, clientHeight ) - fBorderH do begin
    with canvas do begin
      for k := 0 to fWaves.count - 1 do begin
        with waves[k] do begin
          pen.color := color;

          y := ( x - fBorderH ) * pi2 / clientWidth * frequency * fInterval;

          if inverted then
            y := y + pi;

          case waveType of
            wtSin:
              y := sin( y );
            wtPoly: begin
              y := frac( y / pi2 );
              if y <= 0.25 then
                y := y / 0.25
              else if y <= 0.75 then
                y := ( -y + 0.5 ) / 0.25
              else
                y := ( y - 1 ) / 0.25;
            end;
            wtSqr: begin
              if frac( y / pi2 ) <= 0.5 then
                y := 1
              else
                y := -1;
            end;
          end;

//offset * ( clientHeight / 2 ) * fVolts

          y := y * ( clientHeight / ( volts * 4 ) ) * amplitude * gain + clientHeight / 2 + offset;
          moveTo( lastX[k], lastY[k] );
          lastX[k] := x;
          lastY[k] := trunc( y );
          lineTo( x, lastY[k] );
        end;
      end;
    end;
  end;
end;

procedure TWaveShape.setBackgroundColor(const Value: TColor);
begin
  if color <> value then begin
    color := value;
    Invalidate;
  end;
end;

procedure TWaveShape.setFont(const Value: TFont);
begin
  canvas.font.assign( value );
  invalidate;
end;

procedure TWaveShape.setInterval(const Value: extended);
begin
  if fInterval <> value then begin
    fInterval := value;
    invalidate;
  end;
end;

procedure TWaveShape.setLineColor(const Value: TColor);
begin
  if fLineColor <> value then begin
    fLineColor := value;
    invalidate;
  end;
end;

procedure TWaveShape.setVolts(const Value: extended);
begin
  if fVolts <> value then begin
    fVolts := Value;
    Invalidate
  end;
end;

{ TWave }

procedure TWave.AssignTo(Dest: TPersistent);
begin
  if Dest = nil then
    Dest := TWave.Create;
  if Dest.ClassType <> TWave then
    inherited;
  with TWave( Dest ) do begin
    waveType := self.waveType;
    color := self.color;
    offset := self.offset;
    frequency := self.frequency;
    amplitude := self.amplitude;
    gain := self.gain;
  end;
end;

end.

