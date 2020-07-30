
//----------------------GENERACIÖN DE LAS BARRAS----------------------//

int numBarras = 15;
barra [] Barras = new barra[numBarras];

//Cordenada inferior izquierda donde se dibuja la gráfica 
int xGrafica;
int yGrafica;

void iniciarBarras(){
  xGrafica = width/15;
  yGrafica = height - height/10;
  
  int _x;  //Posición inferior izquierda de la barra
  int _dxBarras = 30;  //Separación entre barras
  int _a = 21;  //Ancho de las barras
  
  for(int b = 0; b < numBarras; b++){
    _x = b*_dxBarras;
    Barras[b] = new barra(xGrafica + _x, yGrafica, _a);
  }
}

//----------------------CLASE----------------------//
class barra{
  int x, y;
  int alto = 100;
  int ancho;
  color bColor = color(106,224,11);
  
  barra(int _x, int _y, int _a){
    x = _x;
    y = _y;
    ancho = _a;
  }
  
  boolean checarMouse(){
    if(mouseX > x  && mouseX < x + ancho && mouseY > y - alto && mouseY < y){  //Si el puntero está sobre la barra
      if(mousePressed && mouseButton == LEFT){
        return true;
      }
    }
    return false;
  }
  
  void cambiarAltura(){
    alto = mouseY;
    println("CAMBIAR ALTURA");
  }
  
  void dibujar(){
    if(checarMouse()){
      cambiarAltura();
    }
    noStroke();
    fill(bColor);
    rect(x, y, ancho, -alto);
  }
  
}
