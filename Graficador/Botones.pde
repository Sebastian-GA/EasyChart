
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Puntos, Linea;
boton EjeX, EjeY;

void iniciarBotones(){
  int xBotones = xGrafica + numBarras*dxBarras + 10;
  Puntos = new boton(xBotones, height/2 - 120, 60, 30, color(0, 157, 73), color(147, 195, 70), "Puntos", "Barras");
  Linea = new boton(xBotones, height/2 - 80, 60, 30, color(192, 0, 116), color(0, 172, 232), "Curva", "Recta");
  Reset = new boton(xBotones, height/2 - 40, 60, 30, color(245, 102, 0), "Reset");
  
  EjeY = new boton(xBotones, height/2 + 40, 60, 30, color(0, 157, 73), "EjeY");
  EjeX = new boton(xBotones, height/2 + 80, 60, 30, color(0, 157, 73), color(0, 157, 73), "Años", "Meses");
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
  String info1 = "Desactivado";
  String info2 = "Activado";
  
  //Cuando el botón cambia de color al presionarse
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, color _Color2, String _info1, String _info2){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    cambiaColor = true;
    Color1 = _Color1;
    Color2 = _Color2;
    info1 = _info1;
    info2 = _info2;
  }
  //Cuando el botón no cambia de color
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, String _info1){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    cambiaColor = false;
    Color1 = _Color1;
    info1 = _info1;
  }
  
  boolean checarMouse(){
    if(mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + alto){  //Si el puntero está sobre el botón
      mslc = true;
      return true;
    }else{
      mslc = false;
      return false;
    }
  }
  
  void cambiarEstado(){
    prsd = !prsd;
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
    if(prsd && cambiaColor){
      text(info2, x + ancho/2, y + alto/2);
    }else{
      text(info1, x + ancho/2, y + alto/2);
    }
  }
}

//----------------------DIBUJAR LOS BOTONES----------------------//

void dibujarBotones(){
  Reset.dibujar();
  Puntos.dibujar();
  Linea.dibujar();
  EjeY.dibujar();
  EjeX.dibujar();
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void accionBotones(){
  
  //----------------------PUNTOS-BARRAS----------------------//
  
  if(Puntos.prsd){  //Si el botón está activado
    strokeWeight(2);
    //Lineas Rectas
    if(!Linea.prsd){  //Si está seleccionado dibujar rectas  (No está activado)
      stroke(255);
      for(int b = 0; b < numBarras - 1; b++){
        line(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto, Barras[b+1].x + Barras[b].ancho/2, Barras[b+1].y - Barras[b+1].alto);  //Linea que une las barras 
      }
    }else{  //Curva  (Está activado el botón)
      noFill();
      stroke(255);
      beginShape();
      for(int b = 0; b < numBarras; b++){
        if(b == 0 || b == numBarras - 1){  //Es necesario usar dos puntos para el inicio y el final, es decir deben de estar repetidos
          curveVertex(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto);
        }
        curveVertex(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto);
      }
      endShape();
    }
  }
  
  //----------------------RESET----------------------//
  
  if(Reset.prsd){
    for(int b = 0; b < numBarras; b++){
      Barras[b].reset();
    }
    Reset.prsd = false;
  }
  
  //----------------------AÑOS-MESES----------------------//
  
  if(EjeX.prsd){  //Años
    for(int b = 0; b < numBarras; b++){
      text(year() - b, Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La última barra es la del presente año y las anteriores son las de los años anteriores
    }
    Titulo = "Ingresos Anuales";
  }if(!EjeX.prsd){  //Meses
    String [] meses = {"EN", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGTO", "SEPT", "OCT", "NOV", "DIC"};
    int mes = month();
    for(int b = 0; b < numBarras; b++){
      mes--;
      if(mes < 0)  mes = 11;
      text(meses[mes], Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La ultima barra es la del mes actual
    }
    Titulo = "Ingresos Mensuales";
  }
  
  //----------------------EJE Y----------------------//
  
  if(EjeY.prsd){
    if(yMax == 100)  yMax = 500;
    else if(yMax == 10000) yMax = 100;
    else  yMax += 1000;
    yMax = constrain(yMax, 0, 10000);
    
    EjeY.prsd = false;
  }
  
}