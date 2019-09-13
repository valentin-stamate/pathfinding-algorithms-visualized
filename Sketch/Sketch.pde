import java.util.List;
import java.util.ArrayList;
import controlP5.*;

int scale, rows, cols;
List< List< Cell > > array;
List< Cell > openList, closedList, path;
Cell startNode, endNode, q;
boolean MousePress, searchDone, searchStarted;
boolean startNodeMove, endNodeMode, intro, undoWall, first, explicitMode;

ControlP5 startButton, pauseButton, resetButton, aStarButton, dikstraButton;

// TODO colors
color startColor, endColor, openListColor, closedListColor, pathColor, bgColor;

void setup(){
  size(1040, 600);
  frameRate(60);
  background(255);

  initialize();
}
// DRAW CELLS ON SCREEN
void draw(){
  background(255);
  drawDownNav();


  if( searchStarted ){
    if(first){
      if(!searchDone){
        if(explicitMode){
          AStar();
        }
        else {
          while( !searchDone ){
            AStar();
          }
        }
      }
    } else {
      if(!searchDone){
        Dijkstra();
      }
    }
  }


  startNode.cellColor(startColor);
  endNode.cellColor(endColor);
}



// INITIALIZE ALL
void initialize(){
  scale = 20;

  MousePress = false;
  searchDone = false;

  array = new ArrayList< List< Cell > >();
  openList = new ArrayList< Cell >();
  closedList = new ArrayList< Cell >();
  path = new ArrayList< Cell >();

  rows = (height - 40) / scale;
  cols = width / scale;

  for(int i = 0; i < rows; i ++){
    array.add( new ArrayList<Cell>()  );
    for(int j = 0; j < cols; j ++){
      array.get( i ).add( new Cell(i, j) );
    }
  }

  startNodeMove = false;
  endNodeMode = false;
  intro = true;

  startNode = array.get(rows / 2).get(5);
  endNode = array.get(rows / 2).get(cols - 1 - 5);

  startColor = color(0, 105, 92);
  endColor = color(198, 40, 40);
  openListColor = color(63, 81, 181);
  closedListColor = color(110, 50, 70);
  pathColor = color(0, 121, 107);
  bgColor = color(255);

  startButton = new ControlP5(this);
  startButton.addButton("Start")
    .setPosition(10, height - 30)
    .setSize(60, 20)
  ;
  pauseButton = new ControlP5(this);
  pauseButton.addButton("Pause")
    .setPosition(80, height - 30)
    .setSize(60, 20)
  ;
  resetButton = new ControlP5(this);
  resetButton.addButton("Reset")
    .setPosition(150, height - 30)
    .setSize(60, 20)
  ;
  aStarButton = new ControlP5(this);
  aStarButton.addButton("astar")
    .setPosition(240, height - 30)
    .setSize(60, 20)
  ;
  resetButton = new ControlP5(this);
  resetButton.addButton("dijkstra")
    .setPosition(310, height - 30)
    .setSize(60, 20)
  ;
  first = true; // ASTAR -> true, DJIKSTRA -> false
  explicitMode = true;// the first time the algorithm is running step by step
}

