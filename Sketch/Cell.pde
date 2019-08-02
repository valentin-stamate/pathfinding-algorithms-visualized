class Cell{
  public int i, j;
  public float f = Float.MAX_VALUE, g, h;
  public boolean isBlocked = false;
  public Cell parent;

  Cell(int i, int j){
    this.i = i;
    this.j = j;
    this.parent = null;
  }

  public void show(int r, int g, int b){
    stroke(255);
    fill(r, g, b);
    if(this.isBlocked)
      fill(0, 0, 0);
    rect( this.j * scale, this.i * scale, scale, scale );
  }

}
