unit Demo.Task;
interface
uses SBD.ServiceProvider;

const
  SDemoTasks = 'demo-tasks';

type

TLogLineProc = reference to procedure ( const Line: string);
ITask = interface
  ['{163B11C8-727B-439A-A7B1-E4FD7A513AAA}']
    function  Name: string;
    function  StaticPreface: string;
    procedure Execute( Put: TLogLineProc);
  end;

IisToBeDeveloped = interface
  ['{EDE78F2A-EE12-44B9-9428-2D41F9737720}']
  end;

Name = class( TCustomAttribute)
  public
    FText: string;
    constructor Create( AText: string);
  end;

Preface = class( TCustomAttribute)
  public
    FText: string;
    constructor Create( AText: string);
  end;

ToBeDeveloped = class( TCustomAttribute)
  end;

type
  /// <remarks> Use Supports( MyITask,IisToBeDeveloped) to test if it has been developed. </remarks>
TTask = class abstract( TInterfacedObject, ITask)
  protected
    function  Name: string;                      virtual;
    function  StaticPreface: string;             virtual;
    procedure Execute( Put: TLogLineProc);       virtual; abstract;
    function  QueryInterface( const IID: TGUID; out Obj): HResult; stdcall;
  public
    class procedure RegisterMe( const Tasks: IServiceProvider);
    [Configuration(SDemoTasks)] constructor ServiceModeCreate;  virtual;
  end;

implementation



uses Rtti, SysUtils;

constructor Name.Create(AText: string);
begin
FText := AText
end;


constructor Preface.Create(AText: string);
begin
FText := AText
end;


function TTask.Name: string;
var
  Ctx: TRttiContext;
  Att: TCustomAttribute;
begin
Ctx.Create;
for Att in Ctx.GetType( ClassType).GetAttributes do
  if Att is Demo.Task.Name then
    result := Demo.Task.Name( Att).FText;
Ctx.Free;
if result = '' then
  result := ClassName
end;

function TTask.QueryInterface( const IID: TGUID; out Obj): HResult;
var
  Ctx: TRttiContext;
  Att: TCustomAttribute;
begin
if isEqualGUID( IID, IisToBeDeveloped) then
    begin
    Ctx.Create;
    result := E_NOINTERFACE;
    for Att in Ctx.GetType( ClassType).GetAttributes do
      if Att is ToBeDeveloped then
        begin
        GetInterface( IInterface, Obj);
        result := 0;
        break
        end;
    Ctx.Free;
    end
  else
    result := inherited QueryInterface( IID, Obj)
end;

class procedure TTask.RegisterMe( const Tasks: IServiceProvider);
begin
Tasks.RegisterServiceClass( ITask, self)
end;

constructor TTask.ServiceModeCreate;
begin
end;

function TTask.StaticPreface: string;
var
  Ctx: TRttiContext;
  Att: TCustomAttribute;
begin
Ctx.Create;
for Att in Ctx.GetType( ClassType).GetAttributes do
  if Att is Demo.Task.Preface then
    result := Demo.Task.Preface( Att).FText;
Ctx.Free
end;

end.
