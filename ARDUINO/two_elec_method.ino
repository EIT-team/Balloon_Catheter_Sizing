// mux 1
int s0_1 = 5;
int s1_1 = 4;
int s2_1 = 3;
int s3_1 = 2;

// mux 2
int s0_2 = 13;
int s1_2 = 12;
int s2_2 = 11;
int s3_2 = 10;

int VC = A0;
int amplifier2_output = A2;

// A pin to check values
int sensorPin = A4;

// Initialise values
int VC_value=0;
int channel = 1;
int sensorValue =0;
float gain1 = 1.05;
float gain2 = 2.8;

void setup() {
  
    // mux 1
  pinMode(s0_1, OUTPUT);
  pinMode(s1_1, OUTPUT);
  pinMode(s2_1, OUTPUT);
  pinMode(s3_1, OUTPUT);

    // mux 2
  pinMode(s0_2, OUTPUT);
  pinMode(s1_2, OUTPUT);
  pinMode(s2_2, OUTPUT);
  pinMode(s3_2, OUTPUT);

    Serial.begin(9600);

}

void loop() {

  // read SensorPin
  sensorValue = analogRead(sensorPin); 
  float voltage= sensorValue * (5.0 / 1023.0);
  Serial.print("PIN: ");
  Serial.println(voltage);

  delay(1000);

  //read VC to check current I = V/R R = 10K 
  VC_value = analogRead(VC);
  float VC_value_volts = (VC_value * (5.0 / 1023.0)) / gain1 ;

  Serial.print("VC: ");
  Serial.println(VC_value_volts);

  delay(500);
  
  // Open channels C0-C8

  selectMux1Ch(0);
  selectMux2Ch(8);
    
  // Measure at channels C0-C8
  delay(500);
//  float amplifier2_output_value = analogRead(amplifier2_output);
//  float amplifier2_value_volts = (amplifier2_output_value * (5.0 / 1023.0));
//  float amplifier2_value_resistance = ((amplifier2_value_volts/gain2) * 10000) / VC_value_volts ;
//
//  Serial.print("C0-C8 R: ");
//  Serial.println(amplifier2_value_resistance);

  float average = 0;
  for (int i=0; i < 50; i++) {
  VC_value = analogRead(VC);
  VC_value_volts = (VC_value * (5.0 / 1023.0)) / gain1 ;
  float amplifier2_output_value = analogRead(amplifier2_output);
  float amplifier2_value_volts = (amplifier2_output_value * (5.0 / 1023.0));
  float amplifier2_value_resistance = ((amplifier2_value_volts/gain2) * 10000) / VC_value_volts ;
  average = average + amplifier2_value_resistance ;
  }
  average = average/50;
  
  Serial.print("C0-C8 R avg: ");
  Serial.println(average);

  delay(1000);

  //read VC to check current I = V/R R = 10K 
  float VC_value2 = analogRead(VC);
  float VC_value_volts2 = (VC_value2 * (5.0 / 1023.0)) / gain1 ;

  Serial.print("VC: ");
  Serial.println(VC_value_volts2);

  delay(500);

  // Open channels C2-C10
  selectMux1Ch(2);
  selectMux2Ch(10);
    
  // Measure at channels C2-C10
  delay(500);
//  float amplifier2_output_value2 = analogRead(amplifier2_output);
//  float amplifier2_value_volts2 = amplifier2_output_value2 * (5.0 / 1023.0);
//  float amplifier2_value_resistance2 = ((amplifier2_value_volts2/gain2) * 10000) / VC_value_volts2 ;

  float average2 = 0;
  for (int i=0; i < 50; i++) {
  VC_value2 = analogRead(VC);
  VC_value_volts2 = (VC_value2 * (5.0 / 1023.0)) / gain1 ;
  float amplifier2_output_value2 = analogRead(amplifier2_output);
  float amplifier2_value_volts2 = amplifier2_output_value2 * (5.0 / 1023.0);
  float amplifier2_value_resistance2 = ((amplifier2_value_volts2/gain2) * 10000) / VC_value_volts2;
  average2 = average2 + amplifier2_value_resistance2 ;
  }
  average2 = average2/50;
  
  Serial.print("C2-C10 R: ");
  Serial.println(average2);

  delay(1000);

   //read VC to check current I = V/R R = 10K 
  float VC_value3 = analogRead(VC);
  float VC_value_volts3 = (VC_value3 * (5.0 / 1023.0)) / gain1 ;

  Serial.print("VC: ");
  Serial.println(VC_value_volts3);

  delay(500);


  // Open channels C4-C12
  selectMux1Ch(4);
  selectMux2Ch(12);
    
  // Measure at channels C4-C12
  delay(500);
//  float amplifier2_output_value3 = analogRead(amplifier2_output);
//  float amplifier2_value_volts3 = amplifier2_output_value3 * (5.0 / 1023.0);
//  float amplifier2_value_resistance3 = ((amplifier2_value_volts3/gain2) * 10000) / VC_value_volts3 ;

  float average3 = 0;
  for (int i=0; i < 50; i++) {
  VC_value3 = analogRead(VC);
  VC_value_volts3 = (VC_value3 * (5.0 / 1023.0)) / gain1 ;
  float amplifier2_output_value3 = analogRead(amplifier2_output);
  float amplifier2_value_volts3 = amplifier2_output_value3 * (5.0 / 1023.0);
  float amplifier2_value_resistance3 = ((amplifier2_value_volts3/gain2) * 10000) / VC_value_volts3 ;
  average3 = average3 + amplifier2_value_resistance3 ;
  }
  average3 = average3/50;
  
  Serial.print("C4-C12 R: ");
  Serial.println(average3);

  delay(1000);

   //read VC to check current I = V/R R = 10K 
  float VC_value4 = analogRead(VC);
  float VC_value_volts4 = (VC_value4 * (5.0 / 1023.0)) / gain1 ;

  Serial.print("VC: ");
  Serial.println(VC_value_volts4);

  delay(500);
  
  // Open channels C6-C14
  selectMux1Ch(6);
  selectMux2Ch(14);
    
  // Measure at channels C6-C14
  delay(500);
//  float amplifier2_output_value4 = analogRead(amplifier2_output);
//  float amplifier2_value_volts4 = amplifier2_output_value4 * (5.0 / 1023.0);
//  float amplifier2_value_resistance4 = ((amplifier2_value_volts4/gain2) * 10000) / VC_value_volts4;


  float average4 = 0;
  for (int i=0; i < 50; i++) {
  VC_value4 = analogRead(VC);
  VC_value_volts4 = (VC_value4 * (5.0 / 1023.0)) / gain1 ;
  float amplifier2_output_value4 = analogRead(amplifier2_output);
  float amplifier2_value_volts4 = amplifier2_output_value4 * (5.0 / 1023.0);
  float amplifier2_value_resistance4 = ((amplifier2_value_volts4/gain2) * 10000) / VC_value_volts4;
  average4 = average4 + amplifier2_value_resistance4 ;
  }
  average4 = average4/50;
  
  Serial.print("C6-C14 R: ");
  Serial.println(average4);

  delay(1000);
}


