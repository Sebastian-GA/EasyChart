/*



*/

void setup(){
  size(700,500);
  iniciarBarras();
  iniciarBotones();
}

void draw(){
  background(150);
  
  //Dibujar Gráfica
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
    if(izqClick1 == false){
      izqClick1 = true;
    }
    izqClick = true;
  }else{
    izqClick = false;
    izqClick1 = false;
  }
}
