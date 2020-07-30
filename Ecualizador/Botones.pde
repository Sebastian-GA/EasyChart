
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Linea;

void iniciarBotones(){
  Reset = new boton(width/2, height/2, 100, 60, color(250,0,0), color(0,255,0), "RESET");
  Linea = new boton(width/2, height/4, 100, 60, color(150,200,30), color(50,244,100), "LINEA");
}

//----------------------CLASE----------------------//

class boton{
  int x, y;
  int alto, ancho;
  color Color1;  //Color del botón
  color Color2;  //Color del botón cuando está seleccionado
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  String info;
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, color _Color2, String _info){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    Color1 = _Color1;
    Color2 = _Color2;
    info = _info;
  }
  
  void checarMouse(){
    if(mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + alto){  //Si el puntero está sobre el botón
      mslc = true;
      if(izqClick()){
        prsd = !prsd;
      }
    }else{
      mslc = false;
    }
  }
  
  void dibujar(){
    checarMouse();
    
    if(mslc)  strokeWeight(4);  //Si el mouse está sobre el botón
    else  strokeWeight(1);
    
    if(prsd){  //Si está presionado se dibuja de Color2
      stroke(Color2);
      fill(Color2);
    }else{
      stroke(Color1);
      fill(Color1);
    }
    rect(x, y, ancho, alto);
    fill(255);
    textAlign(CENTER,CENTER);
    text(info, x + ancho/2, y + alto/2);
  }
}
