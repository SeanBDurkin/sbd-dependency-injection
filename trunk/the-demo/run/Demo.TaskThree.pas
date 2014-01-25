unit Demo.TaskThree;
interface
uses Demo.Task, SBD.ServiceProvider, SysUtils;

type

[Name('Service discrimination by group name')]
[Preface('Services files (as in "rank and file") are identified by a combination.'#13#10 +
         'of interface guid and a string, called the config string'#13#10 +
         'Not all services are interchangeable, even if the interface type is the same.'#13#10 +
         'Take a look at unit Demo.TaskThree for example.')]
TTaskThree = class sealed( TTask)
  protected
    procedure Execute( Put: TLogLineProc);       override;
  end;

implementation


type
ICommonInterface = interface
  ['{160619F8-BE5A-4856-9711-EC62A62AF55B}']
    function Name: string;
  end;

TPerson = class( TInterfacedObject, ICommonInterface)
  private
    function Name: string;
  public
    [configuration('corpus')] constructor CreatePerson;
  end;


TStreet = class( TInterfacedObject, ICommonInterface)
  private
    function Name: string;
  public
    [configuration('place')] constructor CreateStreet;
  end;

procedure TTaskThree.Execute( Put: TLogLineProc);
var
  Provider: IServiceProvider;
  Intf: ICommonInterface;
begin
Provider := StandardServiceProvider;
Provider.RegisterServiceClass( ICommonInterface, TPerson);
Provider.RegisterServiceClass( ICommonInterface, TStreet);
// Note: In most applications, you will follow the good practice of
//  segregating concrete class registration with service resolution.
//  Here it is together, only for demonstration purposes.
Put( 'I want a place type of service, not a corpus type of service,');
Put( 'even though they have the same API.');
Put( 'So what did I get?');
if Provider.Gn.Acquire<ICommonInterface>( nil, Intf, 'place') then
  Put( Format( 'I got %s - this is a place.', [Intf.Name]));
Provider.ShutDown
end;





constructor TPerson.CreatePerson;
begin
end;

function TPerson.Name: string;
begin
result := 'Julius Ceasar'
end;


constructor TStreet.CreateStreet;
begin
end;

function TStreet.Name: string;
begin
result := 'Lygon Street'
end;

end.
