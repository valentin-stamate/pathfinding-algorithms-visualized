public class Node{
  public int i, j, radius;
  private color nodeColor;
  public boolean isBlocked;

  public float minDistance = Float.MAX_VALUE;
  public float fScore = Float.MAX_VALUE, gScore = Float.MAX_VALUE, hScore;
  public boolean vizited = false;
  public Node parent = null;

  // NDOE CONSTRUCTOR
  Node(int i, int j){
    this.i = i;
    this.j = j;
    isBlocked = false;
    nodeColor = color(255);
    registerMethod("draw", this);
  }

  // DRAW FUNCTION WHICH IS CALLED AUTOMATICALLY
  void draw(){
    if(radius > 0){
      radius--;
    }

    if( isOverNode() ){
      if(MousePress && !isBlocked && !searchStarted){
        if(endNodeMove){
          if(endNode != this && this != startNode){
            endNode.nodeColor(bgColor);
            endNode = this;
          }
        } else if(startNodeMove){
          if(startNode != this && this != endNode){
            startNode.nodeColor(bgColor);
            startNode = this;
          }
        }
        // IF THE SELECTED CELL IS NOT START OR END NODE THEN
        // MAKE IT BLOCKED
        else if (this != startNode && this != endNode){
          nodeColor = color(25);
          isBlocked = true;
        }
        // ELSE WE KNOW THAT THE SELECTED NODE IS START OR END NODE
        // AND WE MOVE IT
        else if(this == endNode) {
          endNodeMove = true;
        } else if(this == startNode){
          startNodeMove = true;
        }
      }
      else if(undoWall && isBlocked){
        resetNode();
      }
    }

    // DRAWING A NODE
    noStroke();
    fill(nodeColor);
    rect(j * scale + 2, i * scale + 2, scale - 2, scale - 2, radius);
  }

  // CHANGE THE CELL COLOR WHEN NEEDED
  public void nodeColor(color col){
    nodeColor = col;
  }

  public void resetNode(){
    resetNodeValues();
    nodeColor = color(bgColor);
    isBlocked = false;
  }
  public void resetNodeValues(){
    if(!isBlocked){
      nodeColor = color(bgColor);
    }
    minDistance = Float.MAX_VALUE;
    vizited = false;
    parent = null;
  }

  // IF THE MOUSE IS CLICKED AND OVER THE CELL RETURN TRUE
  private boolean isOverNode() {
    int offsetX = mouseX - this.j * scale;
    int offsetY = mouseY - this.i * scale;
    return (offsetX <= scale && offsetX >= 0 && offsetY <= scale && offsetY >= 0);
  }

}
