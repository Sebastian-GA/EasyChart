
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

int numBotones = 10;
boton [] Botones = new boton[numBotones];

int xBotones;
int dyBotones = 42;  //Separacion en Y de los botones
int anchoBotones = 60;
int altoBotones = 30;

void iniciarBotones(){
  xBotones = width - 90;
  
  //Puntos - Barras
  Botones[0] = new boton(xBotones, height/2 - 4*dyBotones, anchoBotones, altoBotones, 2, 2);
  Botones[0].cambiarTxt(0, "Puntos");
  Botones[0].cambiarTxt(1, "Barras");
  
  //Más o menos puntos-barras
  Botones[1] = new boton(xBotones, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, 3, "+");
  Botones[2] = new boton(xBotones + 30, height/2 - 3*dyBotones, anchoBotones/2, altoBotones, 3, "-");
  Botones[1].txtSize = 20;//Para que los signos se vean más grandes
  Botones[2].txtSize = 20;
  
  //Curva - Recta
  Botones[3] = new boton(xBotones, height/2 - 2*dyBotones, anchoBotones, altoBotones, 2, 3);
  Botones[3].cambiarTxt(0, "Curva");
  Botones[3].cambiarTxt(1, "Recta");
  
  //Reset
  Botones[4] = new boton(xBotones, height/2 - dyBotones, anchoBotones, altoBotones, 4, "Reset");
  
  //Titulo
  Botones[5] = new boton(xBotones, height/2, anchoBotones, altoBotones, 3, 2);
  Botones[5].cambiarTxt(0, "Costos");
  Botones[5].cambiarTxt(1, "Gastos");
  Botones[5].cambiarTxt(2, "Ingresos");
  
  //EjeY
  Botones[6] = new boton(xBotones, height/2 + dyBotones, anchoBotones, altoBotones, 2, "Valor Max");
  //EjeX
  Botones[7] = new boton(xBotones, height/2 + 2*dyBotones, anchoBotones, altoBotones, 2, 2);
  Botones[7].cambiarTxt(0, "Años");
  Botones[7].cambiarTxt(1, "Meses");
  
  //Exportar gráfica
  Botones[8] = new boton(xBotones, height/2 + 3*dyBotones, anchoBotones, altoBotones, 4, "Exportar");
  
  //Cambiar de Tema  //No se muestra (Esta sobre la firma)
  Botones[9] = new boton(xBotones - 10, height/2 + 4*dyBotones, anchoBotones + 20, 20, 4, "Tema");
}

//----------------------DIBUJAR LOS BOTONES----------------------//

void dibujarBotones(){
  stroke(Temas[temaSlct][5]);
  strokeWeight(1);
  noFill();
  rect(xBotones -4, Botones[0].y -4, anchoBotones +8, 3*dyBotones + altoBotones +8);  //Rectángulo que encierra la categoría del control de los puntos, barras, linea...
  rect(xBotones -4, Botones[5].y -4, anchoBotones +8, 2*dyBotones + altoBotones + 8);  //Rectangulo para segunda categoría...
  rect(xBotones -4, Botones[8].y -4, anchoBotones +8, altoBotones + 8);
  for(int b = 0; b < numBotones; b++){
    if(b != 9)  Botones[b].dibujar();  //No dibuja el boton del tema
  }
}

//----------------------CLASE----------------------//

class boton{
  int x, y;
  int alto, ancho;
  int Color1;  //Color del botón (depende del tema)
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  int estado = 0;  //estado en el que está (presionado o no) ó (0,1,2,3,4...)
  int numEstados;  //Numero de posiciones en las que puede estar el botón 
  String [] info;  //Almacena el texto que se muestra en cada estado
  int txtSize = 13;
  
  //Cuando el botón cambia de color al presionarse y tiene varias opciones
  boton(int _x, int _y, int _ancho, int _alto, int _numEstados, int _Color1){
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    
    numEstados = _numEstados;
    info = new String [numEstados];
    
    Color1 = _Color1;
  }
  //Cuando el botón no cambia de color y solo realiza una cosa
  boton(int _x, int _y, int _ancho, int _alto, int _Color1, String _info1){
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
    
    stroke(Temas[temaSlct][Color1]);
    fill(Temas[temaSlct][Color1]);
    rect(x, y, ancho, alto);  //Dibuja el botón
    fill(Temas[temaSlct][6]);
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
  
  if(Botones[0].prsd){  //Si el botón está activado
    strokeWeight(2);
    //Lineas Rectas
    if(!Botones[3].prsd){  //Si está seleccionado dibujar rectas  (No está activado)
      stroke(Temas[temaSlct][5]);
      for(int b = 0; b < numBarras - 1; b++){
        line(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto, Barras[b+1].x + Barras[b].ancho/2, Barras[b+1].y - Barras[b+1].alto);  //Linea que une las barras 
      }
    }else{  //Curva  (Está activado el botón)
      noFill();
      stroke(Temas[temaSlct][5]);
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
  
  if(Botones[1].prsd){
    if(numBarras != numMaxBarras)  cambiarNumBarras(true);
    Botones[1].prsd = false;
  }
  if(Botones[2].prsd){
    if(numBarras != 1)  cambiarNumBarras(false);
    Botones[2].prsd = false;
  }
  
  //----------------------RESET----------------------//
  
  if(Botones[4].prsd){
    for(int b = 0; b < numMaxBarras; b++){
      Barras[b].reset();
    }
    Botones[4].prsd = false;
  }
  
  //----------------------TIPO----------------------//
  
  if(Botones[5].prsd){
    int estadoAnterior;
    estadoAnterior = Botones[5].estado -1;
    if(estadoAnterior < 0)  estadoAnterior = Botones[5].numEstados -1;
    Titulo1 = Botones[5].info[estadoAnterior];
    Botones[5].prsd = false;
  }
  
  //----------------------EJE Y----------------------//
  
  if(Botones[6].prsd){
    if(yMax == 100)  yMax = 500;
    else if(yMax == 1000) yMax = 100;
    else  yMax += 1000;
    yMax = constrain(yMax, 0, 1000);
    
    Botones[6].prsd = false;
  }
  
  //----------------------AÑOS-MESES----------------------//
  
  if(Botones[7].prsd){  //Años
    textFont(Font1);
    fill(Temas[temaSlct][5]);
    for(int b = 0; b < numBarras; b++){
      text(year() - b, Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La última barra es la del presente año y las anteriores son las de los años anteriores
    }
    Titulo2 = "Anuales";
  }if(!Botones[7].prsd){  //Meses
    String [] meses = {"EN", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGTO", "SEPT", "OCT", "NOV", "DIC"};
    int mes = month();
    textFont(Font1);
    fill(Temas[temaSlct][5]);
    for(int b = 0; b < numBarras; b++){
      mes--;
      if(mes < 0)  mes = 11;
      text(meses[mes], Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La ultima barra es la del mes actual
    }
    Titulo2 = "Mensuales";
  }
  
  //----------------------EXPORTAR GRÁFICA----------------------//
  
  if(Botones[8].prsd){
    PImage Chart = get(xGrafica - 50, 0, xBotones - 30, height);  //Solo exporta la gráfica
    Chart.save("charts/"+Titulo1+"_"+Titulo2+numImagen+".png");  //La almacena en la carpeta "charts"
    numImagen++;
    Botones[8].prsd = false;
  }
  
  //----------------------TEMAS DE COLORES----------------------//
  
  if(Botones[9].prsd){
    temaSlct++;
    if(temaSlct >= Temas.length)  temaSlct = 0;
    
    Botones[9].prsd = false;
  }
}
