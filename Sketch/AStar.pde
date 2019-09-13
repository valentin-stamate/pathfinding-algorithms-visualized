class AStar extends Pathfiding{
  private List<Cell> openList, closedList, path;


  AStar(List<List<Cell>> arr){
    super(arr);
    openList = new ArrayList<>();
    closedList = new ArrayList<>();
    path = new ArrayList<>();
  }

  // HERE IS THE A* ALGORITHM
  @Override
  public void run(){

  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

}
