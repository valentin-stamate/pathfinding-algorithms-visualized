import java.util.Comparator;
import java.util.PriorityQueue;

class AStar extends Pathfiding{

  AStar(List<List<Node>> arr){
    super(arr);
    super.priorityQueue = new PriorityQueue<Node>(1, new DistanceFComparator());
  }

  // HERE IS THE A* ALGORITHM
  @Override
  public void run(){
    super.reset();
    searchStarted = true;

    startNode.gScore = 0;
    super.priorityQueue.add(startNode);

    Node temp;

    while(super.priorityQueue.size() != 0){
      temp = super.priorityQueue.poll();

      // PAUSE
      try{while(searchPaused){ Thread.sleep(100); }}
      catch(Exception e){}

      try{ Thread.sleep(5); }
      catch(Exception e){}

      if(temp == endNode){
        searchStarted = false;
        println("Found");
        super.getPath();
        return;
      }

      temp.nodeColor(closedListColor);
      List<Node> neighbors = super.getSuccessors(temp);

      for(Node n : neighbors){
        n.nodeColor(openListColor);
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
          super.priorityQueue.add(n);
        n.vizited = true;

      }
    }
    searchStarted = false;
    super.t = null;
    println("Not Found");

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
