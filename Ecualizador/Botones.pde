
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Linea;

void iniciarBotones(){
  int xBotones = xGrafica + numBarras*30 + 10;  //30 separación de las barras
  Reset = new boton(xBotones, height/2, 60, 30, color(245, 102, 0), "Reset");
  Linea = new boton(xBotones, height/4, 60, 30, color(0, 157, 73), color(147, 195, 70), "Linea");
}

//----------------------CLASE----------------------//

class boton{
  int x, y;
  int alto, ancho;
  boolean cambiaColor;
  color Color1;  //Color del botón
  color Color2;  //Color del botón cuando está seleccionado
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  String info;
  
  
  //Cuando el botón cambia de color al presionarse
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, color _Color2, String _info){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    cambiaColor = true;
    Color1 = _Color1;
    Color2 = _Color2;
    info = _info;
  }
  //Cuando el botón no cambia de color
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, String _info){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    cambiaColor = false;
    Color1 = _Color1;
    info = _info;
  }
  
  void checarMouse(){
    if(mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + alto){  //Si el puntero está sobre el botón
      mslc = true;
      if(izqClick1){
        prsd = !prsd;
        izqClick1 = false;
      }
    }else{
      //izqClick1 = false;
      mslc = false;
    }
  }
  
  void dibujar(){
    checarMouse();
    
    if(mslc)  strokeWeight(4);  //Si el mouse está sobre el botón
    else  strokeWeight(1);
    
    if(prsd && cambiaColor){  //Si el botón cambia de color y está activado se dibuja de Color2
      stroke(Color2);
      fill(Color2);
    }else{
      stroke(Color1);
      fill(Color1);
    }
    rect(x, y, ancho, alto);
    fill(255);
    textSize(13);
    textAlign(CENTER,CENTER);
    text(info, x + ancho/2, y + alto/2);
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void accionBotones(){
  if(Linea.prsd){  //Si el botón está activado
    strokeWeight(2);
    /*Lineas Rectas
    stroke(255);
    for(int b = 0; b < numBarras - 1; b++){
      line(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto, Barras[b+1].x + Barras[b].ancho/2, Barras[b+1].y - Barras[b+1].alto);  //Linea que une las barras 
    }
    */
    //Curva
    noFill();
    stroke(255);
    beginShape();
    for(int b = 0; b < numBarras; b++){
      if(b == 0){  //Es necesario usar dos puntos para el inicio y el final, es decir deben de estar repetidos
        curveVertex(Barras[b].x , Barras[b].y - Barras[b].alto);
        curveVertex(Barras[b].x , Barras[b].y - Barras[b].alto);
      }else if(b == numBarras - 1){
        curveVertex(Barras[b].x + Barras[b].ancho, Barras[b].y - Barras[b].alto);
        curveVertex(Barras[b].x + Barras[b].ancho, Barras[b].y - Barras[b].alto);
      }else{
        curveVertex(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto);
      }
    }
    endShape();
  }
  if(Reset.prsd){
    for(int b = 0; b < numBarras; b++){
      Barras[b].reset();
    }
    Reset.prsd = false;
  }
}
