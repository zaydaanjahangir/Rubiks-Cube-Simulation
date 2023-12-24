import peasy.*;

PeasyCam cam;

int dim = 3;
Cubie[] cube = new Cubie[dim*dim*dim];

String[] allMoves = {"f","b","u","d","l","r"};
String sequence = "";
int counter = 0;


boolean started = false;
void setup(){ //Creates the cube and window with spinning motion
 size(600,600,P3D);
 cam = new PeasyCam(this, 400);
 int index =0;
 for (int x= -1; x <=1 ; x++){
  for (int y = -1; y <=1; y++){
   for (int z = -1; z <=1 ; z++){
     PMatrix3D matrix = new PMatrix3D();
     matrix.translate(x,y,z);
     cube[index] = new Cubie(matrix, x, y, z);
     index++;
   }
  }
 }
 //cube[2].c = color(255,0,0);
 //cube[0].c = color(0,0,255);
 
 for(int i = 0; i < 20; i++){
   int r = int(random(allMoves.length)); 
   if(random(1) < 0.5){
     sequence += allMoves[r];
   } else {
     sequence += allMoves[r].toUpperCase();
   }
 }
 
 for(int i = sequence.length()-1; i >= 0;i--){
   String nextMove = flipCase(sequence.charAt(i));
   sequence += nextMove;
 }
}

String flipCase(char c){
  String s = "" + c;
  if(s.equals(s.toLowerCase())){
    return s.toUpperCase();
  } else {
    return s.toLowerCase();
  }
}



int index = 0;

void turnZ(int index, int dir){ 
  for (int i= 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if(qb.z == index){
      PMatrix2D matrix = new PMatrix2D(); //creates a 2D matrix out of the x and y coordinates
      matrix.rotate(dir*HALF_PI); //roatating
      matrix.translate(qb.x, qb.y);  //getting the new x y coordinates
      qb.update(round(matrix.m02), round(matrix.m12),round(qb.z)); //replacing the x y coordinates
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir){ 
  for (int i= 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if(qb.y == index){
      PMatrix2D matrix = new PMatrix2D(); //creates a 2D matrix out of the x and y coordinates
      matrix.rotate(dir*HALF_PI); //roatating
      matrix.translate(qb.x, qb.z);  //getting the new x y coordinates
      qb.update(round(matrix.m02),qb.y, round(matrix.m12)); //replacing the x y coordinates
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir){ 
  for (int i= 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if(qb.x == index){
      PMatrix2D matrix = new PMatrix2D(); //creates a 2D matrix out of the x and y coordinates
      matrix.rotate(dir*HALF_PI); //roatating
      matrix.translate(qb.y, qb.z);  //getting the new x y coordinates
      qb.update(qb.x, round(matrix.m02), round(matrix.m12)); //replacing the x y coordinates
      qb.turnFacesX(dir);

    }
  }
}

void draw(){
  background(51);
  
  if(started){
    if(frameCount % 5 == 0){
      if(counter < sequence.length()){
        char move = sequence.charAt(counter);
        applyMove(move);
        counter++;
      }
    }
    
  }


 
  scale(50);
  for (int i= 0; i < cube.length; i++){
       cube[i].show();
   }
}
