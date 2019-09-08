public class Cell{
  public int i, j, radius;
  private color cellColor;
  public boolean isBlocked;

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
    // REMEMBER , IN ORDER FOR THIS TO WORK THE CLASS MUST BE SET PUBLIC
    registerMethod("draw", this);
  }
  // CHANGE THE CELL COLOR WHEN NEEDED
  public void cellColor( color col ){
    if( !this.isBlocked )
      this.cellColor = col;
  }

  void draw(){
    if(frameCount % 1 == 0 && this.radius > 0){
      this.radius--;
    }
    // RADIUS ANIMATION
    if( MousePress && !this.isBlocked && this.isOverCell() ){
      this.cellColor = color(25);
      this.radius = 20;
      this.isBlocked = true;
    }
    // DRAWING A CELL
    noStroke();
    fill( this.cellColor );
    rect( this.j * scale + 1, this.i * scale + 1, scale - 1, scale - 1, this.radius);
  }

  // IF THE MOUSE IS CLICKED AND OVER THE CELL RETURN TRUE
  private boolean isOverCell() {
    int offsetX = mouseX - this.j * scale;
    int offsetY = mouseY - this.i * scale;

    return (offsetX <= scale && offsetX >= 0 && offsetY <= scale && offsetY >= 0);
  }

}
