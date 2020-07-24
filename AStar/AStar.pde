int cols = 5;
int rows = 5;
int f = 0;
int g = 0;
int h = 0;
ArrayList[][] table = new ArrayList[10][10];
//table[0][0].add(); // add object to that ArrayList



void setup() {
  size(400,400);
  
  //generating a 2D array
  for(int i = 0; i < cols; i++){
    for(int j = 0; j < rows; j++){
   table[i][j] = new ArrayList(); // add another ArrayList object to [0,0]
    }
  }
  
   for(int i = 0; i < cols; i++){
     for(int j = 0; j < rows; j++){
         table[0][0].add(new Cell()); // add object to that ArrayList
     }
  }
 
  
}

void draw() {
background(0);
}
