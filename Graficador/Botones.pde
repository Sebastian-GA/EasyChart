
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Puntos, PuntosMas, PuntosMenos, Linea;
boton Tema;
boton Tipo, EjeX, EjeY;

int xBotones;
int dyBotones = 42;  //Separacion en Y de los botones
int anchoBotones = 60;
int altoBotones = 30;

void iniciarBotones(){
  xBotones = width - 90;
  
  Puntos = new boton(xBotones, height/2 - 4*dyBotones, anchoBotones, altoBotones, color(0, 157, 73), color(147, 195, 70), "Puntos", "Barras");
  
  PuntosMas = new boton(xBotones, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, color(192, 0, 116), "+");
  PuntosMenos = new boton(xBotones + 30, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, color(192, 0, 116), "-");
  PuntosMas.txtSize = 20;//Para que los signos se vean más grandes
  PuntosMas.Color2 = color(0, 172, 232);  //Para que cuando se alcance el límite queden de un color distinto
  PuntosMenos.txtSize = 20;
  PuntosMenos.Color2 = color(0, 172, 232);
  
  Linea = new boton(xBotones, height/2 - 2*dyBotones, anchoBotones, altoBotones, color(192, 0, 116), color(0, 172, 232), "Curva", "Recta");
  Reset = new boton(xBotones, height/2 - dyBotones, anchoBotones, altoBotones, color(245, 102, 0), "Reset");
  
  Tipo = new boton(xBotones, height/2, anchoBotones, altoBotones, color(0, 157, 73), "Ingresos");  //Costos, Gastos
  EjeY = new boton(xBotones, height/2 + dyBotones, anchoBotones, altoBotones, color(0, 157, 73), "EjeY");
  EjeX = new boton(xBotones, height/2 + 2*dyBotones, anchoBotones, altoBotones, color(0, 157, 73), color(0, 157, 73), "Años", "Meses");
  
  Tema = new boton(xBotones, height/2 + 3*dyBotones, anchoBotones, altoBotones, color(192, 0, 116), color(0, 172, 232), "Tema 1", "Tema 2");
}

//----------------------DIBUJAR LOS BOTONES----------------------//

void dibujarBotones(){
  stroke(255);
  strokeWeight(1);
  noFill();
  rect(xBotones -4, Puntos.y -4, anchoBotones +8, 3*dyBotones + altoBotones +8);  //Rectángulo que encierra la categoría del control de los puntos, barras, linea...
  Puntos.dibujar();
  PuntosMas.dibujar();
  PuntosMenos.dibujar();
  Linea.dibujar();
  Reset.dibujar();
  
  stroke(255);
  strokeWeight(1);
  noFill();
  rect(xBotones -4, Tipo.y -4, anchoBotones +8, 2*dyBotones + altoBotones + 8);  //Rectángulo que encierra la categoría del control de los puntos, barras, linea...
  Tipo.dibujar();
  EjeY.dibujar();
  EjeX.dibujar();
  
  Tema.dibujar();
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
  boolean valMax = false;
  String info1 = "Desactivado";
  String info2 = "Activado";
  int txtSize = 13;
  
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
    
    if(mslc && !valMax)  strokeWeight(4);  //Si el mouse está sobre el botón y no esta el valor máximo
    else  strokeWeight(1);
    
    if((prsd && cambiaColor) || valMax){  //Si el botón cambia de color y está activado se dibuja de Color2
      stroke(Color2);
      fill(Color2);
    }else{
      stroke(Color1);
      fill(Color1);
    }
    rect(x, y, ancho, alto);
    fill(255);
    textSize(txtSize);
    textAlign(CENTER,CENTER);
    if(prsd && cambiaColor){
      text(info2, x + ancho/2, y + alto/2);
    }else{
      text(info1, x + ancho/2, y + alto/2);
    }
  }
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
  
  //----------------------CAMBIO DEL NUMERO DE BARRAS----------------------//
  
  if(PuntosMas.prsd){
    if(numBarras == numMaxBarras)  PuntosMas.valMax = true;  //Si se alcanzo el valor máximo se pinta de otro color
    else  cambiarNumBarras(true);
    PuntosMenos.valMax = false;  //Si se el valor aumenta o se queda igual por tanto se "desactiva" el color2 de PuntosMenos
    PuntosMas.prsd = false;
  }
  if(PuntosMenos.prsd){
    if(numBarras == 1)  PuntosMenos.valMax = true;
    else  cambiarNumBarras(false);
    PuntosMas.valMax = false;
    PuntosMenos.prsd = false;
  }
  
  //----------------------RESET----------------------//
  
  if(Reset.prsd){
    for(int b = 0; b < numBarras; b++){
      Barras[b].reset();
    }
    Reset.prsd = false;
  }
  
  //----------------------TIPO----------------------//
  
  if(Tipo.prsd){
    if(Titulo1 == "Ingresos")  Titulo1 = "Costos";
    else if(Titulo1 == "Costos")  Titulo1 = "Gastos";
    else if(Titulo1 == "Gastos")  Titulo1 = "Ingresos";
    Tipo.prsd = false;
  }
  
  //----------------------EJE Y----------------------//
  
  if(EjeY.prsd){
    if(yMax == 100)  yMax = 500;
    else if(yMax == 1000) yMax = 100;
    else  yMax += 1000;
    yMax = constrain(yMax, 0, 1000);
    
    EjeY.prsd = false;
  }
  
  //----------------------AÑOS-MESES----------------------//
  
  if(EjeX.prsd){  //Años
    for(int b = 0; b < numBarras; b++){
      text(year() - b, Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La última barra es la del presente año y las anteriores son las de los años anteriores
    }
    Titulo2 = "Anuales";
  }if(!EjeX.prsd){  //Meses
    String [] meses = {"EN", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGTO", "SEPT", "OCT", "NOV", "DIC"};
    int mes = month();
    for(int b = 0; b < numBarras; b++){
      mes--;
      if(mes < 0)  mes = 11;
      text(meses[mes], Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La ultima barra es la del mes actual
    }
    Titulo2 = "Mensuales";
  }
  
}
