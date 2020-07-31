/*



*/

String Titulo = "Ingresos Mensuales";

void setup(){
  size(600,300);
  surface.setTitle("Graficador");  //Nombre de la ventana
  
  textFont(createFont("Bebas-Regular.ttf", 32));
  
  iniciarBarras();
  iniciarBotones();
}

void draw(){
  background(0,0,41);
  fill(255);
  textAlign(CENTER,CENTER);
  textSize(20);
  text(Titulo, width/2, height/12);
  
  //Dibujar Gráfica
  dibujarEje();
  for(int b = 0; b < numBarras; b++){
    Barras[b].dibujar();
  }
  
  //Botones
  dibujarBotones();
  accionBotones();
}

//----------------------CONTROL CLICK----------------------//

boolean izqClick = false;
boolean izqClick1 = false;

void mousePressed(){
 if(mouseButton == LEFT){
   if(Puntos.checarMouse())  Puntos.cambiarEstado();
   else if(Linea.checarMouse())  Linea.cambiarEstado();
   else if(Reset.checarMouse())  Reset.cambiarEstado();
   else if(EjeX.checarMouse())  EjeX.cambiarEstado();
   else if(EjeY.checarMouse())  EjeY.cambiarEstado();
 }
}