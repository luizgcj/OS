unit MaisVSLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 01/11/2013 09:18:13 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Projetos_Ariel\Teste_OnlineSites\maisvslib.tlb (1)
// LIBID: {C1D752AE-1589-3F3C-947C-71A423527517}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
// Errors:
//   Error creating palette bitmap of (TCript) : Server mscoree.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MaisVSLibMajorVersion = 1;
  MaisVSLibMinorVersion = 0;

  LIBID_MaisVSLib: TGUID = '{C1D752AE-1589-3F3C-947C-71A423527517}';

  IID_ICriptInterface: TGUID = '{AE517BC6-71C1-3BC9-82F2-AAF045246641}';
  CLASS_Cript: TGUID = '{8995C0D1-8FC1-30FC-8DCF-525C835901FB}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICriptInterface = interface;
  ICriptInterfaceDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Cript = ICriptInterface;


// *********************************************************************//
// Interface: ICriptInterface
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AE517BC6-71C1-3BC9-82F2-AAF045246641}
// *********************************************************************//
  ICriptInterface = interface(IDispatch)
    ['{AE517BC6-71C1-3BC9-82F2-AAF045246641}']
    function CreateSalt(initialValue: Integer; finalValue: Integer): WideString; safecall;
    function Password(const senha: WideString; const salt: WideString): WideString; safecall;
    function CriarChave(tamanho: Integer): WideString; safecall;
    function Criptografar(const valor: WideString): WideString; safecall;
    function Criptografar_2(const valor: WideString; const chave: WideString): WideString; safecall;
    function Descriptografar(const valor: WideString): WideString; safecall;
    function Descriptografar_2(const valor: WideString; const chave: WideString): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  ICriptInterfaceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AE517BC6-71C1-3BC9-82F2-AAF045246641}
// *********************************************************************//
  ICriptInterfaceDisp = dispinterface
    ['{AE517BC6-71C1-3BC9-82F2-AAF045246641}']
    function CreateSalt(initialValue: Integer; finalValue: Integer): WideString; dispid 1610743808;
    function Password(const senha: WideString; const salt: WideString): WideString; dispid 1610743809;
    function CriarChave(tamanho: Integer): WideString; dispid 1610743810;
    function Criptografar(const valor: WideString): WideString; dispid 1610743811;
    function Criptografar_2(const valor: WideString; const chave: WideString): WideString; dispid 1610743812;
    function Descriptografar(const valor: WideString): WideString; dispid 1610743813;
    function Descriptografar_2(const valor: WideString; const chave: WideString): WideString; dispid 1610743814;
  end;

// *********************************************************************//
// The Class CoCript provides a Create and CreateRemote method to          
// create instances of the default interface ICriptInterface exposed by              
// the CoClass Cript. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCript = class
    class function Create: ICriptInterface;
    class function CreateRemote(const MachineName: string): ICriptInterface;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCript
// Help String      : 
// Default Interface: ICriptInterface
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCriptProperties= class;
{$ENDIF}
  TCript = class(TOleServer)
  private
    FIntf:        ICriptInterface;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCriptProperties;
    function      GetServerProperties: TCriptProperties;
{$ENDIF}
    function      GetDefaultInterface: ICriptInterface;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ICriptInterface);
    procedure Disconnect; override;
    function CreateSalt(initialValue: Integer; finalValue: Integer): WideString;
    function Password(const senha: WideString; const salt: WideString): WideString;
    function CriarChave(tamanho: Integer): WideString;
    function Criptografar(const valor: WideString): WideString;
    function Criptografar_2(const valor: WideString; const chave: WideString): WideString;
    function Descriptografar(const valor: WideString): WideString;
    function Descriptografar_2(const valor: WideString; const chave: WideString): WideString;
    property DefaultInterface: ICriptInterface read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCriptProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCript
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCriptProperties = class(TPersistent)
  private
    FServer:    TCript;
    function    GetDefaultInterface: ICriptInterface;
    constructor Create(AServer: TCript);
  protected
  public
    property DefaultInterface: ICriptInterface read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoCript.Create: ICriptInterface;
begin
  Result := CreateComObject(CLASS_Cript) as ICriptInterface;
end;

class function CoCript.CreateRemote(const MachineName: string): ICriptInterface;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Cript) as ICriptInterface;
end;

procedure TCript.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8995C0D1-8FC1-30FC-8DCF-525C835901FB}';
    IntfIID:   '{AE517BC6-71C1-3BC9-82F2-AAF045246641}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCript.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ICriptInterface;
  end;
end;

procedure TCript.ConnectTo(svrIntf: ICriptInterface);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCript.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCript.GetDefaultInterface: ICriptInterface;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCriptProperties.Create(Self);
{$ENDIF}
end;

destructor TCript.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCript.GetServerProperties: TCriptProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TCript.CreateSalt(initialValue: Integer; finalValue: Integer): WideString;
begin
  Result := DefaultInterface.CreateSalt(initialValue, finalValue);
end;

function TCript.Password(const senha: WideString; const salt: WideString): WideString;
begin
  Result := DefaultInterface.Password(senha, salt);
end;

function TCript.CriarChave(tamanho: Integer): WideString;
begin
  Result := DefaultInterface.CriarChave(tamanho);
end;

function TCript.Criptografar(const valor: WideString): WideString;
begin
  Result := DefaultInterface.Criptografar(valor);
end;

function TCript.Criptografar_2(const valor: WideString; const chave: WideString): WideString;
begin
  Result := DefaultInterface.Criptografar_2(valor, chave);
end;

function TCript.Descriptografar(const valor: WideString): WideString;
begin
  Result := DefaultInterface.Descriptografar(valor);
end;

function TCript.Descriptografar_2(const valor: WideString; const chave: WideString): WideString;
begin
  Result := DefaultInterface.Descriptografar_2(valor, chave);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCriptProperties.Create(AServer: TCript);
begin
  inherited Create;
  FServer := AServer;
end;

function TCriptProperties.GetDefaultInterface: ICriptInterface;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCript]);
end;

end.
