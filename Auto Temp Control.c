/* Automatic temperature Monitor for house Appliance
    MCU  PIC18F45K22
    Designer Pitias T Fessahaie
    Oscillator    HS_PLL 8Mhz*/

// Keypad module connections
char  keypadPort at PORTB;

// LCD module connections
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D4 at RC0_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D7 at RC3_bit;


sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC0_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D7_Direction at TRISC3_bit;
// End LCD module connections

const char character[] = {15,29,27,23,30,24,24,24};

void CustomChar(char pos_row, char pos_char) {
  char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}
#define HEATER PORTD.RD0
#define FAN PORTD.RD1
#define ENTER 15
#define CLEAR 13
#define ON 1
#define OFF 0

void main()
{
unsigned short kp,txt[14];
unsigned short Temp_Ref;
unsigned char inTemp;
unsigned int temp;
float mv, ActualTemp;
ANSELC = 0;                     //configure port c digital i/o
ANSELB = 0;                     // configure port b digital i/o
ANSELD = 0;                     //configure port d digital i/o
TRISA0_bit = 1;                 //LM35 reading AO as input
TRISC = 0;                      //PORTC are output 4 LCD
TRISD0_bit=0;                   //RD0 output heater
TRISD1_bit=0;                   //RD1 output fan

keypad_Init();                      // Initialize keypad
Lcd_Init();                        // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,4, "Automatic");                 // Write text in first row
  Lcd_Out(2,2, "Temp Control");                 // Write text in second row
  Delay_ms(1200);
  
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,3, "DESIGNED BY");
  CustomChar(2,2);                 // Write text in first row
  Lcd_Out(2,3, "itias Tsegu");     // Write text in second row
  Delay_ms(800);
  HEATER = OFF;
  FAN = OFF;
           //on start up read the temp from key pad
 START:
   Lcd_Cmd(_LCD_CLEAR);          // Cursor off
  Lcd_Out(1,1,"Enter Temp Ref");
  Temp_Ref=0;                 // Write text in first row
  Lcd_Out(2,1,"Temp Ref:");                 // Write text in second row
  while(1)
  { 
  do
  kp = Keypad_Key_Click();             // Store key code in kp variable
  while(!kp);
  if(kp == ENTER)break;
  if(kp > 3 && kp < 8) kp = kp-1;
  if(kp > 8 && kp < 12) kp = kp-2;
  if(kp ==14) kp=0;
  if(kp ==CLEAR) 
  goto START;
  Lcd_Chr_Cp(kp +'0');
  Temp_Ref=(10*Temp_Ref)+kp;
  }
      Lcd_Cmd(_LCD_CLEAR);                     // Clear display
      Lcd_Out(1,1,"Temp Ref:");
      intToStr(Temp_Ref,Txt);                     // Convert to String
      inTemp=Ltrim(Txt);
      
     Lcd_Out_CP(inTemp);
     Lcd_Out(2,1, "Press # to Cont.");
     kp = 0;
     while(kp!=ENTER)
     {
             do
          kp = Keypad_Key_Click();
          while(!kp);    //store key code var kp
     }
         Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1, "Temp Ref:");
          Lcd_Chr(1,15,223);      //Display degree sign
          Lcd_Chr(1,16,'C');     //Display C for celcius
                 
                 //program loop
                 
                 while(1)
     {
                  temp= ADC_Read(0);
                 mv = (temp * 5000.0)/1024.0;
                 ActualTemp= mv/10.0;
                 intToStr(Temp_Ref,Txt);
                 
                 inTemp=Ltrim(Txt);
                 Lcd_Out(1,11,InTemp);
                 Lcd_Out(2,1,"Temp= ");
                 FloatToStr(ActualTemp,Txt);
                 Txt[4]=0;
                 Lcd_Out(2,7,Txt);
                 Lcd_Out(2,12,"   ");
                 
                 if(Temp_Ref > ActualTemp)
                 { HEATER = OFF;
                  FAN =ON;}
                 if(Temp_Ref < ActualTemp)
                 { HEATER = ON;
                  FAN = OFF;}
                 if(Temp_Ref == ActualTemp)
                 { HEATER = OFF; 
                 FAN = OFF;}
                 Delay_ms(1000);
     }
}