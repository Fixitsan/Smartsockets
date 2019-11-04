
; PICBASIC PRO(TM) Compiler 2.50, (c) 1998, 2007 microEngineering Labs, Inc. All Rights Reserved.  
PM_USED			EQU	1

	INCLUDE	"16F690.INC"


; Define statements.
#define		CODE_SIZE		 4
#define		INTHAND		 myint ; Assembly language interrupt handler
#define		OSC		 4 ; 4MHz oscillator                                           

RAM_START       		EQU	00020h
RAM_END         		EQU	0016Fh
RAM_BANKS       		EQU	00003h
BANK0_START     		EQU	00020h
BANK0_END       		EQU	0007Fh
BANK1_START     		EQU	000A0h
BANK1_END       		EQU	000EFh
BANK2_START     		EQU	00120h
BANK2_END       		EQU	0016Fh
EEPROM_START    		EQU	02100h
EEPROM_END      		EQU	021FFh

wsave           		EQU	RAM_START + 000h
R0              		EQU	RAM_START + 001h
R1              		EQU	RAM_START + 003h
R2              		EQU	RAM_START + 005h
R3              		EQU	RAM_START + 007h
R4              		EQU	RAM_START + 009h
R5              		EQU	RAM_START + 00Bh
R6              		EQU	RAM_START + 00Dh
R7              		EQU	RAM_START + 00Fh
R8              		EQU	RAM_START + 011h
FLAGS           		EQU	RAM_START + 013h
GOP             		EQU	RAM_START + 014h
psave           		EQU	RAM_START + 015h
RM1             		EQU	RAM_START + 016h
RM2             		EQU	RAM_START + 017h
RR1             		EQU	RAM_START + 018h
RR2             		EQU	RAM_START + 019h
ssave           		EQU	RAM_START + 01Ah
_RX_BUFFER       		EQU	RAM_START + 01Bh
T1              		EQU	RAM_START + 02Ch
T2              		EQU	RAM_START + 02Eh
T3              		EQU	RAM_START + 030h
_BESPEED         		EQU	RAM_START + 032h
_BYTE_CNT        		EQU	RAM_START + 033h
_control         		EQU	RAM_START + 034h
_DEVICE          		EQU	RAM_START + 035h
_DUMMY           		EQU	RAM_START + 036h
_EE_ADR          		EQU	RAM_START + 037h
_EE_DAT          		EQU	RAM_START + 038h
_EFFECT          		EQU	RAM_START + 039h
_ESPEED          		EQU	RAM_START + 03Ah
_FONT            		EQU	RAM_START + 03Bh
_GP              		EQU	RAM_START + 03Ch
_GP2             		EQU	RAM_START + 03Dh
_GP3             		EQU	RAM_START + 03Eh
_GP4             		EQU	RAM_START + 03Fh
_INT_SPARE       		EQU	RAM_START + 040h
_LOOP            		EQU	RAM_START + 041h
_NEW_PORTA       		EQU	RAM_START + 042h
_NEW_PORTB       		EQU	RAM_START + 043h
_NEW_PORTC       		EQU	RAM_START + 044h
_OLD_PORTA       		EQU	RAM_START + 045h
_OLD_PORTB       		EQU	RAM_START + 046h
_OLD_PORTC       		EQU	RAM_START + 047h
_OUTA2H          		EQU	RAM_START + 048h
_OUTI2N          		EQU	RAM_START + 049h
_OUTVAL          		EQU	RAM_START + 04Ah
PB01            		EQU	RAM_START + 04Bh
_PORTC_BUF       		EQU	RAM_START + 04Ch
_PROGRESS        		EQU	RAM_START + 04Dh
_RX_BUF          		EQU	RAM_START + 04Eh
_RX_BYTE_CNT     		EQU	RAM_START + 04Fh
_SPARE           		EQU	RAM_START + 050h
_TEMP1           		EQU	RAM_START + 051h
_ticks           		EQU	RAM_START + 052h
_ticks_reload    		EQU	RAM_START + 053h
_TYPE            		EQU	RAM_START + 054h
_ZFLAGS          		EQU	RAM_START + 055h
wsave1          		EQU	RAM_START + 080h
wsave2          		EQU	RAM_START + 00100h
_PORTL           		EQU	 PORTA
_PORTH           		EQU	 PORTC
_TRISL           		EQU	 TRISA
_TRISH           		EQU	 TRISC
#define _OUTBIT          	 PB01, 000h
#define _sega            	_PORTA??1
#define _segb            	_PORTC??0
#define _segc            	_PORTA??2
#define _segd            	_PORTA??5
#define _sege            	_PORTC??6
#define _segf            	_PORTC??3
#define _segg            	_PORTC??4
#define _segh            	_PORTB??6
#define _segi            	_PORTC??1
#define _segj            	_PORTA??0
#define _segk            	_PORTC??2
#define _segl            	_PORTC??5
#define _segm            	_PORTC??7
#define _segn            	_PORTA??4
#define _segu            	_PORTB??4
#define _PORTA??1        	 PORTA, 001h
#define _PORTC??0        	 PORTC, 000h
#define _PORTA??2        	 PORTA, 002h
#define _PORTA??5        	 PORTA, 005h
#define _PORTC??6        	 PORTC, 006h
#define _PORTC??3        	 PORTC, 003h
#define _PORTC??4        	 PORTC, 004h
#define _PORTB??6        	 PORTB, 006h
#define _PORTC??1        	 PORTC, 001h
#define _PORTA??0        	 PORTA, 000h
#define _PORTC??2        	 PORTC, 002h
#define _PORTC??5        	 PORTC, 005h
#define _PORTC??7        	 PORTC, 007h
#define _PORTA??4        	 PORTA, 004h
#define _PORTB??4        	 PORTB, 004h
#define _control??1      	_control, 001h
#define _control??7      	_control, 007h
#define _EE_DAT??7       	_EE_DAT, 007h
#define _EE_DAT??6       	_EE_DAT, 006h
#define _EE_DAT??5       	_EE_DAT, 005h
#define _EE_DAT??4       	_EE_DAT, 004h
#define _EE_DAT??3       	_EE_DAT, 003h
#define _EE_DAT??2       	_EE_DAT, 002h
#define _EE_DAT??1       	_EE_DAT, 001h
#define _EE_DAT??0       	_EE_DAT, 000h
#define _control??0      	_control, 000h
#define _OUTI2N??4       	_OUTI2N, 004h
#define _OUTA2H??0       	_OUTA2H, 000h
#define _OUTI2N??7       	_OUTI2N, 007h
#define _OUTI2N??3       	_OUTI2N, 003h
#define _OUTA2H??6       	_OUTA2H, 006h
#define _OUTA2H??3       	_OUTA2H, 003h
#define _OUTI2N??6       	_OUTI2N, 006h
#define _OUTI2N??2       	_OUTI2N, 002h
#define _OUTA2H??5       	_OUTA2H, 005h
#define _OUTA2H??2       	_OUTA2H, 002h
#define _OUTI2N??5       	_OUTI2N, 005h
#define _OUTA2H??1       	_OUTA2H, 001h
#define _OUTA2H??7       	_OUTA2H, 007h
#define _OUTA2H??4       	_OUTA2H, 004h
#define _ZFLAGS??7       	_ZFLAGS, 007h
#define _NEW_PORTA??0    	_NEW_PORTA, 000h
#define _NEW_PORTA??2    	_NEW_PORTA, 002h
#define _NEW_PORTC??2    	_NEW_PORTC, 002h
#define _NEW_PORTC??5    	_NEW_PORTC, 005h
#define _NEW_PORTB??6    	_NEW_PORTB, 006h
#define _NEW_PORTA??4    	_NEW_PORTA, 004h
#define _NEW_PORTC??3    	_NEW_PORTC, 003h
#define _NEW_PORTA??1    	_NEW_PORTA, 001h
#define _NEW_PORTA??5    	_NEW_PORTA, 005h
#define _NEW_PORTC??0    	_NEW_PORTC, 000h
#define _NEW_PORTC??7    	_NEW_PORTC, 007h
#define _NEW_PORTC??6    	_NEW_PORTC, 006h
#define _NEW_PORTC??1    	_NEW_PORTC, 001h
#define _NEW_PORTC??4    	_NEW_PORTC, 004h
#define _NEW_PORTB??4    	_NEW_PORTB, 004h

