
//----------------------GENERACIÖN DE LAS BARRAS----------------------//

int numBarras = 15;
barra [] Barras = new barra[numBarras];

//Cordenada inferior izquierda donde se dibuja la gráfica 
int xGrafica;
int yGrafica;

int altoMaxBarras;

void iniciarBarras(){
  xGrafica = width/15;
  yGrafica = height - height/10;
  altoMaxBarras = yGrafica - height/5;
  int _x;  //Posición inferior izquierda de la barra
  int _dxBarras = 30;  //Separación entre barras
  int _a = 21;  //Ancho de las barras
  
  for(int b = 0; b < numBarras; b++){
    _x = b*_dxBarras;
    Barras[b] = new barra(xGrafica + _x, yGrafica, _a);
    Barras[b].reset();
  }
}

//----------------------CLASE----------------------//
class barra{
  int x, y;
  int alto = altoMaxBarras/2;
  int num = 50;
  int ancho;
  color bColor = color(106,224,11);
  
  barra(int _x, int _y, int _a){
    x = _x;
    y = _y;
    ancho = _a;
  }
  
  boolean checarMouse(){
    if(mouseX > x  && mouseX < x + ancho && mouseY > y - alto - 20 && mouseY < y){  //Si el puntero está sobre la barra
      if(mousePressed && mouseButton == LEFT){
        return true;
      }
    }
    return false;
  }
  
  void cambiarAltura(){
    alto = y-mouseY;
    alto = constrain(alto, 0, altoMaxBarras);
    
  }
  
  void dibujar(){
    if(checarMouse()){
      cambiarAltura();
    }
    noStroke();
    fill(bColor);
    rect(x, y, ancho, -alto);
    fill(0);
    textSize(10);
    textAlign(CENTER,CENTER);
    num = round(map(alto, 0, altoMaxBarras, 0, 100));
    text(num, x + ancho/2, y - alto);
  }
  
  void reset(){
    alto = altoMaxBarras/2;
  }
  
}
