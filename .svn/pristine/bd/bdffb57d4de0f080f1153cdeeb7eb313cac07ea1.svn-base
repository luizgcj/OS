unit cxGridExtentions;

interface

Uses
  Vcl.Controls,
  Data.Db,
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Math,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Winapi.Windows,
  cxGridDBTableView,
  Empresa;

Type TcxGridExtentions = Class abstract
  Private
    Class function Replicate( Caracter:String; Quant:Integer ): String;
    Class function ColorToHtml(mColor: TColor): string;
    Class function StrToHtml(mStr: string; mTam : integer; mFont: TFont = nil): string;
  Public
    Class Function cxGridToHtml(mDBGrid: TcxGridDbTableView; Logo : Boolean;  mIMG: String; Empresa : TEmpresa; mTitulo, mCaption, NomeRel,mTotalizar, mNomeArqFiltro : string;vCont:Boolean=False):Boolean;
End;

implementation

Class Function TcxGridExtentions.cxGridToHtml(mDBGrid: TcxGridDbTableView; Logo : Boolean ; mIMG: String; Empresa : TEmpresa; mTitulo, mCaption, NomeRel,mTotalizar, mNomeArqFiltro : string;vCont:Boolean=False):Boolean;
const cAlignText : array[TAlignment] of string = ('LEFT', 'RIGHT', 'CENTER');
var vColFormat, vColText,  NomeCampo, TotalColuna, LinFiltro : String;
    vAllWidth, I, J, K, Tam                                 : Integer;
    vWidths                                                 : array of Integer;
    DisplayText                                             : String[30];
    SomaColuna                                              : Real;
    ArqFiltro, Arq                                          : TextFile;
    vBookmark : TBookMark;
    formato : string;

