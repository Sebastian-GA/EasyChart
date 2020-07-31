/*



*/

String nombreApp = "ECUALIZADOR";
PFont Font;

void setup(){
  size(600,300);
  surface.setTitle(nombreApp);  //Nombre de la ventana
  
  Font = createFont("Bebas-Regular.ttf", 32);
  textFont(Font);
  
  iniciarBarras();
  iniciarBotones();
}

void draw(){
  background(0,0,41);
  fill(255);
  textAlign(CENTER,CENTER);
  textSize(20);
  text(nombreApp, width/2, height/12);
  
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
   clickControl(true);
 }
}
void mouseReleased(){
  if(mouseButton == LEFT){
    clickControl(false);
  }
}

void clickControl(boolean state){
  if(izqClick && izqClick1){
    izqClick1 = false;
  }else if(state && !izqClick){//Si está presionado pero antes no lo estaba
    izqClick1 = true;
  }else if(!state){
    izqClick1 = false;
  }
  izqClick = state;
}
