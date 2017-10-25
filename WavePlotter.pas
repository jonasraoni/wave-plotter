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
  PI2 = PI * 2;

type
  TWaveType = (wtSqr, wtPoly, wtSin);

  TWave = class(TPersistent)
  public
    waveType: TWaveType;
    color: TColor;
    offset: integer;
    frequency, amplitude, volts, interval, gain: extended;

procedure AssignTo(Dest: TPersistent); override;
  end;

  TWaveShape = class(TGraphicControl)
  protected
    fWaves: TList;
    fBoxSize: integer;
    fLineColor: TColor;

    function getWave(const index: integer): TWave;
    procedure setBoxSize(const Value: integer);

    function getBackgroundColor: TColor;
    procedure setBackgroundColor(const Value: TColor);
    procedure setLineColor(const Value: TColor);

  public
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;

    procedure clear;
    procedure delete(const index: integer);

    function add: integer;

    property waves[const index: integer]: TWave read GetWave;

  published
    procedure paint; override;
    property boxSize: integer read fBoxSize write setBoxSize;
    property backgroundColor: TColor read getBackgroundColor write setBackgroundColor;
    property lineColor: TColor read fLineColor write setLineColor;

    //inherited
    //property Canvas;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    //property Font;
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

implementation

function max(const a, b: integer): integer;
begin
  if a > b then
    result := a
  else
    result := b;
end;

{ TWaveShape }

function TWaveShape.add: integer;
begin
  result := fWaves.add(TWave.Create);
end;

procedure TWaveShape.clear;
begin
  while fWaves.count > 0 do begin
    TWave(fWaves[0]).free;
    fWaves.delete(0);
  end;
end;

constructor TWaveShape.create(AOwner: TComponent);
begin
  inherited;
  fWaves := TList.create;
  fLineColor := clGray;
  color := clBtnFace;
  fBoxSize := 50;
end;

procedure TWaveShape.delete(const index: integer);
begin
  if (index > -1) and (index < fWaves.count) then begin
    TWave(fWaves[index]).free;
    fWaves.delete(index);
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

function TWaveShape.getWave(const index: integer): TWave;
begin
  result := nil;
  if (index > -1) and (index < fWaves.count) then
    result := TWave(fWaves[ index ]);
end;

procedure TWaveShape.paint;
var
  k, x: integer;
  lastX, lastY: array of integer;
  y: extended;
begin
  if not enabled then
    exit;
  canvas.brush.color := color;
  canvas.fillRect(clientRect);

  setLength(lastY, fWaves.count);
  setLength(lastX, fWaves.count);
  for k := 0 to high(lastY) do begin
    lastY[k] := clientHeight div 2 + waves[k].offset;
    lastX[k] := 0;
  end;

  for x := 0 to max(clientWidth, clientHeight) do begin
    with canvas do begin
      pen.color := fLineColor;
      pen.width := 1;
      pen.style := psDot;

      if x mod fBoxSize = 0 then begin
        moveTo(0, x + trunc(frac(clientHeight / 2 / fBoxSize) * fBoxSize));
        lineTo(clientWidth, x + trunc(frac(clientHeight / 2 / fBoxSize) * fBoxSize));

        moveTo(x, 0);
        lineTo(x, clientHeight);
      end;

      for k := 0 to fWaves.count - 1 do begin
        with waves[k] do begin
          pen.color := color;
          pen.width := 1;
          pen.style := psSolid;

          y := pi*k + PI2 * x * interval / fBoxSize * frequency;

          case waveType of
            wtSin:
              y := sin(y);
            wtPoly: begin
              y := frac(y / PI2);
              if y <= 0.25 then
                y := y / 0.25
              else if y <= 0.75 then
                y := (-y + 0.5) / 0.25
              else
                y := (y - 1) / 0.25;
            end;
            wtSqr: begin
              if frac(y / PI2) <= 0.5 then
                y := 1
              else
                y := -1;
            end;
          end;
          y := (y * (fBoxSize / volts) * amplitude * gain) + clientHeight / 2 + offset;
          moveTo(lastX[k], lastY[k]);
          lastX[k] := x;
          lastY[k] := trunc(y);
          lineTo(x, lastY[k]);
        end;
      end;
    end;
  end;
end;

procedure TWaveShape.setBackgroundColor(const Value: TColor);
begin
  color := Value;
  Invalidate;
end;

procedure TWaveShape.setBoxSize(const Value: integer);
begin
  fBoxSize := Value;
  invalidate;
end;


procedure TWaveShape.setLineColor(const Value: TColor);
begin
  fLineColor := Value;
  Invalidate;
end;

{ TWave }

procedure TWave.AssignTo(Dest: TPersistent);
begin
  if Dest.ClassType <> TWave then
    inherited;
  with TWave(Dest) do begin
    waveType := self.waveType;
    color := self.color;
    offset := self.offset;
    frequency := self.frequency;
    amplitude := self.amplitude;
    volts := self.volts;
    interval := self.interval;
    gain := self.gain;
  end;
end;

end.
