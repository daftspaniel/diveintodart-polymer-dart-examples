import 'dart:html';
import 'dart:math';

void main() {
  query("#surface")
  ..onClick.listen(drawRose);
  
  CanvasElement surface = query("#surface");
  CanvasRenderingContext2D crc = surface.getContext("2d");
  crc.fillText("Click Me!", 370, 300, 999);
}

String randomRGBA(){ Random rng = new Random();return 'rgba('+ rng.nextInt(255).toString() +',' + rng.nextInt(255).toString() +',' + rng.nextInt(255).toString() + ',.6)';}
double deg2rads(d){return d * PI / 180;}

int a = 8;
int b = 16;
int c = 16;
int tx = 0;
int ty = 0;
int canvasx = 0;
int canvasy = 0;
int clickcount = 0;

void drawRose(MouseEvent event) {
  
  CanvasElement surface = query("#surface");
  CanvasRenderingContext2D crc = surface.getContext("2d");
    
  clickcount++;
  if (clickcount==1){
    crc.clearRect(0, 0, 800, 600);  
  }
  
  crc.translate(tx, ty);

  canvasx = event.client.x - surface.clientTop;
  canvasy = event.client.y - surface.clientTop;
  crc.translate(canvasx, canvasy);
  tx = -1 * canvasx;
  ty = -1 * canvasy;

  double radius = 20.0;
  double rad = 0.0;
  
  for(int j=1; j<10;j++){
    
    crc.beginPath();
    
    for(int i=0; i<360;i++){
      var rad = deg2rads(i);
      rose(crc, rad, radius);  
    }
    
    radius -= 10;
    crc.closePath();
    
    crc.fillStyle = randomRGBA();
    crc.strokeStyle = randomRGBA();
    crc.fill();
    crc.stroke();
    
  }
}  
 
void rose(crc, radian, r) {
       
  var k = 2 + sin( a * radian ) / 2;
  var tt = radian + sin( b * radian ) / c;
  var valueX = r * k * cos( tt );
  var valueY = -(r * k * sin( tt ));
       
  crc.lineTo(valueX, valueY);
     
}    


