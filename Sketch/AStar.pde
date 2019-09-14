import java.util.Comparator;
import java.util.PriorityQueue;

class AStar extends Pathfiding{
  private PriorityQueue<Node> priorityQueue;


  AStar(List<List<Node>> arr){
    super(arr);
    priorityQueue = new PriorityQueue<Node>(1, new DistanceFComparator());
  }

  // HERE IS THE A* ALGORITHM
  @Override
  public void run(){
    priorityQueue.clear();

    startNode.gScore = 0;
    priorityQueue.add(startNode);

    Node temp;
    while(priorityQueue.size() != 0){
      temp = priorityQueue.poll();

      try{ Thread.sleep(5); }
      catch(Exception e){}

      if(temp == endNode){
        super.getPath();
        println("Found");
        return;
      }

      temp.nodeColor(closedListColor);
      List<Node> neighbors = super.getSuccessors(temp);

      for(Node n : neighbors){
        float cost;
        if(n.i == temp.i || n.j == temp.j){
          cost = 1;
        } else {
          cost = 1.4;
        }

        float tempG = temp.gScore + cost;
        n.parent = temp;
        if(tempG < n.gScore){
          n.gScore = tempG;
          n.parent = temp;
          n.fScore = tempG + heuristic(n, endNode);
        }

        if(!n.vizited)
          priorityQueue.add(n);
        n.vizited = true;

      }

    }

    print("Not found");

  }

  public void start(){
    super.t = new Thread(this);
    super.t.start();
  }

  float heuristic(Node a, Node b){
    return dist(a.j, a.i, b.j, b.i);
  }
}

class DistanceFComparator implements Comparator<Node>{
  @Override
  public int compare(Node a, Node b){
    return a.fScore == b.fScore ? 0 : a.fScore < b.fScore ? -1 : 1;
  }
}
