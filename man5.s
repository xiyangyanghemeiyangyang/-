                PRESERVE8            ; 8?????
                THUMB                ; ??Thumb???

; ?????
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x20001000   ; ????(SRAM??)
                DCD     Reset_Handler; ????
                SPACE   0x1C0        ; ????????

; ???
                AREA    |.text|, CODE, READONLY
                ENTRY
Reset_Handler   PROC
                EXPORT  Reset_Handler

                ; ?????1??
                LDR     R0, =Str1
                BL      StrLen
                LDR     R1, =Length1
                STR     R0, [R1]

                ; ?????2??
                LDR     R0, =Str2
                BL      StrLen
                LDR     R1, =Length2
                STR     R0, [R1]

                ; ?????
                LDR     R0, =Str1
                LDR     R1, =Str2
                BL      StrCmp
                LDR     R2, =MatchResult
                STR     R0, [R2]

                B       .            ; ????

; ??????????
; ??:R0 = ?????
; ??:R0 = ?????
StrLen          PROC
                MOV     R1, #0        ; ??????
Loop_StrLen     LDRB    R2, [R0], #1  ; ?????????
                CMP     R2, #0        ; ?????
                BEQ     Exit_StrLen
                ADD     R1, R1, #1    ; ???+1
                B       Loop_StrLen
Exit_StrLen     MOV     R0, R1        ; ????
                BX      LR
                ENDP

; ????????
; ??:R0 = ???1??,R1 = ???2??
; ??:R0 = ????(0:?? 1:???)
StrCmp          PROC
                PUSH    {R4-R5}
Loop_StrCmp     LDRB    R4, [R0], #1  ; ??Str1??
                LDRB    R5, [R1], #1  ; ??Str2??
                CMP     R4, R5
                BNE     NotMatch      ; ?????
                CMP     R4, #0        ; ??????
                BEQ     Match
                B       Loop_StrCmp

NotMatch        MOV     R0, #1        ; ?????
                B       Exit_StrCmp
Match           MOV     R0, #0        ; ????
Exit_StrCmp     POP     {R4-R5}
                BX      LR
                ENDP

; ???
                AREA    MyData, DATA, READWRITE
Str1            DCB     "Hello",0     ; ?????1
Str2            DCB     "Hello",0     ; ?????2
                ALIGN                ; ????
Length1         DCD     0             ; ???1??
Length2         DCD     0             ; ???2??
MatchResult     DCD     0             ; ????

                ALIGN
                END
