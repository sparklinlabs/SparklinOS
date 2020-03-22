[bits 16]
[org 0x7c00]
  jmp start
  nop

# BIOS parameter block
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
  xor ax, ax
  mov ds, ax

  mov ah, 0x00
  mov al, 0x13
  int 0x10

  mov cx, 160
  mov dx, 100
  call hline

  mov cx, 160
  mov dx, 140
  call hline

  mov cx, 160
  mov dx, 100
  call vline

  mov cx, 240
  mov dx, 100
  call vline

  mov si, msg
  call print

end:
  hlt

hline:
  mov ah, 0x0c
  mov al, 0x0a
  mov bh, 0
  int 0x10
  inc cx
  cmp cx, 240
  jne hline
  ret

vline:
  mov ah, 0x0c
  mov al, 0x0a
  mov bh, 0
  int 0x10
  inc dx
  cmp dx, 140
  jne vline
  ret

print:
  mov ah, 0x02
  mov dh, 4
  mov dl, 4
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

msg:
  db "Bonjour le stream!", 0

times 510-($-$$) db 0
dw 0xaa55
