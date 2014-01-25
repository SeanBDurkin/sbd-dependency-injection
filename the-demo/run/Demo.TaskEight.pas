unit Demo.TaskEight;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Cooperative Services')]
[Preface('Preface - to be developed.')]
[ToBeDeveloped]
TTaskEight = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation



procedure TTaskEight.Execute( Put: TLogLineProc);
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
