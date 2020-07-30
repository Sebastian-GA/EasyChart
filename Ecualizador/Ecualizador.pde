/*



*/

void setup(){
  size(700,500);
  iniciarBarras();
  iniciarBotones();
}

void draw(){
  background(150);
  
  pushMatrix();
  translate(xGrafica, yGrafica);
  for(int b = 0; b < numBarras; b++){
    Barras[b].dibujar();
  }
  popMatrix();
  Reset.dibujar();
  Linea.dibujar();
}
