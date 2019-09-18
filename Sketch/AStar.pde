import java.util.Comparator;
import java.util.PriorityQueue;

class AStar extends Pathfinding{

  AStar(List<List<Node>> arr){
    super(arr);
    super.priorityQueue = new PriorityQueue<Node>(1, new DistanceFComparator());
  }
  int k = 0;
  // HERE IS THE A* ALGORITHM
  @Override
  public void run(){
    super.priorityQueue.clear();
    startNode.gScore = 0;
    super.priorityQueue.add(startNode);

    Node temp;

    while(super.priorityQueue.size() != 0){
      temp = super.priorityQueue.poll();

      if(explicitMode){
        try{while(searchPaused){ Thread.sleep(100); }}
        catch(Exception e){}

        try{ Thread.sleep(Pathfinding.DELAY); }
        catch(Exception e){}
      }

      if(temp == endNode){
        searchStarted = false;
        //println("Found");
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

      print("");

    }
    searchStarted = false;
    println("Not Found");

  }

  public void start(){
    super.reset();
    searchStarted = true;

    if(super.t == null){
      super.t = new Thread(this);
    }
    try{ super.t.start(); }
    catch(Exception e){}
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
