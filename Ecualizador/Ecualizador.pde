/*



*/

void setup(){
  size(700,300);
  iniciarBarras();
  iniciarBotones();
}

void draw(){
  background(150);
  
  //Dibujar Gráfica
  dibujarEje();
  for(int b = 0; b < numBarras; b++){
    Barras[b].dibujar();
  }
  
  //Dibujar Botones
  Reset.dibujar();
  Linea.dibujar();
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
