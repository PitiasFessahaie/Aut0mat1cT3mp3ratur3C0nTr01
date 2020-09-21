
_CustomChar:

;Auto Temp Control.c,28 :: 		void CustomChar(char pos_row, char pos_char) {
;Auto Temp Control.c,30 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,31 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar0:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar1
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar0
L_CustomChar1:
;Auto Temp Control.c,32 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,33 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Auto Temp Control.c,34 :: 		}
L_end_CustomChar:
	RETURN      0
; end of _CustomChar

_main:

;Auto Temp Control.c,42 :: 		void main()
;Auto Temp Control.c,49 :: 		ANSELC = 0;                     //configure port c digital i/o
	CLRF        ANSELC+0 
;Auto Temp Control.c,50 :: 		ANSELB = 0;                     // configure port b digital i/o
	CLRF        ANSELB+0 
;Auto Temp Control.c,51 :: 		ANSELD = 0;                     //configure port d digital i/o
	CLRF        ANSELD+0 
;Auto Temp Control.c,52 :: 		TRISA0_bit = 1;                 //LM35 reading AO as input
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;Auto Temp Control.c,53 :: 		TRISC = 0;                      //PORTC are output 4 LCD
	CLRF        TRISC+0 
;Auto Temp Control.c,54 :: 		TRISD0_bit=0;                   //RD0 output heater
	BCF         TRISD0_bit+0, BitPos(TRISD0_bit+0) 
;Auto Temp Control.c,55 :: 		TRISD1_bit=0;                   //RD1 output fan
	BCF         TRISD1_bit+0, BitPos(TRISD1_bit+0) 
;Auto Temp Control.c,57 :: 		keypad_Init();                      // Initialize keypad
	CALL        _Keypad_Init+0, 0
;Auto Temp Control.c,58 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;Auto Temp Control.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,61 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,62 :: 		Lcd_Out(1,4, "Automatic");                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,63 :: 		Lcd_Out(2,2, "Temp Control");                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,64 :: 		Delay_ms(1200);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       45
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;Auto Temp Control.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,68 :: 		Lcd_Out(1,3, "DESIGNED BY");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,69 :: 		CustomChar(2,2);                 // Write text in first row
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;Auto Temp Control.c,70 :: 		Lcd_Out(2,3, "itias Tsegu");     // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,71 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;Auto Temp Control.c,72 :: 		HEATER = OFF;
	BCF         PORTD+0, 0 
;Auto Temp Control.c,73 :: 		FAN = OFF;
	BCF         PORTD+0, 1 
;Auto Temp Control.c,75 :: 		START:
___main_START:
;Auto Temp Control.c,76 :: 		Lcd_Cmd(_LCD_CLEAR);          // Cursor off
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,77 :: 		Lcd_Out(1,1,"Enter Temp Ref");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,78 :: 		Temp_Ref=0;                 // Write text in first row
	CLRF        main_Temp_Ref_L0+0 
;Auto Temp Control.c,79 :: 		Lcd_Out(2,1,"Temp Ref:");                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,80 :: 		while(1)
L_main5:
;Auto Temp Control.c,82 :: 		do
L_main7:
;Auto Temp Control.c,83 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;Auto Temp Control.c,84 :: 		while(!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;Auto Temp Control.c,85 :: 		if(kp == ENTER)break;
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	GOTO        L_main6
L_main10:
;Auto Temp Control.c,86 :: 		if(kp > 3 && kp < 8) kp = kp-1;
	MOVF        main_kp_L0+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
	MOVLW       8
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
L__main31:
	DECF        main_kp_L0+0, 1 
L_main13:
;Auto Temp Control.c,87 :: 		if(kp > 8 && kp < 12) kp = kp-2;
	MOVF        main_kp_L0+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
	MOVLW       12
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
L__main30:
	MOVLW       2
	SUBWF       main_kp_L0+0, 1 
L_main16:
;Auto Temp Control.c,88 :: 		if(kp ==14) kp=0;
	MOVF        main_kp_L0+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
	CLRF        main_kp_L0+0 
L_main17:
;Auto Temp Control.c,89 :: 		if(kp ==CLEAR)
	MOVF        main_kp_L0+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;Auto Temp Control.c,90 :: 		goto START;
	GOTO        ___main_START
L_main18:
;Auto Temp Control.c,91 :: 		Lcd_Chr_Cp(kp +'0');
	MOVLW       48
	ADDWF       main_kp_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Auto Temp Control.c,92 :: 		Temp_Ref=(10*Temp_Ref)+kp;
	MOVLW       10
	MULWF       main_Temp_Ref_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       main_Temp_Ref_L0+0 
	MOVF        main_kp_L0+0, 0 
	ADDWF       main_Temp_Ref_L0+0, 1 
;Auto Temp Control.c,93 :: 		}
	GOTO        L_main5
