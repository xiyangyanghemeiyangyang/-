                PRESERVE8            ; 8?????
                THUMB                ; ??Thumb???

; ?????
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x20001000   ; ????(SRAM??)
                DCD     Reset_Handler; ????
                SPACE   0x1C0        ; ??????????

; ???
                AREA    |.text|, CODE, READONLY
                ENTRY
Reset_Handler   PROC
                EXPORT  Reset_Handler

                ; ??????
                MOV     R4, #1       ; ?????i (1~10)
                MOV     R5, #0       ; ???SUM

MainLoop        CMP     R4, #10      ; ??????
                BGT     StoreResult  ; ???????

                ; ??i!
                MOV     R0, R4       ; ??n = i
                BL      Factorial    ; ??????
                
                ; ???SUM
                ADD     R5, R5, R0   ; SUM += i!
                
                ; ???????
                ADD     R4, R4, #1   ; i++
                B       MainLoop

StoreResult     ; ??????
                LDR     R1, =SUM     ; ??????
                STR     R5, [R1]     ; ????
                B       .            ; ????

; ???????
; ??:R0 = n
; ??:R0 = n!
Factorial       PROC
                CMP     R0, #1       ; ??????
                BGT     RecursiveCase
                MOV     R0, #1       ; 0! = 1! = 1
                BX      LR

RecursiveCase   PUSH    {R0, LR}     ; ????n?????
                SUB     R0, #1       ; n = n-1
                BL      Factorial    ; ??(n-1)!
                POP     {R1, LR}     ; ????n?R1
                MUL     R0, R1, R0  ; R0 = n * (n-1)!
                BX      LR           ; ?????
                ENDP

; ???
                AREA    MyData, DATA, READWRITE
SUM             DCD     0            ; ??????(??0x20000000)

                ALIGN
                END
