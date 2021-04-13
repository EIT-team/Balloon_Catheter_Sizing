// S channels on mux to digital pins

int s0_1 = 13;
int s1_1 = 12;
int s2_1 = 11;
int s3_1 = 10;
//int sig = 29;

//int SIG_pin = A10;
int VC = A0;

int sensorPin = A2; 
//int sensorPin = 51;

int sensorValue = 0; 
int sig_val_read = 0;
int vc = 0;
int channel = 0;

void setup() {

    // multiplexer 1
    
    pinMode(s0_1, OUTPUT);
    pinMode(s1_1, OUTPUT);
    pinMode(s2_1, OUTPUT);
    pinMode(s3_1, OUTPUT);
    
    //pinMode(8, OUTPUT);
    //pinMode(sig, OUTPUT);
   
    Serial.begin(9600);
   
    
}

void loop(){
    // selectMux1Ch(14); // channel to open
    digitalWrite(s0_1, LOW);
    digitalWrite(s1_1, LOW);
    digitalWrite(s2_1, LOW);
    digitalWrite(s3_1, LOW);
    
    //digitalWrite(sig, HIGH);
  
    digitalWrite(8, HIGH);

    // Read sig from A10
    //sig_val_read = analogRead(SIG_pin);
    //float voltage = sig_val_read * (5.0 / 1023.0);
    
     // read pin from A1
     sensorValue = analogRead(sensorPin); 
     float voltage= sensorValue * (5.0 / 1023.0);

      
     // read pin from A0 (amplifier1)
     //vc = analogRead(VC);
     //float voltage= vc * (5.0 / 1023.0);

     
    Serial.println(voltage);
    delay(1000);

    
}

// channel 15 open
void selectMux1Ch(int channel){
    if (channel==15){
        digitalWrite(s0_1, LOW);
        digitalWrite(s1_1, HIGH);
        digitalWrite(s2_1, HIGH);
        digitalWrite(s3_1, HIGH);
    }

    
// here we need to add similar else if conditions for other pins

}
