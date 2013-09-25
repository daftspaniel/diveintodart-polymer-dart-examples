import 'dart:html';
//The Editor wants the following import but if it is uncommented the demo will not run.
//import 'BinaryClock.dart';

main() {
  print("Main");
  Element elem = query('#clock');
  BinaryClock myClock = elem.xtag;
  myClock.initTime();
}
