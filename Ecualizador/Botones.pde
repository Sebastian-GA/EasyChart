
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Linea;

void iniciarBotones(){
  int xBotones = xGrafica + (numBarras + 1)*30;  //30 separación de las barras
  Reset = new boton(xBotones, height/2, 80, 50, color(250,0,0), "RESET");
  Linea = new boton(xBotones, height/4, 80, 50, color(150,200,30), color(50,244,100), "LINEA");
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
    fill(0);
    textSize(20);
    textAlign(CENTER,CENTER);
    text(info, x + ancho/2, y + alto/2);
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void accionBotones(){
  if(Linea.prsd){  //Si el botón está activado
    for(int b = 0; b < numBarras - 1; b++){
      stroke(255);
      strokeWeight(4);
      line(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto, Barras[b+1].x + Barras[b].ancho/2, Barras[b+1].y - Barras[b+1].alto);  //Linea que une las barras 
    }
  }
  if(Reset.prsd){
    for(int b = 0; b < numBarras; b++){
      Barras[b].reset();
    }
    Reset.prsd = false;
  }
}
