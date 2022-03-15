/*

Syringe pump firmware for UStepper S-Lite board

*/



//Libraries Included
#include <Wire.h>
#include <SparkFun_MS5803_I2C.h> // Click here to get the library: http://librarymanager/All#SparkFun_MS5803-14BA
#include <uStepperSLite.h>

//Code defining variables for pressure sensor

// Begin class with selected address
// available addresses (selected by jumper on board)
// default is ADDRESS_HIGH

//  ADDRESS_HIGH = 0x76
//  ADDRESS_LOW  = 0x77

MS5803 sensor(ADDRESS_HIGH);

//Create variables to store results
double pressure_abs, pressure_baseline, pressure_diff;

//Code defining variables for syringe pump

#define MAXACCELERATION 1500         //Max acceleration = 1500 Steps/s^2
#define MAXVELOCITY 1100           //Max velocity = 1100 steps/s

uStepperSLite stepper(MAXACCELERATION, MAXVELOCITY);

char cmd;

// Change the value of "th" for pressure threshold
int th=10000;



// this code reports pressure value after 4 and 5 so can be read by pc


void setup() {

    //Initialize Serial Monitor
  Serial.begin(115200);
  Serial.println("Syringe Pump!");

// Code for setting up syringe pump
  

// Code for setting up pressure sensor
// Start your preferred I2C object
  Wire.begin();

  //Retrieve calibration constants for conversion math.
  sensor.reset();
  sensor.begin();
  stepper.setup();
  pressure_baseline = sensor.getPressure(ADC_4096);
  Serial.print("Enter 1 to move forward continuously\nEnter 2 to move backward continuously\nEnter 3 to STOP\nEnter 4 to move forward with specific steps\nEnter 5 to move backward with specific steps\nEnter 0 to go back to the initial point\nEnter p to read pressure\nEnter r to reset the pump and the initial point\nEnter y to use the pump to balance the pressure at this point\nThere is a pressure threshold which is 100 hPa to triger the protection program\n change the value of th if you would like to change the threshold."); 
}

void userinput(){
  if (Serial.available()>0)
  {
   cmd=Serial.read();
   Serial.println(cmd);
  }
  else{
  cmd=0; // reset cmd intro if no input
  }
}

void pressurecalc(){
  pressure_abs=sensor.getPressure(ADC_4096);
  pressure_diff=pressure_abs-pressure_baseline;
}

void pumpcontrol(){
  if(cmd=='1')
  {
    stepper.runContinous(CCW);
  }
  else if(cmd=='2')
  {
    stepper.runContinous(CW);
  }
  else if(cmd=='3')
  {
    stepper.softStop(HARD);
    Serial.println(stepper.getStepsSinceReset());
    //stepper.setup();
  }
  else if(cmd=='r')
  {
    stepper.setup();
    Serial.print("Pump Reseted");
  }
  else if(cmd=='4')
  {
    Serial.print("Enter the steps for moving forward");
    while(Serial.available()==0)
    {
    }

    stepper.moveSteps(Serial.parseInt(),CCW);

    // wait till motor is finished
    while(stepper.getMotorState())
    {
      //do nothing
    }
    //pressurecalc();
    //Serial.println(pressure_abs);
    Serial.println("f");
  }
  else if(cmd=='5')
  {
    Serial.print("Enter the steps for moving backward");
    while(Serial.available()==0)
    {
    }
    stepper.moveSteps(Serial.parseInt(),CW);
// wait till motor is finished
    while(stepper.getMotorState())
    {
      //do nothing
    }
    //pressurecalc();
    //Serial.println(pressure_abs);
    Serial.println("f");
  }
  else if(cmd=='p')
  {
    //read pressure
     pressurecalc();
    Serial.println(pressure_abs);   
  }
  else if(cmd=='0')
  {
    if (stepper.getStepsSinceReset()>0)
    {
      while (stepper.getStepsSinceReset()>0)
      {
        userinput();
        if (cmd=='3')
        {
          break;
        }
        stepper.moveSteps(1,CCW);
      }
      cmd=3;
    }
    else if (stepper.getStepsSinceReset()<0)
    {
      while (stepper.getStepsSinceReset()<0)
      {
        userinput();
        if (cmd=='3')
        {
          break;
        }
        stepper.moveSteps(1,CW);
      }
      cmd=3;
    }
  }
  else if (cmd=='y')
  {
    pressure_baseline = sensor.getPressure(ADC_4096);
    pressurecalc();
    while(pressure_diff>0)
    {
      userinput();
      if (cmd=='3')
      {
        break;
      }
      stepper.moveAngle(10);
      pressurecalc();
      Serial.print("The absolute pressure is higher than expected \n");
      Serial.println(pressure_abs);
      Serial.print("The pressure diff is  \n");
      Serial.println(pressure_diff);
      cmd='y';
    }
    while(pressure_diff<0)
    {
      userinput();
      if (cmd=='3')
      {
        break;
      }
      stepper.moveAngle(-10);
      pressurecalc();
      Serial.print("The absolute pressure is lower than expected \n");
      Serial.println(pressure_abs);
      Serial.print("The pressure diff is  \n");
      Serial.println(pressure_diff);
      cmd='y';
    }
  }
}



void loop() {
  // put your main code here, to run repeatedly:
  userinput();
  pressurecalc();
  //Serial.println(pressure_abs);
  //Serial.println(stepper.getStepsSinceReset());
  if (pressure_diff>th)
  {
    stepper.softStop(HARD);
    Serial.print("Pressure too high, going back to the inital pressure\n");
    Serial.print("The high pressure is:\n");
    Serial.println(pressure_abs);
    while(pressure_diff>0)
    {
      userinput();
      if (cmd=='3')
      {
        break;
      }
      stepper.moveAngle(10);
      pressurecalc();
    }
    stepper.softStop(HARD);
    Serial.print("The pressure now is:\n");
    Serial.println(pressure_abs);
  }
  else if (pressure_diff<-th)
  {
    stepper.softStop(HARD);
    Serial.print("Pressure too low, going back to the inital pressure\n");
    Serial.print("The low pressure is:\n");
    Serial.println(pressure_abs);
    while(pressure_diff<0)
    {
      userinput();
      if (cmd=='3')
      {
        break;
      }
      stepper.moveAngle(-10);
      pressurecalc();
    }
    stepper.softStop(HARD);
    Serial.print("The pressure now is:\n");
    Serial.println(pressure_abs);
  }
  pumpcontrol();
}
