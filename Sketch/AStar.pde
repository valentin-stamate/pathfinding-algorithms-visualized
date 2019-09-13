class AStar extends Pathfiding{

  AStar(List<List<Cell>> arr){
    super(arr);
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
