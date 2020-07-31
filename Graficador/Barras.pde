
//----------------------GENERACIÖN DE LAS BARRAS----------------------//

int numBarras = 15;  //Como mínimo 1 barra y como máximo pueden ser 20
int numMaxBarras = 20;  //NO CAMBIAR
barra [] Barras = new barra[numMaxBarras];  //Se genera el número máximo de barras que pueden haber

//Cordenada inferior izquierda donde se dibuja la gráfica 
int xGrafica;
int yGrafica;
int yMax = 100;  //Valor máximo del eje Y

int altoMaxBarras;
int dxBarras = 30;  //Separación entre barras
int anchoBarras = 21;  //Ancho de las barras

void iniciarBarras(){
  xGrafica = width/12;
  yGrafica = height - height/10;
  altoMaxBarras = yGrafica - height/5;
  
  dxBarras = (xBotones - xGrafica)/numBarras;  //*Importante que numBarras no sea cero
  anchoBarras = dxBarras - 10;
  
  int _x;  //Posición inferior izquierda de la barra
  
  for(int b = 0; b < numMaxBarras; b++){
    _x = b*dxBarras;
    Barras[b] = new barra(xGrafica + _x, yGrafica, anchoBarras);
    Barras[b].reset();
  }
}

//----------------------CAMBIO DEL NUMERO DE BARRAS----------------------//

void cambiarNumBarras(boolean _mas){
  if(_mas)  numBarras++;
  else numBarras--;
  numBarras = constrain(numBarras, 1, 20);
  
  dxBarras = (xBotones - xGrafica)/numBarras;  //*Importante que numBarras no sea cero
  anchoBarras = dxBarras - 10;
  
  int _x;  //Posición inferior izquierda de la barra
  
  for(int b = 0; b < numBarras; b++){
    _x = b*dxBarras;
    Barras[b].ancho = anchoBarras;
    Barras[b].x = xGrafica + _x;
  }
}

//----------------------EJES----------------------//

void dibujarEje(){
  stroke(255);
  strokeWeight(1);
  fill(255);
  textSize(12);
  textAlign(RIGHT,CENTER);
  
  //Eje
  line(xGrafica -10, yGrafica, xGrafica -10, yGrafica - altoMaxBarras);  //Linea del ejeY
  line(xGrafica -10, yGrafica, xGrafica + numBarras*dxBarras, yGrafica);  //Linea del ejeX 
  
  int divisiones = 4;  //Cantidad de divisiones del eje  (*Tiene que ser un número mayor que cero)
  
  //Numeros del eje
  for(int n = 0; n <= divisiones; n++){
    line(xGrafica - 13, yGrafica - (n*altoMaxBarras/(divisiones)), xGrafica - 10, yGrafica - (n*altoMaxBarras/(divisiones))); 
    text(round(map(n, 0,divisiones, 0, yMax)), xGrafica -15, yGrafica - (n*altoMaxBarras/(divisiones)));
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
    if(!Puntos.prsd){  //Se muestra el número solo cuando no se muestra la linea
      rect(x, y, ancho, -alto);
      fill(255);
      textSize(12);
      textAlign(CENTER,CENTER);
      num = round(map(alto, 0, altoMaxBarras, 0, yMax));
      text(num, x + ancho/2, y - alto - 10);
    }else{  //Si está activado el botón muestra un círculo a la misma altura de la barra
      circle(x + ancho/2, y - alto, 13);
    }
  }
  
  void reset(){
    alto = altoMaxBarras/2;
  }
  
}
