unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
    TToastLength = (LongToast, ShortToast);
    TfrmPrincipal = class(TForm)
    btnToastLong: TButton;
    btnToastShort: TButton;
    procedure btnToastLongClick(Sender: TObject);
    procedure btnToastShortClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

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

{$R *.fmx}

procedure TfrmPrincipal.btnToastLongClick(Sender: TObject);
  begin
    Toast ('Mensagem Longa', LongToast);
  end;

procedure TfrmPrincipal.btnToastShortClick(Sender: TObject);
  begin
    Toast ('Mensagem Curta', ShortToast);
  end;

end.
