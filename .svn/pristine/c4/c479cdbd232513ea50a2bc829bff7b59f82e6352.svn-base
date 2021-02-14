unit CustomMessage;

interface

Uses
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Controls;

Type TTypeMessage = (Exclamation, Error, Question);
Type TButtons = (Ok, YesNo, YesNoCancel, YesNoOk);

Type TDescriptionButtons = Class
    Ok : String;
    Yes : String;
    No : String;
    Cancel : String;
    Constructor Create();
End;

Type TCustomMessage = Class Abstract
  Class Function Show(sMessage:String; sTitle:String; TypeMessage : TTypeMessage; Buttons : TButtons;
                                              DescriptionButtons : TDescriptionButtons = nil):Integer;
End;

implementation

{$Region 'TDescriptionButtons'}
Constructor TDescriptionButtons.Create();
Begin
  Inherited Create();
    Ok := 'Ok';
    Yes := 'Sim';
    No := 'Não';
    Cancel := 'Cancelar';
End;
{$EndRegion}

Class Function TCustomMessage.Show(sMessage:String; sTitle:String; TypeMessage : TTypeMessage; Buttons : TButtons;
                                              DescriptionButtons : TDescriptionButtons = nil):Integer;
Var
  Form : TForm;
  i : Integer;
  typeMessageAux : TMsgDlgType;
  ArrayButtons :TMsgDlgBtn;
Begin
  Result := 2; //Cancel
  case TypeMessage of
    TTypeMessage.Exclamation : typeMessageAux := mtInformation;
    TTypeMessage.Error : typeMessageAux := mtError;
    TTypeMessage.Question : typeMessageAux := mtConfirmation;
  end;

  case Buttons of
    TButtons.Ok : Form := createmessagedialog(sMessage, typeMessageAux, [MbOk]);
    TButtons.YesNo :Form := createmessagedialog(sMessage, typeMessageAux, [MbYes, MbNo]);
    TButtons.YesNoCancel :Form := createmessagedialog(sMessage, typeMessageAux, [MbYes, MbNo, MbCancel]);
    TButtons.YesNoOk :Form := createmessagedialog(sMessage, typeMessageAux, [MbYes, MbNo, MbOk]);
  end;

  if (DescriptionButtons = nil) then
    DescriptionButtons := TDescriptionButtons.Create();

  try
    for i:=0 to Form.componentCount -1 do
    Begin
      if Form.components[i] is TButton then
      Begin
        with Tbutton(Form.components[i]) do
        Begin
          case modalresult of
            mryes   : caption := DescriptionButtons.Yes;
            mrno    : caption := DescriptionButtons.No;
            mrok    : caption := DescriptionButtons.Ok;
            mrCancel: caption := DescriptionButtons.Cancel;
          end;
        End;
      End;
    End;
    Form.caption := sTitle;

    Result := Form.showmodal;

  finally
     Form.free;
  end;
End;

end.
