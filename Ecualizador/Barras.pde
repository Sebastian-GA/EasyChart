/*


*/

//----------------------GENERACIÖN DE LAS BARRAS----------------------//

int numBarras = 15;
barra [] Barras = new barra[numBarras];

//Cordenada inferior izquierda donde se dibuja la gráfica 
int xGrafica;
int yGrafica = height - (height/6);

void iniciarBarras(){
  int _x;  //Posición inferior izquierda de la barra
  int _y = 0;  //Posición inferior de la barra
  int _dxBarras = 30;  //Separación entre barras
  int _a = 20;  //Ancho de las barras
  for(int b = 0; b < numBarras; b++){
    _x = b*_dxBarras;
    Barras[b] = new barra(_x, _y, _a);
  }
}

//----------------------CLASE----------------------//
class barra{
  int x, y;
  int alto = 50;
  int ancho;
  color bColor = color(106,224,11);
  
  barra(int _x, int _y, int _a){
    x = _x;
    y = _y;
    ancho = _a;
  }
  
  
  void display(){
    rect(x, y, -alto, ancho);
    
  }
  
}
