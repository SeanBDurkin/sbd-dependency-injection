unit Demo.TaskOne;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Service Locator')]
[Preface('SBD Dependency Injection can be used as a simple Service Locator.'#13#10 +
         'Take a look at unit Demo.TaskOne for example.')]
TTaskOne = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation




type
IFishMonger = interface
  ['{AC0311B0-E3D6-47A2-BE76-A67FF13504B4}']
    function NameOfFishSold: string;
  end;

TMyLocalFishMonger = class( TInterfacedObject, IFishMonger)
  private
    FName: string;
    function NameOfFishSold: string;
  public
    [configuration] constructor Create;
  end;

procedure TTaskOne.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  FishMonger: IFishMonger;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( IFishMonger, TMyLocalFishMonger);
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
if Provider.Gn.Acquire<IFishMonger>( nil, FishMonger) then
  Put( Format( 'I located a FishMonger service. He sells %s.', [FishMonger.NameOfFishSold]));
Put( 'Inspect the code in unit Demo.TaskOne .');
Provider.ShutDown
end;


{ TMyLocalFishMonger }

constructor TMyLocalFishMonger.Create;
begin
FName := 'Sea Bass'
end;

function TMyLocalFishMonger.NameOfFishSold: string;
begin
result := FName
end;

end.
