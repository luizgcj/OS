unit CustomExcept;

interface

Uses
  System.SysUtils,
  CustomMessage,
  Log;

Type TCustomExcept = Class
  Private

  Public
    Class Procedure Show(e : Exception; Mensagem : String; ExibeMensage : Boolean = True);
    Class Procedure Generic(Sender : TObject; E : Exception);
End;

implementation

Class Procedure TCustomExcept.Show(e : Exception; Mensagem : String; ExibeMensage : Boolean = True);
Begin
  if ExibeMensage then
    TCustomMessage.Show(Mensagem, 'Erro', TTypeMessage.Error, TButtons.Ok);
  TLog.Write(Mensagem + ' Erro : '+ e.Message);
End;

Class Procedure TCustomExcept.Generic(Sender : TObject; E : Exception);
Begin
  TCustomExcept.Show(e, 'Erro desconhecido.'+chr(13)+' Contate o suporte.');
End;

end.
