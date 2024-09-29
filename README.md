
#  Bootloader and Protected Mode Transition 

- **Bootloader Development**: Custom bootloader designed to boot in real mode and prepare the system for protected mode transition.
- **Protected Mode Transition**: Worked on configuring segment descriptors and enabling the A20 line to switch the system into protected mode, allowing access to 32-bit memory addressing.
- **Kernel Loading**: Loaded a 32-bit kernel into memory and debugged the system using symbols for further development in C.






## Features

- Implemented interrupt vector table (IVT) in real mode.
- Disk access in real mode, allowing the bootloader to read from the hard disk
- Enabled A20 line for access to extended memory
- Configured segment descriptors for 32-bit protected mode


## Tech 
- **Languages**: Assembly (NASM), C, makefile
- **Tools**: QEMU (for emulation), NASM (Assembler), GCC (Cross Compiler)
- **Concepts**: Real mode, protected mode, A20 line, segmentation memory model


## Acknowledgements

 - Thanks to the [OSDev Wiki](https://wiki.osdev.org) for the invaluable resources and documentation.


## Lessons Learned

- Gained a deeper understanding of x86 architecture and low-level programming.
- Learned to troubleshoot and debug complex boot processes.
- Improved skills in memory management and hardware interaction.
- Enhanced knowledge of operating system fundamentals and real-mode programming.



## Authors

- [Zahra Ebrahim zade](https://github.com/zhr-ebrahimzade)


## Feedback
Feel free to reach out via email: [ebrahimzade.zhr@gmail.com] if you have questions or suggestions.


## Screenshots
The first stages: 

![1](https://drive.google.com/drive/u/0/folders/1nAJh0Sw0LZ1N1XyJ4zC1ksPSsmKzytm_)

![2](https://drive.google.com/file/d/11U7MEjCxvYXujL1IJHaB134978YLMMKb/view?usp=sharing)

![3](https://drive.google.com/drive/u/0/folders/1nAJh0Sw0LZ1N1XyJ4zC1ksPSsmKzytm_)

