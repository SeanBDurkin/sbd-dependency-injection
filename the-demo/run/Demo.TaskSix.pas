unit Demo.TaskSix;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Service discrimination by name')]
[Preface('Preface - to be developed.')]
[ToBeDeveloped]
TTaskSix = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation



procedure TTaskSix.Execute( Put: TLogLineProc);
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