void selectMux1Ch(int channel){
    if (channel==0){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, LOW);
        digitalWrite(s2_1, LOW);
        digitalWrite(s3_1, LOW);
    }
     if (channel==2){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, HIGH);
        digitalWrite(s2_1, LOW);
        digitalWrite(s3_1, LOW);
    }
    if (channel==4){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, LOW);
        digitalWrite(s2_1, HIGH);
        digitalWrite(s3_1, LOW);
    }
    if (channel==6){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, HIGH);
        digitalWrite(s2_1, HIGH);
        digitalWrite(s3_1, LOW);
    }
    if (channel==8){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, LOW);
        digitalWrite(s2_1, LOW);
        digitalWrite(s3_1, HIGH);
    }
    if (channel==10){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, HIGH);
        digitalWrite(s2_1, LOW);
        digitalWrite(s3_1, HIGH);
    }
    if (channel==12){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, LOW);
        digitalWrite(s2_1, HIGH);
        digitalWrite(s3_1, HIGH);
    }
    if (channel==14){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, HIGH);
        digitalWrite(s2_1, HIGH);
        digitalWrite(s3_1, HIGH);
    }

}


void selectMux2Ch(int channel){
    if (channel==0){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, LOW);
        digitalWrite(s2_2, LOW);
        digitalWrite(s3_2, LOW);
    }
     if (channel==2){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, HIGH);
        digitalWrite(s2_2, LOW);
        digitalWrite(s3_2, LOW);
    }
    if (channel==4){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, LOW);
        digitalWrite(s2_2, HIGH);
        digitalWrite(s3_2, LOW);
    }
    if (channel==6){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, HIGH);
        digitalWrite(s2_2, HIGH);
        digitalWrite(s3_2, LOW);
    }
    if (channel==8){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, LOW);
        digitalWrite(s2_2, LOW);
        digitalWrite(s3_2, HIGH);
    }
    if (channel==10){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, HIGH);
        digitalWrite(s2_2, LOW);
        digitalWrite(s3_2, HIGH);
    }
    if (channel==12){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, LOW);
        digitalWrite(s2_2, HIGH);
        digitalWrite(s3_2, HIGH);
    }
    if (channel==14){
        digitalWrite(s0_2, LOW);
        digitalWrite(s1_2, HIGH);
        digitalWrite(s2_2, HIGH);
        digitalWrite(s3_2, HIGH);
    }

}
