class Pathfiding implements Runnable{
  private List<List<Node>> matrix;
  private PriorityQueue<Node> priorityQueue;
  private Thread t;

  Pathfiding(List<List<Node>> arr){
    this.matrix = arr;
  }

  // HERE WILL BE THE PATHFIDING ALGORITHM
  @Override
  public void run(){
    // look into the subclass
  }

  public boolean canStart(){
    return t == null && !searchStarted ? true : false;
  }

  // GET ALL POSSIBLE SUCCESSORS
  private List<Node> getSuccessors(Node node){
    List<Node> s = new ArrayList<Node>();
    Node n;
    try {
      n = array.get( node.i - 1 ).get( node.j - 1 );
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i - 1 ).get( node.j );
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i - 1 ).get( node.j + 1 ) ;
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i ).get( node.j - 1 );
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i ).get( node.j + 1 ) ;
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j - 1 ) ;
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j );
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j + 1 );
      if(!n.vizited && !n.isBlocked){
        s.add(n);
      }
    } catch (Exception e){}

    return s;
  }

  public void reset(){
    for(int i = 0; i < rows; i++){
      for(Node n : matrix.get(i)){
        n.resetNodeValues();
      }
    }
    this.priorityQueue.clear();
  }

  private void getPath(){
    this.t = null;
    Node temp = endNode;
    while(temp != null && temp != startNode){
        temp.nodeColor(pathColor);
        temp = temp.parent;
    }
    return;
  }

}
