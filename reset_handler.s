Reset_Handler:
    cpsid   i
    .equ    VTOR, 0xE000ED08
    ldr     r0, VTOR
    ldr     r1, __isr_vector
    str     r1, [r0]
    
    # Apel SystemInit 
    ldr     r0, SystemInit
    blx     r0

    # Copiere constante 
    ldr     r1, __etext
    ldr     r2, __data_start__
    ldr     r3, __data_end__

    subs    r3, r2
    ble     .LC1
.LC0:
    subs    r3, 4
    ldr     r0, [r1, r3]
    str     r0, [r2, r3]
    bgt     .LC0
.LC1:

    # Inițializare heap 
    ldr     r1, __bss_start__
    ldr     r2, __bss_end__

    movs    r0, 0
.LC2:
    cmp     r1, r2
    itt     lt
    strlt   r0, [r1], 4
    blt     .LC2

    cpsie   i
    
    # Inițializare libc 
    ldr     r0, __libc_init_array
    blx     r0
    
    # Apel main, predare control spre aplicație 
    ldr     r0, main
    bx      r0