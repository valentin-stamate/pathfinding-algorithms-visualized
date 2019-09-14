class Pathfiding implements Runnable{
  private List<List<Node>> matrix;
  private Thread t;

  Pathfiding(List<List<Node>> arr){
    this.matrix = arr;
  }

  // HERE WILL BE THE PATHFIDING ALGORITHM
  @Override
  public void run(){
    // look into the subclass
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

}
