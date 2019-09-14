import java.util.List;
import java.util.ArrayList;
import controlP5.*;

int scale, rows, cols;

List<List<Node>> array;
Node startNode, endNode;
boolean MousePress, searchDone;
boolean startNodeMove, endNodeMove, undoWall, explicitMode;

ControlP5 pauseButton, resetButton, aStarButton, dikstraButton;
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
  searchDone = true;

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

  startNode = array.get(rows / 2).get(5);
  endNode = array.get(rows / 2).get(cols - 1 - 5);

  startColor = color(0, 105, 92);
  endColor = color(198, 40, 40);
  openListColor = color(63, 81, 181);
  closedListColor = color(110, 50, 70);
  pathColor = color(0, 121, 107);
  bgColor = color(255);

  pauseButton = new ControlP5(this);
  pauseButton.addButton("Pause")
    .setPosition(10, height - 30)
    .setSize(60, 20)
  ;
  resetButton = new ControlP5(this);
  resetButton.addButton("Reset")
    .setPosition(80, height - 30)
    .setSize(60, 20)
  ;
  dikstraButton = new ControlP5(this);
  resetButton.addButton("dijkstra")
    .setPosition(170, height - 30)
    .setSize(60, 20)
  ;
  aStarButton = new ControlP5(this);
  aStarButton.addButton("astar")
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
  if(searchDone){
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
  searchDone = !searchDone;
}
void Reset(){
  explicitMode = true;
  MousePress = false;
  searchDone = false;
}
void dijkstra(){
  searchDone = false;
  if(dijkstra.canStart()){
    dijkstra.reset();
    dijkstra.start();
  }
}
void astar(){
  aStar.start();
}
