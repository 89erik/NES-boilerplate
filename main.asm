.include "data/constants.inc"
.include "data/sound_constants.inc"

; Exporting global variables. TODO: move to separate file
.export v_blank_complete
.export sub_routine_arg1
.export sub_routine_arg2
.export sub_routine_tmp
.export fp


.segment "INES"
    .byte "NES",$1A,1,1,1
    ;      012   3  4 5 6
    ; http://wiki.nesdev.com/w/index.php/INES
    
.segment "VECTORS"
    .word V_blank   ; Non-maskable interrupt (used by V-Blank)
    .word Start     ; Initial program counter value
    .word No_op     ; IRQ (not used)

.segment "GFX"
    .incbin "data/sprites.chr"      ; Graphics for moving things (binary file)
    .incbin "data/background.chr"   ; Graphics for background (binary file)
    
.segment "CODE"
        .include "src/lib/graphical.asm"
        .include "src/lib/game.asm"
        .include "src/load_level.asm"
        .include "src/init/fill_background.asm"
        .include "src/start_screen.asm"
        .include "src/next_level.asm"
        .include "src/sound/sounds.asm"
    Start:
        .include "src/init/init.asm"        ; Initialization procedure
        .include "src/loop/loop.asm"        ; Physics to be performed per framerate
    V_blank:
        .include "src/v_blank.asm"          ; Drawing the screen
    No_op:
        RTI
    
.segment "DATA" 
    .include "data/palette.asm"
    .include "data/levels.asm"
    
.segment "ZERO_PAGE"
    .include "memory/ram.asm"               ; Variables in RAM
    
.segment "OAM"
    .include "memory/oam.asm"               ; Sprite memory
    