; Constants.
_T2400           		EQU	00000h
_T1200           		EQU	00001h
_T9600           		EQU	00002h
_T300            		EQU	00003h
_N2400           		EQU	00004h
_N1200           		EQU	00005h
_N9600           		EQU	00006h
_N300            		EQU	00007h
_OT2400          		EQU	00008h
_OT1200          		EQU	00009h
_OT9600          		EQU	0000Ah
_OT300           		EQU	0000Bh
_ON2400          		EQU	0000Ch
_ON1200          		EQU	0000Dh
_ON9600          		EQU	0000Eh
_ON300           		EQU	0000Fh
_MSBPRE          		EQU	00000h
_LSBPRE          		EQU	00001h
_MSBPOST         		EQU	00002h
_LSBPOST         		EQU	00003h
_LSBFIRST        		EQU	00000h
_MSBFIRST        		EQU	00001h
_CLS             		EQU	00000h
_HOME            		EQU	00001h
_BELL            		EQU	00007h
_BKSP            		EQU	00008h
_TAB             		EQU	00009h
_CR              		EQU	0000Dh
_UnitOn          		EQU	00012h
_UnitOff         		EQU	0001Ah
_UnitsOff        		EQU	0001Ch
_LightsOn        		EQU	00014h
_LightsOff       		EQU	00010h
_Dim             		EQU	0001Eh
_Bright          		EQU	00016h

; EEPROM data.
	ORG EEPROM_START

	ORG EEPROM_START + 074h
	DE	001h
	DE	010h
	DE	060h
	DE	000h
	DE	000h
	DE	0A0h
	DE	010h
	DE	044h
	DE	002h
	DE	008h
	DE	0C4h
	DE	050h
	DE	0F8h
	DE	014h
	DE	000h
	DE	044h
	DE	001h
	DE	054h
	DE	000h
	DE	028h
	DE	002h
	DE	080h
	ORG EEPROM_START + 08Ah
	DE	003h
	DE	080h
	DE	001h
	DE	0C0h
	DE	000h
	DE	0E0h
	DE	000h
	DE	070h
	DE	000h
	DE	038h
	DE	000h
	DE	01Ch
	DE	002h
	DE	00Ch
	DE	003h
	DE	004h
	ORG EEPROM_START + 0FDh
	DE	000h
	DE	001h
	DE	003h

	INCLUDE	"MODIFI~1.MAC"
	INCLUDE	"PBPPIC14.LIB"


	ASM?
   DEVICE PIC16F690, CPD_OFF,WDT_OFF,PWRT_OFF,BOD_OFF,INTRC_OSC_NOCLKOUT,MCLR_OFF

	ENDASM?


	LABEL?L	_z	
	MOVE?CB	000h, FLAGS
	GOTO?L	_init

	LABEL?L	_SPIRALPAUSE	
	CMPNE?BCL	_EFFECT, 007h, L00024
	ADD?BCW	_ESPEED, 001h, T1
	MUL?WCW	T1, 016h, T1
	PAUSE?W	T1
	LABEL?L	L00024	
	CMPNE?BCL	_EFFECT, 008h, L00026
	ADD?BCW	_ESPEED, 001h, T1
	MUL?WCW	T1, 010h, T1
	PAUSE?W	T1
	LABEL?L	L00026	
	CMPEQ?BCB	_EFFECT, 009h, T1
	CMPEQ?BCB	_EFFECT, 005h, T2
	LOR?BBW	T1, T2, T2
	CMPEQ?BCB	_EFFECT, 004h, T3
	LOR?WBW	T2, T3, T3
	CMPF?WL	T3, L00028
	ADD?BCW	_ESPEED, 001h, T1
	MUL?WCW	T1, 00Ch, T1
	PAUSE?W	T1
	LABEL?L	L00028	
	RETURN?	

	LABEL?L	_textfont	
	LOOKUP?BCLB	_OUTVAL, 01Ah, L00001, _OUTA2H
	LURET?C	0ECh
	LURET?C	0F1h
	LURET?C	09Ch
	LURET?C	0F1h
	LURET?C	09Ch
	LURET?C	08Ch
	LURET?C	0BCh
	LURET?C	06Ch
	LURET?C	091h
	LURET?C	078h
	LURET?C	00Ch
	LURET?C	01Ch
	LURET?C	06Eh
	LURET?C	06Eh
	LURET?C	0FCh
	LURET?C	0CCh
	LURET?C	0FCh
	LURET?C	0CCh
	LURET?C	0B4h
	LURET?C	081h
	LURET?C	07Ch
	LURET?C	00Ch
	LURET?C	06Ch
	LURET?C	002h
	LURET?C	002h
	LURET?C	090h

	LABEL?L	L00001	
	LOOKUP?BCLB	_OUTVAL, 01Ah, L00002, _OUTI2N
	LURET?C	044h
	LURET?C	050h
	LURET?C	000h
	LURET?C	010h
	LURET?C	044h
	LURET?C	004h
	LURET?C	040h
	LURET?C	044h
	LURET?C	010h
	LURET?C	000h
	LURET?C	0A4h
	LURET?C	000h
	LURET?C	080h
	LURET?C	020h
	LURET?C	000h
	LURET?C	044h
	LURET?C	020h
	LURET?C	064h
	LURET?C	044h
	LURET?C	010h
	LURET?C	000h
	LURET?C	088h
	LURET?C	028h
	LURET?C	0A8h
	LURET?C	088h
	LURET?C	088h

	LABEL?L	L00002	
	GOTO?L	_remap

	LABEL?L	_font0	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00003, _OUTA2H
	LURET?C	0FCh
	LURET?C	060h
	LURET?C	0D8h
	LURET?C	0F0h
	LURET?C	064h
	LURET?C	0B4h
	LURET?C	0BCh
	LURET?C	0E0h
	LURET?C	0FCh
	LURET?C	0E4h

	LABEL?L	L00003	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00004, _OUTI2N
	LURET?C	088h
	LURET?C	000h
	LURET?C	044h
	LURET?C	044h
	LURET?C	044h
	LURET?C	044h
	LURET?C	044h
	LURET?C	000h
	LURET?C	044h
	LURET?C	044h

	LABEL?L	L00004	
	GOTO?L	_remap

	LABEL?L	_font1	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00005, _OUTA2H
	LURET?C	0FCh
	LURET?C	001h
	LURET?C	0D0h
	LURET?C	0B0h
	LURET?C	004h
	LURET?C	094h
	LURET?C	0BCh
	LURET?C	080h
	LURET?C	01Eh
	LURET?C	0E4h

	LABEL?L	L00005	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00006, _OUTI2N
	LURET?C	088h
	LURET?C	010h
	LURET?C	048h
	LURET?C	0C0h
	LURET?C	08Ch
	LURET?C	024h
	LURET?C	044h
	LURET?C	090h
	LURET?C	024h
	LURET?C	044h

	LABEL?L	L00006	
	GOTO?L	_remap

	LABEL?L	_font2	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00007, _OUTA2H
	LURET?C	070h
	LURET?C	000h
	LURET?C	090h
	LURET?C	090h
	LURET?C	004h
	LURET?C	092h
	LURET?C	010h
	LURET?C	080h
	LURET?C	092h
	LURET?C	082h

	LABEL?L	L00007	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00008, _OUTI2N
	LURET?C	088h
	LURET?C	088h
	LURET?C	088h
	LURET?C	0A0h
	LURET?C	08Ch
	LURET?C	020h
	LURET?C	0A8h
	LURET?C	088h
	LURET?C	0A8h
	LURET?C	088h

	LABEL?L	L00008	
	GOTO?L	_remap

	LABEL?L	_font3	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00009, _OUTA2H
	LURET?C	01Eh
	LURET?C	060h
	LURET?C	098h
	LURET?C	090h
	LURET?C	004h
	LURET?C	0B2h
	LURET?C	030h
	LURET?C	080h
	LURET?C	0B4h
	LURET?C	084h

	LABEL?L	L00009	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00010, _OUTI2N
	LURET?C	020h
	LURET?C	080h
	LURET?C	084h
	LURET?C	0A4h
	LURET?C	094h
	LURET?C	040h
	LURET?C	0C8h
	LURET?C	090h
	LURET?C	0CCh
	LURET?C	094h

	LABEL?L	L00010	
	GOTO?L	_remap

	LABEL?L	_font4	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00011, _OUTA2H
	LURET?C	0FCh
	LURET?C	060h
	LURET?C	0D8h
	LURET?C	0F0h
	LURET?C	066h
	LURET?C	0B6h
	LURET?C	0BCh
	LURET?C	0C0h
	LURET?C	0FEh
	LURET?C	0E4h

	LABEL?L	L00011	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00012, _OUTI2N
	LURET?C	0A8h
	LURET?C	0C0h
	LURET?C	0CCh
	LURET?C	0E0h
	LURET?C	0E4h
	LURET?C	064h
	LURET?C	06Ch
	LURET?C	0D0h
	LURET?C	04Ch
	LURET?C	0A4h

	LABEL?L	L00012	
	GOTO?L	_remap

	LABEL?L	_font5	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00013, _OUTA2H
	LURET?C	0FCh
	LURET?C	000h
	LURET?C	06Eh
	LURET?C	0FDh
	LURET?C	091h
	LURET?C	06Ch
	LURET?C	06Ch
	LURET?C	09Ch
	LURET?C	0FDh
	LURET?C	09Dh

	LABEL?L	L00013	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00014, _OUTI2N
	LURET?C	044h
	LURET?C	044h
	LURET?C	048h
	LURET?C	010h
	LURET?C	014h
	LURET?C	0A4h
	LURET?C	0E4h
	LURET?C	000h
	LURET?C	054h
	LURET?C	014h

	LABEL?L	L00014	
	GOTO?L	_remap

	LABEL?L	_font6	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00015, _OUTA2H
	LURET?C	0FCh
	LURET?C	060h
	LURET?C	016h
	LURET?C	092h
	LURET?C	006h
	LURET?C	050h
	LURET?C	08Ch
	LURET?C	081h
	LURET?C	026h
	LURET?C	016h

	LABEL?L	L00015	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00016, _OUTI2N
	LURET?C	028h
	LURET?C	0A0h
	LURET?C	00Ch
	LURET?C	00Ch
	LURET?C	054h
	LURET?C	0E0h
	LURET?C	00Ch
	LURET?C	090h
	LURET?C	064h
	LURET?C	024h

	LABEL?L	L00016	
	GOTO?L	_remap

	LABEL?L	_font7	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00017, _OUTA2H
	LURET?C	06Eh
	LURET?C	00Fh
	LURET?C	00Eh
	LURET?C	00Eh
	LURET?C	00Eh
	LURET?C	060h
	LURET?C	060h
	LURET?C	060h
	LURET?C	062h
	LURET?C	061h

	LABEL?L	L00017	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00018, _OUTI2N
	LURET?C	0A8h
	LURET?C	008h
	LURET?C	088h
	LURET?C	048h
	LURET?C	028h
	LURET?C	0B0h
	LURET?C	0A8h
	LURET?C	0A4h
	LURET?C	0A0h
	LURET?C	0A0h

	LABEL?L	L00018	
	GOTO?L	_remap

	LABEL?L	_font8	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00019, _OUTA2H
	LURET?C	080h
	LURET?C	0C0h
	LURET?C	0E0h
	LURET?C	0F0h
	LURET?C	0F8h
	LURET?C	0FCh
	LURET?C	0FEh
	LURET?C	0FFh
	LURET?C	0FFh
	LURET?C	0FFh

	LABEL?L	L00019	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00020, _OUTI2N
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	080h
	LURET?C	0C0h

	LABEL?L	L00020	
	GOTO?L	_remap

	LABEL?L	_fontnixie	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00021, _OUTA2H
	LURET?C	080h
	LURET?C	040h
	LURET?C	020h
	LURET?C	010h
	LURET?C	008h
	LURET?C	004h
	LURET?C	002h
	LURET?C	001h
	LURET?C	000h
	LURET?C	000h

	LABEL?L	L00021	
	LOOKUP?BCLB	_OUTVAL, 00Ah, L00022, _OUTI2N
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	000h
	LURET?C	080h
	LURET?C	040h

	LABEL?L	L00022	
	GOTO?L	_remap

	LABEL?L	_userfont	
	CMPLT?BCL	_OUTVAL, 07Eh, L00030
	GOTO?L	_remap
	LABEL?L	L00030	
	MUL?BCB	_OUTVAL, 002h, _EE_ADR
	READ?BB	_EE_ADR, _OUTA2H
	ADD?BCB	_EE_ADR, 001h, _EE_ADR
	READ?BB	_EE_ADR, _OUTI2N
	GOTO?L	_remap

	ASM?

