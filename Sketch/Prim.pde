class Prim extends Pathfiding{

  Prim(List<List<Node>> arr){
    super(arr);
  }

  // HERE IS THE PRIM ALGORITHM
  @Override
  public void run(){

  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

}
