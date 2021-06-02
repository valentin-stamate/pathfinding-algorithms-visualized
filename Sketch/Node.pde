public class Node {
  private int i, j;
  private color nodeColor;
  private boolean isBlocked;

  private float minDistance = Float.MAX_VALUE;
  private float fScore = Float.MAX_VALUE, gScore = Float.MAX_VALUE, hScore;
  private boolean vizited = false;
  private Node parent = null;

  // ANIMATION
  private int nodeSize = scale - 2, radius = 9;

  // NDOE CONSTRUCTOR
  Node(int i, int j) {
    this.i = i;
    this.j = j;
    isBlocked = false;
    nodeColor = color(255);
    registerMethod("draw", this);
  }

  // DRAW FUNCTION WHICH IS CALLED AUTOMATICALLY
  void draw() {
    if(radius > 0 && nodeSize == scale - 2) {
      radius--;
    }

    if(this.nodeSize < scale - 2) {
      this.nodeSize++;
    }

    if( isOverNode() ){
      if(mousePress && !isBlocked && !searchStarted) {
        if(endNodeMove) {
          if(endNode != this && this != startNode) {
            endNode.nodeColor(bgColor);
            endNode = this;

            if(!drawMode) {
              explicitMode = false;
              switch(pathfindingAlgorithm){
                case 1: dijkstra.start(); break;
                case 2: aStar.start(); break;

              }
              // FOR REMOVING `CELL FLASH`
              try{ Thread.sleep(15); }
              catch(Exception e){}
            }

          }
        } else if(startNodeMove) {
          if(startNode != this && this != endNode) {
            startNode.nodeColor(bgColor);
            startNode = this;
          }
        }
        // IF THE SELECTED CELL IS NOT START OR END NODE THEN
        // MAKE IT BLOCKED
        else if (this != startNode && this != endNode) {
          resetNode();
          nodeColor = color(25);
          isBlocked = true;
          animate();
        }
        // ELSE WE KNOW THAT THE SELECTED NODE IS START OR END NODE
        // AND WE MOVE IT
        else if(this == endNode) {
          endNodeMove = true;
        } else if(this == startNode) {
          startNodeMove = true;
        }
      }
      else if(undoWall && isBlocked) {
        resetNode();
      }
    }

    // DRAWING A NODE
    noStroke();
    fill(nodeColor);
    rect(j * scale + scale / 2, i * scale + scale / 2, this.nodeSize, this.nodeSize, this.radius);
  }

  // CHANGE THE CELL COLOR WHEN NEEDED
  public void nodeColor(color col) {
    nodeColor = col;
    if(explicitMode && this != startNode && this != endNode){
      animate();
    }
  }

  public void resetNode() {
    resetNodeValues();
    nodeColor = color(bgColor);
    isBlocked = false;
  }

  public void resetNodeValues() {
    if(!isBlocked){
      nodeColor = color(bgColor);
    }

    minDistance = Float.MAX_VALUE;
    fScore = Float.MAX_VALUE;
    gScore = Float.MAX_VALUE;
    hScore = 0;
    vizited = false;
    parent = null;
  }

  private void animate() {
    nodeSize = 2;
    radius = 9;
  }

  // IF THE MOUSE IS CLICKED AND OVER THE CELL RETURN TRUE
  private boolean isOverNode() {
    int offsetX = mouseX - this.j * scale;
    int offsetY = mouseY - this.i * scale;
    return (offsetX <= scale && offsetX >= 0 && offsetY <= scale && offsetY >= 0);
  }

}
