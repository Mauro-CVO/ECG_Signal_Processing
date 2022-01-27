
float signal_ecg; // Crea Variable tipo float

void setup(){
// Inicializamos comunicacion serial con el microcontrolador
  Serial.begin(9600); 
  
}
void loop() {
// Leemos la señal del ECG y la asignamos a signal_ecg
  signal_ecg = analogRead(A0); 
// Mapeamos el valor de signal_ecg de 0-1024 a 0-5
  signal_ecg = (signal_ecg/1024.0)*5; //
//Imprimimos signal_ecg
  Serial.println(signal_ecg);
//Delay de 10 microsegundos
  delay(10);

}
