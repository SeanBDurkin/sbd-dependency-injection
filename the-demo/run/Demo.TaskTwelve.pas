unit Demo.TaskTwelve;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Deregistration')]
[Preface('Preface - to be developed.')]
[ToBeDeveloped]
TTaskTwelve = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation



procedure TTaskTwelve.Execute( Put: TLogLineProc);
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
