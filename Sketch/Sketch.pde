import java.util.List;
import java.util.ArrayList;

int scale = 20, rows, cols;
List< List< Cell > > array;
List< Cell > openList, closedList, path;
Cell startNode, endNode, q;
int dist = 1;
boolean searchDone = false;
void setup(){
  size(601, 601);
  frameRate(30);
  background(30);
  // PART 1 & 2
  initialize();

}

void draw(){
  background(15);

  // PART 3 .
  if( !openList.isEmpty() ){

    // PART 3.a .
    q = openList.get(0);
    for(Cell c : openList){
      if( c.f < q.f ){
       q = c;
      }
    }
    // PART 3.b .
    openList.remove( q );

    // PART 3.c .
    List< Cell> successors = getSuccessors( q );

    // PART 3.d
    float gNew, hNew, fNew;
    for(Cell s : successors){
      // i
      if( !closedList.contains( s ) && !s.isBlocked){
        
        if(s == endNode ){
          s.parent = q;
          print("Done!");
          searchDone = true;
          noLoop();
        }
        if( !closedList.contains( s ) ){
          
          gNew = q.g + 1;// sqrt(2) if there a succesor is in the corner
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
    }

    closedList.add(q);

    drawArray();

    } else {
      println( "Done!" );
      searchDone = true;
      noLoop();
    }

    if( searchDone ){
      drawArray();
    }

    endNode.show(234, 2, 43);

}

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

float heuristic(Cell a, Cell b){
  return dist( a.j, a.i, b.j, b.i );
  //return abs( a.i - b.i ) + abs( a.j - b.j );
}

void initialize(){
  array = new ArrayList< List< Cell > >();
  openList = new ArrayList< Cell >();
  closedList = new ArrayList< Cell >();
  path = new ArrayList< Cell >();

  rows = height / scale;
  cols = width / scale;

  for(int i = 0; i < rows; i ++){
    array.add( new ArrayList<Cell>()  );
    for(int j = 0; j < cols; j ++){
      array.get( i ).add( new Cell(i, j) );
      if( random(0, 1) < 0.3 )
        array.get(i).get(j).isBlocked = true;
    }
  }
  

  startNode = array.get( 0 ).get( 0 );
  endNode = array.get( rows - 1 ).get( cols - 1 );
  endNode.isBlocked = false;
  startNode.isBlocked = false;
  startNode.f = 0;
  startNode.g = 0;

  openList.add( startNode );

}

void drawArray(){
  for(int i = 0; i < rows; i ++){
    for(int j = 0; j < cols; j ++){
      array.get( i ).get( j ).show(100, 100, 100);
    }
  }
  if( !searchDone ){
    for(Cell c : closedList)
     c.show(110, 50, 70);
    for(Cell c : openList)
      c.show(249, 85, 85);
  }
  // GET THE PATH AND SHOW IT
  path.clear();

  Cell temp = q;
  path.add(temp);

  while( temp.parent != null ){
    path.add( temp.parent );
    temp = temp.parent;
  }

  for(Cell c : path)
    c.show(43, 239, 127);
  return;
}
