unit Demo.TaskSix;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Service discrimination by name')]
[Preface('When we register a service we specify a string id for this particular solution.'#13#10 +
         'using the [configuration] attribute with parameter in format ''Id=Something'''#13#10 +
         'This id can then be used to discriminate between multiple competing'#13#10 +
         'implementations of a service using the ActiveArrayMemberName property.'#13#10 +
         'Take a look at unit Demo.TaskSix for example.')]
TTaskSix = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation


type
IPerson = interface
  ['{348F5700-660C-4495-93F7-65D0DF902F31}']
    function Name: string;
  end;

TPerson = class abstract( TInterfacedObject, IPerson)
  protected
    function Name: string;       virtual; abstract;
  end;

TSean = class sealed( TPerson)
  protected
    function Name: string;       override;
  public
    [configuration] constructor CreatePerson;
  end;

TChris = class sealed( TPerson)
  protected
    function Name: string;       override;
  public
    [configuration('Id=ThisOne')] constructor CreatePerson;
  end;


procedure TTaskSix.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Person: IPerson;
begin
Provider := StandardServiceProvider;
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
Provider.RegisterServiceClass( IPerson, TSean);
Provider.RegisterServiceClass( IPerson, TChris);
// In Delphi 2010, RegisterServiceClass returns an integer token for the first service registered.
// In late compilers, it returns an array of integer tokens, one for each service registered.

Provider.ActiveArrayMemberName[ IPerson, ''] := 'ThisOne';
if Provider.Gn.Acquire<IPerson>( nil, Person) then
  Put( Format( 'Of Sean and Chris, %s was selected', [Person.Name]));
Provider.ShutDown
end;


constructor TSean.CreatePerson;
begin
end;

function TSean.Name: string;
begin
result := 'Sean'
end;


constructor TChris.CreatePerson;
begin
end;

function TChris.Name: string;
begin
result := 'Chris'
end;
end.

