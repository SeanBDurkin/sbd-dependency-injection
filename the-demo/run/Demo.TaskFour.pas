unit Demo.TaskFour;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Same class, multiple configurations of service')]
[Preface('It is easy to register a service class that services multiple configurations.'#13#10 +
         'Use the [configuration] attribute on a constructor with one string parameter'#13#10 +
         'The [configuration] attribute takes as a parameter a comma-seperated'#13#10 +
         'list of config strings.'#13#10 +
         'Take a look at unit Demo.TaskFour for example.')]
TTaskFour = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation

type
INamedThing = interface
  ['{F883ED5E-45CA-4446-B076-C9B9C840D336}']
    function Name: string;
  end;

TPerson = class( TInterfacedObject, INamedThing)
  private
    FName: string;
    function Name: string;
  public
    [configuration('Sean,Chris')] constructor CreatePerson( const Config: string);
  end;


procedure TTaskFour.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Person: INamedThing;
begin
Provider := StandardServiceProvider;
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
Provider.RegisterServiceClass( INamedThing, TPerson);
if Provider.Gn.Acquire<INamedThing>( nil, Person, 'Chris') then
  Put( Format( 'There were two people registered. The Chris service said his name was %s.', [Person.Name]));
Provider.ShutDown
end;



{ TPerson }

constructor TPerson.CreatePerson(const Config: string);
begin
FName := Config
end;

function TPerson.Name: string;
begin
result := FName
end;

end.
