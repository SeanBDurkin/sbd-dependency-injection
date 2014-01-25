unit Demo.TaskFourteen;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('No singletons')]
[Preface('Preface - to be developed.')]
[ToBeDeveloped]
TTaskFourteen = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation



procedure TTaskFourteen.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
begin
Provider := StandardServiceProvider;
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.

Provider.ShutDown
end;
end.
