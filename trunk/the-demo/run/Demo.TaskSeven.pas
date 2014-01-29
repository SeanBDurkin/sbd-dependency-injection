unit Demo.TaskSeven;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Service competition')]
[Preface('By default, multiple services registered in the same'#13#10 +
          'service file (Interface pointer type + config string)'#13#10 +
          'are competing against each other for acquisition by the client.'#13#10 +
         'Take a look at unit Demo.TaskSeven for example.'#13#10 +
         'Compare and constrast with unit Demo.TaskEight.')]
TTaskSeven = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation


type
IPerson = interface
 ['{CE27C70E-4FC1-476C-A852-FA1034A27953}']
    function Name: string;
    function Weight: double;
  end;

TSean = class ( TInterfacedObject, IPerson)
  private
    function Name: string;
    function Weight: double;
  public
    [configuration('corpus')] constructor CreatePerson;
  end;

TChris = class ( TInterfacedObject, IPerson)
  private
    function Name: string;
    function Weight: double;
  public
    [configuration('corpus')] constructor CreatePerson;
  end;

ITeam = interface
  ['{2CF59753-13A1-4AE0-B578-ACA8FB0A6768}']
    function TeamWeight: double;
  end;

TOneManBand = class( TInterfacedObject, ITeam)
  protected
    [injection('corpus')] FStaff: IPerson;
    function TeamWeight: double;
  public
    [configuration] constructor CreateTeam;
  end;

procedure TTaskSeven.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Person: IPerson;
  Team: ITeam;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( IPerson, TSean);
Provider.RegisterServiceClass( IPerson, TChris);
Provider.RegisterServiceClass( ITeam, TOneManBand);
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.

if Provider.Gn.Acquire<IPerson>( nil, Person, 'corpus') then
  Put( Format( '%s weighs %.2f Kg', [Person.Name, Person.Weight]));

if Provider.Gn.Acquire<ITeam>( nil, Team) then
   Put( Format( 'Or via dependency injection it is %.2f Kg', [Team.TeamWeight]));

Provider.ShutDown
end;




constructor TSean.CreatePerson;
begin
end;

function TSean.Name: string;
begin
result := 'Sean'
end;

function TSean.Weight: double;
begin
result := 77.0
end;


constructor TChris.CreatePerson;
begin
end;

function TChris.Name: string;
begin
result := 'Chris'
end;

function TChris.Weight: double;
begin
result := 102.0
end;


constructor TOneManBand.CreateTeam;
begin
end;

function TOneManBand.TeamWeight: double;
begin
result := FStaff.Weight
end;

end.
