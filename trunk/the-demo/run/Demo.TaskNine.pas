unit Demo.TaskNine;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Cooperative Services in an IInterfaceList')]
[Preface('Want cooperative services, but are too lazy to write the.'#13#10 +
         'two generic funcs at registration time for making the collection?'#13#10 +
         'No worries - just declare the injectable data member or'#13#10 +
         'property as a IInterfaceList'#13#10 +
         'If you are flat out like a lizard drinking, use this zero-code solution'#13#10 +
         'to acquire a gang of cooperative services.'#13#10 +
         'Take a look at unit Demo.TaskNine for example.'#13#10 +
         'Compare and constrast with unit Demo.TaskEight.')]
TTaskNine = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation


uses Classes;
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
    [configuration] constructor CreatePerson;
  end;

TChris = class ( TInterfacedObject, IPerson)
  private
    function Name: string;
    function Weight: double;
  public
    [configuration] constructor CreatePerson;
  end;

ITeam = interface
  ['{2CF59753-13A1-4AE0-B578-ACA8FB0A6768}']
    function TeamWeight: double;
  end;

TTeam = class( TInterfacedObject, ITeam)
  protected
    [injection] [Collection('Demo.TaskEight.IPeople')]
      FStaff: IInterfaceList;
    function TeamWeight: double;
  public
    [configuration] constructor CreateTeam;
  end;

procedure TTaskNine.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Team: ITeam;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( IPerson, TSean);
Provider.RegisterServiceClass( IPerson, TChris);
Provider.SetCooperativeAffinity( IPerson, 'Demo.TaskEight.IPeople', '', nil, nil);
Provider.RegisterServiceClass( ITeam, TTeam);

// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.

if Provider.Gn.Acquire<ITeam>( nil, Team) then
   Put( Format( 'The combined weight of the ITeam service is %.2f Kg', [Team.TeamWeight]));

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

constructor TTeam.CreateTeam;
begin
end;

function TTeam.TeamWeight: double;
var
  StaffMember: IInterface;
begin
result := 0.0;
for StaffMember in FStaff as IInterfaceListEx do
  result := result + (StaffMember as IPerson).Weight
end;

end.
