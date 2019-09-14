import java.util.Comparator;
import java.util.PriorityQueue;

class Dijkstra extends Pathfiding{

  private PriorityQueue<Node> priorityQueue;

  Dijkstra(List<List<Node>> arr){
    super(arr);
    priorityQueue = new PriorityQueue<Node>(1, new DistanceComparator());
  }

  // HERE IS THE DIJKSTRA ALGORITHM
  @Override
  public void run(){
    priorityQueue.clear();

    startNode.minDistance = 0;
    priorityQueue.add(startNode);

    Node temp;

    while(priorityQueue.size() != 0){

      try{
        while(searchDone){
          Thread.sleep(20);
        }
      }
      catch(Exception e){}

      try{ Thread.sleep(20); }
      catch(Exception e){}

      temp = priorityQueue.poll();
      temp.nodeColor( closedListColor );

      float tempDist = temp.minDistance;

      if(temp == endNode){
        while(temp != null){
          temp.nodeColor(pathColor);
          temp = temp.parent;
        }
        println("Found");
        super.t = null;
        return;
      }

      List<Node> neighbors = super.getSuccessors(temp);
      for(Node n : neighbors){
        n.nodeColor(openListColor);
        float cost;
        if(n.i == temp.i || n.j == temp.j){
          cost = 1;
        } else {
          cost = 1.4;
        }

        if(tempDist + cost < n.minDistance){
          n.minDistance = tempDist + cost;
          n.parent = temp;
        }
        if(!n.vizited)
          priorityQueue.add(n);
        n.vizited = true;
      }

    }
    super.t = null;
    println("Not Found");
  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

  private float heuristic(Node a, Node b){
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
