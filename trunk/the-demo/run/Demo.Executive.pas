unit Demo.Executive;
interface
uses SBD.ServiceProvider;

type
TDemo_Executive = class
  public
    constructor Create;
    destructor  Destroy; override;
    function GetDemoServices: IServiceProvider;

  private
    FDemoServices: IServiceProvider;
  end;


implementation






uses Demo.Task, Demo.TaskOne, Demo.TaskTwo, Demo.TaskThree, Demo.TaskFour,
  Demo.TaskFive,
  Demo.TaskSix,
  Demo.TaskSeven,
  Demo.TaskEight,
  Demo.TaskNine,
  Demo.TaskTen,
  Demo.taskEleven,
  Demo.TaskTwelve,
  Demo.TaskThirteen,
  Demo.TaskFourteen,
  Demo.TaskFifteen,
  Demo.TaskSixteen,
  Demo.TaskSeventeen;

constructor TDemo_Executive.Create;
begin
FDemoServices := StandardServiceProvider;
FDemoServices.SetCooperativeAffinity( ITask, 'Demo.Task.ITask', SDemoTasks, nil, nil);
Demo.TaskOne.TTaskOne.RegisterMe( FDemoServices);
Demo.TaskTwo.TTaskTwo.RegisterMe( FDemoServices);
Demo.TaskThree.TTaskThree.RegisterMe( FDemoServices);
Demo.TaskFour.TTaskFour.RegisterMe( FDemoServices);
Demo.TaskFive.TTaskFive.RegisterMe( FDemoServices);
Demo.TaskSix.TTaskSix.RegisterMe( FDemoServices);
Demo.TaskSeven.TTaskSeven.RegisterMe( FDemoServices);
Demo.TaskEight.TTaskEight.RegisterMe( FDemoServices);
Demo.TaskNine.TTaskNine.RegisterMe( FDemoServices);
Demo.TaskTen.TTaskTen.RegisterMe( FDemoServices);
Demo.taskEleven.TTaskEleven.RegisterMe( FDemoServices);
Demo.TaskTwelve.TTaskTwelve.RegisterMe( FDemoServices);
Demo.TaskThirteen.TTaskThirteen.RegisterMe( FDemoServices);
Demo.TaskFourteen.TTaskFourteen.RegisterMe( FDemoServices);
Demo.TaskFifteen.TTaskFifteen.RegisterMe( FDemoServices);
Demo.TaskSixteen.TTaskSixteen.RegisterMe( FDemoServices);
Demo.TaskSeventeen.TTaskSeventeen.RegisterMe( FDemoServices);
// Register more as needed as the demo grows ....

end;

destructor TDemo_Executive.Destroy;
begin
FDemoServices.ShutDown;
inherited
end;

function TDemo_Executive.GetDemoServices: IServiceProvider;
begin
result := FDemoServices
end;

end.
