import java.util.List;
import java.util.ArrayList;
import controlP5.*;

int scale, rows, cols;

List<List<Node>> array;
Node startNode, endNode;
boolean MousePress, searchStarted;
boolean startNodeMove, endNodeMove, undoWall, explicitMode, searchPaused, directSearch;

ControlP5 button;
color startColor, endColor, openListColor, closedListColor, pathColor, bgColor;

Dijkstra dijkstra;
AStar aStar;

// SETUP()
void setup(){
  size(1040, 600);
  frameRate(60);
  background(255);

  initialize();
}
// DRAW()
void draw(){
  background(255);
  drawDownNav();

  startNode.nodeColor(startColor);
  endNode.nodeColor(endColor);
}
// INITIALIZE ALL
void initialize(){
  scale = 20;

  MousePress = false;
  searchStarted = false;
  searchPaused = false;

  rows = (height - 40) / scale;
  cols = width / scale;

  array = new ArrayList<List<Node>>();
  for(int i = 0; i < rows; i ++){
    array.add( new ArrayList<Node>()  );
    for(int j = 0; j < cols; j ++){
      array.get( i ).add( new Node(i, j) );
    }
  }
  dijkstra = new Dijkstra(array);
  aStar = new AStar(array);

  startNodeMove = false;
  endNodeMove = false;
  directSearch = false;

  startNode = array.get(rows / 2).get(5);
  endNode = array.get(rows / 2).get(cols - 1 - 5);

  startColor = color(0, 105, 92);
  endColor = color(198, 40, 40);
  openListColor = color(63, 81, 181);
  closedListColor = color(110, 50, 70);
  pathColor = color(0, 121, 107);
  bgColor = color(255);

  button = new ControlP5(this);
  button.addButton("Pause")
    .setPosition(10, height - 30)
    .setSize(60, 20)
  ;

  button.addButton("Reset")
    .setPosition(80, height - 30)
    .setSize(60, 20)
  ;
  button.addButton("dijkstra")
    .setPosition(170, height - 30)
    .setSize(60, 20)
  ;
  button.addButton("astar")
    .setPosition(240, height - 30)
    .setSize(60, 20)
  ;

  explicitMode = true;// the first time the algorithm is running step by step
}
// DRAW THE BOTTOM BAR
void drawDownNav(){
  noStroke();
  fill(color(15));
  rect(0, height - 40, width, 40 );
}


// MOUSE METHODS
void mousePressed(){
  if(!searchStarted){
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
  endNodeMove = false;
}


// BUTTONS
void Pause(){
  searchPaused = !searchPaused;
}
void Reset(){
  explicitMode = true;
  MousePress = false;
  searchPaused = false;
  searchStarted = false;

  dijkstra.reset();
  // TODO how to stop a thread
}
void dijkstra(){
  searchPaused = false;
  if(dijkstra.canStart()){
    println("DJIGSTRA");
    dijkstra.start();
  }
}
void astar(){
  searchPaused = false;
  if(aStar.canStart()){
    println("ASTAR");
    aStar.start();
  }
}
