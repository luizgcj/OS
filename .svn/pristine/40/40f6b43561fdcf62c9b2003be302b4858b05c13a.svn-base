unit Log;

interface
Uses
  Vcl.Forms,
  System.StrUtils,
  Windows,
  System.Classes,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  Usuario;

Type TLog = Class
  Private
    Class Function TamArquivo(Arquivo: string): Integer;
    Class Procedure AbrirLogGerencial(var ArqLogGerencial :TextFile);
    Class Procedure FecharLogGerencial(var ArqLogGerencial :TextFile);
    Class Procedure ImprimirLogGerencial(sTextoLog:string; var ArqLogGerencial :TextFile);
  Public
    Class var Usuario : TUsuario;
    Class var CodigoEmpresa : Integer;
    Class Procedure Write(Mensagem : String);


End;

implementation

Class Procedure TLog.Write(Mensagem : String);
var
  nText:String;
  ArqLogGerencial :TextFile;
begin
  Try
    TLog.AbrirLogGerencial(ArqLogGerencial);
    TLog.ImprimirLogGerencial(mensagem, ArqLogGerencial);
    TLog.FecharLogGerencial(ArqLogGerencial);
  except
  end;
End;

{$Region 'Private'}

Class Function TLog.TamArquivo(Arquivo: string): Integer;
Begin
  with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
   Try
     Result := Size;
   Finally
     Free;
   End;
End;

Class Procedure TLog.AbrirLogGerencial(var ArqLogGerencial :TextFile);
var
  nNomeArq:String;
  nDiretorio:String;
begin
  nDiretorio := ExtractFileDrive(Application.ExeName)+ '\SGE32\Log\';
  nNomeArq:= nDiretorio + 'Gerencial' + FormatFloat('000',StrToFloat(IntToSTr(TLog.CodigoEmpresa)))+'.log';
  try
    If Not DirectoryExists(Trim(nDiretorio)) Then
       CreateDir(Trim(nDiretorio));
  except
    Application.MessageBox('Não foi possíve criar o caminho de Log.','Atenção',Mb_IconExclamation);
  end;
  Try
    if FileExists(nNomeArq) then
    begin
      if TamArquivo(nNomeArq)>=5000000 then//5MBytes
      begin
        CopyFile(Pchar(nNomeArq),Pchar(nDiretorio+'Gerencial'+ FormatFloat('000',StrToFloat(IntToSTr(TLog.CodigoEmpresa)))+ '_' + FormatDateTime('ddmmyyyy',Date)+ '_'+ FormatDateTime('hhmmss',Time)+'.log'),True);
        DeleteFile(nNomeArq);
      end;
    end;
  except
  end;

  Assignfile(ArqLogGerencial,nNomeArq);
  if FileExists(nNomeArq) then
    Append(ArqLogGerencial)
  else
    Rewrite(ArqLogGerencial);
end;

Class Procedure TLog.FecharLogGerencial(var ArqLogGerencial :TextFile);
begin
   CloseFile(ArqLogGerencial);
end;

Class Procedure TLog.ImprimirLogGerencial(sTextoLog : string; var ArqLogGerencial : TextFile);
var sText:String;
begin
  sText:= FormatDateTime('dd/mm/yyyy', Date) + ' - ' + FormatDateTime('hh:mm:ss', Time) + '- OP: ' + TLog.Usuario.Nome + '->' + UpperCase(sTextoLog);
  Writeln(ArqLogGerencial,UpperCase(sText));
end;

{$EndRegion}



end.