// ------====== A* ALGORITHM ======------
void AStar(){
  if( !openList.isEmpty() ){

    q = openList.get(0);
    for(Cell c : openList){
      if( c.f < q.f ){
       q = c;
      }
    }

    openList.remove( q );

    List< Cell> successors = getSuccessors( q );

    float gNew, hNew, fNew;
    for(Cell s : successors){

      if( !closedList.contains( s ) && !s.isBlocked){

        if(s == endNode ){
          s.parent = q;
          // print("Done!");
          searchDone = true;
          explicitMode = false;
          break;
        }
        float dist;
        // IF i OR j IS EQUAL WITH q.i OR q.j THE SUCCESSOR IS NOT A CORNER
        // AND THE DISTANCE IS 1
        if(s.i == q.i || s.j == q.j)
          dist = 1;
        else
          dist = 1.4; // sqrt(2);

        gNew = q.g + dist;
        hNew = heuristic(s, endNode);
        fNew = gNew + hNew;

        if( s.f == Float.MAX_VALUE || s.f > fNew ){
          openList.add( s );

          s.f = fNew;
          s.g = gNew;
          s.h = hNew;

          s.parent = q;
        }
      }
    }

    closedList.add(q);

    } else if( !searchDone ) {
      println("Not found");
      explicitMode = false;
      searchDone = true;
    }

    for(Cell c : closedList)
      c.cellColor( closedListColor );

    for(Cell c : openList)
      c.cellColor( openListColor );

    path.clear();

    Cell temp = q;
    path.add(temp);
    // GET THE PATH AND cellColor IT
    while( temp.parent != null ){
      path.add( temp.parent );
      temp = temp.parent;
    }

    for(Cell c : path)
      c.cellColor( pathColor );
}
// GET ALL POSSIBLE SUCCESSORS
List< Cell > getSuccessors(Cell cell){
  List< Cell > s = new ArrayList< Cell >();
  try {
    s.add( array.get( cell.i - 1 ).get( cell.j - 1 ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i - 1 ).get( cell.j ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i - 1 ).get( cell.j + 1 ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i ).get( cell.j - 1 ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i ).get( cell.j + 1 ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i + 1 ).get( cell.j - 1 ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i + 1 ).get( cell.j ) );
  } catch (Exception e){}
  try {
    s.add( array.get( cell.i + 1 ).get( cell.j + 1 ) );
  } catch (Exception e){}

  return s;
}
// HEURISTIC DISTANCE
float heuristic(Cell a, Cell b){
  return dist( a.j, a.i, b.j, b.i );
}

// ------====== DIJKSTRA ALGORITHM ======------
void Dijkstra(){

  Cell temp;

  if( !openList.isEmpty() ){

    temp = openList.get(0);

    List<Cell> neighbors = getSuccessors(temp);

    for(Cell c : neighbors){
      if(!c.isBlocked && !c.visited){

        if(c == endNode){
          print("Found");
          searchDone = true;
          return;
        }

        openList.add(c);
        c.visited = true;
        c.cellColor( color(openListColor) );
      }
    }

    openList.remove(0);

  }

}


void resetAStar(){
  for(Cell c : closedList){
    if(!c.isBlocked)
      c.resetCell();
  }
  for(Cell c : openList){
    if(!c.isBlocked && c != startNode)
      c.resetCell();
  }
  for(Cell c : path){
    if(!c.isBlocked && c != startNode) // CHANGE
      c.resetCell();
  }

  startNode.resetValues();
  endNode.resetValues();

  openList.clear();
  closedList.clear();
  path.clear();

  openList.add(startNode);
}
// DRAW THE BOTTOM BAR
void drawDownNav(){
  noStroke();
  fill( color(15) );
  rect(0, height - 40, width, 40 );
}
// MOUSE METHODS
void mousePressed(){
  if(intro || searchDone){
    if(mouseButton == LEFT)
      MousePress = true;
    else if(mouseButton == RIGHT)
      undoWall = true;
  }
}
void mouseReleased(){
  MousePress = false;
  undoWall = false;
  startNodeMove = false;
  endNodeMode = false;
}
// BUTTONS
void Start(){
  searchStarted = true;
  openList.add( startNode );
  intro = false;
}
void Pause(){
  searchStarted = false;
}
void Reset(){
  explicitMode = true;
  searchStarted = false;
  searchDone = false;
  intro = true;

  MousePress = false;
  searchDone = false;

  for(int i = 0; i < rows; i ++){
    for(Cell c : array.get(i)){
      if(c != startNode && c != endNode)
        c.resetCell();
    }
  }

  startNode.resetValues();
  endNode.resetValues();

  path.clear();
  openList.clear();
  closedList.clear();
}
void astar(){
  first = true;
}
void dijkstra(){
  openList.clear();
  openList.add(startNode);
  first = false;
}
