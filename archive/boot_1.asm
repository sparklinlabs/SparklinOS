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
  mov si, msg

  mov ah, 0x0e

print_next:
  lodsb
  cmp al, 0
  je end
  int 0x10
  jmp print_next

end:
  hlt

msg:
  db "Coucou.", 0

times 510-($-$$) db 0
dw 0xaa55
