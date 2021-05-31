import java.util.Comparator;
import java.util.PriorityQueue;

class Dijkstra extends Pathfinding {

  Dijkstra(List<List<Node>> arr) {
    super(arr);
    super.priorityQueue = new PriorityQueue<Node>(1, new DistanceComparator());
  }

  // HERE IS THE DIJKSTRA ALGORITHM
  @Override
  public void run() {

    startNode.minDistance = 0;
    super.priorityQueue.add(startNode);

    Node temp;

    while(super.priorityQueue.size() != 0){

      // PAUSE
      if(explicitMode) {
        try{while(searchPaused){ Thread.sleep(100); }}
        catch(Exception e){}

        try{ Thread.sleep(Pathfinding.DELAY); }
        catch(Exception e){}
      }

      temp = super.priorityQueue.poll();
      temp.nodeColor(closedListColor);

      float tempDist = temp.minDistance;

      if(temp == endNode) {
        searchStarted = false;
        // println("Found");
        super.getPath();
        return;
      }

      List<Node> neighbors = super.getSuccessors(temp);
      for(Node n : neighbors) {
        n.nodeColor(openListColor);
        float cost;
        if(n.i == temp.i || n.j == temp.j){
          cost = 1;
        } else {
          cost = 1.4;
        }

        if(tempDist + cost < n.minDistance) {
          n.minDistance = tempDist + cost;
          n.parent = temp;
        }
        if(!n.vizited) {
          super.priorityQueue.add(n);
        }

        n.vizited = true;
      }

      print("");
    }

    searchStarted = false;
    println("Not Found");
    super.thread = null;
  }

  public void start() {
    super.reset();
    searchStarted = true;

    if(super.thread == null) {
      super.thread = new Thread(this);
    }

    try{ super.thread.start(); }
    catch(Exception e){}
  }

  private float heuristic(Node a, Node b) {
    return dist(a.j, a.i, b.j, b.i);
  }

}

// COMPARATOR CLASS FOR PriorityQueue
class DistanceComparator implements Comparator<Node>{
  @Override
  public int compare(Node a, Node b){
    return a.minDistance == b.minDistance ? 0 : a.minDistance < b.minDistance ? -1 : 1;
  }
}
