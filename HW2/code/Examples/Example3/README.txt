# In first shell
make
spike --rbb-port=9824 pk ./sum

# In second shell
openocd -f spike.cfg

# In third shell
riscv64-unknown-elf-gdb ./sum
(gdb) target remote :3333
