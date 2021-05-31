public class Pathfinding implements Runnable{
  private List<List<Node>> matrix;
  private PriorityQueue<Node> priorityQueue;
  private Thread thread;
  public static final int DELAY = 10;

  Pathfinding(List<List<Node>> arr) {
    this.matrix = arr;
  }

  // HERE WILL BE THE PATHFINDING ALGORITHM
  @Override
  public void run() {
    // look into the subclass
  }

  public boolean canStart(){
    return thread == null && !searchStarted ? true : false;
  }

  // GET ALL POSSIBLE SUCCESSORS
  private List<Node> getSuccessors(Node node) {
    List<Node> successors = new ArrayList<Node>();
    Node n;
    try {
      n = array.get( node.i - 1 ).get( node.j - 1 );
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i - 1 ).get( node.j );
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i - 1 ).get( node.j + 1 ) ;
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i ).get( node.j - 1 );
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i ).get( node.j + 1 ) ;
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j - 1 ) ;
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j );
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}
    try {
      n = array.get( node.i + 1 ).get( node.j + 1 );
      if(!n.vizited && !n.isBlocked){
        successors.add(n);
      }
    } catch (Exception e){}

    return successors;
  }

  public void reset(){
    for(int i = 0; i < rows; i++){
      for(Node n : matrix.get(i)){
        n.resetNodeValues();
      }
    }

    priorityQueue.clear();
  }

  private void getPath(){
    thread = null;
    Node temp = endNode;
    while(temp != null && temp != startNode){
        try{if(explicitMode){ Thread.sleep(20); }}
        catch(Exception e){}
        temp.nodeColor(pathColor);
        temp = temp.parent;
    }
    return;
  }

}
