[bits 16]
[org 0x7c00]
  jmp start
  nop

; BIOS parameter block
  OEMname:           db    "mkfs.fat"
  bytesPerSector:    dw    512
  sectPerCluster:    db    1
  reservedSectors:   dw    1
  numFAT:            db    2
  numRootDirEntries: dw    224
  numSectors:        dw    2880
  mediaType:         db    0xf0
  numFATsectors:     dw    9
  sectorsPerTrack:   dw    18
  numHeads:          dw    2
  numHiddenSectors:  dd    0
  numSectorsHuge:    dd    0
  driveNum:          db    0
  reserved:          db    0
  signature:         db    0x29
  volumeID:          dd    0x2d7e5a1a
  volumeLabel:       db    "NO NAME    "
  fileSysType:       db    "FAT12   "

start:
  cli
  mov [drive], dl

  xor ax, ax
  mov ds, ax

  ; Setup stack pointer
  mov bp, 0x8000
  mov sp, bp

  ; Reset disk system
  xor ax, ax
  int 0x13

  ; Read sectors into memory
  mov ah, 0x02
  mov al, 3 ; Read 3 sectors
  mov ch, 0
  mov dh, 0
  mov cl, 2
  mov dl, [drive]
  mov bx, 0x9000
  mov es, bx
  xor bx, bx
  int 0x13
  jc error

  ; Enter graphical mode
  xor ax, ax
  mov ds, ax

  mov ah, 0x00
  mov al, 0x13
  int 0x10

  ; Print message
  mov ax, 0x9000
  mov ds, ax
  mov si, 0
  call print

  ; Draw logo
  mov si, 0x200

  mov ah, 0x0c
  mov bh, 0

  mov dx, 0
next_line:
  mov cx, 0
  add dx, 100 - 16
next_pixel:
  lodsb
  add cx, 160 - 16
  int 0x10
  sub cx, 160 - 16

  inc cx
  cmp cx, 32
  jne next_pixel

  sub dx, 100 - 16
  inc dx
  cmp dx, 32
  jne next_line

end:
  hlt

error:
  mov si, errormsg
  call print
  jmp end

print:
  mov ah, 0x02
  mov dh, 16
  mov dl, 14
  int 0x10

  mov ah, 0x0e
  mov bl, 0xf

print_next:
  lodsb
  cmp al, 0
  je print_end
  int 0x10
  jmp print_next

print_end:
  ret

drive: dw 0
msg: db "Bonjour le stream!", 0
errormsg: db "Ca a pas marche lol", 0

times 510-($-$$) db 0
dw 0xaa55
