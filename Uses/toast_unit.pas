unit toast_unit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TToastLength = (LongToast, ShortToast);

type
    TForm1 = class(TForm)
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{$IFDEF ANDROID}
uses
  Androidapi.JNI.Toasts,
  Androidapi.Helpers,
  FMX.Helpers.Android;

  procedure Toast(const Msg: string; duration: TToastLength);
  var
    ToastLength: Integer;
  begin
    if duration = ShortToast then
      ToastLength := TJToast.JavaClass.LENGTH_SHORT
    else
      ToastLength := TJToast.JavaClass.LENGTH_LONG;

    CallInUiThread (
      procedure
      begin
        TJToast.JavaClass.makeText (SharedActivityContext,StrToJCharSequence(Msg), ToastLength).show
      end
    );
  end;
{$ENDIF}
end.