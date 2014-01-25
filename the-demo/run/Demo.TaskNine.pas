unit Demo.TaskNine;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Cooperative Services in an IInterfaceList')]
[Preface('Preface - to be developed.')]
[ToBeDeveloped]
TTaskNine = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation



procedure TTaskNine.Execute( Put: TLogLineProc);
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