myint
        btfss   INTCON,6  ; Is this interupt caused by some PIE1 device
        goto    dot
        btfss   PIR1,5    ; is the received data flag set ?
        goto    dot
        movf    RCREG,w
        movwf   _RX_BUF  ; save the received byte immediately
        movwf   TXREG    ; Load the TX register immediately to pass the byte on
        nop
        btfss   PIR1,TXIF  ; Wait for TX send to complte
        goto    $-1

;progrss register bits 0-3 get set as each element of the header
; is received. If a bad byte is detected then progress is reset
; and the code starts waiting for another $ sign

        
prog0   btfsc   _PROGRESS,0  ; has  the progress,0 step been completed
        goto    prog1        ; yes, test for progress,1
        bsf     _PROGRESS,0  ; no, set this bit now
        movf    _RX_BUF,w
        xorlw   '$'          ; test if this byte is a $ sign
        btfss   STATUS,Z
        goto    dump         ; not a $ sign, clear the progress register
        goto    out          ; is a $ sign, don't clear progress, allow more
        
prog1   btfsc   _PROGRESS,1 ; same as above, validate the received data/header
        goto    prog2
        bsf     _PROGRESS,1
        movf    _RX_BUF,w
        xorlw   'B'
        btfss   STATUS,Z
        goto    dump   
        goto    out
prog2   btfsc   _PROGRESS,2
        goto    prog3
        bsf     _PROGRESS,2
        movf    _RX_BUF,w
        xorlw   '7'
        btfss   STATUS,Z
        goto    dump  
        goto    out
prog3   btfsc   _PROGRESS,3
        goto    prog4
        bsf     _PROGRESS,3
        clrf    _RX_BYTE_CNT
        
; The fourth byte to be received is the 'type of message' character
; as for prog0 to prog2, if the fourth byte doesn't meet the test
; criteria of being a valid message type this data sentence is aborted        
        
        movf    _RX_BUF,w
        movwf   _SPARE
        xorlw   'M'
        btfsc   STATUS,Z
        goto    type1
        movf    _SPARE,w
        xorlw   'F'
        btfsc   STATUS,Z
        goto    type3
        movf    _SPARE,w
        xorlw   'W'
        btfsc   STATUS,Z
        goto    type2
        movf    _SPARE,w
        xorlw   'E'
        btfsc   STATUS,Z
        goto    type4
        movf    _SPARE,w
        xorlw   'S'
        btfsc   STATUS,Z
        goto    type5
        movf    _SPARE,w
        xorlw   'U'
        btfsc   STATUS,Z
        goto    type7       
        
        goto    dump ; If we got here then this is not a valid message type
        
        
type1   movlw   1    ; assign the correct message number to the TYPE reg
        movwf   _TYPE
        goto    out
type2   movlw   2
        movwf   _TYPE
        goto    out
type3   movlw   3
        movwf   _TYPE
        goto    out
type4   movlw   4
        movwf   _TYPE
        goto    out
type5   movlw   5
        movwf   _TYPE
        goto    out
type7   movlw   7
        movwf   _TYPE
        goto    out      

        
  
; If we got to here then the message type is valid and all that's required
; is to pick the correct data byte from the stream relevant to this device's
; enumerated position in the chain, and then save it for processing
prog4   ;duntype


        movf   _RX_BUF,w
        xorlw   13          ; Is this the final character of a message ?
        btfsc   STATUS,Z 
        goto    goodmes
        
        
        ; For message type 2, Write eeprom userfont data.....
        movf   _TYPE,w
        xorlw   2
        btfss   STATUS,Z
        goto    typnot2
        movlw   17
        subwf    _RX_BYTE_CNT,w
        btfsc   STATUS,C
        goto    out
        
        movlw   _RX_BUFFER
        addwf   _RX_BYTE_CNT,w
        movwf   FSR
        movf    _RX_BUF,w
        movwf   INDF
        movf    _RX_BYTE_CNT,w
        xorlw   255
        btfss   STATUS,Z
        incf    _RX_BYTE_CNT,f
        goto    out

        ; For all other, non- type 2 messages, count data bytes
        ; and when the current byte number equals this device's
        ; enumerated position put the current data byte in the buffer , OUTVAL
