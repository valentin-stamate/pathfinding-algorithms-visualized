public class Cell{
  public int i, j, radius;
  private color cellColor;
  public boolean isBlocked, animate;

  public float f = Float.MAX_VALUE, g, h;
  public Cell parent;

  // CELL CONSTRUCTOR
  Cell(int i, int j){
    this.i = i;
    this.j = j;
    this.parent = null;
    this.isBlocked = false;
    this.cellColor = color(255);
    this.radius = 0;
    this.g = 0;
    this.h = 0;
    this.animate = false;
    // REMEMBER , IN ORDER FOR THIS TO WORK THE CLASS MUST BE SET PUBLIC
    registerMethod("draw", this);
  }
  // CHANGE THE CELL COLOR WHEN NEEDED
  public void cellColor(color col){
    if( !this.isBlocked ){
      this.cellColor = col;
      if(col == openListColor && !this.animate){
        this.radius = 15;
        this.animate = true;
      }
    }
  }

  public void resetCell(){
    this.cellColor = color(255);
    this.isBlocked = false;
    this.f = Float.MAX_VALUE;
    this.g = 0;
    this.h = 0;
    this.parent = null;
    this.animate = false;
  }
  // DRAW FUNCTION WHICH IS CALLED AUTOMATICALLY
  void draw(){
      // RADIUS ANIMATION
    if(this.radius > 0 && !this.animate){
      this.radius--;
    }
    if(frameCount % 3 == 1 && this.radius > 0 && this.animate){
      this.radius--;
    }
    if( MousePress && !this.isBlocked && this.isOverCell() && intro){
      if(endNodeMode){
        endNode = this;
      } else if(startNodeMove){
        startNode = this;
      }
      // IF THE SELECTED CELL IS NOT START OR END NODE THEN
      // MAKE IT BLOCKED
      else if (this != startNode && this != endNode){
        this.cellColor = color(25);
        this.radius = 20;
        this.isBlocked = true;
      }
      // ELSE WE KNOW THAT THE SELECTED NODE IS START OR END NODE
      // AND WE MOVE IT
      else if(this == endNode) {
        endNodeMode = true;
      } else if(this == startNode){
        startNodeMove = true;
      }
    }
    // RESET ALL WITCH IS NOT SELECTED
    if( intro && !this.isBlocked && this != startNode && this != endNode){
      this.cellColor( color(255) );
    }

    // DRAWING A CELL
    noStroke();
    fill(this.cellColor);
    rect(this.j * scale + 1, this.i * scale + 1, scale - 1, scale - 1, this.radius);
  }
  // IF THE MOUSE IS CLICKED AND OVER THE CELL RETURN TRUE
  private boolean isOverCell() {
    int offsetX = mouseX - this.j * scale;
    int offsetY = mouseY - this.i * scale;

    return (offsetX <= scale && offsetX >= 0 && offsetY <= scale && offsetY >= 0);
  }

}
