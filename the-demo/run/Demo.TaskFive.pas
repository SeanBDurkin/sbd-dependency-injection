unit Demo.TaskFive;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Service discrimination by cookie')]
[Preface('When we register a service we get an integer token for each service'#13#10 +
         'This token can then be used to discriminate between multiple competing'#13#10 +
         'implementations of a service using the ActiveArrayMemberCookie property.'#13#10 +
         'Take a look at unit Demo.TaskFive for example.')]
TTaskFive = class sealed( TTask)
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
  public
    [configuration] constructor CreatePerson;
  end;

TSean = class sealed( TPerson)
  protected
    function Name: string;       override;
  end;

TChris = class sealed( TPerson)
  protected
    function Name: string;       override;
  end;

procedure TTaskFive.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Person: IPerson;
 {$if CompilerVersion < 22}
    TokenForChris: integer;
  {$else}
    TokenForChris: TIntegers;
  {$ifend}

begin
Provider := StandardServiceProvider;
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
Provider.RegisterServiceClass( IPerson, TSean);
TokenForChris := Provider.RegisterServiceClass( IPerson, TChris);
// In Delphi 2010, RegisterServiceClass returns an integer token for the first service registered.
// In late compilers, it returns an array of integer tokens, one for each service registered.

Provider.ActiveArrayMemberCookie[ IPerson, ''] :=
 {$if CompilerVersion < 22}
    TokenForChris;
  {$else}
    TokenForChris[0];
  {$ifend}
 // ^ Having remembered the cookie, this is how we can discriminate between multiple solutions
 //    by cookie.
if Provider.Gn.Acquire<IPerson>( nil, Person) then
  Put( Format( 'Of Sean and Chris, %s was selected', [Person.Name]));
Provider.ShutDown
end;




constructor TPerson.CreatePerson;
begin
end;


function TSean.Name: string;
begin
result := 'Sean'
end;


function TChris.Name: string;
begin
result := 'Chris'
end;

end.
