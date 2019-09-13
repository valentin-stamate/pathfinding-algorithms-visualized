class Dijkstra extends Pathfiding{

  Dijkstra(List<List<Cell>> arr){
    super(arr);
  }

  // HERE IS THE DIJKSTRA ALGORITHM
  @Override
  public void run(){

  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

}
