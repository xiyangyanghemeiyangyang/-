                PRESERVE8                          ; 8?????
                THUMB                              ; ??Thumb???

; ?????
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x20001000                 ; ????(??SRAM????)
                DCD     Reset_Handler              ; ????
                SPACE   4 * 7                     ; ??????????

; ????
                AREA    |.text|, CODE, READONLY
                ENTRY
Reset_Handler   PROC
                EXPORT  Reset_Handler

                ; 1. ??????Flash???RAM
                LDR     R0, =__data_load          ; Flash????????
                LDR     R1, =__data_start         ; RAM?????(0x20000000)
                LDR     R2, =__data_end           ; RAM???????
CopyLoop        CMP     R1, R2
                BGE     CopyDone
                LDR     R3, [R0], #4              ; ?Flash????
                STR     R3, [R1], #4              ; ??RAM
                B       CopyLoop
CopyDone

                ; 2. ??????????????
                LDR     R0, =DataArray            ; R0 = ??????
                LDR     R1, [R0]                   ; R1 = ?????(?????)
                MOV     R2, R1                     ; R2 = ?????(?????)
                MOV     R3, #1                     ; ?????

FindLoop        CMP     R3, #10                   ; ???????????
                BGE     StoreResults               ; ?????

                LDR     R4, [R0, R3, LSL #2]       ; ???????(R3*4?????)
                
                ; ????????
                CMP     R4, R1                     
                BLE     CheckMin                  
                MOV     R1, R4                     ; ?????

CheckMin        ; ????????
                CMP     R4, R2
                BGE     NextIteration             
                MOV     R2, R4                     ; ?????

NextIteration   ADD     R3, R3, #1                ; ????1
                B       FindLoop                   ; ????

StoreResults    ; ???????
                LDR     R5, =MaxResult
                STR     R1, [R5]                   ; ?????
                LDR     R5, =MinResult
                STR     R2, [R5]                   ; ?????

                B       .                         ; ????(????)
                ENDP

; ?????
                AREA    MyData, DATA, READWRITE
__data_start    EQU     0x20000000                 ; ???????(RAM)
DataArray       DCD     32, 77, 12, 94, 58, 6, 100, 45, 73, 20
MaxResult       DCD     0
MinResult       DCD     0
__data_end      EQU     .                          ; ???????

                AREA    DataLoad, DATA, READONLY
__data_load     DCD     32, 77, 12, 94, 58, 6, 100, 45, 73, 20 ; Flash??????

                ALIGN
                END
