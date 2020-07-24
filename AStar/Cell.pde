class Cell{
int f = 0;
int g = 0;
int h = 0;
int x = 0;
int y = 0;
ArrayList<Cell> neighbours;
Cell previous;
boolean wall;
public Cell(int i, int j){
 this.x = i;
 this.y = j;
  this.f = 0;
  this.g = 0;
  this.h = 0;
  this.neighbours = new ArrayList();
  this.previous = null;
  this.wall = false;
  
  if(random(1) < 0.25){ //determines the amount of obstacles
  this.wall = true;
  }  
}

public void show(int c1, int c2, int c3){
  fill(c1, c2, c3);
  if(this.wall){
    fill(0);
  }
  noStroke();
  rect(this.x * getWidth(),this.y * getHeight() , getWidth()-1, getHeight()-1);
}

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
