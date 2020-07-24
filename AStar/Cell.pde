class Cell{
int f = 0;
int g = 0;
int h = 0;
int x = 0;
int y = 0;
ArrayList<Cell> neighbours;
Cell previous;
boolean wall;
final int WALL_PERCENTAGE = 25;
/*
Contructor
Requires: an x and y location on the grid
Promises: a cell in the exact location
**/
public Cell(int x, int y){
 this.x = x;
 this.y = y;
  this.f = 0;
  this.g = 0;
  this.h = 0;
  this.neighbours = new ArrayList(); //sets an empty arraylist as the current neighbours are unknown
  this.previous = null; //sets the previous to null as it hasn't been given life by a previousNode
  this.wall = false; 
  
  if(random(1) < (WALL_PERCENTAGE)/100){ //determines if the current node will be turned into a wall.
  this.wall = true;
  }  
}

/*
This function is responsible for taking the three colours inputter by the user are (R,G,B)
and then uses those colour to draw the node.
**/
public void show(int c1, int c2, int c3){
  fill(c1, c2, c3);
  if(this.wall){ //if it's a wall it changes the colour to black
    fill(0);
  }
  noStroke();
  rect(this.x * getWidth(),this.y * getHeight() , getWidth()-1, getHeight()-1);
}

/*
finds all the neighbours off the cell in the grid and then adds that onto the arrayList of total neighbours 
of that specific node
**/
public void addNeighbours(Cell[][] Grid){
  int i = this.x;
  int j = this.y;
  if(i < getCol() - 1){
  this.neighbours.add(Grid[i+1][j]);
  }
  if(i > 0){
   this.neighbours.add(Grid[i-1][j]);
  }
  if( j < getRows() - 1){
    this.neighbours.add(Grid[i][j+1]);
  }
  if(j < 0){
     this.neighbours.add(Grid[i][j-1]);
  }
}

public int getf(){
  return this.f;
}


public ArrayList getNeighbours(){
  return  this.neighbours;
}

public int getG(){
return this.g;
}

public int getH(){
return this.h;
}

public void setG(int i){
  this.g = i;
}

public void setH(int i){
  this.h = i;
}

public void setF(int i){
  this.f = i;
}

public void setPrevious(Cell c){
  this.previous = c;
}

public Cell getPrevious(){
  return this.previous;
}

public boolean getWall(){
return this.wall;
}

public void setWall(boolean t){
this.wall = t;

}

}
