main:
    li x10, 48          # Argument 1: a
    li x11, 18          # Argument 2: b
    jal x1, gcd          # Calculate gcd(48, 18)

    addi x11, x10, 0    # move result to a1
    li x10, 1
    ecall
    j exit

gcd:
    addi sp, sp, -8       # reserve 2 words: ra, b
    sw x1, 4(sp)          # save return address
    sw x11, 0(sp)         # save b (need it after the call for remainder calc)

    beq x11, x0, base     # if b == 0, base case: return a (already in x10)

    rem x5, x10, x11      # x5 = a mod b
    add x10, x11, x0      # new a = old b
    add x11, x5, x0       # new b = a mod b
    jal x1, gcd            # gcd(b, a mod b)

    j exit_gcd

base:
    # x10 already holds a (the gcd), nothing to compute

exit_gcd:
    lw x1, 4(sp)          # restore return address
    addi sp, sp, 8         # pop frame
    jalr x0, 0(x1)          # return

exit:
end:
    j end