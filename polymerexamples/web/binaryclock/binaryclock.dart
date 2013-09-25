library binary_clock;
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

@CustomTag('binary-clock')
class BinaryClock extends PolymerElement  {

  String _value = "null";
  int _size = 256;
  CanvasElement _ca;  
  CanvasRenderingContext2D _crc;
  Timer _atimer = null;
  
  List<String> _history = new List<String>();
  
  BinaryClock(){}
  
  void initTime() {
    if(_atimer==null){
      _atimer = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => updateTime());
    }
    draw();
  }  
 
  void draw() {
    
    if (_ca == null)
    {            
      _ca = shadowRoot.query("#surface");
      if (_ca==null) return;
    }
    
    if (_crc == null){
      _crc= _ca.getContext("2d");
      if (_crc==null) return;
    }
    
    int l = _history.length;
    int rows = 0;
    int startcol = 255;
    int square = 16;
    for (String bintime in _history.reversed)
    {        
        int v = (startcol - rows*10);
        int vv = 255- (startcol - rows*10);
        
        for(int i=0;i<bintime.length;i++){
          String ch = bintime[i];
          if (ch=="1") 
            _crc.fillStyle = 'rgb(255, $v, $vv)';
          else
            _crc.fillStyle = 'rgb($v, 255, 255)';
          
          _crc.fillRect(i*square, rows*square, square, square);
          _crc.fillRect((768-square) - i*square, rows*square, square, square);
          
          _crc.strokeStyle = 'rgb(225, 225, 225)';
          _crc.strokeRect(i*square, rows*square, square, square);
          _crc.strokeRect((768-square) - i*square, rows*square, square, square);
        }
      rows++;
    }
  }
    
   void updateTime()
   {
     int numtime = new DateTime.now().millisecondsSinceEpoch ~/ 1000;
     String binary = numtime.toRadixString(2);
     _value = binary.substring(binary.length-24);
     _history.add(_value);
     if (_history.length>24) _history.removeAt(0);   
     draw();
   }
  
}

