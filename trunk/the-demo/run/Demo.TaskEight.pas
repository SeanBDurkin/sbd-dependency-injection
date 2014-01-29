unit Demo.TaskEight;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type
[Name('Cooperative Services')]
[Preface('Multiple services registered in the same'#13#10 +
          'service file (Interface pointer type + config string)'#13#10 +
          'can be registered as co-operating with each other in a gang.'#13#10 +
          'The user acquires a collection of them, not just one.'#13#10 +
          'At registration time, the service-writer has control over the collection class.'#13#10 +
         'Take a look at unit Demo.TaskEight for example.'#13#10 +
         'Compare and constrast with unit Demo.TaskSeven.')]
TTaskEight = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation


uses Generics.Collections;
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

RPersonCursor = record
    FIdx: integer;
    FList: TList<IPerson>;
    function MoveNext: boolean;
    function GetCurrent: IPerson;
    property Current: IPerson read GetCurrent;
  end;

IPeople = interface
  ['{9BB474F8-377A-4CC9-BFAD-99769CF29544}']
    function GetEnumerator: RPersonCursor;
  end;

IPersonAdder = interface
  ['{7772017A-291A-4432-8B84-500BEDD820B9}']
    procedure Add( const Addend: IPerson);
  end;

TPeople = class( TInterfacedObject, IPeople, IPersonAdder)
  private
    FList: TList<IPerson>;
    function  GetEnumerator: RPersonCursor;
    procedure Add( const Addend: IPerson);
  public
    constructor Create;
    destructor Destroy; override;
  end;

ITeam = interface
  ['{2CF59753-13A1-4AE0-B578-ACA8FB0A6768}']
    function TeamWeight: double;
  end;

TTeam = class( TInterfacedObject, ITeam)
  protected
    [injection('corpus')] [Collection('Demo.TaskEight.IPeople')]
      FStaff: IPeople;
    function TeamWeight: double;
  public
    [configuration] constructor CreateTeam;
  end;

procedure TTaskEight.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  People: IPeople;
  Person: IPerson;
  Sum: double;
  Team: ITeam;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( IPerson, TSean);
Provider.RegisterServiceClass( IPerson, TChris);
Provider.SetCooperativeAffinity( IPerson, 'Demo.TaskEight.IPeople', 'corpus',
  function( const Config: string): IInterface
    begin
    result := IInterface( TPeople.Create as IPeople)
    end,
  procedure( const Collection, Addend: IInterface)
    begin
    (Collection as IPersonAdder).Add( Addend as IPerson)
    end);
Provider.RegisterServiceClass( ITeam, TTeam);


// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.

Sum := 0.0;
if Provider.Acquire( IPerson, nil, People, 'corpus') then
  for Person in People do
    Sum := Sum + Person.Weight;
 Put( Format( 'The combined weight of registered IPeople services is %.2f Kg', [Sum]));

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


function RPersonCursor.GetCurrent: IPerson;
begin
result := FList[ FIdx]
end;

function RPersonCursor.MoveNext: boolean;
begin
result := FIdx <= (FList.Count - 2);
if result then
  Inc( FIdx)
end;


constructor TPeople.Create;
begin
FList := TList<IPerson>.Create
end;

destructor TPeople.Destroy;
begin
FList.Free;
inherited
end;

procedure TPeople.Add( const Addend: IPerson);
begin
FList.Add( Addend)
end;


function TPeople.GetEnumerator: RPersonCursor;
begin
result.FIdx := -1;
result.FList := FList
end;


constructor TTeam.CreateTeam;
begin
end;

function TTeam.TeamWeight: double;
var
  StaffMember: IPerson;
begin
result := 0.0;
for StaffMember in FStaff do
  result := result + StaffMember.Weight
end;

end.
