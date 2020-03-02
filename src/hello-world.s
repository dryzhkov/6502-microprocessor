PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

reset:
  ldx #$ff       ; Initialize stack pointer
  txs

  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_send

  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_send

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_send

  lda #%00000001 ; Clear display
  jsr lcd_send

loop:
  lda #"H"
  jsr print_char

  lda #"e"
  jsr print_char

  lda #"l"
  jsr print_char

  lda #"l"
  jsr print_char

  lda #"o"
  jsr print_char

  lda #","
  jsr print_char

  lda #%00010100 ; Shift cursor to the right once
  jsr lcd_send

  lda #%11000011 ; Sets DDRAM address so that the cursor is positioned at the head of the second line. 
  jsr lcd_send

  lda #"w"
  jsr print_char

  lda #"o"
  jsr print_char

  lda #"r"
  jsr print_char

  lda #"l"
  jsr print_char

  lda #"d"
  jsr print_char

  lda #"!"
  jsr print_char

  lda #%00000001 ; Clear display
  jsr lcd_send

  lda #%00000010 ; Return cursor home
  jsr lcd_send

  jmp loop

lcd_send:        ; subrouting to value from "A" register to LCD
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

print_char:      ; prints charatcter from "A" register to LCD
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000