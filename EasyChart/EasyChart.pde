/*
------------------------EasyChart------------------------

Autor: Sebastián García Angarita
Fecha: 02/Agosto/2020

...

*/

String Titulo1 = "Ingresos";
String Titulo2 = "Anuales";

PFont Font1;
PFont Font2;
int numImagen = 1;  //Tema que se muestra

int temaSlct = 0;
                   //      Background          Barras             Boton1             Boton2               Boton3         Texto1(General)          Texto2(Botones)
color [][] Temas = {{color(0, 0, 041), color(147, 195, 70), color(0, 157, 73), color(192, 0, 116), color(245, 102, 0), color(255, 255, 255), color(255, 255, 255)},
                    {color(255, 255, 255), color(40, 49, 073), color(0, 129, 138), color(0, 129, 138), color(40, 49, 073), color(40, 49, 73), color(255, 255, 255)},
                    {color(255, 255, 255), color(78, 240, 055), color(0, 183, 194), color(18, 132, 148), color(18, 132, 148), color(0, 0, 0), color(255, 255, 255)},
                    {color(244, 244, 244), color(240, 165, 0), color(207, 117, 0), color(240, 165, 0), color(0, 0, 0), color(0, 0, 0), color(255, 255, 255)},
                    {color(7, 3, 26), color(251, 212, 109), color(251, 212, 109), color(79, 138, 139), color(7, 3, 26), color(255, 255, 255), color(255, 255, 255)},
                    {color(255, 255, 255), color(232, 74, 95), color(232, 74, 95), color(254, 206, 171), color(232, 74, 95), color(0, 0, 0), color(255, 255, 255)},
                    {color(235, 232, 190), color(52, 122, 42), color(32, 46, 36), color(179, 200, 122), color(32, 46, 36), color(32, 46, 36), color(255, 255, 255)}};


void setup(){
  size(760,400);
  surface.setTitle("Graficador");  //Nombre de la ventana
  
  Font1 = createFont("BebasNeue-Regular.ttf", 13);
  Font2 = createFont("BillionDreams.ttf", 18);
  
  iniciarBotones();
  iniciarBarras();
}

void draw(){
  background(Temas[temaSlct][0]);
  fill(Temas[temaSlct][5]);
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
  fill(Temas[temaSlct][5]);
  textAlign(CENTER,CENTER);
  text("by Sebastián", xBotones + anchoBotones/2, height-25);
}


//----------------------CONTROL CLICK----------------------//

void mousePressed(){
 if(mouseButton == LEFT){
   for(int b = 0; b < numBotones; b++){
     if(Botones[b].checarMouse()){
       Botones[b].cambiarEstado();
       break;
     }
   }
 }
}

void mouseMoved(){
  for(int b = 0; b < numBotones; b++){
   if(Botones[b].checarMouse()){
     cursor(HAND);
     break;
   }
   cursor(ARROW);
  }
}
