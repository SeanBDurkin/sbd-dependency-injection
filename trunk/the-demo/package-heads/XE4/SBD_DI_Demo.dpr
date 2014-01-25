program SBD_DI_Demo;

uses
  Forms,
  Demo.DemoSBD_DI in '..\..\run\Demo.DemoSBD_DI.pas' {mfmDemoSBD_DI},
  SBD.ServiceProvider in '..\..\..\the-framework\run\SBD.ServiceProvider.pas',
  SBD.ServiceProvider.Internal in '..\..\..\the-framework\run\SBD.ServiceProvider.Internal.pas',
  Demo.Executive in '..\..\run\Demo.Executive.pas',
  Demo.Task in '..\..\run\Demo.Task.pas',
  Demo.TaskOne in '..\..\run\Demo.TaskOne.pas',
  Demo.TaskTwo in '..\..\run\Demo.TaskTwo.pas',
  Demo.TaskThree in '..\..\run\Demo.TaskThree.pas',
  Demo.TaskFour in '..\..\run\Demo.TaskFour.pas',
  Demo.TaskFive in '..\..\run\Demo.TaskFive.pas',
  Demo.TaskSix in '..\..\run\Demo.TaskSix.pas',
  Demo.TaskSeven in '..\..\run\Demo.TaskSeven.pas',
  Demo.TaskEight in '..\..\run\Demo.TaskEight.pas',
  Demo.TaskNine in '..\..\run\Demo.TaskNine.pas',
  Demo.TaskTen in '..\..\run\Demo.TaskTen.pas',
  Demo.taskEleven in '..\..\run\Demo.taskEleven.pas',
  Demo.TaskTwelve in '..\..\run\Demo.TaskTwelve.pas',
  Demo.TaskThirteen in '..\..\run\Demo.TaskThirteen.pas',
  Demo.TaskFourteen in '..\..\run\Demo.TaskFourteen.pas',
  Demo.TaskFifteen in '..\..\run\Demo.TaskFifteen.pas',
  Demo.TaskSixteen in '..\..\run\Demo.TaskSixteen.pas',
  Demo.TaskSeventeen in '..\..\run\Demo.TaskSeventeen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowHint := True;
  Application.CreateForm(TmfmDemoSBD_DI, mfmDemoSBD_DI);
  Application.Run;
end.
