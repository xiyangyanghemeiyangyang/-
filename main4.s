                PRESERVE8
                THUMB

; ??????? CODE ?
                AREA    RESET, CODE, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x20001000       ; ?????
                DCD     Reset_Handler    ; ????
                SPACE   0x1C0            ; ????????

; ???
                AREA    |.text|, CODE, READONLY
                ENTRY
Reset_Handler   PROC
                EXPORT  Reset_Handler

                ; ==== ??????? ====
                LDR     R0, =FlashData   ; FLASH???????
                LDR     R1, =DataArray   ; RAM??????(0x20000000)
                MOV     R2, #10          ; ??10??

copy_loop       LDRB    R3, [R0], #1     ; ?FLASH????
                STRB    R3, [R1], #1     ; ???RAM
                SUBS    R2, #1
                BNE     copy_loop

                ; ==== ???? ====
                LDR     R0, =DataArray
                MOV     R1, #10
                BL      BubbleSort

                B       .               ; ????
                ENDP

; ???????
BubbleSort      PROC
                PUSH    {R4-R7, LR}
                SUBS    R2, R1, #1
                BEQ     ExitSort

OuterLoop       MOV     R3, #0
                MOV     R4, #0

InnerLoop       LDRB    R5, [R0, R3]
                ADD     R6, R3, #1
                LDRB    R7, [R0, R6]
                CMP     R5, R7
                BLS     NoSwap

                STRB    R7, [R0, R3]
                STRB    R5, [R0, R6]
                MOV     R4, #1

NoSwap          ADDS    R3, #1
                CMP     R3, R2
                BLT     InnerLoop

                CBZ     R4, ExitSort
                SUBS    R2, #1
                BGT     OuterLoop

ExitSort        POP     {R4-R7, PC}
                ENDP

; FLASH?????? (???????RAM)
                AREA    FlashData, CODE, READONLY
InitialData     DCB     '9','8','7','6','5','4','3','2','1','0'

; RAM??? (?????0x20000000)
                AREA    MyData, DATA, READWRITE
                ALIGN   4
DataArray       SPACE   10              ; ??10????
ResultArray     SPACE   10

                END
