/**
A* shortest path with obstacles
William Marks
July 24, 2020
*/

int cols = 25; //columns of the grid
int rows = 25; //rows of the grid

Cell[][] Grid = new Cell[cols][rows]; //basic container of the grid, the empty husk if you will
ArrayList<Cell> openSet = new ArrayList<Cell>(); //current open alive nodes //green
ArrayList<Cell> closedSet = new ArrayList<Cell>(); //current set of dead nodes //red
Cell startNode,endNode; //the start and end node, so we can determine where the program starts from and where it's going to end
int w, h;
ArrayList<Cell> Path = new ArrayList<Cell>(); //the logged path of cells in which produces the shortest path
boolean FLAG = false; //flag to know when to stop searching

void setup() {
  size(400,400);
  
   for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
         Grid[i][j] = new Cell(i,j); // adding a cell to the empty grid
     }
  }
  
  for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
         Grid[i][j].addNeighbours(Grid); //finding the neighbours of each cell in the grid 
     }
  }
 
   startNode = Grid[0][0]; //setting the start node to the top left corner
   endNode = Grid[cols - 1][rows-1]; //setting the bottom node to the bottom right corner
   startNode.setWall(false); 
   endNode.setWall(false); //ensuring the start and end node doesn't contain a wall overtop of them.
   
   openSet.add(startNode); //adds the start node to the open set since that is the start location
}

void draw() {
  
 if(FLAG != true){ 
  if(openSet.size() > 0){ //if the openSet size is greater then 0, the program can keep looking for the shortets path.
   //keep going
   int lowestIndex = 0;
   for(int i = 0; i < openSet.size(); i++){
     if(openSet.get(i).getf() < openSet.get(lowestIndex).getf()){ 
       lowestIndex = i; //finding the current shortest f value from the current LowestIndex
     }
   }
   
   Cell current = openSet.get(lowestIndex); //duplicates the current lowest cell into a new cell to address it easier
   
   if(current == endNode){ //if the program is currently on the end node, then it will proceed with backtracking.
     
     //find the route backwards
     Cell temp = current; //duplicating the endNode are the first temp cell
     Path.add(temp); //adds the endNode to the path since it's the first in the reverse order
     while(temp.getPrevious() != null){ //loops until it reaches the startNode
       Path.add(temp.getPrevious()); //adds the previous from the currentNode to the path
       temp = temp.getPrevious(); //duplicates the next previous to temp, so that way once it reaches the firstNode it will break the cycle
     }
     FLAG = true; //sets the flag to true since it doesn't need to find the shortest path anymore
     print("DONE");
   }
   
   openSet.remove(current); //removes the current cell from the open set 
   closedSet.add(current); //adds the current to the closed set 
   
   ArrayList<Cell> neighbours = current.getNeighbours();
   
   for(int i = 0; i < neighbours.size(); i++){//gets the neighbouring cells of current.
   Cell neighbour = neighbours.get(i);
   
   if(!closedSet.contains(neighbour) && !neighbour.getWall()){ //if the cell is not a wall,and it does not already exist in the closedSet
    int tempG = current.getG() + 1; //assignes the G-Cost value from the current node to a temporary
    
    if(openSet.contains(neighbour)){ //if the neighbours exist within the open set
      if(tempG < neighbour.getG()){ //if the temp G-cost is less then the neighbours G-cost
        neighbour.setG(tempG); //changes the neighbours G-cost to the one of the current Node
      }
    } else { //if the openSet does not contain the neighbour
      neighbour.setG(tempG);  //changes the neighbours G-cost to the one of the current Node
      openSet.add(neighbour); //adds the neighbour into the open set.
    }
    
    neighbour.setH(heuristic(neighbour, endNode)); //find the H value from the current node to the endNode
    neighbour.setF(neighbour.getG() + neighbour.getH());
    neighbour.setPrevious(current); //sets the previous so it will be able to track back if this is the shortest path
    
    
   }
   
   }
   
  }else{ //if there is no possible way for the path to reach start -> end
  print("no solution");
  FLAG = true;
  }
  background(0);

  for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
       Grid[i][j].show(255, 255 ,255); //draws out the base grid
    }
  }
  
  for(int i = 0; i < closedSet.size(); i++){
    closedSet.get(i).show(255, 0 , 0 ); //draws out the dead nodes
  }
  
    for(int i = 0; i < openSet.size(); i++){
    openSet.get(i).show(0, 255 , 0 ); //draws out the alive tracked nodes
  }
  
  for(int i = 0; i < Path.size(); i++){
  Path.get(i).show(0, 0, 255); //draws the final path once it has been found.
  }
 }
 
 startNode.show(250,5,255); //draws the start node
 endNode.show(213, 151, 214); //draws the ending node
  
}

/*
caluclates the distance from one node -> end node
**/
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