typnot2 movf    _RX_BYTE_CNT,w
        xorlw   255
        btfss   STATUS,Z
        incf    _RX_BYTE_CNT,f
        movf    _RX_BYTE_CNT,w
        xorwf   _DEVICE,w
        btfss   STATUS,Z
        goto    out
        movf    _RX_BUF,w
        movwf   _OUTVAL   ; Outval now has the correct data byte with respect
        goto    out       ; to this device's position in the chain
        
        ;got here, is a good message

goodmes movf    _DEVICE,w
        subwf   _RX_BYTE_CNT,w
        btfss   STATUS,C
        goto    dump    ; This ensures we don't try to save the <ENTER> char
        
        movf    _OUTVAL,W
        xorlw   33      ; Character 33 is the exclamation mark
        btfsc   STATUS,Z; In this application an ' ! ' means ignore this data
        goto    dump
       
       
        movf    _TYPE,w
        xorlw   3
        btfss   STATUS,Z
        goto    not3
        
        ;Type 3 message stuff, Font number
        movf    _OUTVAL,w        
        movwf   _FONT   
        movlw   48      ; Subtract the ascii value 48 to create 0-9
        subwf   _FONT,1
        
        movf    _FONT,w ; store immediately
        movwf   _EE_DAT
        movlw   253
        movwf   _EE_ADR
        goto    ee_write_no_wait
        
          
        
not3   
        movf    _TYPE,w
        xorlw   4
        btfss   STATUS,Z
        goto    not4
        movf    _OUTVAL,w
        movwf   _EFFECT   
        movlw   48
        subwf   _EFFECT,1
        movf    _EFFECT,w
        movwf   _EE_DAT
        movlw   254
        movwf   _EE_ADR
        goto    ee_write_no_wait
        






not4    movf    _TYPE,w
        xorlw   5
        btfss   STATUS,Z
        goto    not5
        movf    _OUTVAL,w
        movwf   _ESPEED
        movlw   48
        subwf   _ESPEED,1
        movf    _ESPEED,w
        movwf   _EE_DAT
        movlw   255
        movwf   _EE_ADR
        goto    ee_write_no_wait


; Normally, this procedure could cause hangups, where the data is
; coming in faster than it takes an EEPROM byte to be written.
; But because the speed is only 9600 baud it is possible to drop
;the data to be written to eeprom into the write buffer and not have
; to wait for completion, which would probably cause a display aberation
; as the code execution waits for eeprom writing to complete, because
; we are still in the interupt here.

ee_write_no_wait
    bcf     STATUS,RP0
    bcf     STATUS,RP1
    bcf     PIR2,EEIF
    movf    _EE_ADR,w
    bsf     STATUS,RP1
    movwf   EEADR
    bcf     STATUS,RP1
    movf    _EE_DAT,w
    bsf     STATUS,RP1
    movwf   10Ch   ;_EEDAT
    bsf     STATUS,RP0
    bcf     EECON1,EEPGD
	BSF 	EECON1, WREN
	MOVLW 	055h
	MOVWF 	EECON2
	MOVLW 	0AAh
	MOVWF 	EECON2
	BSF 	EECON1, WR
	NOP
    bcf     STATUS,RP0
    bcf     STATUS,RP1
    goto    dump



not5    movf    _TYPE,w
        xorlw   7 
        btfss   STATUS,Z
        goto    not7
        movf    _OUTVAL,w
        xorlw   48
        btfsc   STATUS,Z
        bcf     _ZFLAGS,7
        
        movf    _OUTVAL,w
        xorlw   49
        btfsc   STATUS,Z
        bsf     _ZFLAGS,7
        goto    dump
              

not7  
        bsf     _CONTROL,1
        goto    out

; Jumps to 'DUMP' are made when data cannot be validated
; It prevents the code from looping endlessly waiting for a good
; byte, helping to free it up from processing line noise and
; clears all progress counters at once in case the next data byte
; is the start of some good data
        
dump    clrf    _RX_BYTE_CNT
        clrf    _TYPE
        clrf    _PROGRESS
        bcf     _CONTROL,1
        goto    out       
        
        
dot btfss   INTCON,2  ;Did a timer overflow occur ?
    goto    OUT
    bcf     INTCON,2  ; do timer maintenance
    decfsz  _TICKS
    goto     out
    bsf     _CONTROL,0
    movf    _TICKS_RELOAD,w
    movwf   _TICKS