begin

  Result := false;

  AssignFile(Arq,'\SGE32\Relatorios\'+ NomeRel +'.htm');
  Rewrite(Arq);

  if not Assigned(mDBGrid) then
    Exit;
  if not Assigned(mDBGrid.DataController.DataSource) then
    Exit;
  if not Assigned(mDBGrid.DataController.DataSource.DataSet) then
    Exit;
  if not mDBGrid.DataController.DataSource.DataSet.Active then
    Exit;

  vBookmark := mDBGrid.DataController.DataSource.DataSet.Bookmark;
  mDBGrid.DataController.DataSource.DataSet.DisableControls;
  mDBGrid.DataController.DataSource.DataSet.First();

  Try
    J         := 100;
    vAllWidth := 0;

    for I := 0 to mDBGrid.ColumnCount - 1 do
    if mDBGrid.Columns[I].Visible then
    begin
      Inc(J);
      SetLength(vWidths, J);

      vWidths[J - 1] := mDBGrid.Columns[I].Width;
      Inc(vAllWidth, mDBGrid.Columns[I].Width);
    end;

    if (J <= 0) then
      Exit;
    if (vAllWidth <= 780) then
      Tam := 0
    else
      Tam := Round(vAllWidth / 8);

    Writeln(Arq,'<TITLE>'+ mTitulo +'</TITLE>');

    if (Logo) and (FileExists(mIMG)= true) then
      Writeln(Arq,'<P ALIGN="CENTER"><IMG SRC='+ mIMG +'></P>');

    Writeln(Arq,'<FONT FACE="VERDANA" COLOR=#0000FF SIZE=5><B><I><P ALIGN="CENTER">'+ Empresa.Nome +'</FONT></B></I></P>');

    if mCaption <> '' then
      Writeln(Arq,'<FONT FACE="VERDANA" COLOR=#000000 SIZE=3><B><I><P ALIGN="CENTER">'+ mCaption +'</FONT></B></I></P>');

    Writeln(Arq,'<TABLE BGCOLOR=#000000 ALIGN="CENTER" CELLSPACING=1 WIDTH=0%>'); // Leandro - 15/04/08
    vColFormat := '';
    vColText   := '';
    vColFormat := '<TR>'#13#10;
    vColText   := '<TR>'#13#10;
    J          := 0;

    For I := 0 to mDBGrid.ColumnCount - 1 Do
    Begin
      If mDBGrid.Columns[I].Visible then
      Begin
       vColFormat := vColFormat + Format('<TD BGCOLOR=#FFFFFF ALIGN=%s WIDTH="%d%%">DisplayText%d</TD>',[cAlignText[mDBGrid.Columns[I].FooterAlignmentHorz],Round(vWidths[J]),J]);
       vColText   := vColText   + Format('<TD BGCOLOR="%s" ALIGN=LEFT WIDTH="%d%%">%s</TD>',[ColorToHtml(clInfoBk),Round(vWidths[J]), StrToHtml(mDBGrid.Columns[I].Caption,1)]);
       Inc(J);
      End;
    End;

    vColFormat := vColFormat + '</TR>';
    vColText   := vColText + '</TR>';
    Writeln(Arq,vColText);

    for K := 0 to mDBGrid.ViewData.RowCount -1 do
    begin
      vColText := vColFormat;
      J := 0;

      for I := 0 to mDBGrid.ColumnCount - 1 do
      begin
        if mDBGrid.Columns[I].Visible then
        begin
          if mDBGrid.ViewData.Rows[K].Values[I] = null then
            formato := ''
          else if mDBGrid.Columns[I].DataBinding.ValueType = 'Float' then
            formato := FormatFloat('#,##0.00',mDBGrid.ViewData.Rows[K].Values[I])
          else if mDBGrid.Columns[I].DataBinding.ValueType = 'Integer' then
            formato := intToStr(mDBGrid.ViewData.Rows[K].Values[I])
          else
            formato := mDBGrid.ViewData.Rows[K].Values[I];

          vColText    := StringReplace(vColText, Format('>DisplayText%d<',[J]),Format('>%s<',[StrToHtml(Copy(Trim(formato),1,Trunc(RoundTo(mDBGrid.Columns[I].Width/8,0))),2)]),[rfReplaceAll]); // Leandro - 15/04/08
          Inc(J);
        end;
      end;
      Writeln(Arq,vColText);
      mDBGrid.DataController.DataSource.DataSet.Next;
    end;

    vColText := '';

    if mTotalizar='S' then
    begin
      for I := 0 to mDBGrid.ColumnCount - 1 do
      begin
        if mDBGrid.Columns[I].Visible then
        begin
          if mDBGrid.Columns[I].DataBinding.ValueType = 'Float' then
          begin
            NomeCampo := mDBGrid.Columns[I].DataBinding.FieldName;

            SomaColuna  := 0.00;
            TotalColuna := '';

            for K := 0 to mDBGrid.ViewData.RowCount -1 do
            begin
              if mDBGrid.ViewData.Rows[K].Values[I] = Null then
               SomaColuna := SomaColuna + 0
              else
                SomaColuna := SomaColuna + mDBGrid.ViewData.Rows[K].Values[I];
            end;
            TotalColuna := FormatFloat('#,##0.00',SomaColuna);
          end;

          vColText := vColText + Format('<TD BGCOLOR="%s" ALIGN=RIGHT HEIGHT="15" WIDTH="%d%%"><FONT FACE="VERDANA" SIZE="1"><B>'+ TotalColuna +'</B></FONT></TD>',[ColorToHtml(clInfoBk),Round(vWidths[J])]);
          TotalColuna := '';
          Inc(J);
        end;
      end;
      Writeln(Arq,vColText);
    end;

    Writeln(Arq,'</TABLE><BR>');
    If FileExists(mNomeArqFiltro) Then
    Begin
      AssignFile(ArqFiltro,mNomeArqFiltro);
      Reset(ArqFiltro);
      Write(Arq,'<FONT FACE="VERDANA" SIZE=1><P ALIGN="CENTER" >Filtros: ');
      while not Eof(ArqFiltro) do
      Begin
        ReadLn(ArqFiltro,LinFiltro);
        WriteLn(Arq,'<FONT FACE="VERDANA" SIZE=1><P ALIGN="CENTER" >'+ Replicate(' ',9) + LinFiltro);
      End;
      CloseFile(ArqFiltro);
    End
    Else
      WriteLn(Arq,'');

    Writeln(Arq,'</TABLE><BR>');
    FormatSettings.ShortDateFormat := ('dddd, dd" de "mmmm" de "yyyy');
    Writeln(Arq,'<FONT FACE="VERDANA" SIZE=1><P ALIGN="CENTER" >Total de Registros: '+ IntToStr(mDBGrid.ViewData.RowCount) +'</FONT></P>');
    Writeln(Arq,'<FONT FACE="VERDANA" SIZE=1><P ALIGN="CENTER" >Atualizado em: '+ Empresa.Cidade +', '+ DateToStr(Date) +' às '+ TimeToStr(Time) +'</FONT></P>');
    Writeln(Arq,'<FONT FACE="VERDANA" SIZE=1><P ALIGN="CENTER" >Relatório gerado pelo sistema SGE32, Mais Soluções© - <A HREF=http://www.maissolucoes.com>www.maissolucoes.com</A></FONT></P>');

    CloseFile(Arq);
    FormatSettings.ShortDateFormat := ('dd/mm/yyyy');
  finally
    mDBGrid.DataController.DataSource.DataSet.Bookmark := vBookmark;
    mDBGrid.DataController.DataSource.DataSet.EnableControls;
    vWidths := nil;
  end;
  Result := true;
end;

Class function TcxGridExtentions.ColorToHtml(mColor: TColor): string;
begin
  mColor := ColorToRGB(mColor);
  Result := Format('#%.2x%.2x%.2x',[GetRValue(mColor), GetGValue(mColor), GetBValue(mColor)]);
end;

Class function TcxGridExtentions.StrToHtml(mStr: string; mTam : integer; mFont: TFont = nil): string;
var  vLeft, vRight: string;
begin
  Result := mStr;
  Result := StringReplace(Result, '&', '&AMP;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&LT;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&GT;', [rfReplaceAll]);

  if not Assigned(mFont) then
    Exit;

  vLeft  := Format('<FONT FACE=''%s'' COLOR=''%s'' SIZE=''%d''>',[mFont.Name, ColorToHtml(mFont.Color), mTam]);
  vRight := '</FONT>';

  if fsBold in mFont.Style then
  begin
    vLeft := vLeft + '<B>';
    vRight := '</B>' + vRight;
  end;

  if fsItalic in mFont.Style then
  begin
    vLeft := vLeft + '<I>';
    vRight := '</I>' + vRight;
  end;

  if fsUnderline in mFont.Style then
  begin
    vLeft := vLeft + '<U>';
    vRight := '</U>' + vRight;
  end;

  if fsStrikeOut in mFont.Style then
  begin
    vLeft := vLeft + '<S>';
    vRight := '</S>' + vRight;
  end;

  Result := vLeft + Result + vRight;
end;

Class function TcxGridExtentions.Replicate( Caracter:String; Quant:Integer ): String;
{Repete o mesmo caractere várias vezes}
var I : Integer;
begin
Result := '';
  for I := 1 to Quant do
  Result := Result + Caracter;
end;

end.
