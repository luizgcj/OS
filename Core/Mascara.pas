unit Mascara;

interface

Uses
  System.SysUtils, Vcl.Mask, FuncoesGerais;

Type TMascara = Class Abstract
  Private

  Public

  {$Region 'Telefone'}
  Class Function AplicaTelefone(Value:String):String;
  Class Function RetiraTelefone(Value:String):String;
  {$EndRegion}

  {$Region 'CpfCnpj'}
  Class Function AplicaCpfCnpj(Value:String):String;
  Class Function RetiraCpfCnpj(Value:String):String;
  {$EndRegion}

  {$Region 'Cep'}
  Class Function AplicaCep(Value:String):String;
  Class Function RetiraCep(Value:String):String;
  {$EndRegion}

  {$Region 'Decimais'}
  Class Function GetDisplayDecimais(DecimaisTotal : Integer; DecimaisNaoObrigatorios : integer = 0):String;
  {$EndRegion}

End;

implementation


{$Region 'Telefone'}
Class Function TMascara.AplicaTelefone(Value:String):String;
Var
  edit : TMaskedit;
  iTamanho : Integer;
  mascara : String;
Begin
  Value := Trim(Value);
  iTamanho := Length(Value);

  case iTamanho of
    11 : mascara := '!\(##\) #####\-####;0; ';
    10 : mascara := '!\(##\) ####\-####;0; ';
    9  : mascara := '!\(##\) #####\-####;0; ';
    8  : mascara := '!\(##\) ####\-####;0; ';
  end;

  edit := TMaskedit.Create(nil);
  edit.EditMask := mascara;
  edit.Text := Value;

  Result := Edit.EditText;
End;

Class Function TMascara.RetiraTelefone(Value:String):String;
begin
  Result := TFuncoesGerais.ApenasNumeros(Value);
end;

{$EndRegion}

{$Region 'Cpf_Cnpj'}
Class Function TMascara.AplicaCpfCnpj(Value:String):String;
Var
  edit : TMaskedit;
  iTamanho : Integer;
  mascara : String;
Begin
  Value := Trim(Value);
  iTamanho := Length(Value);

  case iTamanho of
    14 : mascara := '##\.###\.###\/####\-##;0; ';
    11 : mascara := '###\.###\.###\-##;0; ';
  end;

  edit := TMaskedit.Create(nil);
  edit.EditMask := mascara;
  edit.Text := Value;

  Result := Edit.EditText;
End;

Class Function TMascara.RetiraCpfCnpj(Value:String):String;
begin
  Result := TFuncoesGerais.ApenasNumeros(Value);
end;
{$EndRegion}

{$Region 'Cep'}
Class Function TMascara.AplicaCep(Value:String):String;
Var
  edit : TMaskedit;
Begin
  Value := Trim(Value);

  edit := TMaskedit.Create(nil);
  edit.EditMask := '#####\-###;0; ';
  edit.Text := Value;

  Result := Edit.EditText;
End;

Class Function TMascara.RetiraCep(Value:String):String;
begin
  Result := TFuncoesGerais.ApenasNumeros(Value);
end;
{$EndRegion}

{$Region 'Decimais'}
Class Function TMascara.GetDisplayDecimais(DecimaisTotal : Integer; DecimaisNaoObrigatorios : integer = 0):String;
Var
  sDecimais : String;
  I: Integer;
Begin
  if DecimaisTotal > 0 then
  begin
    for I := 1 to (DecimaisTotal) do
    Begin
      if (I > (DecimaisTotal - DecimaisNaoObrigatorios)) then
        sDecimais := sDecimais + '#'
      else
        sDecimais := sDecimais + '0';
    End;
    sDecimais := '.'+ sDecimais;
  end;
  Result := '###,###,###,##0' + sDecimais;
End;
{$EndRegion}

end.
