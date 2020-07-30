/*



*/

void setup(){
  size(700,500);
  iniciarBarras();
  
}

void draw(){
  for(int b = 0; b < numBarras; b++){
    Barras[b].display();
  }
}