L_main6:
;Auto Temp Control.c,94 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,95 :: 		Lcd_Out(1,1,"Temp Ref:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,96 :: 		intToStr(Temp_Ref,Txt);                     // Convert to String
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Auto Temp Control.c,97 :: 		inTemp=Ltrim(Txt);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;Auto Temp Control.c,99 :: 		Lcd_Out_CP(inTemp);
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Auto Temp Control.c,100 :: 		Lcd_Out(2,1, "Press # to Cont.");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,101 :: 		kp = 0;
	CLRF        main_kp_L0+0 
;Auto Temp Control.c,102 :: 		while(kp!=ENTER)
L_main19:
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;Auto Temp Control.c,104 :: 		do
L_main21:
;Auto Temp Control.c,105 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;Auto Temp Control.c,106 :: 		while(!kp);    //store key code var kp
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
;Auto Temp Control.c,107 :: 		}
	GOTO        L_main19
L_main20:
;Auto Temp Control.c,108 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Auto Temp Control.c,109 :: 		Lcd_Out(1,1, "Temp Ref:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,110 :: 		Lcd_Chr(1,15,223);      //Display degree sign
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Auto Temp Control.c,111 :: 		Lcd_Chr(1,16,'C');     //Display C for celcius
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Auto Temp Control.c,115 :: 		while(1)
L_main24:
;Auto Temp Control.c,117 :: 		temp= ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;Auto Temp Control.c,118 :: 		mv = (temp * 5000.0)/1024.0;
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;Auto Temp Control.c,119 :: 		ActualTemp= mv/10.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_ActualTemp_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ActualTemp_L0+1 
	MOVF        R2, 0 
	MOVWF       main_ActualTemp_L0+2 
	MOVF        R3, 0 
	MOVWF       main_ActualTemp_L0+3 
;Auto Temp Control.c,120 :: 		intToStr(Temp_Ref,Txt);
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Auto Temp Control.c,122 :: 		inTemp=Ltrim(Txt);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;Auto Temp Control.c,123 :: 		Lcd_Out(1,11,InTemp);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,124 :: 		Lcd_Out(2,1,"Temp= ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,125 :: 		FloatToStr(ActualTemp,Txt);
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Auto Temp Control.c,126 :: 		Txt[4]=0;
	CLRF        main_txt_L0+4 
;Auto Temp Control.c,127 :: 		Lcd_Out(2,7,Txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,128 :: 		Lcd_Out(2,12,"   ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Auto_32Temp_32Control+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Auto_32Temp_32Control+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Auto Temp Control.c,130 :: 		if(Temp_Ref > ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R1 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R2 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
;Auto Temp Control.c,131 :: 		{ HEATER = OFF;
	BCF         PORTD+0, 0 
;Auto Temp Control.c,132 :: 		FAN =ON;}
	BSF         PORTD+0, 1 
L_main26:
;Auto Temp Control.c,133 :: 		if(Temp_Ref < ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
;Auto Temp Control.c,134 :: 		{ HEATER = ON;
	BSF         PORTD+0, 0 
;Auto Temp Control.c,135 :: 		FAN = OFF;}
	BCF         PORTD+0, 1 
L_main27:
;Auto Temp Control.c,136 :: 		if(Temp_Ref == ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
;Auto Temp Control.c,137 :: 		{ HEATER = OFF;
	BCF         PORTD+0, 0 
;Auto Temp Control.c,138 :: 		FAN = OFF;}
	BCF         PORTD+0, 1 
L_main28:
;Auto Temp Control.c,139 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 1
	BRA         L_main29
	DECFSZ      R12, 1, 1
	BRA         L_main29
	DECFSZ      R11, 1, 1
	BRA         L_main29
	NOP
	NOP
;Auto Temp Control.c,140 :: 		}
	GOTO        L_main24
;Auto Temp Control.c,141 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
