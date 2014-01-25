unit Demo.TaskTwo;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Dependency Injection')]
[Preface('Dependency Injection injects the appropriate service into data members.'#13#10 +
         'and write-able properties. The injection is done after memory for the object'#13#10 +
         'has been allocated, but before the constructor is called.'#13#10 +
         'Service injection is hierarchical. As each service is injected'#13#10 +
         'it is created on the fly (unless marked as otherwise), with it''s'#13#10 +
         'dependent services in turn also injected.'#13#10 +
         'Take a look at unit Demo.TaskTwo for example.')]
TTaskTwo = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation




type
IWheel = interface
  ['{AC0311B0-E3D6-47A2-BE76-A67FF13504B4}']
    function Spin: string;
  end;

ICar = interface
  ['{EFC24390-DB3B-4C4C-8293-288F532A3E8D}']
    procedure SpinMyWheels( Put: TLogLineProc);
  end;

TWheel = class( TInterfacedObject, IWheel)
  private
    function Spin: string;
  public
    [configuration] constructor CreateWheel;
  end;

TCar = class( TInterfacedObject, ICar)
  private
    [Injection] FWheel1: IWheel;
    [Injection] FWheel2: IWheel;
    [Injection] FWheel3: IWheel;
    [Injection] FWheel4: IWheel;
    procedure SpinMyWheels( Put: TLogLineProc);
  public
    [configuration] constructor CreateCarWith4Wheels;
  end;

procedure TTaskTwo.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Car: ICar;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( ICar, TCar);
Provider.RegisterServiceClass( IWheel, TWheel);
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
if Provider.Gn.Acquire<ICar>( nil, Car) then
  Car.SpinMyWheels( Put);
Provider.ShutDown
end;




constructor TCar.CreateCarWith4Wheels;
begin
// All wheels exist at this point.
// Notice the lack of constructors and configuration logic.
end;

procedure TCar.SpinMyWheels( Put: TLogLineProc);
begin
Put('The car now spins all it''s wheels. I wonder how many have been provisioned?');
Put( FWheel1.Spin);
Put( FWheel2.Spin);
Put( FWheel3.Spin);
Put( FWheel4.Spin);
Put( 'Inspect the code in unit Demo.TaskTwo .');
end;


constructor TWheel.CreateWheel;
begin
end;

function TWheel.Spin: string;
begin
result := '''brrrmmm...'' ... a wheel spins.'
end;

end.
