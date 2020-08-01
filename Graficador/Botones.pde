
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

boton [] BotonesB = new boton[numBarras];  //Botones de cada barra
boton Reset, Puntos, PuntosMas, PuntosMenos, Linea;
boton Tipo, EjeX, EjeY;
boton Export;

int xBotones;
int dyBotones = 42;  //Separacion en Y de los botones
int anchoBotones = 60;
int altoBotones = 30;

void iniciarBotones(){
  xBotones = width - 90;
  
  Puntos = new boton(xBotones, height/2 - 4*dyBotones, anchoBotones, altoBotones, 2, color(0, 157, 73));
  Puntos.cambiarTxt(0, "Puntos");
  Puntos.cambiarTxt(1, "Barras");
  
  PuntosMas = new boton(xBotones, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, color(192, 0, 116), "+");
  PuntosMenos = new boton(xBotones + 30, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, color(192, 0, 116), "-");
  PuntosMas.txtSize = 20;//Para que los signos se vean más grandes
  PuntosMenos.txtSize = 20;
  
  Linea = new boton(xBotones, height/2 - 2*dyBotones, anchoBotones, altoBotones, 2, color(192, 0, 116));
  Linea.cambiarTxt(0, "Curva");
  Linea.cambiarTxt(1, "Recta");
  
  Reset = new boton(xBotones, height/2 - dyBotones, anchoBotones, altoBotones, color(245, 102, 0), "Reset");
  
  Tipo = new boton(xBotones, height/2, anchoBotones, altoBotones, 3, color(0, 157, 73));
  Tipo.cambiarTxt(0, "Costos");
  Tipo.cambiarTxt(1, "Gastos");
  Tipo.cambiarTxt(2, "Ingresos");
  
  EjeY = new boton(xBotones, height/2 + dyBotones, anchoBotones, altoBotones, color(0, 157, 73), "Valor Max");
  
  EjeX = new boton(xBotones, height/2 + 2*dyBotones, anchoBotones, altoBotones, 2, color(0, 157, 73));
  EjeX.cambiarTxt(0, "Años");
  EjeX.cambiarTxt(1, "Meses");
  
  Export = new boton(xBotones, height/2 + 3*dyBotones, anchoBotones, altoBotones, color(245, 102, 0), "Exportar");
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
  rect(xBotones -4, Tipo.y -4, anchoBotones +8, 2*dyBotones + altoBotones + 8);
  Tipo.dibujar();
  EjeY.dibujar();
  EjeX.dibujar();
  
  stroke(255);
  strokeWeight(1);
  noFill();
  rect(xBotones -4, Export.y -4, anchoBotones +8, altoBotones + 8);  //Rectángulo que encierra la categoría del control de los puntos, barras, linea...
  Export.dibujar();
}

//----------------------CLASE----------------------//

class boton{
  int x, y;
  int alto, ancho;
  color Color1;  //Color del botón
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  int estado = 0;  //estado en el que está (presionado o no) ó (0,1,2,3,4...)
  int numEstados;  //Numero de posiciones en las que puede estar el botón 
  String [] info;  //Almacena el texto que se muestra en cada estado
  int txtSize = 13;
  
  //Cuando el botón cambia de color al presionarse y tiene varias opciones
  boton(int _x, int _y, int _ancho, int _alto, int _numEstados, color _Color1){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    
    numEstados = _numEstados;
    info = new String [numEstados];
    
    Color1 = _Color1;
  }
  //Cuando el botón no cambia de color y solo realiza una cosa
  boton(int _x, int _y, int _ancho, int _alto, color _Color1, String _info1){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    
    numEstados = 1;
    info = new String [numEstados];
    info[0] = _info1;
    
    Color1 = _Color1;
  }
  
  void cambiarTxt(int _i, String _info){
    _i = constrain(_i, 0, numEstados -1);
    info[_i] = _info;
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
  
  int cambiarEstado(){
    prsd = !prsd;
    estado++;
    if(estado == numEstados)  estado = 0;  //Se resetea al llegar al máximo
    return estado;
  }
  
  void dibujar(){
    
    if(mslc)  strokeWeight(4);  //Si el mouse está sobre el botón y no esta el valor máximo
    else  strokeWeight(1);
    
    stroke(Color1);
    fill(Color1);
    rect(x, y, ancho, alto);  //Dibuja el botón
    fill(255);
    textFont(Font1);
    textSize(txtSize);
    textAlign(CENTER,CENTER);
    if(info[estado] != null){
      text(info[estado], x + ancho/2, y + alto/2);
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
    if(numBarras != numMaxBarras)  cambiarNumBarras(true);
    PuntosMas.prsd = false;
  }
  if(PuntosMenos.prsd){
    if(numBarras != 1)  cambiarNumBarras(false);
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
    int estadoAnterior;
    estadoAnterior = Tipo.estado -1;
    if(estadoAnterior < 0)  estadoAnterior = Tipo.numEstados -1;
    Titulo1 = Tipo.info[estadoAnterior];
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
      textFont(Font1);
      text(year() - b, Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La última barra es la del presente año y las anteriores son las de los años anteriores
    }
    Titulo2 = "Anuales";
  }if(!EjeX.prsd){  //Meses
    String [] meses = {"EN", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGTO", "SEPT", "OCT", "NOV", "DIC"};
    int mes = month();
    textFont(Font1);
    for(int b = 0; b < numBarras; b++){
      mes--;
      if(mes < 0)  mes = 11;
      text(meses[mes], Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La ultima barra es la del mes actual
    }
    Titulo2 = "Mensuales";
  }
  
  //----------------------EXPORTAR GRÁFICA----------------------//
  
  if(Export.prsd){
    
    PImage Graph = get(xGrafica - 50, 0, xBotones - 30, height);
    Graph.save(Titulo1+"_"+Titulo2+numImagen+".png");
    numImagen++;
    
    Export.prsd = false;
  }
}