out                  ; restore W, Status and Pclath
    movf psave, W
    movwf PCLATH
    swapf ssave, W
    movwf STATUS
    swapf wsave, F
    swapf wsave, W
    retfie


	ENDASM?


	LABEL?L	_init	
	MOVE?CB	087h, ADCON1
	MOVE?CB	000h, TRISA
	MOVE?CB	020h, TRISB
	MOVE?CB	000h, TRISC
	MOVE?CB	000h, PORTA
	MOVE?CB	000h, PORTB
	MOVE?CB	000h, PORTC
	MOVE?CB	000h, INTCON
	MOVE?CB	000h, PIE1
	MOVE?CB	087h, OPTION_REG
	MOVE?CB	000h, SSPCON
	MOVE?CB	000h, SSPSTAT
	MOVE?CB	000h, ANSEL
	MOVE?CB	000h, ANSELH
	MOVE?CB	000h, BAUDCTL

	LABEL?L	_CONTINIT	
	MOVE?CB	000h, OSCTUNE
	MOVE?CB	018h, SPBRG
	MOVE?CB	061h, OSCCON
	MOVE?CB	0A4h, TXSTA
	MOVE?CB	090h, RCSTA
	MOVE?CB	018h, _ticks_reload
	MOVE?BB	_ticks_reload, _ticks
	MOVE?CB	000h, _RX_BYTE_CNT
	MOVE?CB	000h, _BYTE_CNT
	MOVE?CB	001h, _DUMMY
	MOVE?CB	000h, _ZFLAGS
	MOVE?CB	020h, _OUTVAL
	MOVE?CB	000h, _control
	MOVE?CB	000h, _TYPE
	MOVE?CB	000h, _NEW_PORTA
	MOVE?CB	000h, _NEW_PORTB
	MOVE?CB	000h, _OUTA2H
	MOVE?CB	000h, _OUTI2N
	MOVE?CB	000h, _FONT
	MOVE?CB	001h, _EFFECT
	MOVE?CB	003h, _ESPEED

	ASM?

    btfss   PIR1,TXIF
    goto    $-1
    movlw   171
    movwf   TXREG  ; SEND '171', which wakes up potentially sleepy USARTS
    nop
    btfss   PIR1,TXIF
    goto    $-1


	ENDASM?

	PAUSE?C	001h

	ASM?

    ; Clear RX register
    bcf     RCSTA,4
    movf    RCREG,w
    movf    RCREG,w
    movf    RCREG,w    ; RX register is 3-deep
    bsf     RCSTA,4
    nop
    nop
    movlw   171
    movwf   TXREG     ; Now send the identifying value of '171'
    nop
    btfss   PIR1,TXIF ; Wait till end of transmission
    goto    $-1


	ENDASM?

	PAUSE?C	005h

	ASM?

    movf    RCREG,w
    xorlw   171       ; Does the RX RCREG contain 171 ?
    btfsc   STATUS,Z
    goto    _NOTFIRST ; Yes, so it's not the first device, goto notfirst

    movlw   1
    movwf   _DEVICE     ;Assign '1' to this device and transmit it
    movwf   _OUTVAL

    movwf   TXREG
    nop
    btfss   PIR1,TXIF  ; Once transmitted go to the main loop
    goto    $-1
    goto    _MAIN



	ENDASM?


	LABEL?L	_NOTFIRST	

	ASM?

    btfss   PIR1,5
    goto    $-1
    movf    RCREG,w
    addlw   1
    movwf   _DEVICE
    movwf   TXREG
    nop
    btfss   PIR1,TXIF
    goto    $-1   


	ENDASM?

	GOTO?L	_main

	LABEL?L	_remap	

	ASM?

    btfsc   _OUTA2H,7        ;seg1
    bsf     _NEW_PORTA,1
    btfss   _OUTA2H,7
    bcf     _NEW_PORTA,1
    
    btfsc   _OUTA2H,6     ;seg2
    bsf     _NEW_PORTC,0
    btfss   _OUTA2H,6
    bcf     _NEW_PORTC,0
    
    btfsc   _OUTA2H,5
    bsf     _NEW_PORTA,2
    btfss   _OUTA2H,5
    bcf     _NEW_PORTA,2

    btfsc   _OUTA2H,4   ;seg4
    bsf     _NEW_PORTA,5
    btfss   _OUTA2H,4
    bcf     _NEW_PORTA,5

    btfsc   _OUTA2H,3    ;seg5
    bsf     _NEW_PORTC,4
    btfss   _OUTA2H,3
    bcf     _NEW_PORTC,4

    btfsc   _OUTA2H,2
    bsf     _NEW_PORTC,3
    btfss   _OUTA2H,2
    bcf     _NEW_PORTC,3

    btfsc   _OUTA2H,1     ;seg7
    bsf     _NEW_PORTC,6
    btfss   _OUTA2H,1
    bcf     _NEW_PORTC,6
    
    btfsc   _OUTA2H,0
    bsf     _NEW_PORTB,6
    btfss   _OUTA2H,0
    bcf     _NEW_PORTB,6
    
    btfsc   _OUTI2N,7      ;seg9
    bsf     _NEW_PORTC,1
    btfss   _OUTI2N,7
    bcf     _NEW_PORTC,1
    
    btfsc   _OUTI2N,6      ;seg10
    bsf     _NEW_PORTA,0
    btfss   _OUTI2N,6
    bcf     _NEW_PORTA,0

    btfsc   _OUTI2N,5       ;seg11
    bsf     _NEW_PORTC,2
    btfss   _OUTI2N,5
    bcf     _NEW_PORTC,2

    btfsc   _OUTI2N,4       ;seg12
    bsf     _NEW_PORTC,5
    btfss   _OUTI2N,4
    bcf     _NEW_PORTC,5

    btfsc   _OUTI2N,3       ;seg13
    bsf     _NEW_PORTC,7
    btfss   _OUTI2N,3
    bcf     _NEW_PORTC,7

    btfsc   _OUTI2N,2       ;seg14
    bsf     _NEW_PORTA,4
    btfss   _OUTI2N,2
    bcf     _NEW_PORTA,4

    btfsc   _OUTI2N,1
    bsf     _NEW_PORTB,4    ;underscore from character
    btfss   _OUTI2N,1
    bcf     _NEW_PORTB,4
    
    btfsc   _ZFLAGS,7        ;underscore from command
    bsf     _NEW_PORTB,4
 

	ENDASM?

	GOTO?L	_gotfont

	LABEL?L	_GETINPUT	
	MOVE?CB	000h, _PROGRESS
	LOW?T	_control??1
	CMPEQ?BCL	_TYPE, 000h, L00032
	GOTO?L	_goodtype
	LABEL?L	L00032	
	MOVE?CB	000h, _RX_BYTE_CNT
	MOVE?CB	000h, _TYPE
	RETURN?	

	LABEL?L	_goodtype	
	MOVE?BB	_ticks_reload, _ticks
	CMPEQ?BCL	_TYPE, 002h, _type2

	LABEL?L	_type1	
	MOVE?CB	000h, _TYPE
	CMPEQ?BCL	_FONT, 025h, L00034
	CMPLT?CBB	02Fh, _OUTVAL, T1
	CMPLT?BCB	_OUTVAL, 03Ah, T2
	LAND?BBW	T1, T2, T2
	CMPF?WL	T2, L00036
	SUB?BCB	_OUTVAL, 030h, _OUTVAL
	LABEL?L	L00036	
	LABEL?L	L00034	
	HIGH?T	_control??7
	RETURN?	

	LABEL?L	_type2	
	CMPEQ?BCL	_FONT, 025h, L00038
	RETURN?	
	LABEL?L	L00038	
	MOVE?CB	000h, _TYPE
	CMPLT?BCL	_RX_BUFFER, 07Eh, L00040
	RETURN?	
	LABEL?L	L00040	
	MUL?BCB	_RX_BUFFER, 002h, _EE_ADR
	MOVE?CB	000h, _EE_DAT
	CMPNE?BCL	_RX_BUFFER + 00001h, 031h, L00042
	HIGH?T	_EE_DAT??7
	LABEL?L	L00042	
	CMPNE?BCL	_RX_BUFFER + 00002h, 031h, L00044
	HIGH?T	_EE_DAT??6
	LABEL?L	L00044	
	CMPNE?BCL	_RX_BUFFER + 00003h, 031h, L00046
	HIGH?T	_EE_DAT??5
	LABEL?L	L00046	
	CMPNE?BCL	_RX_BUFFER + 00004h, 031h, L00048
	HIGH?T	_EE_DAT??4
	LABEL?L	L00048	
	CMPNE?BCL	_RX_BUFFER + 00005h, 031h, L00050
	HIGH?T	_EE_DAT??3
	LABEL?L	L00050	
	CMPNE?BCL	_RX_BUFFER + 00006h, 031h, L00052
	HIGH?T	_EE_DAT??2
	LABEL?L	L00052	
	CMPNE?BCL	_RX_BUFFER + 00007h, 031h, L00054
	HIGH?T	_EE_DAT??1
	LABEL?L	L00054	
	CMPNE?BCL	_RX_BUFFER + 00008h, 031h, L00056
	HIGH?T	_EE_DAT??0
	LABEL?L	L00056	
	WRITE?BB	_EE_ADR, _EE_DAT
	ADD?BCB	_EE_ADR, 001h, _EE_ADR
	MOVE?CB	000h, _EE_DAT
	CMPNE?BCL	_RX_BUFFER + 00009h, 031h, L00058
	HIGH?T	_EE_DAT??7
	LABEL?L	L00058	
	CMPNE?BCL	_RX_BUFFER + 0000Ah, 031h, L00060
	HIGH?T	_EE_DAT??6
	LABEL?L	L00060	
	CMPNE?BCL	_RX_BUFFER + 0000Bh, 031h, L00062
	HIGH?T	_EE_DAT??5
	LABEL?L	L00062	
	CMPNE?BCL	_RX_BUFFER + 0000Ch, 031h, L00064
	HIGH?T	_EE_DAT??4
	LABEL?L	L00064	
	CMPNE?BCL	_RX_BUFFER + 0000Dh, 031h, L00066
	HIGH?T	_EE_DAT??3
	LABEL?L	L00066	
	CMPNE?BCL	_RX_BUFFER + 0000Eh, 031h, L00068
	HIGH?T	_EE_DAT??2
	LABEL?L	L00068	
	CMPNE?BCL	_RX_BUFFER + 0000Fh, 031h, L00070
	HIGH?T	_EE_DAT??1
	LABEL?L	L00070	
	CMPNE?BCL	_RX_BUFFER + 00010h, 031h, L00072
	HIGH?T	_EE_DAT??0
	LABEL?L	L00072	
	WRITE?BB	_EE_ADR, _EE_DAT
	RETURN?	

	LABEL?L	_main	
	READ?CB	0FDh, _FONT
	READ?CB	0FEh, _EFFECT
	READ?CB	0FFh, _ESPEED
	MOVE?CB	0E0h, INTCON
	MOVE?CB	020h, PIE1

	LABEL?L	_TOP	
	CMPF?TL	_control??0, L00074
	LOW?T	_control??0
	LABEL?L	L00074	
	CMPF?TL	_control??1, L00076
	GOSUB?L	_GETINPUT
	LABEL?L	L00076	
	CMPF?TL	_control??7, L00078
	GOSUB?L	_CHANGEDISP
	LABEL?L	L00078	
	GOTO?L	_TOP

	LABEL?L	_CHANGEDISP	
	LOW?T	_control??7
	CMPLE?CBB	000h, _OUTVAL, T1
	CMPLT?BCB	_OUTVAL, 00Ah, T2
	LAND?BBW	T1, T2, T2
	CMPF?WL	T2, L00080
	GOTO?L	_numeric
	LABEL?L	L00080	
	CMPNE?BCL	_FONT, 025h, L00082
	GOTO?L	_userfont
	LABEL?L	L00082	
	CMPLT?CBB	040h, _OUTVAL, T1
	CMPLT?BCB	_OUTVAL, 05Bh, T2
	LAND?BBW	T1, T2, T2
	CMPF?WL	T2, L00084
	SUB?BCB	_OUTVAL, 041h, _OUTVAL
	GOTO?L	_textfont
	LABEL?L	L00084	
	CMPNE?BCL	_OUTVAL, 020h, L00086
	MOVE?CB	000h, _OUTA2H
	MOVE?CB	000h, _OUTI2N
	GOTO?L	_remap
	LABEL?L	L00086	
	GOTO?L	_norm

	LABEL?L	_numeric	
	CMPNE?BCL	_FONT, 000h, L00090
	GOTO?L	_font0
	GOTO?L	L00089
	LABEL?L	L00090	
	CMPNE?BCL	_FONT, 001h, L00091
	GOTO?L	_font1
	GOTO?L	L00089
	LABEL?L	L00091	
	CMPNE?BCL	_FONT, 002h, L00092
	GOTO?L	_font2
	GOTO?L	L00089
	LABEL?L	L00092	
	CMPNE?BCL	_FONT, 003h, L00093
	GOTO?L	_font3
	GOTO?L	L00089
	LABEL?L	L00093	
	CMPNE?BCL	_FONT, 004h, L00094
	GOTO?L	_font4
	GOTO?L	L00089
	LABEL?L	L00094	
	CMPNE?BCL	_FONT, 005h, L00095
	GOTO?L	_font5
	GOTO?L	L00089
	LABEL?L	L00095	
	CMPNE?BCL	_FONT, 006h, L00096
	GOTO?L	_font6
	GOTO?L	L00089
	LABEL?L	L00096	
	CMPNE?BCL	_FONT, 007h, L00097
	GOTO?L	_font7
	GOTO?L	L00089
	LABEL?L	L00097	
	CMPNE?BCL	_FONT, 008h, L00098
	GOTO?L	_font8
	GOTO?L	L00089
	LABEL?L	L00098	
	CMPNE?BCL	_FONT, 009h, L00099
	GOTO?L	_fontnixie
	LABEL?L	L00099	
	LABEL?L	L00089	
	GOTO?L	_font0

	LABEL?L	_gotfont	
	BRANCHL?BCL	_EFFECT, 00Ah, L00023
	BRLGOTO?L	_norm
	BRLGOTO?L	_fade1
	BRLGOTO?L	_fade1
	BRLGOTO?L	_sweller
	BRLGOTO?L	_zipper
	BRLGOTO?L	_shifter
	BRLGOTO?L	_bits
	BRLGOTO?L	_spiral
	BRLGOTO?L	_spiral
	BRLGOTO?L	_wiper

	LABEL?L	L00023	
	GOTO?L	_norm

	LABEL?L	_spiral	
	HIGH?T	_segi
	HIGH?T	_segm
	LOW?T	_segh
	LOW?T	_segl
	LOW?T	_sega
	LOW?T	_segd
	LOW?T	_segu
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	HIGH?T	_segn
	LOW?T	_segi
	LOW?T	_segm
	LOW?T	_segb
	LOW?T	_sege
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segg
	LOW?T	_segj
	LOW?T	_segn
	LOW?T	_segc
	LOW?T	_segf
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	HIGH?T	_segh
	LOW?T	_segk
	LOW?T	_segg
	GOSUB?L	_SPIRALPAUSE
	CMPEQ?BCL	_EFFECT, 008h, L00100
	GOTO?L	_spircont
	LABEL?L	L00100	
	HIGH?T	_segi
	HIGH?T	_segm
	LOW?T	_segh
	LOW?T	_segl
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	HIGH?T	_segn
	LOW?T	_segi
	LOW?T	_segm
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segg
	LOW?T	_segj
	LOW?T	_segn
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	HIGH?T	_segh
	LOW?T	_segk
	LOW?T	_segg
	GOSUB?L	_SPIRALPAUSE

	LABEL?L	_spircont	
	HIGH?T	_segi
	HIGH?T	_segm
	CMPT?TL	_OUTI2N??4, L00102
	LOW?T	_segl
	LABEL?L	L00102	
	CMPT?TL	_OUTA2H??0, L00104
	LOW?T	_segh
	LABEL?L	L00104	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	HIGH?T	_segn
	CMPT?TL	_OUTI2N??7, L00106
	LOW?T	_segi
	LABEL?L	L00106	
	CMPT?TL	_OUTI2N??3, L00108
	LOW?T	_segm
	LABEL?L	L00108	
	CMPF?TL	_OUTA2H??6, L00110
	HIGH?T	_segb
	LABEL?L	L00110	
	CMPF?TL	_OUTA2H??3, L00112
	HIGH?T	_sege
	LABEL?L	L00112	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segg
	CMPT?TL	_OUTI2N??6, L00114
	LOW?T	_segj
	LABEL?L	L00114	
	CMPT?TL	_OUTI2N??2, L00116
	LOW?T	_segn
	LABEL?L	L00116	
	CMPF?TL	_OUTA2H??5, L00118
	HIGH?T	_segc
	LABEL?L	L00118	
	CMPF?TL	_OUTA2H??2, L00120
	HIGH?T	_segf
	LABEL?L	L00120	
	GOSUB?L	_SPIRALPAUSE
	CMPT?TL	_OUTI2N??5, L00122
	LOW?T	_segk
	LABEL?L	L00122	
	CMPT?TL	_OUTA2H??1, L00124
	LOW?T	_segg
	LABEL?L	L00124	
	CMPF?TL	_OUTA2H??7, L00126
	HIGH?T	_sega
	LABEL?L	L00126	
	CMPF?TL	_OUTA2H??4, L00128
	HIGH?T	_segd
	LABEL?L	L00128	
	CMPF?TL	_ZFLAGS??7, L00130
	HIGH?T	_segu
	LABEL?L	L00130	
	GOTO?L	_outdisp

	LABEL?L	_norm	
	MOVE?BB	_NEW_PORTC, PORTC
	MOVE?BB	_NEW_PORTB, PORTB
	MOVE?BB	_NEW_PORTA, PORTA
	GOTO?L	_outdisp

	LABEL?L	_fade1	
	ADD?BCB	_ESPEED, 001h, _BESPEED
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	CMPNE?BCL	_EFFECT, 002h, L00132
	MUL?BCB	_BESPEED, 015h, _GP3
	LABEL?L	L00132	
	MOVE?CB	000h, _GP
	LABEL?L	L00134	
	CMPGT?BBL	_GP, _GP3, L00135
	MOVE?CB	000h, _GP2
	MOVE?CB	000h, _GP2
	LABEL?L	L00136	
	CMPGT?BCL	_GP2, 008h, L00137
	MOVE?BB	_NEW_PORTA, PORTA
	MOVE?BB	_NEW_PORTB, PORTB
	MOVE?BB	_NEW_PORTC, PORTC

	ASM?
 
            movf   _EFFECT,w
            xorlw   2
            btfss   STATUS,z
            goto    $+4
            movf    _GP3,w
            movwf   _GP4
            goto    $+4
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?BB	_OLD_PORTA, PORTA
	MOVE?BB	_OLD_PORTB, PORTB
	MOVE?BB	_OLD_PORTC, PORTC

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP2, 001h, L00136
	LABEL?L	L00137	
	NEXT?BCL	_GP, 001h, L00134
	LABEL?L	L00135	
	MOVE?BB	_NEW_PORTA, PORTA
	MOVE?BB	_NEW_PORTB, PORTB
	MOVE?BB	_NEW_PORTC, PORTC
	GOTO?L	_outdisp

	LABEL?L	_sweller	
	ADD?BCB	_ESPEED, 001h, _BESPEED
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	CMPNE?BCL	_EFFECT, 004h, L00138
	MUL?BCB	_BESPEED, 00Fh, _GP3
	LABEL?L	L00138	
	MOVE?CB	000h, _GP
	LABEL?L	L00140	
	CMPGT?BBL	_GP, _GP3, L00141
	MOVE?CB	000h, _GP2
	MOVE?CB	000h, _GP2
	LABEL?L	L00142	
	CMPGT?BCL	_GP2, 009h, L00143
	MOVE?CB	0FFh, PORTA
	MOVE?CB	0EFh, PORTB
	MOVE?CB	0FFh, PORTC

	ASM?
 
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?BB	_OLD_PORTA, PORTA
	MOVE?BB	_OLD_PORTB, PORTB
	MOVE?BB	_OLD_PORTC, PORTC

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP2, 001h, L00142
	LABEL?L	L00143	
	NEXT?BCL	_GP, 001h, L00140
	LABEL?L	L00141	
	CMPNE?BCL	_EFFECT, 005h, L00144
	GOTO?L	_endswell
	LABEL?L	L00144	
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	MOVE?CB	000h, _GP
	LABEL?L	L00146	
	CMPGT?BBL	_GP, _GP3, L00147
	MOVE?CB	000h, _GP2
	MOVE?CB	000h, _GP2
	LABEL?L	L00148	
	CMPGT?BCL	_GP2, 006h, L00149
	MOVE?BB	_NEW_PORTA, PORTA
	MOVE?BB	_NEW_PORTB, PORTB
	MOVE?BB	_NEW_PORTC, PORTC

	ASM?
 
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?CB	0FFh, PORTA
	MOVE?CB	0EFh, PORTB
	MOVE?CB	0FFh, PORTC

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP2, 001h, L00148
	LABEL?L	L00149	
	NEXT?BCL	_GP, 001h, L00146
	LABEL?L	L00147	

	LABEL?L	_endswell	
	MOVE?BB	_NEW_PORTA, PORTA
	MOVE?BB	_NEW_PORTB, PORTB
	MOVE?BB	_NEW_PORTC, PORTC
	GOTO?L	_outdisp

	LABEL?L	_outdisp	
	MOVE?BB	_NEW_PORTA, _OLD_PORTA
	MOVE?BB	_NEW_PORTB, _OLD_PORTB
	MOVE?BB	_NEW_PORTC, _OLD_PORTC
	RETURN?	

	LABEL?L	_fouta	
	MOVE?BB	PORTA, _OLD_PORTA
	ADD?BCB	_ESPEED, 001h, _BESPEED
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	MOVE?CB	000h, _GP
	LABEL?L	L00150	
	CMPGT?BBL	_GP, _GP3, L00151
	MOVE?BB	_TEMP1, PORTA

	ASM?
 
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?BB	_OLD_PORTA, PORTA

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP, 001h, L00150
	LABEL?L	L00151	
	MOVE?BB	_TEMP1, PORTA
	RETURN?	

	LABEL?L	_foutb	
	MOVE?BB	PORTB, _OLD_PORTB
	ADD?BCB	_ESPEED, 001h, _BESPEED
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	MOVE?CB	000h, _GP
	LABEL?L	L00152	
	CMPGT?BBL	_GP, _GP3, L00153

	ASM?
 
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?BB	_OLD_PORTB, PORTB

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP, 001h, L00152
	LABEL?L	L00153	
	MOVE?BB	_TEMP1, PORTB
	RETURN?	

	LABEL?L	_foutc	
	MOVE?BB	PORTC, _OLD_PORTC
	ADD?BCB	_ESPEED, 001h, _BESPEED
	MOVE?CB	000h, _GP
	MUL?BCB	_BESPEED, 019h, _GP3
	MOVE?CB	000h, _GP
	LABEL?L	L00154	
	CMPGT?BBL	_GP, _GP3, L00155
	MOVE?BB	_TEMP1, PORTC

	ASM?
 
            movf    _GP,w
            addlw   1
            movwf   _GP4
            decfsz   _GP4
            goto    $-1


	ENDASM?

	MOVE?BB	_OLD_PORTC, PORTC

	ASM?
         movf    _GP,w
            subwf   _GP3,0
            addlw   1
            movwf   _GP4
            decfsz  _GP4
            goto    $-1


	ENDASM?

	NEXT?BCL	_GP, 001h, L00154
	LABEL?L	L00155	
	MOVE?BB	_TEMP1, PORTC
	RETURN?	

	LABEL?L	_wiper	
	HIGH?T	_segi
	LOW?T	_sega
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	LOW?T	_segi
	LOW?T	_segb
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	LOW?T	_segj
	LOW?T	_segc
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	LOW?T	_segk
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segm
	LOW?T	_segl
	LOW?T	_segd
	LOW?T	_segu
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segn
	LOW?T	_segm
	LOW?T	_sege
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segg
	LOW?T	_segn
	LOW?T	_segf
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segh
	LOW?T	_segg
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segi
	CMPT?TL	_OUTA2H??0, L00156
	LOW?T	_segh
	LABEL?L	L00156	
	CMPF?TL	_OUTA2H??7, L00158
	HIGH?T	_sega
	LABEL?L	L00158	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	CMPT?TL	_OUTI2N??7, L00160
	LOW?T	_segi
	LABEL?L	L00160	
	CMPF?TL	_OUTA2H??6, L00162
	HIGH?T	_segb
	LABEL?L	L00162	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	CMPT?TL	_OUTI2N??6, L00164
	LOW?T	_segj
	LABEL?L	L00164	
	CMPF?TL	_OUTA2H??5, L00166
	HIGH?T	_segc
	LABEL?L	L00166	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	CMPT?TL	_OUTI2N??5, L00168
	LOW?T	_segk
	LABEL?L	L00168	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segm
	CMPT?TL	_OUTI2N??4, L00170
	LOW?T	_segl
	LABEL?L	L00170	
	CMPF?TL	_OUTA2H??4, L00172
	HIGH?T	_segd
	LABEL?L	L00172	
	CMPF?TL	_ZFLAGS??7, L00174
	HIGH?T	_segu
	LABEL?L	L00174	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segn
	CMPT?TL	_OUTI2N??3, L00176
	LOW?T	_segm
	LABEL?L	L00176	
	CMPF?TL	_OUTA2H??3, L00178
	HIGH?T	_sege
	LABEL?L	L00178	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segg
	CMPT?TL	_OUTI2N??2, L00180
	LOW?T	_segn
	LABEL?L	L00180	
	CMPF?TL	_OUTA2H??2, L00182
	HIGH?T	_segf
	LABEL?L	L00182	
	GOSUB?L	_SPIRALPAUSE
	CMPF?TL	_OUTA2H??0, L00184
	HIGH?T	_segh
	LABEL?L	L00184	
	CMPT?TL	_OUTA2H??1, L00186
	LOW?T	_segg
	LABEL?L	L00186	
	GOSUB?L	_SPIRALPAUSE
	GOTO?L	_outdisp

	LABEL?L	_bits	

	LABEL?L	_b1	
	CMPT?TL	_sega, L00188
	GOTO?L	_b2
	LABEL?L	L00188	
	SUB?BCB	PORTA, 002h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_b2	
	CMPT?TL	_segc, L00190
	GOTO?L	_b3
	LABEL?L	L00190	
	SUB?BCB	PORTA, 004h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_b3	
	CMPT?TL	_segk, L00192
	GOTO?L	_b4
	LABEL?L	L00192	
	SUB?BCB	PORTC, 004h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b4	
	CMPT?TL	_segn, L00194
	GOTO?L	_b5
	LABEL?L	L00194	
	SUB?BCB	PORTA, 010h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_b5	
	CMPT?TL	_segh, L00196
	GOTO?L	_b6
	LABEL?L	L00196	
	SUB?BCB	PORTB, 040h, _TEMP1
	GOSUB?L	_foutb

	LABEL?L	_b6	
	CMPT?TL	_segl, L00198
	GOTO?L	_b7
	LABEL?L	L00198	
	SUB?BCB	PORTC, 020h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b7	
	CMPT?TL	_segf, L00200
	GOTO?L	_b8
	LABEL?L	L00200	
	SUB?BCB	PORTC, 008h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b8	
	CMPT?TL	_segj, L00202
	GOTO?L	_b9
	LABEL?L	L00202	
	SUB?BCB	PORTA, 001h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_b9	
	CMPT?TL	_segd, L00204
	GOTO?L	_b10
	LABEL?L	L00204	
	SUB?BCB	PORTA, 020h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_b10	
	CMPT?TL	_segb, L00206
	GOTO?L	_b11
	LABEL?L	L00206	
	SUB?BCB	PORTC, 001h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b11	
	CMPT?TL	_segm, L00208
	GOTO?L	_b12
	LABEL?L	L00208	
	SUB?BCB	PORTC, 080h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b12	
	CMPT?TL	_segg, L00210
	GOTO?L	_b13
	LABEL?L	L00210	
	SUB?BCB	PORTC, 010h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b13	
	CMPT?TL	_segi, L00212
	GOTO?L	_b14
	LABEL?L	L00212	
	SUB?BCB	PORTC, 002h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b14	
	CMPT?TL	_sege, L00214
	GOTO?L	_b15
	LABEL?L	L00214	
	SUB?BCB	PORTC, 040h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_b15	
	CMPT?TL	_segu, L00216
	GOTO?L	_b16
	LABEL?L	L00216	
	SUB?BCB	PORTB, 010h, _TEMP1
	GOSUB?L	_foutb

	LABEL?L	_b16	
	GOTO?L	_nb1

	LABEL?L	_nb1	
	CMPT?TL	_NEW_PORTA??0, L00218
	GOTO?L	_nb2
	LABEL?L	L00218	
	ADD?BCB	PORTA, 001h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_nb2	
	CMPT?TL	_NEW_PORTA??2, L00220
	GOTO?L	_nb3
	LABEL?L	L00220	
	ADD?BCB	PORTA, 004h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_nb3	
	CMPT?TL	_NEW_PORTC??2, L00222
	GOTO?L	_nb4
	LABEL?L	L00222	
	ADD?BCB	PORTC, 004h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb4	
	CMPT?TL	_NEW_PORTC??5, L00224
	GOTO?L	_nb5
	LABEL?L	L00224	
	ADD?BCB	PORTC, 020h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb5	
	CMPT?TL	_NEW_PORTB??6, L00226
	GOTO?L	_nb6
	LABEL?L	L00226	
	ADD?BCB	PORTB, 040h, _TEMP1
	GOSUB?L	_foutb

	LABEL?L	_nb6	
	CMPT?TL	_NEW_PORTA??4, L00228
	GOTO?L	_nb7
	LABEL?L	L00228	
	ADD?BCB	PORTA, 010h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_nb7	
	CMPT?TL	_NEW_PORTC??3, L00230
	GOTO?L	_nb8
	LABEL?L	L00230	
	ADD?BCB	PORTC, 008h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb8	
	CMPT?TL	_NEW_PORTA??1, L00232
	GOTO?L	_nb9
	LABEL?L	L00232	
	ADD?BCB	PORTA, 002h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_nb9	
	CMPT?TL	_NEW_PORTA??5, L00234
	GOTO?L	_nb10
	LABEL?L	L00234	
	ADD?BCB	PORTA, 020h, _TEMP1
	GOSUB?L	_fouta

	LABEL?L	_nb10	
	CMPT?TL	_NEW_PORTC??0, L00236
	GOTO?L	_nb11
	LABEL?L	L00236	
	ADD?BCB	PORTC, 001h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb11	
	CMPT?TL	_NEW_PORTC??7, L00238
	GOTO?L	_nb12
	LABEL?L	L00238	
	ADD?BCB	PORTC, 080h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb12	
	CMPT?TL	_NEW_PORTC??6, L00240
	GOTO?L	_nb13
	LABEL?L	L00240	
	ADD?BCB	PORTC, 040h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb13	
	CMPT?TL	_NEW_PORTC??1, L00242
	GOTO?L	_nb14
	LABEL?L	L00242	
	ADD?BCB	PORTC, 002h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb14	
	CMPT?TL	_NEW_PORTC??4, L00244
	GOTO?L	_nb15
	LABEL?L	L00244	
	ADD?BCB	PORTC, 010h, _TEMP1
	GOSUB?L	_foutc

	LABEL?L	_nb15	
	CMPT?TL	_NEW_PORTB??4, L00246
	GOTO?L	_nb16
	LABEL?L	L00246	
	ADD?BCB	PORTB, 010h, _TEMP1
	GOSUB?L	_foutb

	LABEL?L	_nb16	
	GOTO?L	_outdisp

	LABEL?L	_zipper	
	HIGH?T	_segh
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segg
	HIGH?T	_segi
	LOW?T	_segh
	LOW?T	_sega
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segn
	HIGH?T	_segj
	LOW?T	_segi
	LOW?T	_segg
	LOW?T	_segb
	LOW?T	_segf
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segm
	LOW?T	_segn
	LOW?T	_segj
	LOW?T	_sege
	LOW?T	_segc
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	LOW?T	_segm
	LOW?T	_segk
	LOW?T	_segd
	GOSUB?L	_SPIRALPAUSE
	LOW?T	_segl
	LOW?T	_segu
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segl
	GOSUB?L	_SPIRALPAUSE
	CMPF?TL	_ZFLAGS??7, L00248
	HIGH?T	_segu
	LABEL?L	L00248	
	HIGH?T	_segd
	HIGH?T	_segk
	HIGH?T	_segm
	CMPT?TL	_OUTI2N??4, L00250
	LOW?T	_segl
	LABEL?L	L00250	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segn
	HIGH?T	_segj
	HIGH?T	_segc
	HIGH?T	_sege
	CMPT?TL	_OUTI2N??5, L00252
	LOW?T	_segk
	LABEL?L	L00252	
	CMPT?TL	_OUTI2N??3, L00254
	LOW?T	_segm
	LABEL?L	L00254	
	CMPT?TL	_OUTA2H??4, L00256
	LOW?T	_segd
	LABEL?L	L00256	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segg
	HIGH?T	_segi
	HIGH?T	_segb
	HIGH?T	_segf
	CMPT?TL	_OUTI2N??2, L00258
	LOW?T	_segn
	LABEL?L	L00258	
	CMPT?TL	_OUTI2N??6, L00260
	LOW?T	_segj
	LABEL?L	L00260	
	CMPT?TL	_OUTA2H??5, L00262
	LOW?T	_segc
	LABEL?L	L00262	
	CMPT?TL	_OUTA2H??3, L00264
	LOW?T	_sege
	LABEL?L	L00264	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_sega
	CMPT?TL	_OUTA2H??6, L00266
	LOW?T	_segb
	LABEL?L	L00266	
	CMPT?TL	_OUTA2H??2, L00268
	LOW?T	_segf
	LABEL?L	L00268	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segh
	CMPT?TL	_OUTI2N??7, L00270
	LOW?T	_segi
	LABEL?L	L00270	
	CMPT?TL	_OUTA2H??1, L00272
	LOW?T	_segg
	LABEL?L	L00272	
	CMPT?TL	_OUTA2H??7, L00274
	LOW?T	_sega
	LABEL?L	L00274	
	GOSUB?L	_SPIRALPAUSE
	CMPT?TL	_OUTA2H??0, L00276
	LOW?T	_segh
	LABEL?L	L00276	
	GOSUB?L	_SPIRALPAUSE
	GOTO?L	_outdisp

	LABEL?L	_shifter	
	HIGH?T	_segn
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segm
	HIGH?T	_segg
	LOW?T	_segn
	LOW?T	_segf
	LOW?T	_sege
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segh
	HIGH?T	_segl
	LOW?T	_segm
	LOW?T	_segg
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segi
	LOW?T	_segh
	LOW?T	_segl
	LOW?T	_sega
	LOW?T	_segd
	LOW?T	_segu
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	LOW?T	_segi
	LOW?T	_segk
	LOW?T	_segb
	LOW?T	_segc
	GOSUB?L	_SPIRALPAUSE
	LOW?T	_segj
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segn
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_sege
	HIGH?T	_segf
	HIGH?T	_segm
	HIGH?T	_segg
	CMPT?TL	_OUTI2N??2, L00278
	LOW?T	_segn
	LABEL?L	L00278	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segh
	HIGH?T	_segl
	CMPF?TL	_ZFLAGS??7, L00280
	HIGH?T	_segu
	LABEL?L	L00280	
	CMPT?TL	_OUTI2N??3, L00282
	LOW?T	_segm
	LABEL?L	L00282	
	CMPT?TL	_OUTA2H??1, L00284
	LOW?T	_segg
	LABEL?L	L00284	
	CMPT?TL	_OUTA2H??3, L00286
	LOW?T	_sege
	LABEL?L	L00286	
	CMPT?TL	_OUTA2H??2, L00288
	LOW?T	_segf
	LABEL?L	L00288	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segk
	HIGH?T	_segi
	CMPT?TL	_OUTA2H??0, L00290
	LOW?T	_segh
	LABEL?L	L00290	
	CMPT?TL	_OUTI2N??4, L00292
	LOW?T	_segl
	LABEL?L	L00292	
	CMPF?TL	_OUTA2H??7, L00294
	HIGH?T	_sega
	LABEL?L	L00294	
	CMPF?TL	_OUTA2H??4, L00296
	HIGH?T	_segd
	LABEL?L	L00296	
	GOSUB?L	_SPIRALPAUSE
	HIGH?T	_segj
	CMPF?TL	_OUTA2H??6, L00298
	HIGH?T	_segb
	LABEL?L	L00298	
	CMPF?TL	_OUTA2H??5, L00300
	HIGH?T	_segc
	LABEL?L	L00300	
	CMPT?TL	_OUTI2N??7, L00302
	LOW?T	_segi
	LABEL?L	L00302	
	CMPT?TL	_OUTI2N??5, L00304
	LOW?T	_segk
	LABEL?L	L00304	
	GOSUB?L	_SPIRALPAUSE
	CMPT?TL	_OUTI2N??6, L00306
	LOW?T	_segj
	LABEL?L	L00306	
	GOSUB?L	_SPIRALPAUSE
	GOTO?L	_outdisp
	END?	

	END
