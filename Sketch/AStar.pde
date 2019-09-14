class AStar extends Pathfiding{
  private List<Node> openList, closedList, path;


  AStar(List<List<Node>> arr){
    super(arr);
    openList = new ArrayList<Node>();
    closedList = new ArrayList<Node>();
    path = new ArrayList<Node>();
  }

  // HERE IS THE A* ALGORITHM
  @Override
  public void run(){
    openList.add(startNode);
  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

  public void reset(){
    openList.clear();
    closedList.clear();
    path.clear();
  }

}
