unit Demo.DemoSBD_DI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Demo.Executive, Demo.Task, StdCtrls, SBD.ServiceProvider, ExtCtrls;

type
  TmfmDemoSBD_DI = class(TForm)
    memoLog: TMemo;
    btnRun: TButton;
    rgFeatures: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure rgFeaturesClick(Sender: TObject);
  private
    procedure ExecuteTask( const Task: ITask);
    procedure PutLn( const Line: string);
    procedure PutNewLn;
  public
    FExec: TDemo_Executive;
    Tasks: IInterfaceList;
  end;

var
  mfmDemoSBD_DI: TmfmDemoSBD_DI;

implementation

{$R *.dfm}












procedure TmfmDemoSBD_DI.btnRunClick(Sender: TObject);
var
  Task: ITask;
begin
PutNewLn;
PutNewLn;
PutLn( '----------------------------------------');
if Supports( Tasks[ rgFeatures.ItemIndex], ITask, Task) then
  ExecuteTask( Task)
end;

procedure TmfmDemoSBD_DI.ExecuteTask( const Task: ITask);
begin
if Task.StaticPreface <> '' then
  begin
  PutLn( Task.StaticPreface);
  PutNewLn;
  end;
if Supports( Task, IisToBeDeveloped) then
    PutLn( 'Task to be developed.')
  else
    Task.Execute( procedure ( const Line: string)
      begin
      PutLn( Line)
      end)
end;

procedure TmfmDemoSBD_DI.FormCreate( Sender: TObject);
var
  Task: ITask;
  Intf: IInterface;
begin
rgFeatures.Items.Clear;
FExec := TDemo_Executive.Create;
if FExec.GetDemoServices.Acquire( ITask, self, Tasks, SDemoTasks) then
  for Intf in Tasks as IInterfaceListEx do
    if Supports( Intf, ITask, Task) then
      rgFeatures.Items.Add( Task.Name);
rgFeatures.ItemIndex := 0;
rgFeaturesClick( rgFeatures)
end;

procedure TmfmDemoSBD_DI.FormDestroy( Sender: TObject);
begin
FExec.Free
end;

procedure TmfmDemoSBD_DI.PutLn( const Line: string);
begin
memoLog.Lines.Add( Line)
end;

procedure TmfmDemoSBD_DI.PutNewLn;
begin
PutLn( '')
end;

procedure TmfmDemoSBD_DI.rgFeaturesClick( Sender: TObject);
var
  Task: ITask;
begin
if Supports( Tasks[ (Sender as TRadioGroup).ItemIndex], ITask, Task) then
  TRadioGroup( Sender).Hint := Task.StaticPreface
end;

end.
