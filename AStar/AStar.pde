int cols = 25;
int rows = 25;

Cell[][] Grid = new Cell[cols][rows];
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();
Cell startNode,endNode;
int w, h;
ArrayList<Cell> Path = new ArrayList<Cell>();
boolean FLAG = false;

void setup() {
  size(400,400);
  
  //generating a 2D array
 /** for(int i = 0; i < cols; i++){
    for(int j = 0; j < rows; j++){
   Grid[i][j] = ;
    }
  }*/
  
   for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
         Grid[i][j] = new Cell(i,j); // add object to that ArrayList
     }
  }
  
  for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
         Grid[i][j].addNeighbours(Grid); 
     }
  }
 
   startNode = Grid[0][0];
   endNode = Grid[cols - 1][rows-1];
   startNode.setWall(false);
   endNode.setWall(false);
   
   openSet.add(startNode);
}

void draw() {
  
 if(FLAG != true){
  if(openSet.size() > 0){
   //keep going
   int lowestIndex = 0;
   for(int i = 0; i < openSet.size(); i++){
     if(openSet.get(i).getf() < openSet.get(lowestIndex).getf()){
       lowestIndex = i;
     }
   }
   Cell current = openSet.get(lowestIndex);
   
   if(current == endNode){
     
     //find the route backwards
     Cell temp = current;
     Path.add(temp);
     while(temp.getPrevious() != null){
       Path.add(temp.getPrevious());
       temp = temp.getPrevious();
     }
     FLAG = true;
     print("DONE");
   }
   
   openSet.remove(current);
   closedSet.add(current);
   
   ArrayList<Cell> neighbours = current.getNeighbours();
   
   for(int i = 0; i < neighbours.size(); i++){//checking every neighbour
   Cell neighbour = neighbours.get(i);
   
   if(!closedSet.contains(neighbour) && !neighbour.getWall()){
    int tempG = current.getG() + 1;
    
    if(openSet.contains(neighbour)){
      if(tempG < neighbour.getG()){
        neighbour.setG(tempG);
      }
    } else {
      neighbour.setG(tempG);
      openSet.add(neighbour);
    }
    
    neighbour.setH(heuristic(neighbour, endNode));
    neighbour.setF(neighbour.getG() + neighbour.getH());
    neighbour.setPrevious(current);
    
    
   }
   
   }
   
  }else{
  print("no solution");
  FLAG = true;
  }
  background(0);

  for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
       Grid[i][j].show(255, 255 ,255);
    }
  }
  
  for(int i = 0; i < closedSet.size(); i++){
    closedSet.get(i).show(255, 0 , 0 );
  }
  
    for(int i = 0; i < openSet.size(); i++){
    openSet.get(i).show(0, 255 , 0 );
  }
  
  for(int i = 0; i < Path.size(); i++){
  Path.get(i).show(0, 0, 255);
  }
 }
 startNode.show(250,5,255);
 endNode.show(213, 151, 214);
  
}

public int heuristic(Cell a, Cell b){
 //int d = (int)dist(a.x, a.y, b.x, b.y); //euclidean distance
 int d = abs(a.x-b.x) + abs(a.y-b.y); //manhattan distance
  return d;
}


public int getWidth(){
  return width / cols;
}

public int getHeight(){
  return height / rows;
}

public int getCol(){
return cols;
}

public int getRows(){
return rows;
}
