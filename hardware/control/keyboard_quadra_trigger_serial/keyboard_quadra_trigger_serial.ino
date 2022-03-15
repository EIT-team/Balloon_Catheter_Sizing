/*
Software for Arduino Pro Micro - Emulates Keyboard Press for Shortcut in Eliko Software


 */

#include <Keyboard.h>    // This is a "built-in" library no need to install


char cmd;


//---------------------------------------------------------
//                           Setup
//---------------------------------------------------------
void setup() {


Serial.begin(115200);       // begin serial comms for debugging
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

//delay(100);
Serial.println("Hello, Pro Micro Quadra Trigger");

}

//---------------------------------------------------------
//                           Loop
//---------------------------------------------------------

void loop() {
  

  if (Serial.available()>0)
  {
   cmd=Serial.read();
   Serial.print(cmd);

  
 Keyboard.begin();         //begin keyboard 

    Keyboard.press(KEY_LEFT_CTRL);
    Keyboard.press(KEY_LEFT_SHIFT);
    Keyboard.press(KEY_F5);
    delay(500);
    Keyboard.releaseAll();
  Keyboard.end();                 //stops keybord
}

}
