.segment "INES"
    .byte "NES",$1A,1,1,1
    ;      012   3  4 5 6
    ; http://wiki.nesdev.com/w/index.php/INES
    
.segment "VECTORS"
    .word V_blank   ; Non-maskable interrupt handler (used for V-Blank)
    .word Start     ; Initial program counter value
    .word Irq       ; Maskable interrupt handler (can be thrown from code with BRK instruction)

.segment "GFX"
    ; These files can be drawn with tile molester
    .incbin "data/sprites.chr"      ; Graphics for moving things (binary file)
    .incbin "data/background.chr"   ; Graphics for background (binary file)
    
.segment "CODE"
    V_blank:
        ; vblank code here
        RTI
    Start:
        ; main thread code
        JMP Start
    No_op:
        ; 
        RTI
    
.segment "ZERO_PAGE"
    .include "memory/zeropage.asm"          ; First page of RAM (faster access)
    
.segment "RAM"
    .include "memory/ram.asm"               ; Remainder of RAM
    
