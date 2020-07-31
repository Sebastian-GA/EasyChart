
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

//----------------------EJES----------------------//

void dibujarEje(){
  stroke(255);
  strokeWeight(1);
  fill(255);
  textSize(10);
  textAlign(RIGHT,CENTER);
  
  //Eje
  line(xGrafica -10, yGrafica, xGrafica -10, yGrafica - altoMaxBarras);  //Linea del eje  
  int divisiones = 4;  //Cantidad de divisiones del eje  (*Tiene que ser un número mayor que cero)
  
  //Numeros del eje
  for(int n = 0; n <= divisiones; n++){
    line(xGrafica - 13, yGrafica - (n*altoMaxBarras/(divisiones)), xGrafica - 10, yGrafica - (n*altoMaxBarras/(divisiones))); 
    text(round(map(n, 0,divisiones, 0, 100)), xGrafica -15, yGrafica - (n*altoMaxBarras/(divisiones)));
  }
}

//----------------------CLASE----------------------//
class barra{
  int x, y;
  int alto = altoMaxBarras/2;
  int num = 50;
  int ancho;
  color Color1 = color(147, 195, 70);
  
  barra(int _x, int _y, int _a){
    x = _x;
    y = _y;
    ancho = _a;
  }
  
  boolean checarMouse(){
    if(mouseX > x  && mouseX < x + ancho && mouseY > y - altoMaxBarras - 20 && mouseY < y){  //Si el puntero está sobre la barra
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
    fill(Color1);
    rect(x, y, ancho, -alto);
    if(!Linea.prsd){  //Se muestra el número solo cuando no se muestra la linea
      fill(255);
      textSize(12);
      textAlign(CENTER,CENTER);
      num = round(map(alto, 0, altoMaxBarras, 0, 100));
      text(num, x + ancho/2, y - alto - 10);
    }
  }
  
  void reset(){
    alto = altoMaxBarras/2;
  }
  
}
