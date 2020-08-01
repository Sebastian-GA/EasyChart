/*



*/

String Titulo1 = "Ingresos";
String Titulo2 = "Anuales";

PFont Font1;
PFont Font2;
int numImagen = 1;

void setup(){
  size(760,400);
  surface.setTitle("Graficador");  //Nombre de la ventana
  
  Font1 = createFont("BebasNeue-Regular.ttf", 13);
  Font2 = createFont("BillionDreams.ttf", 18);
  
  iniciarBotones();
  iniciarBarras();
}

void draw(){
  background(0,0,41);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(Font1);
  textSize(20);
  //text(Titulo1+" "+Titulo2, width/2, height/12);
  text(Titulo1+" "+Titulo2, xGrafica + (numBarras*dxBarras)/2, height/12);
  
  //Dibujar Gráfica
  dibujarEje();
  for(int b = 0; b < numBarras; b++){
    Barras[b].dibujar();
  }
  
  //Botones
  dibujarBotones();
  accionBotones();
  
  textFont(Font2);
  fill(255);
  textAlign(CENTER,CENTER);
  text("by Sebastián", xBotones + anchoBotones/2, height-25);
}


//----------------------CONTROL CLICK----------------------//

void mousePressed(){
 if(mouseButton == LEFT){
   if(Puntos.checarMouse())  Puntos.cambiarEstado();
   else if(PuntosMas.checarMouse())  PuntosMas.cambiarEstado();
   else if(PuntosMenos.checarMouse())  PuntosMenos.cambiarEstado();
   else if(Linea.checarMouse())  Linea.cambiarEstado();
   else if(Reset.checarMouse())  Reset.cambiarEstado();
   else if(Tipo.checarMouse())  Tipo.cambiarEstado();
   else if(EjeX.checarMouse())  EjeX.cambiarEstado();
   else if(EjeY.checarMouse())  EjeY.cambiarEstado();
   else if(Export.checarMouse())  Export.cambiarEstado();
 }
}
void mouseMoved(){
 if(Puntos.checarMouse())  cursor(HAND);
 else if(PuntosMas.checarMouse())  cursor(HAND);
 else if(PuntosMenos.checarMouse())  cursor(HAND);
 else if(Linea.checarMouse())  cursor(HAND);
 else if(Reset.checarMouse())  cursor(HAND);
 else if(Tipo.checarMouse())  cursor(HAND);
 else if(EjeX.checarMouse())  cursor(HAND);
 else if(EjeY.checarMouse())  cursor(HAND);
 else if(Export.checarMouse())  cursor(HAND);
 else  cursor(ARROW);
}
