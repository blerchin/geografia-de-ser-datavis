class Fader {
  
  float dest;
  int finalInc;
  
  float value;
  int i;
  
  Fader( int increments, float countTo) {
     dest = countTo;
     finalInc = increments;
     i=0;
   
  }
 
 Fader( int increment) {
    dest = 1;
    finalInc = increment;
    i++;
 } 
 
float increment(){
     if( i < finalInc )
     i++;

     value = ((float) i/finalInc) * dest;
     return value;
 }
float val() {
     return value;   
}

}
  
