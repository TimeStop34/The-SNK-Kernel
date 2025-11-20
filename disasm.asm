
output/kernel.elf:     формат файла elf32-i386


Дизассемблирование раздела .multiboot:

00000000 <multiboot_header>:
   0:	02 b0 ad 1b 00 00    	add    dh,BYTE PTR [eax+0x1bad]
   6:	00 00                	add    BYTE PTR [eax],al
   8:	fe 4f 52             	dec    BYTE PTR [edi+0x52]
   b:	e4                   	.byte 0xe4

Дизассемблирование раздела .boot:

00010000 <early_boot>:
   10000:	55                   	push   ebp
   10001:	89 e5                	mov    ebp,esp
   10003:	83 ec 08             	sub    esp,0x8
   10006:	e8 76 01 00 00       	call   10181 <early_gdt_init>
   1000b:	e8 17 01 00 00       	call   10127 <higher_half_kernel_init>
   10010:	90                   	nop
   10011:	c9                   	leave
   10012:	c3                   	ret

00010013 <setup_higher_half_mapping>:
   10013:	55                   	push   ebp
   10014:	89 e5                	mov    ebp,esp
   10016:	83 ec 20             	sub    esp,0x20
   10019:	c7 45 f0 00 10 00 00 	mov    DWORD PTR [ebp-0x10],0x1000
   10020:	c7 45 ec 00 20 00 00 	mov    DWORD PTR [ebp-0x14],0x2000
   10027:	c7 45 e8 00 30 00 00 	mov    DWORD PTR [ebp-0x18],0x3000
   1002e:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
   10035:	eb 55                	jmp    1008c <setup_higher_half_mapping+0x79>
   10037:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   1003a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
   10041:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   10044:	01 d0                	add    eax,edx
   10046:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
   1004c:	81 7d fc ff 03 00 00 	cmp    DWORD PTR [ebp-0x4],0x3ff
   10053:	7f 15                	jg     1006a <setup_higher_half_mapping+0x57>
   10055:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   10058:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
   1005f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   10062:	01 d0                	add    eax,edx
   10064:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
   1006a:	81 7d fc ff 03 00 00 	cmp    DWORD PTR [ebp-0x4],0x3ff
   10071:	7f 15                	jg     10088 <setup_higher_half_mapping+0x75>
   10073:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   10076:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
   1007d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
   10080:	01 d0                	add    eax,edx
   10082:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
   10088:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   1008c:	81 7d fc ff 03 00 00 	cmp    DWORD PTR [ebp-0x4],0x3ff
   10093:	7e a2                	jle    10037 <setup_higher_half_mapping+0x24>
   10095:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
   1009c:	eb 20                	jmp    100be <setup_higher_half_mapping+0xab>
   1009e:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   100a1:	c1 e0 0c             	shl    eax,0xc
   100a4:	83 c8 03             	or     eax,0x3
   100a7:	89 c2                	mov    edx,eax
   100a9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   100ac:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
   100b3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   100b6:	01 c8                	add    eax,ecx
   100b8:	89 10                	mov    DWORD PTR [eax],edx
   100ba:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
   100be:	81 7d f8 ff 03 00 00 	cmp    DWORD PTR [ebp-0x8],0x3ff
   100c5:	7e d7                	jle    1009e <setup_higher_half_mapping+0x8b>
   100c7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
   100ce:	eb 20                	jmp    100f0 <setup_higher_half_mapping+0xdd>
   100d0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   100d3:	c1 e0 0c             	shl    eax,0xc
   100d6:	83 c8 03             	or     eax,0x3
   100d9:	89 c2                	mov    edx,eax
   100db:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   100de:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
   100e5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
   100e8:	01 c8                	add    eax,ecx
   100ea:	89 10                	mov    DWORD PTR [eax],edx
   100ec:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
   100f0:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
   100f7:	7e d7                	jle    100d0 <setup_higher_half_mapping+0xbd>
   100f9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   100fc:	83 c8 03             	or     eax,0x3
   100ff:	89 c2                	mov    edx,eax
   10101:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   10104:	89 10                	mov    DWORD PTR [eax],edx
   10106:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
   10109:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   1010c:	05 00 0c 00 00       	add    eax,0xc00
   10111:	83 ca 03             	or     edx,0x3
   10114:	89 10                	mov    DWORD PTR [eax],edx
   10116:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   10119:	05 fc 0f 00 00       	add    eax,0xffc
   1011e:	c7 00 03 10 00 00    	mov    DWORD PTR [eax],0x1003
   10124:	90                   	nop
   10125:	c9                   	leave
   10126:	c3                   	ret

00010127 <higher_half_kernel_init>:
   10127:	55                   	push   ebp
   10128:	89 e5                	mov    ebp,esp
   1012a:	83 ec 08             	sub    esp,0x8
   1012d:	e8 e1 fe ff ff       	call   10013 <setup_higher_half_mapping>
   10132:	e8 67 00 00 00       	call   1019e <early_enable_paging>
   10137:	b8 00 80 0b 00       	mov    eax,0xb8000
   1013c:	66 c7 00 4f 2f       	mov    WORD PTR [eax],0x2f4f
   10141:	b8 02 80 0b 00       	mov    eax,0xb8002
   10146:	66 c7 00 4b 2f       	mov    WORD PTR [eax],0x2f4b
   1014b:	e8 06 33 01 c0       	call   c0023456 <kmain>
   10150:	90                   	nop
   10151:	c9                   	leave
   10152:	c3                   	ret

00010153 <page_fault_handler>:
   10153:	55                   	push   ebp
   10154:	89 e5                	mov    ebp,esp
   10156:	b8 00 80 0b 00       	mov    eax,0xb8000
   1015b:	66 c7 00 41 2f       	mov    WORD PTR [eax],0x2f41
   10160:	90                   	nop
   10161:	5d                   	pop    ebp
   10162:	c3                   	ret

00010163 <early_gdt>:
	...
   1016b:	ff                   	(bad)
   1016c:	ff 00                	inc    DWORD PTR [eax]
   1016e:	00 00                	add    BYTE PTR [eax],al
   10170:	9a cf 00 ff ff 00 00 	call   0x0:0xffff00cf
   10177:	00 92 cf 00      	add    BYTE PTR [edx+0x1700cf],dl

0001017b <early_gdt_info>:
   1017b:	17                   	pop    ss
   1017c:	00 63 01             	add    BYTE PTR [ebx+0x1],ah
   1017f:	01 00                	add    DWORD PTR [eax],eax

00010181 <early_gdt_init>:
   10181:	0f 01 15 7b 01 01 00 	lgdtd  ds:0x1017b
   10188:	66 b8 10 00          	mov    ax,0x10
   1018c:	8e d8                	mov    ds,eax
   1018e:	8e c0                	mov    es,eax
   10190:	8e e0                	mov    fs,eax
   10192:	8e e8                	mov    gs,eax
   10194:	8e d0                	mov    ss,eax
   10196:	ea 9d 01 01 00 08 00 	jmp    0x8:0x1019d

0001019d <early_gdt_init.early_reload_cs>:
   1019d:	c3                   	ret

0001019e <early_enable_paging>:
   1019e:	b8 00 10 00 00       	mov    eax,0x1000
   101a3:	0f 22 d8             	mov    cr3,eax
   101a6:	0f 20 c0             	mov    eax,cr0
   101a9:	0d 00 00 00 80       	or     eax,0x80000000
   101ae:	0f 22 c0             	mov    cr0,eax
   101b1:	c3                   	ret

000101b2 <asm_page_fault_handler>:
   101b2:	60                   	pusha
   101b3:	e8 9b ff ff ff       	call   10153 <page_fault_handler>
   101b8:	61                   	popa
   101b9:	cf                   	iret

Дизассемблирование раздела .text:

c0020000 <init_section>:
c0020000:	55                   	push   ebp
c0020001:	89 e5                	mov    ebp,esp
c0020003:	83 ec 08             	sub    esp,0x8
c0020006:	83 ec 0c             	sub    esp,0xc
c0020009:	68 20 35 02 c0       	push   0xc0023520
c002000e:	e8 e7 04 00 00       	call   c00204fa <kprintf>
c0020013:	83 c4 10             	add    esp,0x10
c0020016:	f3 90                	pause
c0020018:	eb fc                	jmp    c0020016 <init_section+0x16>

c002001a <atomic_xchg>:
c002001a:	55                   	push   ebp
c002001b:	89 e5                	mov    ebp,esp
c002001d:	83 ec 10             	sub    esp,0x10
c0020020:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
c0020023:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0020026:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c0020029:	f0 87 01             	lock xchg DWORD PTR [ecx],eax
c002002c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c002002f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020032:	c9                   	leave
c0020033:	c3                   	ret

c0020034 <spinlock_init>:
c0020034:	55                   	push   ebp
c0020035:	89 e5                	mov    ebp,esp
c0020037:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002003a:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
c0020040:	90                   	nop
c0020041:	5d                   	pop    ebp
c0020042:	c3                   	ret

c0020043 <spinlock_lock>:
c0020043:	55                   	push   ebp
c0020044:	89 e5                	mov    ebp,esp
c0020046:	eb 02                	jmp    c002004a <spinlock_lock+0x7>
c0020048:	f3 90                	pause
c002004a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002004d:	6a 01                	push   0x1
c002004f:	50                   	push   eax
c0020050:	e8 c5 ff ff ff       	call   c002001a <atomic_xchg>
c0020055:	83 c4 08             	add    esp,0x8
c0020058:	85 c0                	test   eax,eax
c002005a:	75 ec                	jne    c0020048 <spinlock_lock+0x5>
c002005c:	90                   	nop
c002005d:	90                   	nop
c002005e:	c9                   	leave
c002005f:	c3                   	ret

c0020060 <spinlock_unlock>:
c0020060:	55                   	push   ebp
c0020061:	89 e5                	mov    ebp,esp
c0020063:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020066:	6a 00                	push   0x0
c0020068:	50                   	push   eax
c0020069:	e8 ac ff ff ff       	call   c002001a <atomic_xchg>
c002006e:	83 c4 08             	add    esp,0x8
c0020071:	90                   	nop
c0020072:	c9                   	leave
c0020073:	c3                   	ret

c0020074 <terminal_initialize>:
c0020074:	55                   	push   ebp
c0020075:	89 e5                	mov    ebp,esp
c0020077:	83 ec 18             	sub    esp,0x18
c002007a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c0020081:	eb 51                	jmp    c00200d4 <terminal_initialize+0x60>
c0020083:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c002008a:	eb 3e                	jmp    c00200ca <terminal_initialize+0x56>
c002008c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c002008f:	89 d0                	mov    eax,edx
c0020091:	c1 e0 02             	shl    eax,0x2
c0020094:	01 d0                	add    eax,edx
c0020096:	c1 e0 04             	shl    eax,0x4
c0020099:	89 c2                	mov    edx,eax
c002009b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002009e:	01 d0                	add    eax,edx
c00200a0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00200a3:	0f b6 05 94 3a 02 c0 	movzx  eax,BYTE PTR ds:0xc0023a94
c00200aa:	0f b6 c0             	movzx  eax,al
c00200ad:	c1 e0 08             	shl    eax,0x8
c00200b0:	83 c8 20             	or     eax,0x20
c00200b3:	89 c1                	mov    ecx,eax
c00200b5:	a1 90 3a 02 c0       	mov    eax,ds:0xc0023a90
c00200ba:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c00200bd:	01 d2                	add    edx,edx
c00200bf:	01 d0                	add    eax,edx
c00200c1:	89 ca                	mov    edx,ecx
c00200c3:	66 89 10             	mov    WORD PTR [eax],dx
c00200c6:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c00200ca:	83 7d f0 4f          	cmp    DWORD PTR [ebp-0x10],0x4f
c00200ce:	76 bc                	jbe    c002008c <terminal_initialize+0x18>
c00200d0:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c00200d4:	83 7d f4 18          	cmp    DWORD PTR [ebp-0xc],0x18
c00200d8:	76 a9                	jbe    c0020083 <terminal_initialize+0xf>
c00200da:	c7 05 c0 3a 02 c0 00 	mov    DWORD PTR ds:0xc0023ac0,0x0
c00200e1:	00 00 00 
c00200e4:	c7 05 c4 3a 02 c0 00 	mov    DWORD PTR ds:0xc0023ac4,0x0
c00200eb:	00 00 00 
c00200ee:	e8 33 07 00 00       	call   c0020826 <serial_init>
c00200f3:	c6 05 c8 3a 02 c0 01 	mov    BYTE PTR ds:0xc0023ac8,0x1
c00200fa:	83 ec 0c             	sub    esp,0xc
c00200fd:	68 a8 35 02 c0       	push   0xc00235a8
c0020102:	e8 e8 07 00 00       	call   c00208ef <serial_puts>
c0020107:	83 c4 10             	add    esp,0x10
c002010a:	90                   	nop
c002010b:	c9                   	leave
c002010c:	c3                   	ret

c002010d <putchar>:
c002010d:	55                   	push   ebp
c002010e:	89 e5                	mov    ebp,esp
c0020110:	53                   	push   ebx
c0020111:	83 ec 24             	sub    esp,0x24
c0020114:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020117:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
c002011a:	80 7d e4 0a          	cmp    BYTE PTR [ebp-0x1c],0xa
c002011e:	75 19                	jne    c0020139 <putchar+0x2c>
c0020120:	c7 05 c4 3a 02 c0 00 	mov    DWORD PTR ds:0xc0023ac4,0x0
c0020127:	00 00 00 
c002012a:	a1 c0 3a 02 c0       	mov    eax,ds:0xc0023ac0
c002012f:	83 c0 01             	add    eax,0x1
c0020132:	a3 c0 3a 02 c0       	mov    ds:0xc0023ac0,eax
c0020137:	eb 52                	jmp    c002018b <putchar+0x7e>
c0020139:	8b 15 c0 3a 02 c0    	mov    edx,DWORD PTR ds:0xc0023ac0
c002013f:	89 d0                	mov    eax,edx
c0020141:	c1 e0 02             	shl    eax,0x2
c0020144:	01 d0                	add    eax,edx
c0020146:	c1 e0 04             	shl    eax,0x4
c0020149:	89 c2                	mov    edx,eax
c002014b:	a1 c4 3a 02 c0       	mov    eax,ds:0xc0023ac4
c0020150:	01 d0                	add    eax,edx
c0020152:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0020155:	0f b6 05 94 3a 02 c0 	movzx  eax,BYTE PTR ds:0xc0023a94
c002015c:	0f b6 c0             	movzx  eax,al
c002015f:	c1 e0 08             	shl    eax,0x8
c0020162:	89 c2                	mov    edx,eax
c0020164:	66 0f be 45 e4       	movsx  ax,BYTE PTR [ebp-0x1c]
c0020169:	89 d1                	mov    ecx,edx
c002016b:	09 c1                	or     ecx,eax
c002016d:	a1 90 3a 02 c0       	mov    eax,ds:0xc0023a90
c0020172:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0020175:	01 d2                	add    edx,edx
c0020177:	01 d0                	add    eax,edx
c0020179:	89 ca                	mov    edx,ecx
c002017b:	66 89 10             	mov    WORD PTR [eax],dx
c002017e:	a1 c4 3a 02 c0       	mov    eax,ds:0xc0023ac4
c0020183:	83 c0 01             	add    eax,0x1
c0020186:	a3 c4 3a 02 c0       	mov    ds:0xc0023ac4,eax
c002018b:	a1 c4 3a 02 c0       	mov    eax,ds:0xc0023ac4
c0020190:	83 f8 4f             	cmp    eax,0x4f
c0020193:	76 17                	jbe    c00201ac <putchar+0x9f>
c0020195:	c7 05 c4 3a 02 c0 00 	mov    DWORD PTR ds:0xc0023ac4,0x0
c002019c:	00 00 00 
c002019f:	a1 c0 3a 02 c0       	mov    eax,ds:0xc0023ac0
c00201a4:	83 c0 01             	add    eax,0x1
c00201a7:	a3 c0 3a 02 c0       	mov    ds:0xc0023ac0,eax
c00201ac:	a1 c0 3a 02 c0       	mov    eax,ds:0xc0023ac0
c00201b1:	83 f8 18             	cmp    eax,0x18
c00201b4:	0f 86 b2 00 00 00    	jbe    c002026c <putchar+0x15f>
c00201ba:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c00201c1:	eb 5d                	jmp    c0020220 <putchar+0x113>
c00201c3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c00201ca:	eb 4a                	jmp    c0020216 <putchar+0x109>
c00201cc:	8b 0d 90 3a 02 c0    	mov    ecx,DWORD PTR ds:0xc0023a90
c00201d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00201d5:	8d 50 01             	lea    edx,[eax+0x1]
c00201d8:	89 d0                	mov    eax,edx
c00201da:	c1 e0 02             	shl    eax,0x2
c00201dd:	01 d0                	add    eax,edx
c00201df:	c1 e0 04             	shl    eax,0x4
c00201e2:	89 c2                	mov    edx,eax
c00201e4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00201e7:	01 d0                	add    eax,edx
c00201e9:	01 c0                	add    eax,eax
c00201eb:	01 c1                	add    ecx,eax
c00201ed:	8b 1d 90 3a 02 c0    	mov    ebx,DWORD PTR ds:0xc0023a90
c00201f3:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c00201f6:	89 d0                	mov    eax,edx
c00201f8:	c1 e0 02             	shl    eax,0x2
c00201fb:	01 d0                	add    eax,edx
c00201fd:	c1 e0 04             	shl    eax,0x4
c0020200:	89 c2                	mov    edx,eax
c0020202:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0020205:	01 d0                	add    eax,edx
c0020207:	01 c0                	add    eax,eax
c0020209:	8d 14 03             	lea    edx,[ebx+eax*1]
c002020c:	0f b7 01             	movzx  eax,WORD PTR [ecx]
c002020f:	66 89 02             	mov    WORD PTR [edx],ax
c0020212:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0020216:	83 7d f0 4f          	cmp    DWORD PTR [ebp-0x10],0x4f
c002021a:	76 b0                	jbe    c00201cc <putchar+0xbf>
c002021c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0020220:	83 7d f4 17          	cmp    DWORD PTR [ebp-0xc],0x17
c0020224:	76 9d                	jbe    c00201c3 <putchar+0xb6>
c0020226:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
c002022d:	eb 2d                	jmp    c002025c <putchar+0x14f>
c002022f:	0f b6 05 94 3a 02 c0 	movzx  eax,BYTE PTR ds:0xc0023a94
c0020236:	0f b6 c0             	movzx  eax,al
c0020239:	c1 e0 08             	shl    eax,0x8
c002023c:	83 c8 20             	or     eax,0x20
c002023f:	89 c1                	mov    ecx,eax
c0020241:	a1 90 3a 02 c0       	mov    eax,ds:0xc0023a90
c0020246:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0020249:	81 c2 80 07 00 00    	add    edx,0x780
c002024f:	01 d2                	add    edx,edx
c0020251:	01 d0                	add    eax,edx
c0020253:	89 ca                	mov    edx,ecx
c0020255:	66 89 10             	mov    WORD PTR [eax],dx
c0020258:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
c002025c:	83 7d ec 4f          	cmp    DWORD PTR [ebp-0x14],0x4f
c0020260:	76 cd                	jbe    c002022f <putchar+0x122>
c0020262:	c7 05 c0 3a 02 c0 18 	mov    DWORD PTR ds:0xc0023ac0,0x18
c0020269:	00 00 00 
c002026c:	0f b6 05 c8 3a 02 c0 	movzx  eax,BYTE PTR ds:0xc0023ac8
c0020273:	84 c0                	test   al,al
c0020275:	74 10                	je     c0020287 <putchar+0x17a>
c0020277:	0f be 45 e4          	movsx  eax,BYTE PTR [ebp-0x1c]
c002027b:	83 ec 0c             	sub    esp,0xc
c002027e:	50                   	push   eax
c002027f:	e8 2f 06 00 00       	call   c00208b3 <serial_putchar>
c0020284:	83 c4 10             	add    esp,0x10
c0020287:	90                   	nop
c0020288:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
c002028b:	c9                   	leave
c002028c:	c3                   	ret

c002028d <puts>:
c002028d:	55                   	push   ebp
c002028e:	89 e5                	mov    ebp,esp
c0020290:	83 ec 08             	sub    esp,0x8
c0020293:	eb 1b                	jmp    c00202b0 <puts+0x23>
c0020295:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020298:	8d 50 01             	lea    edx,[eax+0x1]
c002029b:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
c002029e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00202a1:	0f be c0             	movsx  eax,al
c00202a4:	83 ec 0c             	sub    esp,0xc
c00202a7:	50                   	push   eax
c00202a8:	e8 60 fe ff ff       	call   c002010d <putchar>
c00202ad:	83 c4 10             	add    esp,0x10
c00202b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00202b3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00202b6:	84 c0                	test   al,al
c00202b8:	75 db                	jne    c0020295 <puts+0x8>
c00202ba:	90                   	nop
c00202bb:	90                   	nop
c00202bc:	c9                   	leave
c00202bd:	c3                   	ret

c00202be <itoa_hex>:
c00202be:	55                   	push   ebp
c00202bf:	89 e5                	mov    ebp,esp
c00202c1:	83 ec 10             	sub    esp,0x10
c00202c4:	c7 45 f4 c4 35 02 c0 	mov    DWORD PTR [ebp-0xc],0xc00235c4
c00202cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00202ce:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c00202d1:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00202d4:	8d 50 01             	lea    edx,[eax+0x1]
c00202d7:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c00202da:	c6 00 30             	mov    BYTE PTR [eax],0x30
c00202dd:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00202e0:	8d 50 01             	lea    edx,[eax+0x1]
c00202e3:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c00202e6:	c6 00 78             	mov    BYTE PTR [eax],0x78
c00202e9:	c7 45 f8 1c 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1c
c00202f0:	eb 29                	jmp    c002031b <itoa_hex+0x5d>
c00202f2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
c00202f5:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c00202f8:	89 c1                	mov    ecx,eax
c00202fa:	d3 ea                	shr    edx,cl
c00202fc:	89 d0                	mov    eax,edx
c00202fe:	83 e0 0f             	and    eax,0xf
c0020301:	89 c2                	mov    edx,eax
c0020303:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020306:	8d 0c 02             	lea    ecx,[edx+eax*1]
c0020309:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002030c:	8d 50 01             	lea    edx,[eax+0x1]
c002030f:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c0020312:	0f b6 11             	movzx  edx,BYTE PTR [ecx]
c0020315:	88 10                	mov    BYTE PTR [eax],dl
c0020317:	83 6d f8 04          	sub    DWORD PTR [ebp-0x8],0x4
c002031b:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
c002031f:	79 d1                	jns    c00202f2 <itoa_hex+0x34>
c0020321:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020324:	c6 00 00             	mov    BYTE PTR [eax],0x0
c0020327:	90                   	nop
c0020328:	c9                   	leave
c0020329:	c3                   	ret

c002032a <itoa_dec>:
c002032a:	55                   	push   ebp
c002032b:	89 e5                	mov    ebp,esp
c002032d:	83 ec 30             	sub    esp,0x30
c0020330:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0020333:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c0020336:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c002033a:	75 17                	jne    c0020353 <itoa_dec+0x29>
c002033c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002033f:	8d 50 01             	lea    edx,[eax+0x1]
c0020342:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c0020345:	c6 00 30             	mov    BYTE PTR [eax],0x30
c0020348:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002034b:	c6 00 00             	mov    BYTE PTR [eax],0x0
c002034e:	e9 98 00 00 00       	jmp    c00203eb <itoa_dec+0xc1>
c0020353:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c0020357:	79 0f                	jns    c0020368 <itoa_dec+0x3e>
c0020359:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002035c:	8d 50 01             	lea    edx,[eax+0x1]
c002035f:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c0020362:	c6 00 2d             	mov    BYTE PTR [eax],0x2d
c0020365:	f7 5d 08             	neg    DWORD PTR [ebp+0x8]
c0020368:	8d 45 d8             	lea    eax,[ebp-0x28]
c002036b:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c002036e:	eb 50                	jmp    c00203c0 <itoa_dec+0x96>
c0020370:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
c0020373:	ba 67 66 66 66       	mov    edx,0x66666667
c0020378:	89 c8                	mov    eax,ecx
c002037a:	f7 ea                	imul   edx
c002037c:	c1 fa 02             	sar    edx,0x2
c002037f:	89 c8                	mov    eax,ecx
c0020381:	c1 f8 1f             	sar    eax,0x1f
c0020384:	29 c2                	sub    edx,eax
c0020386:	89 d0                	mov    eax,edx
c0020388:	c1 e0 02             	shl    eax,0x2
c002038b:	01 d0                	add    eax,edx
c002038d:	01 c0                	add    eax,eax
c002038f:	29 c1                	sub    ecx,eax
c0020391:	89 ca                	mov    edx,ecx
c0020393:	89 d0                	mov    eax,edx
c0020395:	8d 48 30             	lea    ecx,[eax+0x30]
c0020398:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
c002039b:	8d 50 01             	lea    edx,[eax+0x1]
c002039e:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
c00203a1:	89 ca                	mov    edx,ecx
c00203a3:	88 10                	mov    BYTE PTR [eax],dl
c00203a5:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
c00203a8:	ba 67 66 66 66       	mov    edx,0x66666667
c00203ad:	89 c8                	mov    eax,ecx
c00203af:	f7 ea                	imul   edx
c00203b1:	89 d0                	mov    eax,edx
c00203b3:	c1 f8 02             	sar    eax,0x2
c00203b6:	c1 f9 1f             	sar    ecx,0x1f
c00203b9:	89 ca                	mov    edx,ecx
c00203bb:	29 d0                	sub    eax,edx
c00203bd:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
c00203c0:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c00203c4:	7f aa                	jg     c0020370 <itoa_dec+0x46>
c00203c6:	eb 15                	jmp    c00203dd <itoa_dec+0xb3>
c00203c8:	83 6d f8 01          	sub    DWORD PTR [ebp-0x8],0x1
c00203cc:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00203cf:	8d 50 01             	lea    edx,[eax+0x1]
c00203d2:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
c00203d5:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c00203d8:	0f b6 12             	movzx  edx,BYTE PTR [edx]
c00203db:	88 10                	mov    BYTE PTR [eax],dl
c00203dd:	8d 45 d8             	lea    eax,[ebp-0x28]
c00203e0:	3b 45 f8             	cmp    eax,DWORD PTR [ebp-0x8]
c00203e3:	72 e3                	jb     c00203c8 <itoa_dec+0x9e>
c00203e5:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00203e8:	c6 00 00             	mov    BYTE PTR [eax],0x0
c00203eb:	c9                   	leave
c00203ec:	c3                   	ret

c00203ed <itoa_hex64>:
c00203ed:	55                   	push   ebp
c00203ee:	89 e5                	mov    ebp,esp
c00203f0:	83 ec 28             	sub    esp,0x28
c00203f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00203f6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c00203f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00203fc:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c00203ff:	c7 45 f4 c4 35 02 c0 	mov    DWORD PTR [ebp-0xc],0xc00235c4
c0020406:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020409:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
c002040c:	89 d0                	mov    eax,edx
c002040e:	31 d2                	xor    edx,edx
c0020410:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0020413:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020416:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0020419:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002041c:	c6 00 30             	mov    BYTE PTR [eax],0x30
c002041f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0020422:	83 c0 01             	add    eax,0x1
c0020425:	c6 00 78             	mov    BYTE PTR [eax],0x78
c0020428:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c002042f:	eb 34                	jmp    c0020465 <itoa_hex64+0x78>
c0020431:	b8 07 00 00 00       	mov    eax,0x7
c0020436:	2b 45 fc             	sub    eax,DWORD PTR [ebp-0x4]
c0020439:	c1 e0 02             	shl    eax,0x2
c002043c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c002043f:	89 c1                	mov    ecx,eax
c0020441:	d3 ea                	shr    edx,cl
c0020443:	89 d0                	mov    eax,edx
c0020445:	83 e0 0f             	and    eax,0xf
c0020448:	89 c2                	mov    edx,eax
c002044a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002044d:	01 d0                	add    eax,edx
c002044f:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
c0020452:	83 c2 02             	add    edx,0x2
c0020455:	89 d1                	mov    ecx,edx
c0020457:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
c002045a:	01 ca                	add    edx,ecx
c002045c:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c002045f:	88 02                	mov    BYTE PTR [edx],al
c0020461:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c0020465:	83 7d fc 07          	cmp    DWORD PTR [ebp-0x4],0x7
c0020469:	7e c6                	jle    c0020431 <itoa_hex64+0x44>
c002046b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
c0020472:	eb 34                	jmp    c00204a8 <itoa_hex64+0xbb>
c0020474:	b8 07 00 00 00       	mov    eax,0x7
c0020479:	2b 45 f8             	sub    eax,DWORD PTR [ebp-0x8]
c002047c:	c1 e0 02             	shl    eax,0x2
c002047f:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0020482:	89 c1                	mov    ecx,eax
c0020484:	d3 ea                	shr    edx,cl
c0020486:	89 d0                	mov    eax,edx
c0020488:	83 e0 0f             	and    eax,0xf
c002048b:	89 c2                	mov    edx,eax
c002048d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020490:	01 d0                	add    eax,edx
c0020492:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c0020495:	83 c2 0a             	add    edx,0xa
c0020498:	89 d1                	mov    ecx,edx
c002049a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
c002049d:	01 ca                	add    edx,ecx
c002049f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00204a2:	88 02                	mov    BYTE PTR [edx],al
c00204a4:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
c00204a8:	83 7d f8 07          	cmp    DWORD PTR [ebp-0x8],0x7
c00204ac:	7e c6                	jle    c0020474 <itoa_hex64+0x87>
c00204ae:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c00204b1:	83 c0 12             	add    eax,0x12
c00204b4:	c6 00 00             	mov    BYTE PTR [eax],0x0
c00204b7:	90                   	nop
c00204b8:	c9                   	leave
c00204b9:	c3                   	ret

c00204ba <itoa_dec64>:
c00204ba:	55                   	push   ebp
c00204bb:	89 e5                	mov    ebp,esp
c00204bd:	83 ec 08             	sub    esp,0x8
c00204c0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00204c3:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c00204c6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00204c9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c00204cc:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
c00204d0:	77 11                	ja     c00204e3 <itoa_dec64+0x29>
c00204d2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
c00204d5:	ff 75 10             	push   DWORD PTR [ebp+0x10]
c00204d8:	50                   	push   eax
c00204d9:	e8 4c fe ff ff       	call   c002032a <itoa_dec>
c00204de:	83 c4 08             	add    esp,0x8
c00204e1:	eb 14                	jmp    c00204f7 <itoa_dec64+0x3d>
c00204e3:	83 ec 04             	sub    esp,0x4
c00204e6:	ff 75 10             	push   DWORD PTR [ebp+0x10]
c00204e9:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
c00204ec:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
c00204ef:	e8 f9 fe ff ff       	call   c00203ed <itoa_hex64>
c00204f4:	83 c4 10             	add    esp,0x10
c00204f7:	90                   	nop
c00204f8:	c9                   	leave
c00204f9:	c3                   	ret

c00204fa <kprintf>:
c00204fa:	55                   	push   ebp
c00204fb:	89 e5                	mov    ebp,esp
c00204fd:	83 ec 58             	sub    esp,0x58
c0020500:	8d 45 0c             	lea    eax,[ebp+0xc]
c0020503:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
c0020506:	e9 cd 02 00 00       	jmp    c00207d8 <kprintf+0x2de>
c002050b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002050e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020511:	3c 25                	cmp    al,0x25
c0020513:	0f 85 a6 02 00 00    	jne    c00207bf <kprintf+0x2c5>
c0020519:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
c002051d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020520:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020523:	3c 6c                	cmp    al,0x6c
c0020525:	0f 85 44 01 00 00    	jne    c002066f <kprintf+0x175>
c002052b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002052e:	83 c0 01             	add    eax,0x1
c0020531:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020534:	3c 6c                	cmp    al,0x6c
c0020536:	0f 85 33 01 00 00    	jne    c002066f <kprintf+0x175>
c002053c:	83 45 08 02          	add    DWORD PTR [ebp+0x8],0x2
c0020540:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020543:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020546:	0f be c0             	movsx  eax,al
c0020549:	83 f8 78             	cmp    eax,0x78
c002054c:	74 1c                	je     c002056a <kprintf+0x70>
c002054e:	83 f8 78             	cmp    eax,0x78
c0020551:	0f 8f ed 00 00 00    	jg     c0020644 <kprintf+0x14a>
c0020557:	83 f8 64             	cmp    eax,0x64
c002055a:	0f 84 84 00 00 00    	je     c00205e4 <kprintf+0xea>
c0020560:	83 f8 75             	cmp    eax,0x75
c0020563:	74 42                	je     c00205a7 <kprintf+0xad>
c0020565:	e9 da 00 00 00       	jmp    c0020644 <kprintf+0x14a>
c002056a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c002056d:	8d 50 08             	lea    edx,[eax+0x8]
c0020570:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c0020573:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
c0020576:	8b 00                	mov    eax,DWORD PTR [eax]
c0020578:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c002057b:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c002057e:	83 ec 04             	sub    esp,0x4
c0020581:	8d 45 a8             	lea    eax,[ebp-0x58]
c0020584:	50                   	push   eax
c0020585:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0020588:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c002058b:	e8 5d fe ff ff       	call   c00203ed <itoa_hex64>
c0020590:	83 c4 10             	add    esp,0x10
c0020593:	83 ec 0c             	sub    esp,0xc
c0020596:	8d 45 a8             	lea    eax,[ebp-0x58]
c0020599:	50                   	push   eax
c002059a:	e8 ee fc ff ff       	call   c002028d <puts>
c002059f:	83 c4 10             	add    esp,0x10
c00205a2:	e9 c3 00 00 00       	jmp    c002066a <kprintf+0x170>
c00205a7:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c00205aa:	8d 50 08             	lea    edx,[eax+0x8]
c00205ad:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c00205b0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
c00205b3:	8b 00                	mov    eax,DWORD PTR [eax]
c00205b5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00205b8:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
c00205bb:	83 ec 04             	sub    esp,0x4
c00205be:	8d 45 a8             	lea    eax,[ebp-0x58]
c00205c1:	50                   	push   eax
c00205c2:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c00205c5:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
c00205c8:	e8 ed fe ff ff       	call   c00204ba <itoa_dec64>
c00205cd:	83 c4 10             	add    esp,0x10
c00205d0:	83 ec 0c             	sub    esp,0xc
c00205d3:	8d 45 a8             	lea    eax,[ebp-0x58]
c00205d6:	50                   	push   eax
c00205d7:	e8 b1 fc ff ff       	call   c002028d <puts>
c00205dc:	83 c4 10             	add    esp,0x10
c00205df:	e9 86 00 00 00       	jmp    c002066a <kprintf+0x170>
c00205e4:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c00205e7:	8d 50 08             	lea    edx,[eax+0x8]
c00205ea:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c00205ed:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
c00205f0:	8b 00                	mov    eax,DWORD PTR [eax]
c00205f2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c00205f5:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
c00205f8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c00205fb:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
c00205fe:	83 ec 04             	sub    esp,0x4
c0020601:	8d 4d a8             	lea    ecx,[ebp-0x58]
c0020604:	51                   	push   ecx
c0020605:	52                   	push   edx
c0020606:	50                   	push   eax
c0020607:	e8 ae fe ff ff       	call   c00204ba <itoa_dec64>
c002060c:	83 c4 10             	add    esp,0x10
c002060f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
c0020613:	79 1e                	jns    c0020633 <kprintf+0x139>
c0020615:	83 ec 0c             	sub    esp,0xc
c0020618:	6a 2d                	push   0x2d
c002061a:	e8 ee fa ff ff       	call   c002010d <putchar>
c002061f:	83 c4 10             	add    esp,0x10
c0020622:	83 ec 0c             	sub    esp,0xc
c0020625:	8d 45 a8             	lea    eax,[ebp-0x58]
c0020628:	50                   	push   eax
c0020629:	e8 5f fc ff ff       	call   c002028d <puts>
c002062e:	83 c4 10             	add    esp,0x10
c0020631:	eb 37                	jmp    c002066a <kprintf+0x170>
c0020633:	83 ec 0c             	sub    esp,0xc
c0020636:	8d 45 a8             	lea    eax,[ebp-0x58]
c0020639:	50                   	push   eax
c002063a:	e8 4e fc ff ff       	call   c002028d <puts>
c002063f:	83 c4 10             	add    esp,0x10
c0020642:	eb 26                	jmp    c002066a <kprintf+0x170>
c0020644:	83 ec 0c             	sub    esp,0xc
c0020647:	68 d5 35 02 c0       	push   0xc00235d5
c002064c:	e8 3c fc ff ff       	call   c002028d <puts>
c0020651:	83 c4 10             	add    esp,0x10
c0020654:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020657:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c002065a:	0f be c0             	movsx  eax,al
c002065d:	83 ec 0c             	sub    esp,0xc
c0020660:	50                   	push   eax
c0020661:	e8 a7 fa ff ff       	call   c002010d <putchar>
c0020666:	83 c4 10             	add    esp,0x10
c0020669:	90                   	nop
c002066a:	e9 65 01 00 00       	jmp    c00207d4 <kprintf+0x2da>
c002066f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020672:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020675:	0f be c0             	movsx  eax,al
c0020678:	83 f8 25             	cmp    eax,0x25
c002067b:	0f 84 0b 01 00 00    	je     c002078c <kprintf+0x292>
c0020681:	83 f8 25             	cmp    eax,0x25
c0020684:	0f 8c 11 01 00 00    	jl     c002079b <kprintf+0x2a1>
c002068a:	83 f8 78             	cmp    eax,0x78
c002068d:	0f 8f 08 01 00 00    	jg     c002079b <kprintf+0x2a1>
c0020693:	83 f8 63             	cmp    eax,0x63
c0020696:	0f 8c ff 00 00 00    	jl     c002079b <kprintf+0x2a1>
c002069c:	83 e8 63             	sub    eax,0x63
c002069f:	83 f8 15             	cmp    eax,0x15
c00206a2:	0f 87 f3 00 00 00    	ja     c002079b <kprintf+0x2a1>
c00206a8:	8b 04 85 dc 35 02 c0 	mov    eax,DWORD PTR [eax*4-0x3ffdca24]
c00206af:	ff e0                	jmp    eax
c00206b1:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c00206b4:	8d 50 04             	lea    edx,[eax+0x4]
c00206b7:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c00206ba:	8b 00                	mov    eax,DWORD PTR [eax]
c00206bc:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
c00206bf:	83 ec 0c             	sub    esp,0xc
c00206c2:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
c00206c5:	e8 c3 fb ff ff       	call   c002028d <puts>
c00206ca:	83 c4 10             	add    esp,0x10
c00206cd:	e9 02 01 00 00       	jmp    c00207d4 <kprintf+0x2da>
c00206d2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c00206d5:	8d 50 04             	lea    edx,[eax+0x4]
c00206d8:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c00206db:	8b 00                	mov    eax,DWORD PTR [eax]
c00206dd:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
c00206e0:	83 ec 08             	sub    esp,0x8
c00206e3:	8d 45 a8             	lea    eax,[ebp-0x58]
c00206e6:	50                   	push   eax
c00206e7:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
c00206ea:	e8 3b fc ff ff       	call   c002032a <itoa_dec>
c00206ef:	83 c4 10             	add    esp,0x10
c00206f2:	83 ec 0c             	sub    esp,0xc
c00206f5:	8d 45 a8             	lea    eax,[ebp-0x58]
c00206f8:	50                   	push   eax
c00206f9:	e8 8f fb ff ff       	call   c002028d <puts>
c00206fe:	83 c4 10             	add    esp,0x10
c0020701:	e9 ce 00 00 00       	jmp    c00207d4 <kprintf+0x2da>
c0020706:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c0020709:	8d 50 04             	lea    edx,[eax+0x4]
c002070c:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c002070f:	8b 00                	mov    eax,DWORD PTR [eax]
c0020711:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0020714:	83 ec 08             	sub    esp,0x8
c0020717:	8d 45 a8             	lea    eax,[ebp-0x58]
c002071a:	50                   	push   eax
c002071b:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c002071e:	e8 9b fb ff ff       	call   c00202be <itoa_hex>
c0020723:	83 c4 10             	add    esp,0x10
c0020726:	83 ec 0c             	sub    esp,0xc
c0020729:	8d 45 a8             	lea    eax,[ebp-0x58]
c002072c:	50                   	push   eax
c002072d:	e8 5b fb ff ff       	call   c002028d <puts>
c0020732:	83 c4 10             	add    esp,0x10
c0020735:	e9 9a 00 00 00       	jmp    c00207d4 <kprintf+0x2da>
c002073a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c002073d:	8d 50 04             	lea    edx,[eax+0x4]
c0020740:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c0020743:	8b 00                	mov    eax,DWORD PTR [eax]
c0020745:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c0020748:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c002074b:	83 ec 08             	sub    esp,0x8
c002074e:	8d 55 a8             	lea    edx,[ebp-0x58]
c0020751:	52                   	push   edx
c0020752:	50                   	push   eax
c0020753:	e8 d2 fb ff ff       	call   c002032a <itoa_dec>
c0020758:	83 c4 10             	add    esp,0x10
c002075b:	83 ec 0c             	sub    esp,0xc
c002075e:	8d 45 a8             	lea    eax,[ebp-0x58]
c0020761:	50                   	push   eax
c0020762:	e8 26 fb ff ff       	call   c002028d <puts>
c0020767:	83 c4 10             	add    esp,0x10
c002076a:	eb 68                	jmp    c00207d4 <kprintf+0x2da>
c002076c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c002076f:	8d 50 04             	lea    edx,[eax+0x4]
c0020772:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c0020775:	8b 00                	mov    eax,DWORD PTR [eax]
c0020777:	88 45 cf             	mov    BYTE PTR [ebp-0x31],al
c002077a:	0f be 45 cf          	movsx  eax,BYTE PTR [ebp-0x31]
c002077e:	83 ec 0c             	sub    esp,0xc
c0020781:	50                   	push   eax
c0020782:	e8 86 f9 ff ff       	call   c002010d <putchar>
c0020787:	83 c4 10             	add    esp,0x10
c002078a:	eb 48                	jmp    c00207d4 <kprintf+0x2da>
c002078c:	83 ec 0c             	sub    esp,0xc
c002078f:	6a 25                	push   0x25
c0020791:	e8 77 f9 ff ff       	call   c002010d <putchar>
c0020796:	83 c4 10             	add    esp,0x10
c0020799:	eb 39                	jmp    c00207d4 <kprintf+0x2da>
c002079b:	83 ec 0c             	sub    esp,0xc
c002079e:	6a 25                	push   0x25
c00207a0:	e8 68 f9 ff ff       	call   c002010d <putchar>
c00207a5:	83 c4 10             	add    esp,0x10
c00207a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00207ab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00207ae:	0f be c0             	movsx  eax,al
c00207b1:	83 ec 0c             	sub    esp,0xc
c00207b4:	50                   	push   eax
c00207b5:	e8 53 f9 ff ff       	call   c002010d <putchar>
c00207ba:	83 c4 10             	add    esp,0x10
c00207bd:	eb 15                	jmp    c00207d4 <kprintf+0x2da>
c00207bf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00207c2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00207c5:	0f be c0             	movsx  eax,al
c00207c8:	83 ec 0c             	sub    esp,0xc
c00207cb:	50                   	push   eax
c00207cc:	e8 3c f9 ff ff       	call   c002010d <putchar>
c00207d1:	83 c4 10             	add    esp,0x10
c00207d4:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
c00207d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00207db:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00207de:	84 c0                	test   al,al
c00207e0:	0f 85 25 fd ff ff    	jne    c002050b <kprintf+0x11>
c00207e6:	90                   	nop
c00207e7:	90                   	nop
c00207e8:	c9                   	leave
c00207e9:	c3                   	ret

c00207ea <kpanic>:
c00207ea:	55                   	push   ebp
c00207eb:	89 e5                	mov    ebp,esp
c00207ed:	83 ec 08             	sub    esp,0x8
c00207f0:	83 ec 0c             	sub    esp,0xc
c00207f3:	68 34 36 02 c0       	push   0xc0023634
c00207f8:	e8 fd fc ff ff       	call   c00204fa <kprintf>
c00207fd:	83 c4 10             	add    esp,0x10
c0020800:	83 ec 08             	sub    esp,0x8
c0020803:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0020806:	68 4b 36 02 c0       	push   0xc002364b
c002080b:	e8 ea fc ff ff       	call   c00204fa <kprintf>
c0020810:	83 c4 10             	add    esp,0x10
c0020813:	83 ec 0c             	sub    esp,0xc
c0020816:	68 57 36 02 c0       	push   0xc0023657
c002081b:	e8 da fc ff ff       	call   c00204fa <kprintf>
c0020820:	83 c4 10             	add    esp,0x10
c0020823:	f4                   	hlt
c0020824:	eb fd                	jmp    c0020823 <kpanic+0x39>

c0020826 <serial_init>:
c0020826:	55                   	push   ebp
c0020827:	89 e5                	mov    ebp,esp
c0020829:	83 ec 08             	sub    esp,0x8
c002082c:	83 ec 08             	sub    esp,0x8
c002082f:	6a 00                	push   0x0
c0020831:	68 f9 03 00 00       	push   0x3f9
c0020836:	e8 15 2a 00 00       	call   c0023250 <outb>
c002083b:	83 c4 10             	add    esp,0x10
c002083e:	83 ec 08             	sub    esp,0x8
c0020841:	68 80 00 00 00       	push   0x80
c0020846:	68 fb 03 00 00       	push   0x3fb
c002084b:	e8 00 2a 00 00       	call   c0023250 <outb>
c0020850:	83 c4 10             	add    esp,0x10
c0020853:	83 ec 08             	sub    esp,0x8
c0020856:	6a 01                	push   0x1
c0020858:	68 f8 03 00 00       	push   0x3f8
c002085d:	e8 ee 29 00 00       	call   c0023250 <outb>
c0020862:	83 c4 10             	add    esp,0x10
c0020865:	83 ec 08             	sub    esp,0x8
c0020868:	6a 00                	push   0x0
c002086a:	68 f9 03 00 00       	push   0x3f9
c002086f:	e8 dc 29 00 00       	call   c0023250 <outb>
c0020874:	83 c4 10             	add    esp,0x10
c0020877:	83 ec 08             	sub    esp,0x8
c002087a:	6a 03                	push   0x3
c002087c:	68 fb 03 00 00       	push   0x3fb
c0020881:	e8 ca 29 00 00       	call   c0023250 <outb>
c0020886:	83 c4 10             	add    esp,0x10
c0020889:	83 ec 08             	sub    esp,0x8
c002088c:	68 c7 00 00 00       	push   0xc7
c0020891:	68 fa 03 00 00       	push   0x3fa
c0020896:	e8 b5 29 00 00       	call   c0023250 <outb>
c002089b:	83 c4 10             	add    esp,0x10
c002089e:	83 ec 08             	sub    esp,0x8
c00208a1:	6a 0b                	push   0xb
c00208a3:	68 fc 03 00 00       	push   0x3fc
c00208a8:	e8 a3 29 00 00       	call   c0023250 <outb>
c00208ad:	83 c4 10             	add    esp,0x10
c00208b0:	90                   	nop
c00208b1:	c9                   	leave
c00208b2:	c3                   	ret

c00208b3 <serial_putchar>:
c00208b3:	55                   	push   ebp
c00208b4:	89 e5                	mov    ebp,esp
c00208b6:	83 ec 18             	sub    esp,0x18
c00208b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00208bc:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
c00208bf:	90                   	nop
c00208c0:	83 ec 0c             	sub    esp,0xc
c00208c3:	68 fd 03 00 00       	push   0x3fd
c00208c8:	e8 ac 29 00 00       	call   c0023279 <inb>
c00208cd:	83 c4 10             	add    esp,0x10
c00208d0:	83 e0 20             	and    eax,0x20
c00208d3:	85 c0                	test   eax,eax
c00208d5:	74 e9                	je     c00208c0 <serial_putchar+0xd>
c00208d7:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
c00208db:	83 ec 08             	sub    esp,0x8
c00208de:	50                   	push   eax
c00208df:	68 f8 03 00 00       	push   0x3f8
c00208e4:	e8 67 29 00 00       	call   c0023250 <outb>
c00208e9:	83 c4 10             	add    esp,0x10
c00208ec:	90                   	nop
c00208ed:	c9                   	leave
c00208ee:	c3                   	ret

c00208ef <serial_puts>:
c00208ef:	55                   	push   ebp
c00208f0:	89 e5                	mov    ebp,esp
c00208f2:	83 ec 08             	sub    esp,0x8
c00208f5:	eb 1b                	jmp    c0020912 <serial_puts+0x23>
c00208f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00208fa:	8d 50 01             	lea    edx,[eax+0x1]
c00208fd:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
c0020900:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020903:	0f be c0             	movsx  eax,al
c0020906:	83 ec 0c             	sub    esp,0xc
c0020909:	50                   	push   eax
c002090a:	e8 a4 ff ff ff       	call   c00208b3 <serial_putchar>
c002090f:	83 c4 10             	add    esp,0x10
c0020912:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020915:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020918:	84 c0                	test   al,al
c002091a:	75 db                	jne    c00208f7 <serial_puts+0x8>
c002091c:	90                   	nop
c002091d:	90                   	nop
c002091e:	c9                   	leave
c002091f:	c3                   	ret

c0020920 <serial_printf>:
c0020920:	55                   	push   ebp
c0020921:	89 e5                	mov    ebp,esp
c0020923:	81 ec 48 01 00 00    	sub    esp,0x148
c0020929:	8d 45 0c             	lea    eax,[ebp+0xc]
c002092c:	89 85 d8 fe ff ff    	mov    DWORD PTR [ebp-0x128],eax
c0020932:	8d 85 dc fe ff ff    	lea    eax,[ebp-0x124]
c0020938:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002093b:	e9 e0 01 00 00       	jmp    c0020b20 <serial_printf+0x200>
c0020940:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020943:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020946:	3c 25                	cmp    al,0x25
c0020948:	0f 85 bd 01 00 00    	jne    c0020b0b <serial_printf+0x1eb>
c002094e:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
c0020952:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020955:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020958:	0f be c0             	movsx  eax,al
c002095b:	83 f8 78             	cmp    eax,0x78
c002095e:	0f 84 1b 01 00 00    	je     c0020a7f <serial_printf+0x15f>
c0020964:	83 f8 78             	cmp    eax,0x78
c0020967:	0f 8f 7f 01 00 00    	jg     c0020aec <serial_printf+0x1cc>
c002096d:	83 f8 64             	cmp    eax,0x64
c0020970:	74 45                	je     c00209b7 <serial_printf+0x97>
c0020972:	83 f8 73             	cmp    eax,0x73
c0020975:	0f 85 71 01 00 00    	jne    c0020aec <serial_printf+0x1cc>
c002097b:	8b 85 d8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x128]
c0020981:	8d 50 04             	lea    edx,[eax+0x4]
c0020984:	89 95 d8 fe ff ff    	mov    DWORD PTR [ebp-0x128],edx
c002098a:	8b 00                	mov    eax,DWORD PTR [eax]
c002098c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c002098f:	eb 17                	jmp    c00209a8 <serial_printf+0x88>
c0020991:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c0020994:	8d 42 01             	lea    eax,[edx+0x1]
c0020997:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c002099a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002099d:	8d 48 01             	lea    ecx,[eax+0x1]
c00209a0:	89 4d f4             	mov    DWORD PTR [ebp-0xc],ecx
c00209a3:	0f b6 12             	movzx  edx,BYTE PTR [edx]
c00209a6:	88 10                	mov    BYTE PTR [eax],dl
c00209a8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00209ab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c00209ae:	84 c0                	test   al,al
c00209b0:	75 df                	jne    c0020991 <serial_printf+0x71>
c00209b2:	e9 65 01 00 00       	jmp    c0020b1c <serial_printf+0x1fc>
c00209b7:	8b 85 d8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x128]
c00209bd:	8d 50 04             	lea    edx,[eax+0x4]
c00209c0:	89 95 d8 fe ff ff    	mov    DWORD PTR [ebp-0x128],edx
c00209c6:	8b 00                	mov    eax,DWORD PTR [eax]
c00209c8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00209cb:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
c00209cf:	75 11                	jne    c00209e2 <serial_printf+0xc2>
c00209d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00209d4:	8d 50 01             	lea    edx,[eax+0x1]
c00209d7:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c00209da:	c6 00 30             	mov    BYTE PTR [eax],0x30
c00209dd:	e9 3a 01 00 00       	jmp    c0020b1c <serial_printf+0x1fc>
c00209e2:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
c00209e6:	79 0f                	jns    c00209f7 <serial_printf+0xd7>
c00209e8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00209eb:	8d 50 01             	lea    edx,[eax+0x1]
c00209ee:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c00209f1:	c6 00 2d             	mov    BYTE PTR [eax],0x2d
c00209f4:	f7 5d ec             	neg    DWORD PTR [ebp-0x14]
c00209f7:	8d 85 b8 fe ff ff    	lea    eax,[ebp-0x148]
c00209fd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0020a00:	eb 50                	jmp    c0020a52 <serial_printf+0x132>
c0020a02:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
c0020a05:	ba 67 66 66 66       	mov    edx,0x66666667
c0020a0a:	89 c8                	mov    eax,ecx
c0020a0c:	f7 ea                	imul   edx
c0020a0e:	c1 fa 02             	sar    edx,0x2
c0020a11:	89 c8                	mov    eax,ecx
c0020a13:	c1 f8 1f             	sar    eax,0x1f
c0020a16:	29 c2                	sub    edx,eax
c0020a18:	89 d0                	mov    eax,edx
c0020a1a:	c1 e0 02             	shl    eax,0x2
c0020a1d:	01 d0                	add    eax,edx
c0020a1f:	01 c0                	add    eax,eax
c0020a21:	29 c1                	sub    ecx,eax
c0020a23:	89 ca                	mov    edx,ecx
c0020a25:	89 d0                	mov    eax,edx
c0020a27:	8d 48 30             	lea    ecx,[eax+0x30]
c0020a2a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020a2d:	8d 50 01             	lea    edx,[eax+0x1]
c0020a30:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
c0020a33:	89 ca                	mov    edx,ecx
c0020a35:	88 10                	mov    BYTE PTR [eax],dl
c0020a37:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
c0020a3a:	ba 67 66 66 66       	mov    edx,0x66666667
c0020a3f:	89 c8                	mov    eax,ecx
c0020a41:	f7 ea                	imul   edx
c0020a43:	89 d0                	mov    eax,edx
c0020a45:	c1 f8 02             	sar    eax,0x2
c0020a48:	c1 f9 1f             	sar    ecx,0x1f
c0020a4b:	89 ca                	mov    edx,ecx
c0020a4d:	29 d0                	sub    eax,edx
c0020a4f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0020a52:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
c0020a56:	7f aa                	jg     c0020a02 <serial_printf+0xe2>
c0020a58:	eb 15                	jmp    c0020a6f <serial_printf+0x14f>
c0020a5a:	83 6d e8 01          	sub    DWORD PTR [ebp-0x18],0x1
c0020a5e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020a61:	8d 50 01             	lea    edx,[eax+0x1]
c0020a64:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020a67:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0020a6a:	0f b6 12             	movzx  edx,BYTE PTR [edx]
c0020a6d:	88 10                	mov    BYTE PTR [eax],dl
c0020a6f:	8d 85 b8 fe ff ff    	lea    eax,[ebp-0x148]
c0020a75:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
c0020a78:	72 e0                	jb     c0020a5a <serial_printf+0x13a>
c0020a7a:	e9 9d 00 00 00       	jmp    c0020b1c <serial_printf+0x1fc>
c0020a7f:	8b 85 d8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x128]
c0020a85:	8d 50 04             	lea    edx,[eax+0x4]
c0020a88:	89 95 d8 fe ff ff    	mov    DWORD PTR [ebp-0x128],edx
c0020a8e:	8b 00                	mov    eax,DWORD PTR [eax]
c0020a90:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0020a93:	c7 45 dc 67 36 02 c0 	mov    DWORD PTR [ebp-0x24],0xc0023667
c0020a9a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020a9d:	8d 50 01             	lea    edx,[eax+0x1]
c0020aa0:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020aa3:	c6 00 30             	mov    BYTE PTR [eax],0x30
c0020aa6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020aa9:	8d 50 01             	lea    edx,[eax+0x1]
c0020aac:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020aaf:	c6 00 78             	mov    BYTE PTR [eax],0x78
c0020ab2:	c7 45 e4 1c 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1c
c0020ab9:	eb 29                	jmp    c0020ae4 <serial_printf+0x1c4>
c0020abb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0020abe:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
c0020ac1:	89 c1                	mov    ecx,eax
c0020ac3:	d3 ea                	shr    edx,cl
c0020ac5:	89 d0                	mov    eax,edx
c0020ac7:	83 e0 0f             	and    eax,0xf
c0020aca:	89 c2                	mov    edx,eax
c0020acc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
c0020acf:	8d 0c 02             	lea    ecx,[edx+eax*1]
c0020ad2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020ad5:	8d 50 01             	lea    edx,[eax+0x1]
c0020ad8:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020adb:	0f b6 11             	movzx  edx,BYTE PTR [ecx]
c0020ade:	88 10                	mov    BYTE PTR [eax],dl
c0020ae0:	83 6d e4 04          	sub    DWORD PTR [ebp-0x1c],0x4
c0020ae4:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
c0020ae8:	79 d1                	jns    c0020abb <serial_printf+0x19b>
c0020aea:	eb 30                	jmp    c0020b1c <serial_printf+0x1fc>
c0020aec:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020aef:	8d 50 01             	lea    edx,[eax+0x1]
c0020af2:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020af5:	c6 00 25             	mov    BYTE PTR [eax],0x25
c0020af8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020afb:	8d 50 01             	lea    edx,[eax+0x1]
c0020afe:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020b01:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c0020b04:	0f b6 12             	movzx  edx,BYTE PTR [edx]
c0020b07:	88 10                	mov    BYTE PTR [eax],dl
c0020b09:	eb 11                	jmp    c0020b1c <serial_printf+0x1fc>
c0020b0b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020b0e:	8d 50 01             	lea    edx,[eax+0x1]
c0020b11:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
c0020b14:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c0020b17:	0f b6 12             	movzx  edx,BYTE PTR [edx]
c0020b1a:	88 10                	mov    BYTE PTR [eax],dl
c0020b1c:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
c0020b20:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020b23:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020b26:	84 c0                	test   al,al
c0020b28:	0f 85 12 fe ff ff    	jne    c0020940 <serial_printf+0x20>
c0020b2e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020b31:	c6 00 00             	mov    BYTE PTR [eax],0x0
c0020b34:	83 ec 0c             	sub    esp,0xc
c0020b37:	8d 85 dc fe ff ff    	lea    eax,[ebp-0x124]
c0020b3d:	50                   	push   eax
c0020b3e:	e8 ac fd ff ff       	call   c00208ef <serial_puts>
c0020b43:	83 c4 10             	add    esp,0x10
c0020b46:	90                   	nop
c0020b47:	c9                   	leave
c0020b48:	c3                   	ret

c0020b49 <strlen>:
c0020b49:	55                   	push   ebp
c0020b4a:	89 e5                	mov    ebp,esp
c0020b4c:	83 ec 10             	sub    esp,0x10
c0020b4f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c0020b56:	eb 04                	jmp    c0020b5c <strlen+0x13>
c0020b58:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c0020b5c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c0020b5f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020b62:	01 d0                	add    eax,edx
c0020b64:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0020b67:	84 c0                	test   al,al
c0020b69:	75 ed                	jne    c0020b58 <strlen+0xf>
c0020b6b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020b6e:	c9                   	leave
c0020b6f:	c3                   	ret

c0020b70 <IDT_reg_handler>:
c0020b70:	55                   	push   ebp
c0020b71:	89 e5                	mov    ebp,esp
c0020b73:	83 ec 18             	sub    esp,0x18
c0020b76:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
c0020b79:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0020b7c:	66 89 55 ec          	mov    WORD PTR [ebp-0x14],dx
c0020b80:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
c0020b84:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0020b87:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c0020b8a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020b8d:	89 c2                	mov    edx,eax
c0020b8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020b92:	66 89 14 c5 e0 3a 02 	mov    WORD PTR [eax*8-0x3ffdc520],dx
c0020b99:	c0 
c0020b9a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020b9d:	0f b7 55 ec          	movzx  edx,WORD PTR [ebp-0x14]
c0020ba1:	66 89 14 c5 e2 3a 02 	mov    WORD PTR [eax*8-0x3ffdc51e],dx
c0020ba8:	c0 
c0020ba9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020bac:	c6 04 c5 e4 3a 02 c0 	mov    BYTE PTR [eax*8-0x3ffdc51c],0x0
c0020bb3:	00 
c0020bb4:	0f b7 45 e8          	movzx  eax,WORD PTR [ebp-0x18]
c0020bb8:	89 c2                	mov    edx,eax
c0020bba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020bbd:	88 14 c5 e5 3a 02 c0 	mov    BYTE PTR [eax*8-0x3ffdc51b],dl
c0020bc4:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020bc7:	c1 e8 10             	shr    eax,0x10
c0020bca:	89 c2                	mov    edx,eax
c0020bcc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020bcf:	66 89 14 c5 e6 3a 02 	mov    WORD PTR [eax*8-0x3ffdc51a],dx
c0020bd6:	c0 
c0020bd7:	90                   	nop
c0020bd8:	c9                   	leave
c0020bd9:	c3                   	ret

c0020bda <IDT_load>:
c0020bda:	55                   	push   ebp
c0020bdb:	89 e5                	mov    ebp,esp
c0020bdd:	83 ec 10             	sub    esp,0x10
c0020be0:	c7 45 fc 00 01 00 00 	mov    DWORD PTR [ebp-0x4],0x100
c0020be7:	b8 e0 3a 02 c0       	mov    eax,0xc0023ae0
c0020bec:	a3 e2 42 02 c0       	mov    ds:0xc00242e2,eax
c0020bf1:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0020bf4:	c1 e0 03             	shl    eax,0x3
c0020bf7:	83 e8 01             	sub    eax,0x1
c0020bfa:	66 a3 e0 42 02 c0    	mov    ds:0xc00242e0,ax
c0020c00:	0f 01 1d e0 42 02 c0 	lidtd  ds:0xc00242e0
c0020c07:	90                   	nop
c0020c08:	c9                   	leave
c0020c09:	c3                   	ret

c0020c0a <interrupt_enable>:
c0020c0a:	55                   	push   ebp
c0020c0b:	89 e5                	mov    ebp,esp
c0020c0d:	fb                   	sti
c0020c0e:	90                   	nop
c0020c0f:	5d                   	pop    ebp
c0020c10:	c3                   	ret

c0020c11 <interrupt_disable>:
c0020c11:	55                   	push   ebp
c0020c12:	89 e5                	mov    ebp,esp
c0020c14:	fa                   	cli
c0020c15:	90                   	nop
c0020c16:	5d                   	pop    ebp
c0020c17:	c3                   	ret

c0020c18 <PIC_remap>:
c0020c18:	55                   	push   ebp
c0020c19:	89 e5                	mov    ebp,esp
c0020c1b:	83 ec 08             	sub    esp,0x8
c0020c1e:	83 ec 08             	sub    esp,0x8
c0020c21:	6a 11                	push   0x11
c0020c23:	6a 20                	push   0x20
c0020c25:	e8 26 26 00 00       	call   c0023250 <outb>
c0020c2a:	83 c4 10             	add    esp,0x10
c0020c2d:	e8 6c 26 00 00       	call   c002329e <in_out_wait>
c0020c32:	83 ec 08             	sub    esp,0x8
c0020c35:	6a 11                	push   0x11
c0020c37:	68 a0 00 00 00       	push   0xa0
c0020c3c:	e8 0f 26 00 00       	call   c0023250 <outb>
c0020c41:	83 c4 10             	add    esp,0x10
c0020c44:	e8 55 26 00 00       	call   c002329e <in_out_wait>
c0020c49:	83 ec 08             	sub    esp,0x8
c0020c4c:	6a 20                	push   0x20
c0020c4e:	6a 21                	push   0x21
c0020c50:	e8 fb 25 00 00       	call   c0023250 <outb>
c0020c55:	83 c4 10             	add    esp,0x10
c0020c58:	e8 41 26 00 00       	call   c002329e <in_out_wait>
c0020c5d:	83 ec 08             	sub    esp,0x8
c0020c60:	6a 28                	push   0x28
c0020c62:	68 a1 00 00 00       	push   0xa1
c0020c67:	e8 e4 25 00 00       	call   c0023250 <outb>
c0020c6c:	83 c4 10             	add    esp,0x10
c0020c6f:	e8 2a 26 00 00       	call   c002329e <in_out_wait>
c0020c74:	83 ec 08             	sub    esp,0x8
c0020c77:	6a 04                	push   0x4
c0020c79:	6a 21                	push   0x21
c0020c7b:	e8 d0 25 00 00       	call   c0023250 <outb>
c0020c80:	83 c4 10             	add    esp,0x10
c0020c83:	e8 16 26 00 00       	call   c002329e <in_out_wait>
c0020c88:	83 ec 08             	sub    esp,0x8
c0020c8b:	6a 02                	push   0x2
c0020c8d:	68 a1 00 00 00       	push   0xa1
c0020c92:	e8 b9 25 00 00       	call   c0023250 <outb>
c0020c97:	83 c4 10             	add    esp,0x10
c0020c9a:	e8 ff 25 00 00       	call   c002329e <in_out_wait>
c0020c9f:	83 ec 08             	sub    esp,0x8
c0020ca2:	6a 01                	push   0x1
c0020ca4:	6a 21                	push   0x21
c0020ca6:	e8 a5 25 00 00       	call   c0023250 <outb>
c0020cab:	83 c4 10             	add    esp,0x10
c0020cae:	e8 eb 25 00 00       	call   c002329e <in_out_wait>
c0020cb3:	83 ec 08             	sub    esp,0x8
c0020cb6:	6a 01                	push   0x1
c0020cb8:	68 a1 00 00 00       	push   0xa1
c0020cbd:	e8 8e 25 00 00       	call   c0023250 <outb>
c0020cc2:	83 c4 10             	add    esp,0x10
c0020cc5:	e8 d4 25 00 00       	call   c002329e <in_out_wait>
c0020cca:	83 ec 08             	sub    esp,0x8
c0020ccd:	68 fc 00 00 00       	push   0xfc
c0020cd2:	6a 21                	push   0x21
c0020cd4:	e8 77 25 00 00       	call   c0023250 <outb>
c0020cd9:	83 c4 10             	add    esp,0x10
c0020cdc:	83 ec 08             	sub    esp,0x8
c0020cdf:	68 ff 00 00 00       	push   0xff
c0020ce4:	68 a1 00 00 00       	push   0xa1
c0020ce9:	e8 62 25 00 00       	call   c0023250 <outb>
c0020cee:	83 c4 10             	add    esp,0x10
c0020cf1:	90                   	nop
c0020cf2:	c9                   	leave
c0020cf3:	c3                   	ret

c0020cf4 <init_memory>:
c0020cf4:	55                   	push   ebp
c0020cf5:	89 e5                	mov    ebp,esp
c0020cf7:	83 ec 08             	sub    esp,0x8
c0020cfa:	83 ec 0c             	sub    esp,0xc
c0020cfd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0020d00:	e8 2b 09 00 00       	call   c0021630 <vmm_init>
c0020d05:	83 c4 10             	add    esp,0x10
c0020d08:	90                   	nop
c0020d09:	c9                   	leave
c0020d0a:	c3                   	ret

c0020d0b <pmm_init>:
c0020d0b:	55                   	push   ebp
c0020d0c:	89 e5                	mov    ebp,esp
c0020d0e:	83 ec 38             	sub    esp,0x38
c0020d11:	83 ec 0c             	sub    esp,0xc
c0020d14:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0020d17:	e8 c6 00 00 00       	call   c0020de2 <get_memory_size>
c0020d1c:	83 c4 10             	add    esp,0x10
c0020d1f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0020d22:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020d25:	a3 f0 42 02 c0       	mov    ds:0xc00242f0,eax
c0020d2a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020d2d:	c1 e8 0c             	shr    eax,0xc
c0020d30:	a3 e8 42 02 c0       	mov    ds:0xc00242e8,eax
c0020d35:	c7 05 ec 42 02 c0 00 	mov    DWORD PTR ds:0xc00242ec,0x0
c0020d3c:	00 00 00 
c0020d3f:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c0020d44:	83 c0 1f             	add    eax,0x1f
c0020d47:	c1 e8 05             	shr    eax,0x5
c0020d4a:	a3 f8 42 02 c0       	mov    ds:0xc00242f8,eax
c0020d4f:	a1 f8 42 02 c0       	mov    eax,ds:0xc00242f8
c0020d54:	c1 e0 02             	shl    eax,0x2
c0020d57:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0020d5a:	83 ec 08             	sub    esp,0x8
c0020d5d:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0020d60:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0020d63:	e8 ba 00 00 00       	call   c0020e22 <find_free_memory_region>
c0020d68:	83 c4 10             	add    esp,0x10
c0020d6b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0020d6e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0020d71:	a3 f4 42 02 c0       	mov    ds:0xc00242f4,eax
c0020d76:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0020d79:	a3 fc 42 02 c0       	mov    ds:0xc00242fc,eax
c0020d7e:	83 ec 0c             	sub    esp,0xc
c0020d81:	68 00 43 02 c0       	push   0xc0024300
c0020d86:	e8 a9 f2 ff ff       	call   c0020034 <spinlock_init>
c0020d8b:	83 c4 10             	add    esp,0x10
c0020d8e:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c0020d93:	83 ec 04             	sub    esp,0x4
c0020d96:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0020d99:	68 ff 00 00 00       	push   0xff
c0020d9e:	50                   	push   eax
c0020d9f:	e8 04 08 00 00       	call   c00215a8 <memset>
c0020da4:	83 c4 10             	add    esp,0x10
c0020da7:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c0020dac:	a3 ec 42 02 c0       	mov    ds:0xc00242ec,eax
c0020db1:	83 ec 0c             	sub    esp,0xc
c0020db4:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0020db7:	e8 89 01 00 00       	call   c0020f45 <pmm_parse_memory_map>
c0020dbc:	83 c4 10             	add    esp,0x10
c0020dbf:	83 ec 08             	sub    esp,0x8
c0020dc2:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0020dc5:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c0020dc8:	e8 b1 02 00 00       	call   c002107e <pmm_mark_region_as_used>
c0020dcd:	83 c4 10             	add    esp,0x10
c0020dd0:	83 ec 0c             	sub    esp,0xc
c0020dd3:	8d 45 d4             	lea    eax,[ebp-0x2c]
c0020dd6:	50                   	push   eax
c0020dd7:	e8 b9 06 00 00       	call   c0021495 <pmm_get_stats>
c0020ddc:	83 c4 10             	add    esp,0x10
c0020ddf:	90                   	nop
c0020de0:	c9                   	leave
c0020de1:	c3                   	ret

c0020de2 <get_memory_size>:
c0020de2:	55                   	push   ebp
c0020de3:	89 e5                	mov    ebp,esp
c0020de5:	83 ec 18             	sub    esp,0x18
c0020de8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020deb:	8b 00                	mov    eax,DWORD PTR [eax]
c0020ded:	83 e0 01             	and    eax,0x1
c0020df0:	85 c0                	test   eax,eax
c0020df2:	75 10                	jne    c0020e04 <get_memory_size+0x22>
c0020df4:	83 ec 0c             	sub    esp,0xc
c0020df7:	68 78 36 02 c0       	push   0xc0023678
c0020dfc:	e8 e9 f9 ff ff       	call   c00207ea <kpanic>
c0020e01:	83 c4 10             	add    esp,0x10
c0020e04:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020e07:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
c0020e0a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020e0d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
c0020e10:	01 d0                	add    eax,edx
c0020e12:	05 00 04 00 00       	add    eax,0x400
c0020e17:	c1 e0 0a             	shl    eax,0xa
c0020e1a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0020e1d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020e20:	c9                   	leave
c0020e21:	c3                   	ret

c0020e22 <find_free_memory_region>:
c0020e22:	55                   	push   ebp
c0020e23:	89 e5                	mov    ebp,esp
c0020e25:	83 ec 28             	sub    esp,0x28
c0020e28:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020e2b:	8b 00                	mov    eax,DWORD PTR [eax]
c0020e2d:	83 e0 40             	and    eax,0x40
c0020e30:	85 c0                	test   eax,eax
c0020e32:	75 10                	jne    c0020e44 <find_free_memory_region+0x22>
c0020e34:	83 ec 0c             	sub    esp,0xc
c0020e37:	68 a8 36 02 c0       	push   0xc00236a8
c0020e3c:	e8 a9 f9 ff ff       	call   c00207ea <kpanic>
c0020e41:	83 c4 10             	add    esp,0x10
c0020e44:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020e47:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
c0020e4a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0020e4d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c0020e54:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
c0020e5b:	e9 ba 00 00 00       	jmp    c0020f1a <find_free_memory_region+0xf8>
c0020e60:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020e63:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
c0020e66:	83 f8 01             	cmp    eax,0x1
c0020e69:	0f 85 9b 00 00 00    	jne    c0020f0a <find_free_memory_region+0xe8>
c0020e6f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020e72:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
c0020e75:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
c0020e78:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0020e7b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020e7e:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
c0020e81:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
c0020e84:	89 c2                	mov    edx,eax
c0020e86:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020e89:	01 d0                	add    eax,edx
c0020e8b:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0020e8e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020e91:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
c0020e94:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
c0020e97:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0020e9a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0020e9d:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
c0020ea0:	72 68                	jb     c0020f0a <find_free_memory_region+0xe8>
c0020ea2:	c7 45 dc 08 43 02 c0 	mov    DWORD PTR [ebp-0x24],0xc0024308
c0020ea9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
c0020eac:	05 ff 0f 00 00       	add    eax,0xfff
c0020eb1:	25 00 f0 ff ff       	and    eax,0xfffff000
c0020eb6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c0020eb9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020ebc:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
c0020ebf:	72 12                	jb     c0020ed3 <find_free_memory_region+0xb1>
c0020ec1:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
c0020ec4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0020ec7:	01 d0                	add    eax,edx
c0020ec9:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
c0020ecc:	72 05                	jb     c0020ed3 <find_free_memory_region+0xb1>
c0020ece:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020ed1:	eb 70                	jmp    c0020f43 <find_free_memory_region+0x121>
c0020ed3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020ed6:	05 ff 0f 00 00       	add    eax,0xfff
c0020edb:	25 00 f0 ff ff       	and    eax,0xfffff000
c0020ee0:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c0020ee3:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
c0020ee6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0020ee9:	01 d0                	add    eax,edx
c0020eeb:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
c0020eee:	72 1a                	jb     c0020f0a <find_free_memory_region+0xe8>
c0020ef0:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
c0020ef4:	74 08                	je     c0020efe <find_free_memory_region+0xdc>
c0020ef6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020ef9:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
c0020efc:	73 0c                	jae    c0020f0a <find_free_memory_region+0xe8>
c0020efe:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0020f01:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0020f04:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0020f07:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0020f0a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020f0d:	8b 10                	mov    edx,DWORD PTR [eax]
c0020f0f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0020f12:	01 d0                	add    eax,edx
c0020f14:	83 c0 04             	add    eax,0x4
c0020f17:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0020f1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020f1d:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
c0020f20:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020f23:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
c0020f26:	01 d0                	add    eax,edx
c0020f28:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0020f2b:	39 c2                	cmp    edx,eax
c0020f2d:	0f 82 2d ff ff ff    	jb     c0020e60 <find_free_memory_region+0x3e>
c0020f33:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
c0020f37:	74 05                	je     c0020f3e <find_free_memory_region+0x11c>
c0020f39:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0020f3c:	eb 05                	jmp    c0020f43 <find_free_memory_region+0x121>
c0020f3e:	b8 00 00 00 00       	mov    eax,0x0
c0020f43:	c9                   	leave
c0020f44:	c3                   	ret

c0020f45 <pmm_parse_memory_map>:
c0020f45:	55                   	push   ebp
c0020f46:	89 e5                	mov    ebp,esp
c0020f48:	83 ec 18             	sub    esp,0x18
c0020f4b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020f4e:	8b 00                	mov    eax,DWORD PTR [eax]
c0020f50:	83 e0 40             	and    eax,0x40
c0020f53:	85 c0                	test   eax,eax
c0020f55:	75 10                	jne    c0020f67 <pmm_parse_memory_map+0x22>
c0020f57:	83 ec 0c             	sub    esp,0xc
c0020f5a:	68 d4 36 02 c0       	push   0xc00236d4
c0020f5f:	e8 86 f8 ff ff       	call   c00207ea <kpanic>
c0020f64:	83 c4 10             	add    esp,0x10
c0020f67:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c0020f6e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c0020f75:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
c0020f7c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020f7f:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
c0020f82:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0020f85:	eb 50                	jmp    c0020fd7 <pmm_parse_memory_map+0x92>
c0020f87:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020f8a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
c0020f8d:	83 f8 01             	cmp    eax,0x1
c0020f90:	75 31                	jne    c0020fc3 <pmm_parse_memory_map+0x7e>
c0020f92:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020f95:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
c0020f98:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
c0020f9b:	89 c1                	mov    ecx,eax
c0020f9d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020fa0:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
c0020fa3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
c0020fa6:	83 ec 08             	sub    esp,0x8
c0020fa9:	51                   	push   ecx
c0020faa:	50                   	push   eax
c0020fab:	e8 55 00 00 00       	call   c0021005 <pmm_mark_region_as_free>
c0020fb0:	83 c4 10             	add    esp,0x10
c0020fb3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020fb6:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
c0020fb9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
c0020fbc:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
c0020fbf:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
c0020fc3:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0020fc7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020fca:	8b 10                	mov    edx,DWORD PTR [eax]
c0020fcc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0020fcf:	01 d0                	add    eax,edx
c0020fd1:	83 c0 04             	add    eax,0x4
c0020fd4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0020fd7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020fda:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
c0020fdd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0020fe0:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
c0020fe3:	01 d0                	add    eax,edx
c0020fe5:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0020fe8:	39 c2                	cmp    edx,eax
c0020fea:	72 9b                	jb     c0020f87 <pmm_parse_memory_map+0x42>
c0020fec:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
c0020ff0:	75 10                	jne    c0021002 <pmm_parse_memory_map+0xbd>
c0020ff2:	83 ec 0c             	sub    esp,0xc
c0020ff5:	68 00 37 02 c0       	push   0xc0023700
c0020ffa:	e8 eb f7 ff ff       	call   c00207ea <kpanic>
c0020fff:	83 c4 10             	add    esp,0x10
c0021002:	90                   	nop
c0021003:	c9                   	leave
c0021004:	c3                   	ret

c0021005 <pmm_mark_region_as_free>:
c0021005:	55                   	push   ebp
c0021006:	89 e5                	mov    ebp,esp
c0021008:	83 ec 18             	sub    esp,0x18
c002100b:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
c002100f:	74 67                	je     c0021078 <pmm_mark_region_as_free+0x73>
c0021011:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021014:	c1 e8 0c             	shr    eax,0xc
c0021017:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c002101a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c002101d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021020:	01 d0                	add    eax,edx
c0021022:	05 ff 0f 00 00       	add    eax,0xfff
c0021027:	c1 e8 0c             	shr    eax,0xc
c002102a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c002102d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c0021034:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021037:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c002103a:	eb 32                	jmp    c002106e <pmm_mark_region_as_free+0x69>
c002103c:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c0021041:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
c0021044:	73 35                	jae    c002107b <pmm_mark_region_as_free+0x76>
c0021046:	83 ec 0c             	sub    esp,0xc
c0021049:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c002104c:	e8 bd 01 00 00       	call   c002120e <pmm_is_frame_free>
c0021051:	83 c4 10             	add    esp,0x10
c0021054:	84 c0                	test   al,al
c0021056:	75 12                	jne    c002106a <pmm_mark_region_as_free+0x65>
c0021058:	83 ec 0c             	sub    esp,0xc
c002105b:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c002105e:	e8 41 01 00 00       	call   c00211a4 <pmm_set_frame_free>
c0021063:	83 c4 10             	add    esp,0x10
c0021066:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c002106a:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c002106e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021071:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
c0021074:	72 c6                	jb     c002103c <pmm_mark_region_as_free+0x37>
c0021076:	eb 04                	jmp    c002107c <pmm_mark_region_as_free+0x77>
c0021078:	90                   	nop
c0021079:	eb 01                	jmp    c002107c <pmm_mark_region_as_free+0x77>
c002107b:	90                   	nop
c002107c:	c9                   	leave
c002107d:	c3                   	ret

c002107e <pmm_mark_region_as_used>:
c002107e:	55                   	push   ebp
c002107f:	89 e5                	mov    ebp,esp
c0021081:	83 ec 18             	sub    esp,0x18
c0021084:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
c0021088:	0f 84 ab 00 00 00    	je     c0021139 <pmm_mark_region_as_used+0xbb>
c002108e:	83 ec 0c             	sub    esp,0xc
c0021091:	68 00 43 02 c0       	push   0xc0024300
c0021096:	e8 a8 ef ff ff       	call   c0020043 <spinlock_lock>
c002109b:	83 c4 10             	add    esp,0x10
c002109e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00210a1:	c1 e8 0c             	shr    eax,0xc
c00210a4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00210a7:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
c00210aa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00210ad:	01 d0                	add    eax,edx
c00210af:	05 ff 0f 00 00       	add    eax,0xfff
c00210b4:	c1 e8 0c             	shr    eax,0xc
c00210b7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00210ba:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c00210bf:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
c00210c2:	72 12                	jb     c00210d6 <pmm_mark_region_as_used+0x58>
c00210c4:	83 ec 0c             	sub    esp,0xc
c00210c7:	68 00 43 02 c0       	push   0xc0024300
c00210cc:	e8 8f ef ff ff       	call   c0020060 <spinlock_unlock>
c00210d1:	83 c4 10             	add    esp,0x10
c00210d4:	eb 64                	jmp    c002113a <pmm_mark_region_as_used+0xbc>
c00210d6:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c00210db:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
c00210de:	73 08                	jae    c00210e8 <pmm_mark_region_as_used+0x6a>
c00210e0:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c00210e5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00210e8:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c00210ef:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00210f2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00210f5:	eb 28                	jmp    c002111f <pmm_mark_region_as_used+0xa1>
c00210f7:	83 ec 0c             	sub    esp,0xc
c00210fa:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c00210fd:	e8 0c 01 00 00       	call   c002120e <pmm_is_frame_free>
c0021102:	83 c4 10             	add    esp,0x10
c0021105:	84 c0                	test   al,al
c0021107:	74 12                	je     c002111b <pmm_mark_region_as_used+0x9d>
c0021109:	83 ec 0c             	sub    esp,0xc
c002110c:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c002110f:	e8 28 00 00 00       	call   c002113c <pmm_set_frame_used>
c0021114:	83 c4 10             	add    esp,0x10
c0021117:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c002111b:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
c002111f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021122:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
c0021125:	72 d0                	jb     c00210f7 <pmm_mark_region_as_used+0x79>
c0021127:	83 ec 0c             	sub    esp,0xc
c002112a:	68 00 43 02 c0       	push   0xc0024300
c002112f:	e8 2c ef ff ff       	call   c0020060 <spinlock_unlock>
c0021134:	83 c4 10             	add    esp,0x10
c0021137:	eb 01                	jmp    c002113a <pmm_mark_region_as_used+0xbc>
c0021139:	90                   	nop
c002113a:	c9                   	leave
c002113b:	c3                   	ret

c002113c <pmm_set_frame_used>:
c002113c:	55                   	push   ebp
c002113d:	89 e5                	mov    ebp,esp
c002113f:	53                   	push   ebx
c0021140:	83 ec 10             	sub    esp,0x10
c0021143:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c0021148:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
c002114b:	73 51                	jae    c002119e <pmm_set_frame_used+0x62>
c002114d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021150:	c1 e8 05             	shr    eax,0x5
c0021153:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c0021156:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021159:	83 e0 1f             	and    eax,0x1f
c002115c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002115f:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c0021164:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c0021167:	c1 e2 02             	shl    edx,0x2
c002116a:	01 d0                	add    eax,edx
c002116c:	8b 10                	mov    edx,DWORD PTR [eax]
c002116e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021171:	bb 01 00 00 00       	mov    ebx,0x1
c0021176:	89 c1                	mov    ecx,eax
c0021178:	d3 e3                	shl    ebx,cl
c002117a:	89 d8                	mov    eax,ebx
c002117c:	89 c3                	mov    ebx,eax
c002117e:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c0021183:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
c0021186:	c1 e1 02             	shl    ecx,0x2
c0021189:	01 c8                	add    eax,ecx
c002118b:	09 da                	or     edx,ebx
c002118d:	89 10                	mov    DWORD PTR [eax],edx
c002118f:	a1 ec 42 02 c0       	mov    eax,ds:0xc00242ec
c0021194:	83 c0 01             	add    eax,0x1
c0021197:	a3 ec 42 02 c0       	mov    ds:0xc00242ec,eax
c002119c:	eb 01                	jmp    c002119f <pmm_set_frame_used+0x63>
c002119e:	90                   	nop
c002119f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
c00211a2:	c9                   	leave
c00211a3:	c3                   	ret

c00211a4 <pmm_set_frame_free>:
c00211a4:	55                   	push   ebp
c00211a5:	89 e5                	mov    ebp,esp
c00211a7:	53                   	push   ebx
c00211a8:	83 ec 10             	sub    esp,0x10
c00211ab:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c00211b0:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
c00211b3:	73 53                	jae    c0021208 <pmm_set_frame_free+0x64>
c00211b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00211b8:	c1 e8 05             	shr    eax,0x5
c00211bb:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c00211be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00211c1:	83 e0 1f             	and    eax,0x1f
c00211c4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00211c7:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c00211cc:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c00211cf:	c1 e2 02             	shl    edx,0x2
c00211d2:	01 d0                	add    eax,edx
c00211d4:	8b 10                	mov    edx,DWORD PTR [eax]
c00211d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00211d9:	bb 01 00 00 00       	mov    ebx,0x1
c00211de:	89 c1                	mov    ecx,eax
c00211e0:	d3 e3                	shl    ebx,cl
c00211e2:	89 d8                	mov    eax,ebx
c00211e4:	f7 d0                	not    eax
c00211e6:	89 c3                	mov    ebx,eax
c00211e8:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c00211ed:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
c00211f0:	c1 e1 02             	shl    ecx,0x2
c00211f3:	01 c8                	add    eax,ecx
c00211f5:	21 da                	and    edx,ebx
c00211f7:	89 10                	mov    DWORD PTR [eax],edx
c00211f9:	a1 ec 42 02 c0       	mov    eax,ds:0xc00242ec
c00211fe:	83 e8 01             	sub    eax,0x1
c0021201:	a3 ec 42 02 c0       	mov    ds:0xc00242ec,eax
c0021206:	eb 01                	jmp    c0021209 <pmm_set_frame_free+0x65>
c0021208:	90                   	nop
c0021209:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
c002120c:	c9                   	leave
c002120d:	c3                   	ret

c002120e <pmm_is_frame_free>:
c002120e:	55                   	push   ebp
c002120f:	89 e5                	mov    ebp,esp
c0021211:	53                   	push   ebx
c0021212:	83 ec 10             	sub    esp,0x10
c0021215:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c002121a:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
c002121d:	72 07                	jb     c0021226 <pmm_is_frame_free+0x18>
c002121f:	b8 00 00 00 00       	mov    eax,0x0
c0021224:	eb 36                	jmp    c002125c <pmm_is_frame_free+0x4e>
c0021226:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021229:	c1 e8 05             	shr    eax,0x5
c002122c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c002122f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021232:	83 e0 1f             	and    eax,0x1f
c0021235:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021238:	a1 f4 42 02 c0       	mov    eax,ds:0xc00242f4
c002123d:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c0021240:	c1 e2 02             	shl    edx,0x2
c0021243:	01 d0                	add    eax,edx
c0021245:	8b 10                	mov    edx,DWORD PTR [eax]
c0021247:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002124a:	bb 01 00 00 00       	mov    ebx,0x1
c002124f:	89 c1                	mov    ecx,eax
c0021251:	d3 e3                	shl    ebx,cl
c0021253:	89 d8                	mov    eax,ebx
c0021255:	21 d0                	and    eax,edx
c0021257:	85 c0                	test   eax,eax
c0021259:	0f 94 c0             	sete   al
c002125c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
c002125f:	c9                   	leave
c0021260:	c3                   	ret

c0021261 <pmm_alloc_frame>:
c0021261:	55                   	push   ebp
c0021262:	89 e5                	mov    ebp,esp
c0021264:	83 ec 18             	sub    esp,0x18
c0021267:	83 ec 0c             	sub    esp,0xc
c002126a:	68 00 43 02 c0       	push   0xc0024300
c002126f:	e8 cf ed ff ff       	call   c0020043 <spinlock_lock>
c0021274:	83 c4 10             	add    esp,0x10
c0021277:	a1 98 3a 02 c0       	mov    eax,ds:0xc0023a98
c002127c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002127f:	eb 47                	jmp    c00212c8 <pmm_alloc_frame+0x67>
c0021281:	83 ec 0c             	sub    esp,0xc
c0021284:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0021287:	e8 82 ff ff ff       	call   c002120e <pmm_is_frame_free>
c002128c:	83 c4 10             	add    esp,0x10
c002128f:	84 c0                	test   al,al
c0021291:	74 31                	je     c00212c4 <pmm_alloc_frame+0x63>
c0021293:	83 ec 0c             	sub    esp,0xc
c0021296:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0021299:	e8 9e fe ff ff       	call   c002113c <pmm_set_frame_used>
c002129e:	83 c4 10             	add    esp,0x10
c00212a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00212a4:	83 c0 01             	add    eax,0x1
c00212a7:	a3 98 3a 02 c0       	mov    ds:0xc0023a98,eax
c00212ac:	83 ec 0c             	sub    esp,0xc
c00212af:	68 00 43 02 c0       	push   0xc0024300
c00212b4:	e8 a7 ed ff ff       	call   c0020060 <spinlock_unlock>
c00212b9:	83 c4 10             	add    esp,0x10
c00212bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00212bf:	c1 e0 0c             	shl    eax,0xc
c00212c2:	eb 7d                	jmp    c0021341 <pmm_alloc_frame+0xe0>
c00212c4:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c00212c8:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c00212cd:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
c00212d0:	72 af                	jb     c0021281 <pmm_alloc_frame+0x20>
c00212d2:	c7 45 f0 00 01 00 00 	mov    DWORD PTR [ebp-0x10],0x100
c00212d9:	eb 47                	jmp    c0021322 <pmm_alloc_frame+0xc1>
c00212db:	83 ec 0c             	sub    esp,0xc
c00212de:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c00212e1:	e8 28 ff ff ff       	call   c002120e <pmm_is_frame_free>
c00212e6:	83 c4 10             	add    esp,0x10
c00212e9:	84 c0                	test   al,al
c00212eb:	74 31                	je     c002131e <pmm_alloc_frame+0xbd>
c00212ed:	83 ec 0c             	sub    esp,0xc
c00212f0:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c00212f3:	e8 44 fe ff ff       	call   c002113c <pmm_set_frame_used>
c00212f8:	83 c4 10             	add    esp,0x10
c00212fb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00212fe:	83 c0 01             	add    eax,0x1
c0021301:	a3 98 3a 02 c0       	mov    ds:0xc0023a98,eax
c0021306:	83 ec 0c             	sub    esp,0xc
c0021309:	68 00 43 02 c0       	push   0xc0024300
c002130e:	e8 4d ed ff ff       	call   c0020060 <spinlock_unlock>
c0021313:	83 c4 10             	add    esp,0x10
c0021316:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021319:	c1 e0 0c             	shl    eax,0xc
c002131c:	eb 23                	jmp    c0021341 <pmm_alloc_frame+0xe0>
c002131e:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0021322:	a1 98 3a 02 c0       	mov    eax,ds:0xc0023a98
c0021327:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
c002132a:	72 af                	jb     c00212db <pmm_alloc_frame+0x7a>
c002132c:	83 ec 0c             	sub    esp,0xc
c002132f:	68 00 43 02 c0       	push   0xc0024300
c0021334:	e8 27 ed ff ff       	call   c0020060 <spinlock_unlock>
c0021339:	83 c4 10             	add    esp,0x10
c002133c:	b8 00 00 00 00       	mov    eax,0x0
c0021341:	c9                   	leave
c0021342:	c3                   	ret

c0021343 <pmm_free_frame>:
c0021343:	55                   	push   ebp
c0021344:	89 e5                	mov    ebp,esp
c0021346:	83 ec 18             	sub    esp,0x18
c0021349:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c002134d:	74 55                	je     c00213a4 <pmm_free_frame+0x61>
c002134f:	83 ec 0c             	sub    esp,0xc
c0021352:	68 00 43 02 c0       	push   0xc0024300
c0021357:	e8 e7 ec ff ff       	call   c0020043 <spinlock_lock>
c002135c:	83 c4 10             	add    esp,0x10
c002135f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021362:	c1 e8 0c             	shr    eax,0xc
c0021365:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021368:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c002136d:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
c0021370:	72 12                	jb     c0021384 <pmm_free_frame+0x41>
c0021372:	83 ec 0c             	sub    esp,0xc
c0021375:	68 00 43 02 c0       	push   0xc0024300
c002137a:	e8 e1 ec ff ff       	call   c0020060 <spinlock_unlock>
c002137f:	83 c4 10             	add    esp,0x10
c0021382:	eb 21                	jmp    c00213a5 <pmm_free_frame+0x62>
c0021384:	83 ec 0c             	sub    esp,0xc
c0021387:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c002138a:	e8 15 fe ff ff       	call   c00211a4 <pmm_set_frame_free>
c002138f:	83 c4 10             	add    esp,0x10
c0021392:	83 ec 0c             	sub    esp,0xc
c0021395:	68 00 43 02 c0       	push   0xc0024300
c002139a:	e8 c1 ec ff ff       	call   c0020060 <spinlock_unlock>
c002139f:	83 c4 10             	add    esp,0x10
c00213a2:	eb 01                	jmp    c00213a5 <pmm_free_frame+0x62>
c00213a4:	90                   	nop
c00213a5:	c9                   	leave
c00213a6:	c3                   	ret

c00213a7 <pmm_alloc_frames>:
c00213a7:	55                   	push   ebp
c00213a8:	89 e5                	mov    ebp,esp
c00213aa:	83 ec 28             	sub    esp,0x28
c00213ad:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c00213b1:	75 0a                	jne    c00213bd <pmm_alloc_frames+0x16>
c00213b3:	b8 00 00 00 00       	mov    eax,0x0
c00213b8:	e9 d6 00 00 00       	jmp    c0021493 <pmm_alloc_frames+0xec>
c00213bd:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
c00213c1:	75 0a                	jne    c00213cd <pmm_alloc_frames+0x26>
c00213c3:	e8 99 fe ff ff       	call   c0021261 <pmm_alloc_frame>
c00213c8:	e9 c6 00 00 00       	jmp    c0021493 <pmm_alloc_frames+0xec>
c00213cd:	83 ec 0c             	sub    esp,0xc
c00213d0:	68 00 43 02 c0       	push   0xc0024300
c00213d5:	e8 69 ec ff ff       	call   c0020043 <spinlock_lock>
c00213da:	83 c4 10             	add    esp,0x10
c00213dd:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c00213e4:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c00213eb:	c7 45 ec 00 01 00 00 	mov    DWORD PTR [ebp-0x14],0x100
c00213f2:	eb 7c                	jmp    c0021470 <pmm_alloc_frames+0xc9>
c00213f4:	83 ec 0c             	sub    esp,0xc
c00213f7:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c00213fa:	e8 0f fe ff ff       	call   c002120e <pmm_is_frame_free>
c00213ff:	83 c4 10             	add    esp,0x10
c0021402:	84 c0                	test   al,al
c0021404:	74 5f                	je     c0021465 <pmm_alloc_frames+0xbe>
c0021406:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
c002140a:	75 06                	jne    c0021412 <pmm_alloc_frames+0x6b>
c002140c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002140f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021412:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0021416:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021419:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
c002141c:	75 4e                	jne    c002146c <pmm_alloc_frames+0xc5>
c002141e:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
c0021425:	eb 18                	jmp    c002143f <pmm_alloc_frames+0x98>
c0021427:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c002142a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c002142d:	01 d0                	add    eax,edx
c002142f:	83 ec 0c             	sub    esp,0xc
c0021432:	50                   	push   eax
c0021433:	e8 04 fd ff ff       	call   c002113c <pmm_set_frame_used>
c0021438:	83 c4 10             	add    esp,0x10
c002143b:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
c002143f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021442:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
c0021445:	72 e0                	jb     c0021427 <pmm_alloc_frames+0x80>
c0021447:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002144a:	c1 e0 0c             	shl    eax,0xc
c002144d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0021450:	83 ec 0c             	sub    esp,0xc
c0021453:	68 00 43 02 c0       	push   0xc0024300
c0021458:	e8 03 ec ff ff       	call   c0020060 <spinlock_unlock>
c002145d:	83 c4 10             	add    esp,0x10
c0021460:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0021463:	eb 2e                	jmp    c0021493 <pmm_alloc_frames+0xec>
c0021465:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c002146c:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
c0021470:	a1 e8 42 02 c0       	mov    eax,ds:0xc00242e8
c0021475:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
c0021478:	0f 82 76 ff ff ff    	jb     c00213f4 <pmm_alloc_frames+0x4d>
c002147e:	83 ec 0c             	sub    esp,0xc
c0021481:	68 00 43 02 c0       	push   0xc0024300
c0021486:	e8 d5 eb ff ff       	call   c0020060 <spinlock_unlock>
c002148b:	83 c4 10             	add    esp,0x10
c002148e:	b8 00 00 00 00       	mov    eax,0x0
c0021493:	c9                   	leave
c0021494:	c3                   	ret

c0021495 <pmm_get_stats>:
c0021495:	55                   	push   ebp
c0021496:	89 e5                	mov    ebp,esp
c0021498:	8b 15 e8 42 02 c0    	mov    edx,DWORD PTR ds:0xc00242e8
c002149e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214a1:	89 10                	mov    DWORD PTR [eax],edx
c00214a3:	8b 15 ec 42 02 c0    	mov    edx,DWORD PTR ds:0xc00242ec
c00214a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214ac:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
c00214af:	8b 15 e8 42 02 c0    	mov    edx,DWORD PTR ds:0xc00242e8
c00214b5:	a1 ec 42 02 c0       	mov    eax,ds:0xc00242ec
c00214ba:	29 c2                	sub    edx,eax
c00214bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214bf:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
c00214c2:	8b 15 f0 42 02 c0    	mov    edx,DWORD PTR ds:0xc00242f0
c00214c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214cb:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
c00214ce:	a1 ec 42 02 c0       	mov    eax,ds:0xc00242ec
c00214d3:	c1 e0 0c             	shl    eax,0xc
c00214d6:	89 c2                	mov    edx,eax
c00214d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214db:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
c00214de:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214e1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
c00214e4:	c1 e0 0c             	shl    eax,0xc
c00214e7:	89 c2                	mov    edx,eax
c00214e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214ec:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
c00214ef:	90                   	nop
c00214f0:	5d                   	pop    ebp
c00214f1:	c3                   	ret

c00214f2 <memcpy>:
c00214f2:	55                   	push   ebp
c00214f3:	89 e5                	mov    ebp,esp
c00214f5:	83 ec 10             	sub    esp,0x10
c00214f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00214fb:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c00214fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021501:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021504:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c002150b:	eb 19                	jmp    c0021526 <memcpy+0x34>
c002150d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0021510:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0021513:	01 d0                	add    eax,edx
c0021515:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
c0021518:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
c002151b:	01 ca                	add    edx,ecx
c002151d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0021520:	88 02                	mov    BYTE PTR [edx],al
c0021522:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c0021526:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0021529:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
c002152c:	72 df                	jb     c002150d <memcpy+0x1b>
c002152e:	90                   	nop
c002152f:	90                   	nop
c0021530:	c9                   	leave
c0021531:	c3                   	ret

c0021532 <memmove>:
c0021532:	55                   	push   ebp
c0021533:	89 e5                	mov    ebp,esp
c0021535:	83 ec 10             	sub    esp,0x10
c0021538:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002153b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002153e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021541:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021544:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021547:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
c002154a:	73 2c                	jae    c0021578 <memmove+0x46>
c002154c:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c0021553:	eb 19                	jmp    c002156e <memmove+0x3c>
c0021555:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c0021558:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002155b:	01 d0                	add    eax,edx
c002155d:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
c0021560:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
c0021563:	01 ca                	add    edx,ecx
c0021565:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0021568:	88 02                	mov    BYTE PTR [edx],al
c002156a:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c002156e:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0021571:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
c0021574:	72 df                	jb     c0021555 <memmove+0x23>
c0021576:	eb 2d                	jmp    c00215a5 <memmove+0x73>
c0021578:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002157b:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c002157e:	eb 1f                	jmp    c002159f <memmove+0x6d>
c0021580:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
c0021583:	8d 50 ff             	lea    edx,[eax-0x1]
c0021586:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021589:	01 d0                	add    eax,edx
c002158b:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c002158e:	8d 4a ff             	lea    ecx,[edx-0x1]
c0021591:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0021594:	01 ca                	add    edx,ecx
c0021596:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0021599:	88 02                	mov    BYTE PTR [edx],al
c002159b:	83 6d f8 01          	sub    DWORD PTR [ebp-0x8],0x1
c002159f:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
c00215a3:	75 db                	jne    c0021580 <memmove+0x4e>
c00215a5:	90                   	nop
c00215a6:	c9                   	leave
c00215a7:	c3                   	ret

c00215a8 <memset>:
c00215a8:	55                   	push   ebp
c00215a9:	89 e5                	mov    ebp,esp
c00215ab:	83 ec 10             	sub    esp,0x10
c00215ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00215b1:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c00215b4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00215b7:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
c00215ba:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c00215c1:	eb 12                	jmp    c00215d5 <memset+0x2d>
c00215c3:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c00215c6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00215c9:	01 c2                	add    edx,eax
c00215cb:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
c00215cf:	88 02                	mov    BYTE PTR [edx],al
c00215d1:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c00215d5:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00215d8:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
c00215db:	72 e6                	jb     c00215c3 <memset+0x1b>
c00215dd:	90                   	nop
c00215de:	90                   	nop
c00215df:	c9                   	leave
c00215e0:	c3                   	ret

c00215e1 <memcmp>:
c00215e1:	55                   	push   ebp
c00215e2:	89 e5                	mov    ebp,esp
c00215e4:	83 ec 10             	sub    esp,0x10
c00215e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00215ea:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c00215ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00215f0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00215f3:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
c00215fa:	eb 25                	jmp    c0021621 <memcmp+0x40>
c00215fc:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
c00215ff:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0021602:	01 d0                	add    eax,edx
c0021604:	0f b6 10             	movzx  edx,BYTE PTR [eax]
c0021607:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
c002160a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002160d:	01 c8                	add    eax,ecx
c002160f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
c0021612:	38 c2                	cmp    dl,al
c0021614:	74 07                	je     c002161d <memcmp+0x3c>
c0021616:	b8 00 00 00 00       	mov    eax,0x0
c002161b:	eb 11                	jmp    c002162e <memcmp+0x4d>
c002161d:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
c0021621:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0021624:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
c0021627:	72 d3                	jb     c00215fc <memcmp+0x1b>
c0021629:	b8 01 00 00 00       	mov    eax,0x1
c002162e:	c9                   	leave
c002162f:	c3                   	ret

c0021630 <vmm_init>:
c0021630:	55                   	push   ebp
c0021631:	89 e5                	mov    ebp,esp
c0021633:	83 ec 08             	sub    esp,0x8
c0021636:	83 ec 0c             	sub    esp,0xc
c0021639:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c002163c:	e8 ca f6 ff ff       	call   c0020d0b <pmm_init>
c0021641:	83 c4 10             	add    esp,0x10
c0021644:	e8 57 00 00 00       	call   c00216a0 <paging_init>
c0021649:	90                   	nop
c002164a:	c9                   	leave
c002164b:	c3                   	ret

c002164c <invalidate_TLB>:
c002164c:	55                   	push   ebp
c002164d:	89 e5                	mov    ebp,esp
c002164f:	83 ec 10             	sub    esp,0x10
c0021652:	c7 45 fc 00 10 00 00 	mov    DWORD PTR [ebp-0x4],0x1000
c0021659:	b8 00 80 0b 00       	mov    eax,0xb8000
c002165e:	66 c7 00 41 2f       	mov    WORD PTR [eax],0x2f41
c0021663:	90                   	nop
c0021664:	c9                   	leave
c0021665:	c3                   	ret

c0021666 <initialize_current_space_from_cr3>:
c0021666:	55                   	push   ebp
c0021667:	89 e5                	mov    ebp,esp
c0021669:	83 ec 18             	sub    esp,0x18
c002166c:	e8 f9 1c 00 00       	call   c002336a <get_cr3>
c0021671:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021674:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021677:	a3 04 43 02 c0       	mov    ds:0xc0024304,eax
c002167c:	90                   	nop
c002167d:	c9                   	leave
c002167e:	c3                   	ret

c002167f <disable_init_identity_mapping>:
c002167f:	55                   	push   ebp
c0021680:	89 e5                	mov    ebp,esp
c0021682:	83 ec 08             	sub    esp,0x8
c0021685:	a1 04 43 02 c0       	mov    eax,ds:0xc0024304
c002168a:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
c0021690:	83 ec 0c             	sub    esp,0xc
c0021693:	6a 00                	push   0x0
c0021695:	e8 b1 1d 00 00       	call   c002344b <invalidate_directory_TLB>
c002169a:	83 c4 10             	add    esp,0x10
c002169d:	90                   	nop
c002169e:	c9                   	leave
c002169f:	c3                   	ret

c00216a0 <paging_init>:
c00216a0:	55                   	push   ebp
c00216a1:	89 e5                	mov    ebp,esp
c00216a3:	83 ec 08             	sub    esp,0x8
c00216a6:	68 b2 01 01 00       	push   0x101b2
c00216ab:	68 8e 00 00 00       	push   0x8e
c00216b0:	6a 08                	push   0x8
c00216b2:	6a 14                	push   0x14
c00216b4:	e8 b7 f4 ff ff       	call   c0020b70 <IDT_reg_handler>
c00216b9:	83 c4 10             	add    esp,0x10
c00216bc:	e8 a5 ff ff ff       	call   c0021666 <initialize_current_space_from_cr3>
c00216c1:	e8 b9 ff ff ff       	call   c002167f <disable_init_identity_mapping>
c00216c6:	90                   	nop
c00216c7:	c9                   	leave
c00216c8:	c3                   	ret

c00216c9 <paging_create_directory>:
c00216c9:	55                   	push   ebp
c00216ca:	89 e5                	mov    ebp,esp
c00216cc:	83 ec 18             	sub    esp,0x18
c00216cf:	e8 8d fb ff ff       	call   c0021261 <pmm_alloc_frame>
c00216d4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c00216d7:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
c00216db:	75 07                	jne    c00216e4 <paging_create_directory+0x1b>
c00216dd:	b8 00 00 00 00       	mov    eax,0x0
c00216e2:	eb 59                	jmp    c002173d <paging_create_directory+0x74>
c00216e4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00216e7:	2d 00 00 00 40       	sub    eax,0x40000000
c00216ec:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00216ef:	83 ec 04             	sub    esp,0x4
c00216f2:	68 00 10 00 00       	push   0x1000
c00216f7:	6a 00                	push   0x0
c00216f9:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c00216fc:	e8 a7 fe ff ff       	call   c00215a8 <memset>
c0021701:	83 c4 10             	add    esp,0x10
c0021704:	c7 45 f4 00 03 00 00 	mov    DWORD PTR [ebp-0xc],0x300
c002170b:	eb 24                	jmp    c0021731 <paging_create_directory+0x68>
c002170d:	a1 04 43 02 c0       	mov    eax,ds:0xc0024304
c0021712:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0021715:	c1 e2 02             	shl    edx,0x2
c0021718:	01 d0                	add    eax,edx
c002171a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c002171d:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
c0021724:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021727:	01 ca                	add    edx,ecx
c0021729:	8b 00                	mov    eax,DWORD PTR [eax]
c002172b:	89 02                	mov    DWORD PTR [edx],eax
c002172d:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0021731:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
c0021738:	7e d3                	jle    c002170d <paging_create_directory+0x44>
c002173a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002173d:	c9                   	leave
c002173e:	c3                   	ret

c002173f <paging_switch_directory>:
c002173f:	55                   	push   ebp
c0021740:	89 e5                	mov    ebp,esp
c0021742:	83 ec 18             	sub    esp,0x18
c0021745:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021748:	05 00 00 00 40       	add    eax,0x40000000
c002174d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021750:	83 ec 0c             	sub    esp,0xc
c0021753:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0021756:	e8 27 1c 00 00       	call   c0023382 <set_cr3>
c002175b:	83 c4 10             	add    esp,0x10
c002175e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021761:	a3 04 43 02 c0       	mov    ds:0xc0024304,eax
c0021766:	90                   	nop
c0021767:	c9                   	leave
c0021768:	c3                   	ret

c0021769 <paging_get_current_directory>:
c0021769:	55                   	push   ebp
c002176a:	89 e5                	mov    ebp,esp
c002176c:	a1 04 43 02 c0       	mov    eax,ds:0xc0024304
c0021771:	5d                   	pop    ebp
c0021772:	c3                   	ret

c0021773 <paging_clone_directory>:
c0021773:	55                   	push   ebp
c0021774:	89 e5                	mov    ebp,esp
c0021776:	83 ec 28             	sub    esp,0x28
c0021779:	e8 4b ff ff ff       	call   c00216c9 <paging_create_directory>
c002177e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021781:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
c0021785:	75 0a                	jne    c0021791 <paging_clone_directory+0x1e>
c0021787:	b8 00 00 00 00       	mov    eax,0x0
c002178c:	e9 b4 01 00 00       	jmp    c0021945 <paging_clone_directory+0x1d2>
c0021791:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c0021798:	e9 98 01 00 00       	jmp    c0021935 <paging_clone_directory+0x1c2>
c002179d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00217a0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00217a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00217aa:	01 d0                	add    eax,edx
c00217ac:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00217b0:	83 e0 10             	and    eax,0x10
c00217b3:	84 c0                	test   al,al
c00217b5:	0f 84 76 01 00 00    	je     c0021931 <paging_clone_directory+0x1be>
c00217bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00217be:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00217c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00217c8:	01 d0                	add    eax,edx
c00217ca:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00217ce:	83 e0 08             	and    eax,0x8
c00217d1:	84 c0                	test   al,al
c00217d3:	74 27                	je     c00217fc <paging_clone_directory+0x89>
c00217d5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00217d8:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00217df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00217e2:	01 d0                	add    eax,edx
c00217e4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c00217e7:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
c00217ee:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c00217f1:	01 ca                	add    edx,ecx
c00217f3:	8b 00                	mov    eax,DWORD PTR [eax]
c00217f5:	89 02                	mov    DWORD PTR [edx],eax
c00217f7:	e9 35 01 00 00       	jmp    c0021931 <paging_clone_directory+0x1be>
c00217fc:	e8 60 fa ff ff       	call   c0021261 <pmm_alloc_frame>
c0021801:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021804:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
c0021808:	75 0a                	jne    c0021814 <paging_clone_directory+0xa1>
c002180a:	b8 00 00 00 00       	mov    eax,0x0
c002180f:	e9 31 01 00 00       	jmp    c0021945 <paging_clone_directory+0x1d2>
c0021814:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021817:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c002181e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021821:	01 d0                	add    eax,edx
c0021823:	8b 00                	mov    eax,DWORD PTR [eax]
c0021825:	25 ff ff 0f 00       	and    eax,0xfffff
c002182a:	c1 e0 0c             	shl    eax,0xc
c002182d:	2d 00 00 00 40       	sub    eax,0x40000000
c0021832:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021835:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021838:	2d 00 00 00 40       	sub    eax,0x40000000
c002183d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0021840:	83 ec 04             	sub    esp,0x4
c0021843:	68 00 10 00 00       	push   0x1000
c0021848:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
c002184b:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c002184e:	e8 9f fc ff ff       	call   c00214f2 <memcpy>
c0021853:	83 c4 10             	add    esp,0x10
c0021856:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021859:	c1 e8 0c             	shr    eax,0xc
c002185c:	89 c2                	mov    edx,eax
c002185e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021861:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
c0021868:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002186b:	01 c8                	add    eax,ecx
c002186d:	81 e2 ff ff 0f 00    	and    edx,0xfffff
c0021873:	89 d1                	mov    ecx,edx
c0021875:	81 e1 ff ff 0f 00    	and    ecx,0xfffff
c002187b:	8b 10                	mov    edx,DWORD PTR [eax]
c002187d:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0021883:	09 ca                	or     edx,ecx
c0021885:	89 10                	mov    DWORD PTR [eax],edx
c0021887:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002188a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021891:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021894:	01 d0                	add    eax,edx
c0021896:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c002189a:	83 ca 10             	or     edx,0x10
c002189d:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c00218a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00218a3:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00218aa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00218ad:	01 d0                	add    eax,edx
c00218af:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c00218b2:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
c00218b9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c00218bc:	01 ca                	add    edx,ecx
c00218be:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00218c2:	c0 e8 05             	shr    al,0x5
c00218c5:	83 e0 01             	and    eax,0x1
c00218c8:	83 e0 01             	and    eax,0x1
c00218cb:	c1 e0 05             	shl    eax,0x5
c00218ce:	89 c1                	mov    ecx,eax
c00218d0:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c00218d4:	83 e0 df             	and    eax,0xffffffdf
c00218d7:	09 c8                	or     eax,ecx
c00218d9:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c00218dc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00218df:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00218e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00218e9:	01 d0                	add    eax,edx
c00218eb:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c00218ee:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
c00218f5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c00218f8:	01 ca                	add    edx,ecx
c00218fa:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00218fe:	c0 e8 06             	shr    al,0x6
c0021901:	83 e0 01             	and    eax,0x1
c0021904:	83 e0 01             	and    eax,0x1
c0021907:	c1 e0 06             	shl    eax,0x6
c002190a:	89 c1                	mov    ecx,eax
c002190c:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021910:	83 e0 bf             	and    eax,0xffffffbf
c0021913:	09 c8                	or     eax,ecx
c0021915:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021918:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002191b:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021922:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021925:	01 d0                	add    eax,edx
c0021927:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c002192b:	83 e2 f7             	and    edx,0xfffffff7
c002192e:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021931:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0021935:	81 7d f4 ff 02 00 00 	cmp    DWORD PTR [ebp-0xc],0x2ff
c002193c:	0f 8e 5b fe ff ff    	jle    c002179d <paging_clone_directory+0x2a>
c0021942:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021945:	c9                   	leave
c0021946:	c3                   	ret

c0021947 <get_pte>:
c0021947:	55                   	push   ebp
c0021948:	89 e5                	mov    ebp,esp
c002194a:	83 ec 38             	sub    esp,0x38
c002194d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0021950:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
c0021953:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021956:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021959:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002195c:	c1 e8 16             	shr    eax,0x16
c002195f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021962:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021965:	c1 e8 0c             	shr    eax,0xc
c0021968:	25 ff 03 00 00       	and    eax,0x3ff
c002196d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021970:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021973:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c002197a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002197d:	01 d0                	add    eax,edx
c002197f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021982:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021985:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021989:	83 e0 10             	and    eax,0x10
c002198c:	84 c0                	test   al,al
c002198e:	0f 85 c5 00 00 00    	jne    c0021a59 <get_pte+0x112>
c0021994:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
c0021998:	75 0a                	jne    c00219a4 <get_pte+0x5d>
c002199a:	b8 00 00 00 00       	mov    eax,0x0
c002199f:	e9 ee 00 00 00       	jmp    c0021a92 <get_pte+0x14b>
c00219a4:	e8 b8 f8 ff ff       	call   c0021261 <pmm_alloc_frame>
c00219a9:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c00219ac:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
c00219b0:	75 0a                	jne    c00219bc <get_pte+0x75>
c00219b2:	b8 00 00 00 00       	mov    eax,0x0
c00219b7:	e9 d6 00 00 00       	jmp    c0021a92 <get_pte+0x14b>
c00219bc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c00219bf:	c1 e8 0c             	shr    eax,0xc
c00219c2:	25 ff ff 0f 00       	and    eax,0xfffff
c00219c7:	89 c2                	mov    edx,eax
c00219c9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00219cc:	89 d1                	mov    ecx,edx
c00219ce:	81 e1 ff ff 0f 00    	and    ecx,0xfffff
c00219d4:	8b 10                	mov    edx,DWORD PTR [eax]
c00219d6:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c00219dc:	09 ca                	or     edx,ecx
c00219de:	89 10                	mov    DWORD PTR [eax],edx
c00219e0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00219e3:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c00219e7:	83 ca 10             	or     edx,0x10
c00219ea:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c00219ed:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c00219f0:	d1 e8                	shr    eax,1
c00219f2:	83 e0 01             	and    eax,0x1
c00219f5:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c00219f8:	83 e0 01             	and    eax,0x1
c00219fb:	c1 e0 05             	shl    eax,0x5
c00219fe:	89 c1                	mov    ecx,eax
c0021a00:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021a04:	83 e0 df             	and    eax,0xffffffdf
c0021a07:	09 c8                	or     eax,ecx
c0021a09:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021a0c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021a0f:	c1 e8 02             	shr    eax,0x2
c0021a12:	83 e0 01             	and    eax,0x1
c0021a15:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021a18:	83 e0 01             	and    eax,0x1
c0021a1b:	c1 e0 06             	shl    eax,0x6
c0021a1e:	89 c1                	mov    ecx,eax
c0021a20:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021a24:	83 e0 bf             	and    eax,0xffffffbf
c0021a27:	09 c8                	or     eax,ecx
c0021a29:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021a2c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021a2f:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021a33:	83 e2 f7             	and    edx,0xfffffff7
c0021a36:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021a39:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0021a3c:	2d 00 00 00 40       	sub    eax,0x40000000
c0021a41:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0021a44:	83 ec 04             	sub    esp,0x4
c0021a47:	68 00 10 00 00       	push   0x1000
c0021a4c:	6a 00                	push   0x0
c0021a4e:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c0021a51:	e8 52 fb ff ff       	call   c00215a8 <memset>
c0021a56:	83 c4 10             	add    esp,0x10
c0021a59:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021a5c:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021a60:	83 e0 08             	and    eax,0x8
c0021a63:	84 c0                	test   al,al
c0021a65:	74 07                	je     c0021a6e <get_pte+0x127>
c0021a67:	b8 00 00 00 00       	mov    eax,0x0
c0021a6c:	eb 24                	jmp    c0021a92 <get_pte+0x14b>
c0021a6e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021a71:	8b 00                	mov    eax,DWORD PTR [eax]
c0021a73:	25 ff ff 0f 00       	and    eax,0xfffff
c0021a78:	c1 e0 0c             	shl    eax,0xc
c0021a7b:	2d 00 00 00 40       	sub    eax,0x40000000
c0021a80:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0021a83:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021a86:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021a8d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
c0021a90:	01 d0                	add    eax,edx
c0021a92:	c9                   	leave
c0021a93:	c3                   	ret

c0021a94 <paging_map_page>:
c0021a94:	55                   	push   ebp
c0021a95:	89 e5                	mov    ebp,esp
c0021a97:	83 ec 18             	sub    esp,0x18
c0021a9a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021a9d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021aa0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0021aa3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021aa6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021aa9:	25 ff 0f 00 00       	and    eax,0xfff
c0021aae:	85 c0                	test   eax,eax
c0021ab0:	75 0c                	jne    c0021abe <paging_map_page+0x2a>
c0021ab2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021ab5:	25 ff 0f 00 00       	and    eax,0xfff
c0021aba:	85 c0                	test   eax,eax
c0021abc:	74 0a                	je     c0021ac8 <paging_map_page+0x34>
c0021abe:	b8 00 00 00 00       	mov    eax,0x0
c0021ac3:	e9 2b 01 00 00       	jmp    c0021bf3 <paging_map_page+0x15f>
c0021ac8:	ff 75 14             	push   DWORD PTR [ebp+0x14]
c0021acb:	6a 01                	push   0x1
c0021acd:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0021ad0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0021ad3:	e8 6f fe ff ff       	call   c0021947 <get_pte>
c0021ad8:	83 c4 10             	add    esp,0x10
c0021adb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021ade:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
c0021ae2:	75 0a                	jne    c0021aee <paging_map_page+0x5a>
c0021ae4:	b8 00 00 00 00       	mov    eax,0x0
c0021ae9:	e9 05 01 00 00       	jmp    c0021bf3 <paging_map_page+0x15f>
c0021aee:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021af1:	c1 e8 0c             	shr    eax,0xc
c0021af4:	25 ff ff 0f 00       	and    eax,0xfffff
c0021af9:	89 c2                	mov    edx,eax
c0021afb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021afe:	89 d1                	mov    ecx,edx
c0021b00:	81 e1 ff ff 0f 00    	and    ecx,0xfffff
c0021b06:	8b 10                	mov    edx,DWORD PTR [eax]
c0021b08:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0021b0e:	09 ca                	or     edx,ecx
c0021b10:	89 10                	mov    DWORD PTR [eax],edx
c0021b12:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021b15:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0021b19:	83 ca 10             	or     edx,0x10
c0021b1c:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c0021b1f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021b22:	d1 e8                	shr    eax,1
c0021b24:	83 e0 01             	and    eax,0x1
c0021b27:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021b2a:	83 e0 01             	and    eax,0x1
c0021b2d:	c1 e0 05             	shl    eax,0x5
c0021b30:	89 c1                	mov    ecx,eax
c0021b32:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021b36:	83 e0 df             	and    eax,0xffffffdf
c0021b39:	09 c8                	or     eax,ecx
c0021b3b:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021b3e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021b41:	c1 e8 02             	shr    eax,0x2
c0021b44:	83 e0 01             	and    eax,0x1
c0021b47:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021b4a:	83 e0 01             	and    eax,0x1
c0021b4d:	c1 e0 06             	shl    eax,0x6
c0021b50:	89 c1                	mov    ecx,eax
c0021b52:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021b56:	83 e0 bf             	and    eax,0xffffffbf
c0021b59:	09 c8                	or     eax,ecx
c0021b5b:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021b5e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021b61:	c1 e8 03             	shr    eax,0x3
c0021b64:	83 e0 01             	and    eax,0x1
c0021b67:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021b6a:	c1 e0 07             	shl    eax,0x7
c0021b6d:	89 c1                	mov    ecx,eax
c0021b6f:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021b73:	83 e0 7f             	and    eax,0x7f
c0021b76:	09 c8                	or     eax,ecx
c0021b78:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021b7b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021b7e:	c1 e8 04             	shr    eax,0x4
c0021b81:	83 e0 01             	and    eax,0x1
c0021b84:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021b87:	83 e0 01             	and    eax,0x1
c0021b8a:	89 c1                	mov    ecx,eax
c0021b8c:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0021b90:	83 e0 fe             	and    eax,0xfffffffe
c0021b93:	09 c8                	or     eax,ecx
c0021b95:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0021b98:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021b9b:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021b9f:	83 e2 fd             	and    edx,0xfffffffd
c0021ba2:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021ba5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021ba8:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021bac:	83 e2 fb             	and    edx,0xfffffffb
c0021baf:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021bb2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021bb5:	c1 e8 05             	shr    eax,0x5
c0021bb8:	83 e0 01             	and    eax,0x1
c0021bbb:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021bbe:	83 e0 01             	and    eax,0x1
c0021bc1:	c1 e0 04             	shl    eax,0x4
c0021bc4:	89 c1                	mov    ecx,eax
c0021bc6:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0021bca:	83 e0 ef             	and    eax,0xffffffef
c0021bcd:	09 c8                	or     eax,ecx
c0021bcf:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0021bd2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021bd5:	c1 e8 0c             	shr    eax,0xc
c0021bd8:	25 ff 03 00 00       	and    eax,0x3ff
c0021bdd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021be0:	83 ec 0c             	sub    esp,0xc
c0021be3:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
c0021be6:	e8 55 18 00 00       	call   c0023440 <invalidate_table_TLB>
c0021beb:	83 c4 10             	add    esp,0x10
c0021bee:	b8 01 00 00 00       	mov    eax,0x1
c0021bf3:	c9                   	leave
c0021bf4:	c3                   	ret

c0021bf5 <paging_map_large_page>:
c0021bf5:	55                   	push   ebp
c0021bf6:	89 e5                	mov    ebp,esp
c0021bf8:	83 ec 18             	sub    esp,0x18
c0021bfb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021bfe:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021c01:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0021c04:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021c07:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021c0a:	25 ff ff 3f 00       	and    eax,0x3fffff
c0021c0f:	85 c0                	test   eax,eax
c0021c11:	75 0c                	jne    c0021c1f <paging_map_large_page+0x2a>
c0021c13:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021c16:	25 ff ff 3f 00       	and    eax,0x3fffff
c0021c1b:	85 c0                	test   eax,eax
c0021c1d:	74 0a                	je     c0021c29 <paging_map_large_page+0x34>
c0021c1f:	b8 00 00 00 00       	mov    eax,0x0
c0021c24:	e9 45 01 00 00       	jmp    c0021d6e <paging_map_large_page+0x179>
c0021c29:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021c2c:	c1 e8 16             	shr    eax,0x16
c0021c2f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021c32:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021c35:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021c3c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021c3f:	01 d0                	add    eax,edx
c0021c41:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021c44:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021c47:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021c4b:	83 e0 10             	and    eax,0x10
c0021c4e:	84 c0                	test   al,al
c0021c50:	74 18                	je     c0021c6a <paging_map_large_page+0x75>
c0021c52:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021c55:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021c59:	83 e0 08             	and    eax,0x8
c0021c5c:	84 c0                	test   al,al
c0021c5e:	75 0a                	jne    c0021c6a <paging_map_large_page+0x75>
c0021c60:	b8 00 00 00 00       	mov    eax,0x0
c0021c65:	e9 04 01 00 00       	jmp    c0021d6e <paging_map_large_page+0x179>
c0021c6a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021c6d:	c1 e8 16             	shr    eax,0x16
c0021c70:	25 ff ff 0f 00       	and    eax,0xfffff
c0021c75:	89 c2                	mov    edx,eax
c0021c77:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021c7a:	89 d1                	mov    ecx,edx
c0021c7c:	81 e1 ff ff 0f 00    	and    ecx,0xfffff
c0021c82:	8b 10                	mov    edx,DWORD PTR [eax]
c0021c84:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0021c8a:	09 ca                	or     edx,ecx
c0021c8c:	89 10                	mov    DWORD PTR [eax],edx
c0021c8e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021c91:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0021c95:	83 ca 10             	or     edx,0x10
c0021c98:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c0021c9b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021c9e:	d1 e8                	shr    eax,1
c0021ca0:	83 e0 01             	and    eax,0x1
c0021ca3:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021ca6:	83 e0 01             	and    eax,0x1
c0021ca9:	c1 e0 05             	shl    eax,0x5
c0021cac:	89 c1                	mov    ecx,eax
c0021cae:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021cb2:	83 e0 df             	and    eax,0xffffffdf
c0021cb5:	09 c8                	or     eax,ecx
c0021cb7:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021cba:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021cbd:	c1 e8 02             	shr    eax,0x2
c0021cc0:	83 e0 01             	and    eax,0x1
c0021cc3:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021cc6:	83 e0 01             	and    eax,0x1
c0021cc9:	c1 e0 06             	shl    eax,0x6
c0021ccc:	89 c1                	mov    ecx,eax
c0021cce:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021cd2:	83 e0 bf             	and    eax,0xffffffbf
c0021cd5:	09 c8                	or     eax,ecx
c0021cd7:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021cda:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021cdd:	c1 e8 03             	shr    eax,0x3
c0021ce0:	83 e0 01             	and    eax,0x1
c0021ce3:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021ce6:	c1 e0 07             	shl    eax,0x7
c0021ce9:	89 c1                	mov    ecx,eax
c0021ceb:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0021cef:	83 e0 7f             	and    eax,0x7f
c0021cf2:	09 c8                	or     eax,ecx
c0021cf4:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0021cf7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021cfa:	c1 e8 04             	shr    eax,0x4
c0021cfd:	83 e0 01             	and    eax,0x1
c0021d00:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021d03:	83 e0 01             	and    eax,0x1
c0021d06:	89 c1                	mov    ecx,eax
c0021d08:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0021d0c:	83 e0 fe             	and    eax,0xfffffffe
c0021d0f:	09 c8                	or     eax,ecx
c0021d11:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0021d14:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021d17:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021d1b:	83 e2 fd             	and    edx,0xfffffffd
c0021d1e:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021d21:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021d24:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021d28:	83 ca 04             	or     edx,0x4
c0021d2b:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021d2e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021d31:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0021d35:	83 ca 08             	or     edx,0x8
c0021d38:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0021d3b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0021d3e:	c1 e8 05             	shr    eax,0x5
c0021d41:	83 e0 01             	and    eax,0x1
c0021d44:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0021d47:	83 e0 01             	and    eax,0x1
c0021d4a:	c1 e0 04             	shl    eax,0x4
c0021d4d:	89 c1                	mov    ecx,eax
c0021d4f:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0021d53:	83 e0 ef             	and    eax,0xffffffef
c0021d56:	09 c8                	or     eax,ecx
c0021d58:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0021d5b:	83 ec 0c             	sub    esp,0xc
c0021d5e:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c0021d61:	e8 e5 16 00 00       	call   c002344b <invalidate_directory_TLB>
c0021d66:	83 c4 10             	add    esp,0x10
c0021d69:	b8 01 00 00 00       	mov    eax,0x1
c0021d6e:	c9                   	leave
c0021d6f:	c3                   	ret

c0021d70 <paging_unmap_page>:
c0021d70:	55                   	push   ebp
c0021d71:	89 e5                	mov    ebp,esp
c0021d73:	83 ec 28             	sub    esp,0x28
c0021d76:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021d79:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021d7c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021d7f:	c1 e8 16             	shr    eax,0x16
c0021d82:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021d85:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021d88:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021d8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021d92:	01 d0                	add    eax,edx
c0021d94:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021d97:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021d9a:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021d9e:	83 e0 10             	and    eax,0x10
c0021da1:	84 c0                	test   al,al
c0021da3:	75 0a                	jne    c0021daf <paging_unmap_page+0x3f>
c0021da5:	b8 01 00 00 00       	mov    eax,0x1
c0021daa:	e9 a8 00 00 00       	jmp    c0021e57 <paging_unmap_page+0xe7>
c0021daf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021db2:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021db6:	83 e0 08             	and    eax,0x8
c0021db9:	84 c0                	test   al,al
c0021dbb:	74 2f                	je     c0021dec <paging_unmap_page+0x7c>
c0021dbd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021dc0:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0021dc4:	83 e2 ef             	and    edx,0xffffffef
c0021dc7:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c0021dca:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021dcd:	8b 10                	mov    edx,DWORD PTR [eax]
c0021dcf:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0021dd5:	89 10                	mov    DWORD PTR [eax],edx
c0021dd7:	83 ec 0c             	sub    esp,0xc
c0021dda:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0021ddd:	e8 69 16 00 00       	call   c002344b <invalidate_directory_TLB>
c0021de2:	83 c4 10             	add    esp,0x10
c0021de5:	b8 01 00 00 00       	mov    eax,0x1
c0021dea:	eb 6b                	jmp    c0021e57 <paging_unmap_page+0xe7>
c0021dec:	6a 00                	push   0x0
c0021dee:	6a 00                	push   0x0
c0021df0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0021df3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0021df6:	e8 4c fb ff ff       	call   c0021947 <get_pte>
c0021dfb:	83 c4 10             	add    esp,0x10
c0021dfe:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021e01:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c0021e05:	74 0e                	je     c0021e15 <paging_unmap_page+0xa5>
c0021e07:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021e0a:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021e0e:	83 e0 10             	and    eax,0x10
c0021e11:	84 c0                	test   al,al
c0021e13:	75 07                	jne    c0021e1c <paging_unmap_page+0xac>
c0021e15:	b8 01 00 00 00       	mov    eax,0x1
c0021e1a:	eb 3b                	jmp    c0021e57 <paging_unmap_page+0xe7>
c0021e1c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021e1f:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0021e23:	83 e2 ef             	and    edx,0xffffffef
c0021e26:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c0021e29:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021e2c:	8b 10                	mov    edx,DWORD PTR [eax]
c0021e2e:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0021e34:	89 10                	mov    DWORD PTR [eax],edx
c0021e36:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021e39:	c1 e8 0c             	shr    eax,0xc
c0021e3c:	25 ff 03 00 00       	and    eax,0x3ff
c0021e41:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0021e44:	83 ec 0c             	sub    esp,0xc
c0021e47:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c0021e4a:	e8 f1 15 00 00       	call   c0023440 <invalidate_table_TLB>
c0021e4f:	83 c4 10             	add    esp,0x10
c0021e52:	b8 01 00 00 00       	mov    eax,0x1
c0021e57:	c9                   	leave
c0021e58:	c3                   	ret

c0021e59 <paging_get_physical_address>:
c0021e59:	55                   	push   ebp
c0021e5a:	89 e5                	mov    ebp,esp
c0021e5c:	83 ec 28             	sub    esp,0x28
c0021e5f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021e62:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021e65:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021e68:	c1 e8 16             	shr    eax,0x16
c0021e6b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021e6e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021e71:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021e78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021e7b:	01 d0                	add    eax,edx
c0021e7d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021e80:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021e83:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021e87:	83 e0 10             	and    eax,0x10
c0021e8a:	84 c0                	test   al,al
c0021e8c:	75 0a                	jne    c0021e98 <paging_get_physical_address+0x3f>
c0021e8e:	b8 00 00 00 00       	mov    eax,0x0
c0021e93:	e9 86 00 00 00       	jmp    c0021f1e <paging_get_physical_address+0xc5>
c0021e98:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021e9b:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021e9f:	83 e0 08             	and    eax,0x8
c0021ea2:	84 c0                	test   al,al
c0021ea4:	74 25                	je     c0021ecb <paging_get_physical_address+0x72>
c0021ea6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021ea9:	8b 00                	mov    eax,DWORD PTR [eax]
c0021eab:	25 ff ff 0f 00       	and    eax,0xfffff
c0021eb0:	c1 e0 16             	shl    eax,0x16
c0021eb3:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0021eb6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021eb9:	25 ff ff 3f 00       	and    eax,0x3fffff
c0021ebe:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c0021ec1:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
c0021ec4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0021ec7:	01 d0                	add    eax,edx
c0021ec9:	eb 53                	jmp    c0021f1e <paging_get_physical_address+0xc5>
c0021ecb:	6a 00                	push   0x0
c0021ecd:	6a 00                	push   0x0
c0021ecf:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0021ed2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0021ed5:	e8 6d fa ff ff       	call   c0021947 <get_pte>
c0021eda:	83 c4 10             	add    esp,0x10
c0021edd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021ee0:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c0021ee4:	74 0e                	je     c0021ef4 <paging_get_physical_address+0x9b>
c0021ee6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021ee9:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021eed:	83 e0 10             	and    eax,0x10
c0021ef0:	84 c0                	test   al,al
c0021ef2:	75 07                	jne    c0021efb <paging_get_physical_address+0xa2>
c0021ef4:	b8 00 00 00 00       	mov    eax,0x0
c0021ef9:	eb 23                	jmp    c0021f1e <paging_get_physical_address+0xc5>
c0021efb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021efe:	8b 00                	mov    eax,DWORD PTR [eax]
c0021f00:	25 ff ff 0f 00       	and    eax,0xfffff
c0021f05:	c1 e0 0c             	shl    eax,0xc
c0021f08:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0021f0b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021f0e:	25 ff 0f 00 00       	and    eax,0xfff
c0021f13:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0021f16:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
c0021f19:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0021f1c:	01 d0                	add    eax,edx
c0021f1e:	c9                   	leave
c0021f1f:	c3                   	ret

c0021f20 <paging_is_mapped>:
c0021f20:	55                   	push   ebp
c0021f21:	89 e5                	mov    ebp,esp
c0021f23:	83 ec 18             	sub    esp,0x18
c0021f26:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021f29:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021f2c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021f2f:	c1 e8 16             	shr    eax,0x16
c0021f32:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021f35:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021f38:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021f3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021f42:	01 d0                	add    eax,edx
c0021f44:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021f47:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021f4a:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021f4e:	83 e0 10             	and    eax,0x10
c0021f51:	84 c0                	test   al,al
c0021f53:	75 07                	jne    c0021f5c <paging_is_mapped+0x3c>
c0021f55:	b8 00 00 00 00       	mov    eax,0x0
c0021f5a:	eb 4a                	jmp    c0021fa6 <paging_is_mapped+0x86>
c0021f5c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021f5f:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021f63:	83 e0 08             	and    eax,0x8
c0021f66:	84 c0                	test   al,al
c0021f68:	74 07                	je     c0021f71 <paging_is_mapped+0x51>
c0021f6a:	b8 01 00 00 00       	mov    eax,0x1
c0021f6f:	eb 35                	jmp    c0021fa6 <paging_is_mapped+0x86>
c0021f71:	6a 00                	push   0x0
c0021f73:	6a 00                	push   0x0
c0021f75:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0021f78:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0021f7b:	e8 c7 f9 ff ff       	call   c0021947 <get_pte>
c0021f80:	83 c4 10             	add    esp,0x10
c0021f83:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0021f86:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c0021f8a:	74 15                	je     c0021fa1 <paging_is_mapped+0x81>
c0021f8c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0021f8f:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021f93:	83 e0 10             	and    eax,0x10
c0021f96:	84 c0                	test   al,al
c0021f98:	74 07                	je     c0021fa1 <paging_is_mapped+0x81>
c0021f9a:	b8 01 00 00 00       	mov    eax,0x1
c0021f9f:	eb 05                	jmp    c0021fa6 <paging_is_mapped+0x86>
c0021fa1:	b8 00 00 00 00       	mov    eax,0x0
c0021fa6:	c9                   	leave
c0021fa7:	c3                   	ret

c0021fa8 <paging_set_flags>:
c0021fa8:	55                   	push   ebp
c0021fa9:	89 e5                	mov    ebp,esp
c0021fab:	83 ec 28             	sub    esp,0x28
c0021fae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0021fb1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0021fb4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0021fb7:	c1 e8 16             	shr    eax,0x16
c0021fba:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0021fbd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0021fc0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0021fc7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0021fca:	01 d0                	add    eax,edx
c0021fcc:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0021fcf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021fd2:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0021fd6:	83 e0 10             	and    eax,0x10
c0021fd9:	84 c0                	test   al,al
c0021fdb:	0f 84 a6 01 00 00    	je     c0022187 <paging_set_flags+0x1df>
c0021fe1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0021fe4:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0021fe8:	83 e0 08             	and    eax,0x8
c0021feb:	84 c0                	test   al,al
c0021fed:	0f 84 ac 00 00 00    	je     c002209f <paging_set_flags+0xf7>
c0021ff3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0021ff6:	d1 e8                	shr    eax,1
c0021ff8:	83 e0 01             	and    eax,0x1
c0021ffb:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0021ffe:	83 e0 01             	and    eax,0x1
c0022001:	c1 e0 05             	shl    eax,0x5
c0022004:	89 c1                	mov    ecx,eax
c0022006:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c002200a:	83 e0 df             	and    eax,0xffffffdf
c002200d:	09 c8                	or     eax,ecx
c002200f:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0022012:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0022015:	c1 e8 02             	shr    eax,0x2
c0022018:	83 e0 01             	and    eax,0x1
c002201b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c002201e:	83 e0 01             	and    eax,0x1
c0022021:	c1 e0 06             	shl    eax,0x6
c0022024:	89 c1                	mov    ecx,eax
c0022026:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c002202a:	83 e0 bf             	and    eax,0xffffffbf
c002202d:	09 c8                	or     eax,ecx
c002202f:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0022032:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0022035:	c1 e8 03             	shr    eax,0x3
c0022038:	83 e0 01             	and    eax,0x1
c002203b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c002203e:	c1 e0 07             	shl    eax,0x7
c0022041:	89 c1                	mov    ecx,eax
c0022043:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0022047:	83 e0 7f             	and    eax,0x7f
c002204a:	09 c8                	or     eax,ecx
c002204c:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c002204f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0022052:	c1 e8 04             	shr    eax,0x4
c0022055:	83 e0 01             	and    eax,0x1
c0022058:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c002205b:	83 e0 01             	and    eax,0x1
c002205e:	89 c1                	mov    ecx,eax
c0022060:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0022064:	83 e0 fe             	and    eax,0xfffffffe
c0022067:	09 c8                	or     eax,ecx
c0022069:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c002206c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002206f:	c1 e8 05             	shr    eax,0x5
c0022072:	83 e0 01             	and    eax,0x1
c0022075:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0022078:	83 e0 01             	and    eax,0x1
c002207b:	c1 e0 04             	shl    eax,0x4
c002207e:	89 c1                	mov    ecx,eax
c0022080:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0022084:	83 e0 ef             	and    eax,0xffffffef
c0022087:	09 c8                	or     eax,ecx
c0022089:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c002208c:	83 ec 0c             	sub    esp,0xc
c002208f:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022092:	e8 b4 13 00 00       	call   c002344b <invalidate_directory_TLB>
c0022097:	83 c4 10             	add    esp,0x10
c002209a:	e9 ec 00 00 00       	jmp    c002218b <paging_set_flags+0x1e3>
c002209f:	6a 00                	push   0x0
c00220a1:	6a 00                	push   0x0
c00220a3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c00220a6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c00220a9:	e8 99 f8 ff ff       	call   c0021947 <get_pte>
c00220ae:	83 c4 10             	add    esp,0x10
c00220b1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00220b4:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c00220b8:	0f 84 cc 00 00 00    	je     c002218a <paging_set_flags+0x1e2>
c00220be:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00220c1:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00220c5:	83 e0 10             	and    eax,0x10
c00220c8:	84 c0                	test   al,al
c00220ca:	0f 84 ba 00 00 00    	je     c002218a <paging_set_flags+0x1e2>
c00220d0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c00220d3:	d1 e8                	shr    eax,1
c00220d5:	83 e0 01             	and    eax,0x1
c00220d8:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c00220db:	83 e0 01             	and    eax,0x1
c00220de:	c1 e0 05             	shl    eax,0x5
c00220e1:	89 c1                	mov    ecx,eax
c00220e3:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c00220e7:	83 e0 df             	and    eax,0xffffffdf
c00220ea:	09 c8                	or     eax,ecx
c00220ec:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c00220ef:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c00220f2:	c1 e8 02             	shr    eax,0x2
c00220f5:	83 e0 01             	and    eax,0x1
c00220f8:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c00220fb:	83 e0 01             	and    eax,0x1
c00220fe:	c1 e0 06             	shl    eax,0x6
c0022101:	89 c1                	mov    ecx,eax
c0022103:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0022107:	83 e0 bf             	and    eax,0xffffffbf
c002210a:	09 c8                	or     eax,ecx
c002210c:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c002210f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0022112:	c1 e8 03             	shr    eax,0x3
c0022115:	83 e0 01             	and    eax,0x1
c0022118:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c002211b:	c1 e0 07             	shl    eax,0x7
c002211e:	89 c1                	mov    ecx,eax
c0022120:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0022124:	83 e0 7f             	and    eax,0x7f
c0022127:	09 c8                	or     eax,ecx
c0022129:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c002212c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002212f:	c1 e8 04             	shr    eax,0x4
c0022132:	83 e0 01             	and    eax,0x1
c0022135:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0022138:	83 e0 01             	and    eax,0x1
c002213b:	89 c1                	mov    ecx,eax
c002213d:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0022141:	83 e0 fe             	and    eax,0xfffffffe
c0022144:	09 c8                	or     eax,ecx
c0022146:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0022149:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002214c:	c1 e8 05             	shr    eax,0x5
c002214f:	83 e0 01             	and    eax,0x1
c0022152:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
c0022155:	83 e0 01             	and    eax,0x1
c0022158:	c1 e0 04             	shl    eax,0x4
c002215b:	89 c1                	mov    ecx,eax
c002215d:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c0022161:	83 e0 ef             	and    eax,0xffffffef
c0022164:	09 c8                	or     eax,ecx
c0022166:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c0022169:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002216c:	c1 e8 0c             	shr    eax,0xc
c002216f:	25 ff 03 00 00       	and    eax,0x3ff
c0022174:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0022177:	83 ec 0c             	sub    esp,0xc
c002217a:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c002217d:	e8 be 12 00 00       	call   c0023440 <invalidate_table_TLB>
c0022182:	83 c4 10             	add    esp,0x10
c0022185:	eb 04                	jmp    c002218b <paging_set_flags+0x1e3>
c0022187:	90                   	nop
c0022188:	eb 01                	jmp    c002218b <paging_set_flags+0x1e3>
c002218a:	90                   	nop
c002218b:	c9                   	leave
c002218c:	c3                   	ret

c002218d <paging_get_flags>:
c002218d:	55                   	push   ebp
c002218e:	89 e5                	mov    ebp,esp
c0022190:	83 ec 28             	sub    esp,0x28
c0022193:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022196:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0022199:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002219c:	c1 e8 16             	shr    eax,0x16
c002219f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00221a2:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c00221a9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c00221ac:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00221b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00221b6:	01 d0                	add    eax,edx
c00221b8:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00221bb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00221be:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00221c2:	83 e0 10             	and    eax,0x10
c00221c5:	84 c0                	test   al,al
c00221c7:	75 0a                	jne    c00221d3 <paging_get_flags+0x46>
c00221c9:	b8 00 00 00 00       	mov    eax,0x0
c00221ce:	e9 22 01 00 00       	jmp    c00222f5 <paging_get_flags+0x168>
c00221d3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00221d6:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00221da:	83 e0 08             	and    eax,0x8
c00221dd:	84 c0                	test   al,al
c00221df:	74 75                	je     c0022256 <paging_get_flags+0xc9>
c00221e1:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00221e4:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00221e8:	83 e0 10             	and    eax,0x10
c00221eb:	84 c0                	test   al,al
c00221ed:	74 04                	je     c00221f3 <paging_get_flags+0x66>
c00221ef:	83 4d f4 01          	or     DWORD PTR [ebp-0xc],0x1
c00221f3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00221f6:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00221fa:	83 e0 20             	and    eax,0x20
c00221fd:	84 c0                	test   al,al
c00221ff:	74 04                	je     c0022205 <paging_get_flags+0x78>
c0022201:	83 4d f4 02          	or     DWORD PTR [ebp-0xc],0x2
c0022205:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022208:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c002220c:	83 e0 40             	and    eax,0x40
c002220f:	84 c0                	test   al,al
c0022211:	74 04                	je     c0022217 <paging_get_flags+0x8a>
c0022213:	83 4d f4 04          	or     DWORD PTR [ebp-0xc],0x4
c0022217:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c002221a:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c002221e:	83 e0 80             	and    eax,0xffffff80
c0022221:	84 c0                	test   al,al
c0022223:	74 04                	je     c0022229 <paging_get_flags+0x9c>
c0022225:	83 4d f4 08          	or     DWORD PTR [ebp-0xc],0x8
c0022229:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c002222c:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022230:	83 e0 01             	and    eax,0x1
c0022233:	84 c0                	test   al,al
c0022235:	74 04                	je     c002223b <paging_get_flags+0xae>
c0022237:	83 4d f4 10          	or     DWORD PTR [ebp-0xc],0x10
c002223b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c002223e:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022242:	83 e0 10             	and    eax,0x10
c0022245:	84 c0                	test   al,al
c0022247:	0f 84 a5 00 00 00    	je     c00222f2 <paging_get_flags+0x165>
c002224d:	83 4d f4 20          	or     DWORD PTR [ebp-0xc],0x20
c0022251:	e9 9c 00 00 00       	jmp    c00222f2 <paging_get_flags+0x165>
c0022256:	6a 00                	push   0x0
c0022258:	6a 00                	push   0x0
c002225a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c002225d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0022260:	e8 e2 f6 ff ff       	call   c0021947 <get_pte>
c0022265:	83 c4 10             	add    esp,0x10
c0022268:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c002226b:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
c002226f:	74 0e                	je     c002227f <paging_get_flags+0xf2>
c0022271:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022274:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022278:	83 e0 10             	and    eax,0x10
c002227b:	84 c0                	test   al,al
c002227d:	75 07                	jne    c0022286 <paging_get_flags+0xf9>
c002227f:	b8 00 00 00 00       	mov    eax,0x0
c0022284:	eb 6f                	jmp    c00222f5 <paging_get_flags+0x168>
c0022286:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022289:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c002228d:	83 e0 10             	and    eax,0x10
c0022290:	84 c0                	test   al,al
c0022292:	74 04                	je     c0022298 <paging_get_flags+0x10b>
c0022294:	83 4d f4 01          	or     DWORD PTR [ebp-0xc],0x1
c0022298:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c002229b:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c002229f:	83 e0 20             	and    eax,0x20
c00222a2:	84 c0                	test   al,al
c00222a4:	74 04                	je     c00222aa <paging_get_flags+0x11d>
c00222a6:	83 4d f4 02          	or     DWORD PTR [ebp-0xc],0x2
c00222aa:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c00222ad:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00222b1:	83 e0 40             	and    eax,0x40
c00222b4:	84 c0                	test   al,al
c00222b6:	74 04                	je     c00222bc <paging_get_flags+0x12f>
c00222b8:	83 4d f4 04          	or     DWORD PTR [ebp-0xc],0x4
c00222bc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c00222bf:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00222c3:	83 e0 80             	and    eax,0xffffff80
c00222c6:	84 c0                	test   al,al
c00222c8:	74 04                	je     c00222ce <paging_get_flags+0x141>
c00222ca:	83 4d f4 08          	or     DWORD PTR [ebp-0xc],0x8
c00222ce:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c00222d1:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00222d5:	83 e0 01             	and    eax,0x1
c00222d8:	84 c0                	test   al,al
c00222da:	74 04                	je     c00222e0 <paging_get_flags+0x153>
c00222dc:	83 4d f4 10          	or     DWORD PTR [ebp-0xc],0x10
c00222e0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c00222e3:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00222e7:	83 e0 10             	and    eax,0x10
c00222ea:	84 c0                	test   al,al
c00222ec:	74 04                	je     c00222f2 <paging_get_flags+0x165>
c00222ee:	83 4d f4 20          	or     DWORD PTR [ebp-0xc],0x20
c00222f2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00222f5:	c9                   	leave
c00222f6:	c3                   	ret

c00222f7 <paging_set_permissions>:
c00222f7:	55                   	push   ebp
c00222f8:	89 e5                	mov    ebp,esp
c00222fa:	83 ec 38             	sub    esp,0x38
c00222fd:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
c0022300:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
c0022303:	88 55 d4             	mov    BYTE PTR [ebp-0x2c],dl
c0022306:	88 45 d0             	mov    BYTE PTR [ebp-0x30],al
c0022309:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c002230c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002230f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022312:	c1 e8 16             	shr    eax,0x16
c0022315:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0022318:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002231b:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022322:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022325:	01 d0                	add    eax,edx
c0022327:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c002232a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002232d:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022331:	83 e0 10             	and    eax,0x10
c0022334:	84 c0                	test   al,al
c0022336:	75 0a                	jne    c0022342 <paging_set_permissions+0x4b>
c0022338:	b8 00 00 00 00       	mov    eax,0x0
c002233d:	e9 ea 00 00 00       	jmp    c002242c <paging_set_permissions+0x135>
c0022342:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022345:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022349:	83 e0 08             	and    eax,0x8
c002234c:	84 c0                	test   al,al
c002234e:	74 4f                	je     c002239f <paging_set_permissions+0xa8>
c0022350:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
c0022354:	0f 95 c2             	setne  dl
c0022357:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002235a:	83 e2 01             	and    edx,0x1
c002235d:	89 d1                	mov    ecx,edx
c002235f:	c1 e1 05             	shl    ecx,0x5
c0022362:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0022366:	83 e2 df             	and    edx,0xffffffdf
c0022369:	09 ca                	or     edx,ecx
c002236b:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c002236e:	80 7d d0 00          	cmp    BYTE PTR [ebp-0x30],0x0
c0022372:	0f 95 c2             	setne  dl
c0022375:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022378:	83 e2 01             	and    edx,0x1
c002237b:	89 d1                	mov    ecx,edx
c002237d:	c1 e1 06             	shl    ecx,0x6
c0022380:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0022384:	83 e2 bf             	and    edx,0xffffffbf
c0022387:	09 ca                	or     edx,ecx
c0022389:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c002238c:	83 ec 0c             	sub    esp,0xc
c002238f:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022392:	e8 b4 10 00 00       	call   c002344b <invalidate_directory_TLB>
c0022397:	83 c4 10             	add    esp,0x10
c002239a:	e9 88 00 00 00       	jmp    c0022427 <paging_set_permissions+0x130>
c002239f:	6a 00                	push   0x0
c00223a1:	6a 00                	push   0x0
c00223a3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c00223a6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c00223a9:	e8 99 f5 ff ff       	call   c0021947 <get_pte>
c00223ae:	83 c4 10             	add    esp,0x10
c00223b1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00223b4:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c00223b8:	74 0e                	je     c00223c8 <paging_set_permissions+0xd1>
c00223ba:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00223bd:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00223c1:	83 e0 10             	and    eax,0x10
c00223c4:	84 c0                	test   al,al
c00223c6:	75 07                	jne    c00223cf <paging_set_permissions+0xd8>
c00223c8:	b8 00 00 00 00       	mov    eax,0x0
c00223cd:	eb 5d                	jmp    c002242c <paging_set_permissions+0x135>
c00223cf:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
c00223d3:	0f 95 c2             	setne  dl
c00223d6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00223d9:	83 e2 01             	and    edx,0x1
c00223dc:	89 d1                	mov    ecx,edx
c00223de:	c1 e1 05             	shl    ecx,0x5
c00223e1:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c00223e5:	83 e2 df             	and    edx,0xffffffdf
c00223e8:	09 ca                	or     edx,ecx
c00223ea:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c00223ed:	80 7d d0 00          	cmp    BYTE PTR [ebp-0x30],0x0
c00223f1:	0f 95 c2             	setne  dl
c00223f4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00223f7:	83 e2 01             	and    edx,0x1
c00223fa:	89 d1                	mov    ecx,edx
c00223fc:	c1 e1 06             	shl    ecx,0x6
c00223ff:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0022403:	83 e2 bf             	and    edx,0xffffffbf
c0022406:	09 ca                	or     edx,ecx
c0022408:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c002240b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002240e:	c1 e8 0c             	shr    eax,0xc
c0022411:	25 ff 03 00 00       	and    eax,0x3ff
c0022416:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0022419:	83 ec 0c             	sub    esp,0xc
c002241c:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c002241f:	e8 1c 10 00 00       	call   c0023440 <invalidate_table_TLB>
c0022424:	83 c4 10             	add    esp,0x10
c0022427:	b8 01 00 00 00       	mov    eax,0x1
c002242c:	c9                   	leave
c002242d:	c3                   	ret

c002242e <paging_set_global>:
c002242e:	55                   	push   ebp
c002242f:	89 e5                	mov    ebp,esp
c0022431:	83 ec 38             	sub    esp,0x38
c0022434:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c0022437:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
c002243a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c002243d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0022440:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022443:	c1 e8 16             	shr    eax,0x16
c0022446:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0022449:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002244c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022453:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022456:	01 d0                	add    eax,edx
c0022458:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c002245b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002245e:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022462:	83 e0 10             	and    eax,0x10
c0022465:	84 c0                	test   al,al
c0022467:	0f 84 a1 00 00 00    	je     c002250e <paging_set_global+0xe0>
c002246d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022470:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022474:	83 e0 08             	and    eax,0x8
c0022477:	84 c0                	test   al,al
c0022479:	74 2e                	je     c00224a9 <paging_set_global+0x7b>
c002247b:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
c002247f:	0f 95 c2             	setne  dl
c0022482:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022485:	83 e2 01             	and    edx,0x1
c0022488:	89 d1                	mov    ecx,edx
c002248a:	c1 e1 04             	shl    ecx,0x4
c002248d:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0022491:	83 e2 ef             	and    edx,0xffffffef
c0022494:	09 ca                	or     edx,ecx
c0022496:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0022499:	83 ec 0c             	sub    esp,0xc
c002249c:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c002249f:	e8 a7 0f 00 00       	call   c002344b <invalidate_directory_TLB>
c00224a4:	83 c4 10             	add    esp,0x10
c00224a7:	eb 69                	jmp    c0022512 <paging_set_global+0xe4>
c00224a9:	6a 00                	push   0x0
c00224ab:	6a 00                	push   0x0
c00224ad:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c00224b0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c00224b3:	e8 8f f4 ff ff       	call   c0021947 <get_pte>
c00224b8:	83 c4 10             	add    esp,0x10
c00224bb:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c00224be:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c00224c2:	74 4d                	je     c0022511 <paging_set_global+0xe3>
c00224c4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00224c7:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00224cb:	83 e0 10             	and    eax,0x10
c00224ce:	84 c0                	test   al,al
c00224d0:	74 3f                	je     c0022511 <paging_set_global+0xe3>
c00224d2:	80 7d d4 00          	cmp    BYTE PTR [ebp-0x2c],0x0
c00224d6:	0f 95 c2             	setne  dl
c00224d9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c00224dc:	83 e2 01             	and    edx,0x1
c00224df:	89 d1                	mov    ecx,edx
c00224e1:	c1 e1 04             	shl    ecx,0x4
c00224e4:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c00224e8:	83 e2 ef             	and    edx,0xffffffef
c00224eb:	09 ca                	or     edx,ecx
c00224ed:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c00224f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00224f3:	c1 e8 0c             	shr    eax,0xc
c00224f6:	25 ff 03 00 00       	and    eax,0x3ff
c00224fb:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c00224fe:	83 ec 0c             	sub    esp,0xc
c0022501:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c0022504:	e8 37 0f 00 00       	call   c0023440 <invalidate_table_TLB>
c0022509:	83 c4 10             	add    esp,0x10
c002250c:	eb 04                	jmp    c0022512 <paging_set_global+0xe4>
c002250e:	90                   	nop
c002250f:	eb 01                	jmp    c0022512 <paging_set_global+0xe4>
c0022511:	90                   	nop
c0022512:	c9                   	leave
c0022513:	c3                   	ret

c0022514 <paging_clear_access_flags>:
c0022514:	55                   	push   ebp
c0022515:	89 e5                	mov    ebp,esp
c0022517:	83 ec 28             	sub    esp,0x28
c002251a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c002251d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0022520:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022523:	c1 e8 16             	shr    eax,0x16
c0022526:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0022529:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002252c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022533:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022536:	01 d0                	add    eax,edx
c0022538:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c002253b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002253e:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022542:	83 e0 10             	and    eax,0x10
c0022545:	84 c0                	test   al,al
c0022547:	74 6f                	je     c00225b8 <paging_clear_access_flags+0xa4>
c0022549:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002254c:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022550:	83 e0 08             	and    eax,0x8
c0022553:	84 c0                	test   al,al
c0022555:	75 62                	jne    c00225b9 <paging_clear_access_flags+0xa5>
c0022557:	6a 00                	push   0x0
c0022559:	6a 00                	push   0x0
c002255b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c002255e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0022561:	e8 e1 f3 ff ff       	call   c0021947 <get_pte>
c0022566:	83 c4 10             	add    esp,0x10
c0022569:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c002256c:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
c0022570:	74 47                	je     c00225b9 <paging_clear_access_flags+0xa5>
c0022572:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022575:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022579:	83 e0 10             	and    eax,0x10
c002257c:	84 c0                	test   al,al
c002257e:	74 39                	je     c00225b9 <paging_clear_access_flags+0xa5>
c0022580:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022583:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0022587:	83 e2 fd             	and    edx,0xfffffffd
c002258a:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c002258d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022590:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0022594:	83 e2 fb             	and    edx,0xfffffffb
c0022597:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c002259a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002259d:	c1 e8 0c             	shr    eax,0xc
c00225a0:	25 ff 03 00 00       	and    eax,0x3ff
c00225a5:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c00225a8:	83 ec 0c             	sub    esp,0xc
c00225ab:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c00225ae:	e8 8d 0e 00 00       	call   c0023440 <invalidate_table_TLB>
c00225b3:	83 c4 10             	add    esp,0x10
c00225b6:	eb 01                	jmp    c00225b9 <paging_clear_access_flags+0xa5>
c00225b8:	90                   	nop
c00225b9:	c9                   	leave
c00225ba:	c3                   	ret

c00225bb <paging_create_table>:
c00225bb:	55                   	push   ebp
c00225bc:	89 e5                	mov    ebp,esp
c00225be:	83 ec 18             	sub    esp,0x18
c00225c1:	e8 9b ec ff ff       	call   c0021261 <pmm_alloc_frame>
c00225c6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00225c9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
c00225cd:	75 07                	jne    c00225d6 <paging_create_table+0x1b>
c00225cf:	b8 00 00 00 00       	mov    eax,0x0
c00225d4:	eb 23                	jmp    c00225f9 <paging_create_table+0x3e>
c00225d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00225d9:	2d 00 00 00 40       	sub    eax,0x40000000
c00225de:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c00225e1:	83 ec 04             	sub    esp,0x4
c00225e4:	68 00 10 00 00       	push   0x1000
c00225e9:	6a 00                	push   0x0
c00225eb:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c00225ee:	e8 b5 ef ff ff       	call   c00215a8 <memset>
c00225f3:	83 c4 10             	add    esp,0x10
c00225f6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00225f9:	c9                   	leave
c00225fa:	c3                   	ret

c00225fb <paging_get_table_entry>:
c00225fb:	55                   	push   ebp
c00225fc:	89 e5                	mov    ebp,esp
c00225fe:	83 ec 10             	sub    esp,0x10
c0022601:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c0022608:	77 09                	ja     c0022613 <paging_get_table_entry+0x18>
c002260a:	81 7d 10 ff 03 00 00 	cmp    DWORD PTR [ebp+0x10],0x3ff
c0022611:	76 07                	jbe    c002261a <paging_get_table_entry+0x1f>
c0022613:	b8 00 00 00 00       	mov    eax,0x0
c0022618:	eb 60                	jmp    c002267a <paging_get_table_entry+0x7f>
c002261a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c002261d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022624:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022627:	01 d0                	add    eax,edx
c0022629:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c002262c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c002262f:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022633:	83 e0 10             	and    eax,0x10
c0022636:	84 c0                	test   al,al
c0022638:	75 07                	jne    c0022641 <paging_get_table_entry+0x46>
c002263a:	b8 00 00 00 00       	mov    eax,0x0
c002263f:	eb 39                	jmp    c002267a <paging_get_table_entry+0x7f>
c0022641:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0022644:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022648:	83 e0 08             	and    eax,0x8
c002264b:	84 c0                	test   al,al
c002264d:	74 07                	je     c0022656 <paging_get_table_entry+0x5b>
c002264f:	b8 00 00 00 00       	mov    eax,0x0
c0022654:	eb 24                	jmp    c002267a <paging_get_table_entry+0x7f>
c0022656:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0022659:	8b 00                	mov    eax,DWORD PTR [eax]
c002265b:	25 ff ff 0f 00       	and    eax,0xfffff
c0022660:	c1 e0 0c             	shl    eax,0xc
c0022663:	2d 00 00 00 40       	sub    eax,0x40000000
c0022668:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
c002266b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002266e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022675:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
c0022678:	01 d0                	add    eax,edx
c002267a:	c9                   	leave
c002267b:	c3                   	ret

c002267c <paging_allocate_table>:
c002267c:	55                   	push   ebp
c002267d:	89 e5                	mov    ebp,esp
c002267f:	83 ec 18             	sub    esp,0x18
c0022682:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c0022689:	76 0a                	jbe    c0022695 <paging_allocate_table+0x19>
c002268b:	b8 00 00 00 00       	mov    eax,0x0
c0022690:	e9 4f 01 00 00       	jmp    c00227e4 <paging_allocate_table+0x168>
c0022695:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022698:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c002269f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00226a2:	01 d0                	add    eax,edx
c00226a4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c00226a7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00226aa:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00226ae:	83 e0 10             	and    eax,0x10
c00226b1:	84 c0                	test   al,al
c00226b3:	74 22                	je     c00226d7 <paging_allocate_table+0x5b>
c00226b5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00226b8:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00226bc:	83 e0 08             	and    eax,0x8
c00226bf:	84 c0                	test   al,al
c00226c1:	74 0a                	je     c00226cd <paging_allocate_table+0x51>
c00226c3:	b8 00 00 00 00       	mov    eax,0x0
c00226c8:	e9 17 01 00 00       	jmp    c00227e4 <paging_allocate_table+0x168>
c00226cd:	b8 01 00 00 00       	mov    eax,0x1
c00226d2:	e9 0d 01 00 00       	jmp    c00227e4 <paging_allocate_table+0x168>
c00226d7:	e8 df fe ff ff       	call   c00225bb <paging_create_table>
c00226dc:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c00226df:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
c00226e3:	75 0a                	jne    c00226ef <paging_allocate_table+0x73>
c00226e5:	b8 00 00 00 00       	mov    eax,0x0
c00226ea:	e9 f5 00 00 00       	jmp    c00227e4 <paging_allocate_table+0x168>
c00226ef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00226f2:	05 00 00 00 40       	add    eax,0x40000000
c00226f7:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00226fa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c00226fd:	c1 e8 0c             	shr    eax,0xc
c0022700:	25 ff ff 0f 00       	and    eax,0xfffff
c0022705:	89 c2                	mov    edx,eax
c0022707:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c002270a:	89 d1                	mov    ecx,edx
c002270c:	81 e1 ff ff 0f 00    	and    ecx,0xfffff
c0022712:	8b 10                	mov    edx,DWORD PTR [eax]
c0022714:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c002271a:	09 ca                	or     edx,ecx
c002271c:	89 10                	mov    DWORD PTR [eax],edx
c002271e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022721:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0022725:	83 ca 10             	or     edx,0x10
c0022728:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c002272b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002272e:	d1 e8                	shr    eax,1
c0022730:	83 e0 01             	and    eax,0x1
c0022733:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0022736:	83 e0 01             	and    eax,0x1
c0022739:	c1 e0 05             	shl    eax,0x5
c002273c:	89 c1                	mov    ecx,eax
c002273e:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0022742:	83 e0 df             	and    eax,0xffffffdf
c0022745:	09 c8                	or     eax,ecx
c0022747:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c002274a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002274d:	c1 e8 02             	shr    eax,0x2
c0022750:	83 e0 01             	and    eax,0x1
c0022753:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0022756:	83 e0 01             	and    eax,0x1
c0022759:	c1 e0 06             	shl    eax,0x6
c002275c:	89 c1                	mov    ecx,eax
c002275e:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c0022762:	83 e0 bf             	and    eax,0xffffffbf
c0022765:	09 c8                	or     eax,ecx
c0022767:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c002276a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002276d:	c1 e8 03             	shr    eax,0x3
c0022770:	83 e0 01             	and    eax,0x1
c0022773:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0022776:	c1 e0 07             	shl    eax,0x7
c0022779:	89 c1                	mov    ecx,eax
c002277b:	0f b6 42 02          	movzx  eax,BYTE PTR [edx+0x2]
c002277f:	83 e0 7f             	and    eax,0x7f
c0022782:	09 c8                	or     eax,ecx
c0022784:	88 42 02             	mov    BYTE PTR [edx+0x2],al
c0022787:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c002278a:	c1 e8 04             	shr    eax,0x4
c002278d:	83 e0 01             	and    eax,0x1
c0022790:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c0022793:	83 e0 01             	and    eax,0x1
c0022796:	89 c1                	mov    ecx,eax
c0022798:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c002279c:	83 e0 fe             	and    eax,0xfffffffe
c002279f:	09 c8                	or     eax,ecx
c00227a1:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c00227a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00227a7:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c00227ab:	83 e2 f7             	and    edx,0xfffffff7
c00227ae:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c00227b1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
c00227b4:	c1 e8 05             	shr    eax,0x5
c00227b7:	83 e0 01             	and    eax,0x1
c00227ba:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
c00227bd:	83 e0 01             	and    eax,0x1
c00227c0:	c1 e0 04             	shl    eax,0x4
c00227c3:	89 c1                	mov    ecx,eax
c00227c5:	0f b6 42 03          	movzx  eax,BYTE PTR [edx+0x3]
c00227c9:	83 e0 ef             	and    eax,0xffffffef
c00227cc:	09 c8                	or     eax,ecx
c00227ce:	88 42 03             	mov    BYTE PTR [edx+0x3],al
c00227d1:	83 ec 0c             	sub    esp,0xc
c00227d4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c00227d7:	e8 6f 0c 00 00       	call   c002344b <invalidate_directory_TLB>
c00227dc:	83 c4 10             	add    esp,0x10
c00227df:	b8 01 00 00 00       	mov    eax,0x1
c00227e4:	c9                   	leave
c00227e5:	c3                   	ret

c00227e6 <paging_free_table>:
c00227e6:	55                   	push   ebp
c00227e7:	89 e5                	mov    ebp,esp
c00227e9:	83 ec 18             	sub    esp,0x18
c00227ec:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c00227f3:	76 0a                	jbe    c00227ff <paging_free_table+0x19>
c00227f5:	b8 00 00 00 00       	mov    eax,0x0
c00227fa:	e9 80 00 00 00       	jmp    c002287f <paging_free_table+0x99>
c00227ff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022802:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022809:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002280c:	01 d0                	add    eax,edx
c002280e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c0022811:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022814:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022818:	83 e0 10             	and    eax,0x10
c002281b:	84 c0                	test   al,al
c002281d:	74 0e                	je     c002282d <paging_free_table+0x47>
c002281f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022822:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022826:	83 e0 08             	and    eax,0x8
c0022829:	84 c0                	test   al,al
c002282b:	74 07                	je     c0022834 <paging_free_table+0x4e>
c002282d:	b8 00 00 00 00       	mov    eax,0x0
c0022832:	eb 4b                	jmp    c002287f <paging_free_table+0x99>
c0022834:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022837:	8b 00                	mov    eax,DWORD PTR [eax]
c0022839:	25 ff ff 0f 00       	and    eax,0xfffff
c002283e:	c1 e0 0c             	shl    eax,0xc
c0022841:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c0022844:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022847:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c002284b:	83 e2 ef             	and    edx,0xffffffef
c002284e:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c0022851:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022854:	8b 10                	mov    edx,DWORD PTR [eax]
c0022856:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c002285c:	89 10                	mov    DWORD PTR [eax],edx
c002285e:	83 ec 0c             	sub    esp,0xc
c0022861:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022864:	e8 da ea ff ff       	call   c0021343 <pmm_free_frame>
c0022869:	83 c4 10             	add    esp,0x10
c002286c:	83 ec 0c             	sub    esp,0xc
c002286f:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0022872:	e8 d4 0b 00 00       	call   c002344b <invalidate_directory_TLB>
c0022877:	83 c4 10             	add    esp,0x10
c002287a:	b8 01 00 00 00       	mov    eax,0x1
c002287f:	c9                   	leave
c0022880:	c3                   	ret

c0022881 <paging_get_directory_entry>:
c0022881:	55                   	push   ebp
c0022882:	89 e5                	mov    ebp,esp
c0022884:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c002288b:	76 07                	jbe    c0022894 <paging_get_directory_entry+0x13>
c002288d:	b8 00 00 00 00       	mov    eax,0x0
c0022892:	eb 0f                	jmp    c00228a3 <paging_get_directory_entry+0x22>
c0022894:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022897:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c002289e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00228a1:	01 d0                	add    eax,edx
c00228a3:	5d                   	pop    ebp
c00228a4:	c3                   	ret

c00228a5 <paging_table_exists>:
c00228a5:	55                   	push   ebp
c00228a6:	89 e5                	mov    ebp,esp
c00228a8:	83 ec 10             	sub    esp,0x10
c00228ab:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c00228b2:	76 07                	jbe    c00228bb <paging_table_exists+0x16>
c00228b4:	b8 00 00 00 00       	mov    eax,0x0
c00228b9:	eb 3a                	jmp    c00228f5 <paging_table_exists+0x50>
c00228bb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c00228be:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00228c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c00228c8:	01 d0                	add    eax,edx
c00228ca:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c00228cd:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00228d0:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00228d4:	83 e0 10             	and    eax,0x10
c00228d7:	84 c0                	test   al,al
c00228d9:	74 15                	je     c00228f0 <paging_table_exists+0x4b>
c00228db:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c00228de:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00228e2:	83 e0 08             	and    eax,0x8
c00228e5:	84 c0                	test   al,al
c00228e7:	75 07                	jne    c00228f0 <paging_table_exists+0x4b>
c00228e9:	b8 01 00 00 00       	mov    eax,0x1
c00228ee:	eb 05                	jmp    c00228f5 <paging_table_exists+0x50>
c00228f0:	b8 00 00 00 00       	mov    eax,0x0
c00228f5:	c9                   	leave
c00228f6:	c3                   	ret

c00228f7 <paging_get_table>:
c00228f7:	55                   	push   ebp
c00228f8:	89 e5                	mov    ebp,esp
c00228fa:	83 ec 10             	sub    esp,0x10
c00228fd:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c0022904:	76 07                	jbe    c002290d <paging_get_table+0x16>
c0022906:	b8 00 00 00 00       	mov    eax,0x0
c002290b:	eb 47                	jmp    c0022954 <paging_get_table+0x5d>
c002290d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022910:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022917:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c002291a:	01 d0                	add    eax,edx
c002291c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
c002291f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0022922:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022926:	83 e0 10             	and    eax,0x10
c0022929:	84 c0                	test   al,al
c002292b:	74 0e                	je     c002293b <paging_get_table+0x44>
c002292d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0022930:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022934:	83 e0 08             	and    eax,0x8
c0022937:	84 c0                	test   al,al
c0022939:	74 07                	je     c0022942 <paging_get_table+0x4b>
c002293b:	b8 00 00 00 00       	mov    eax,0x0
c0022940:	eb 12                	jmp    c0022954 <paging_get_table+0x5d>
c0022942:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
c0022945:	8b 00                	mov    eax,DWORD PTR [eax]
c0022947:	25 ff ff 0f 00       	and    eax,0xfffff
c002294c:	c1 e0 0c             	shl    eax,0xc
c002294f:	2d 00 00 00 40       	sub    eax,0x40000000
c0022954:	c9                   	leave
c0022955:	c3                   	ret

c0022956 <paging_initialize_frame>:
c0022956:	55                   	push   ebp
c0022957:	89 e5                	mov    ebp,esp
c0022959:	83 ec 18             	sub    esp,0x18
c002295c:	81 7d 0c ff 03 00 00 	cmp    DWORD PTR [ebp+0xc],0x3ff
c0022963:	0f 87 bd 00 00 00    	ja     c0022a26 <paging_initialize_frame+0xd0>
c0022969:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c002296c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022973:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022976:	01 d0                	add    eax,edx
c0022978:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c002297b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c002297e:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022982:	83 e0 10             	and    eax,0x10
c0022985:	84 c0                	test   al,al
c0022987:	0f 84 9c 00 00 00    	je     c0022a29 <paging_initialize_frame+0xd3>
c002298d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0022990:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022994:	83 e0 08             	and    eax,0x8
c0022997:	84 c0                	test   al,al
c0022999:	0f 85 8a 00 00 00    	jne    c0022a29 <paging_initialize_frame+0xd3>
c002299f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c00229a2:	8b 00                	mov    eax,DWORD PTR [eax]
c00229a4:	25 ff ff 0f 00       	and    eax,0xfffff
c00229a9:	c1 e0 0c             	shl    eax,0xc
c00229ac:	2d 00 00 00 40       	sub    eax,0x40000000
c00229b1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c00229b4:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c00229bb:	eb 50                	jmp    c0022a0d <paging_initialize_frame+0xb7>
c00229bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00229c0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00229c7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c00229ca:	01 d0                	add    eax,edx
c00229cc:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00229d0:	83 e0 10             	and    eax,0x10
c00229d3:	84 c0                	test   al,al
c00229d5:	74 32                	je     c0022a09 <paging_initialize_frame+0xb3>
c00229d7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00229da:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00229e1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c00229e4:	01 d0                	add    eax,edx
c00229e6:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c00229ea:	83 e2 fd             	and    edx,0xfffffffd
c00229ed:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c00229f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c00229f3:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c00229fa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c00229fd:	01 d0                	add    eax,edx
c00229ff:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
c0022a03:	83 e2 fb             	and    edx,0xfffffffb
c0022a06:	88 50 03             	mov    BYTE PTR [eax+0x3],dl
c0022a09:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0022a0d:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
c0022a14:	76 a7                	jbe    c00229bd <paging_initialize_frame+0x67>
c0022a16:	83 ec 0c             	sub    esp,0xc
c0022a19:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
c0022a1c:	e8 2a 0a 00 00       	call   c002344b <invalidate_directory_TLB>
c0022a21:	83 c4 10             	add    esp,0x10
c0022a24:	eb 04                	jmp    c0022a2a <paging_initialize_frame+0xd4>
c0022a26:	90                   	nop
c0022a27:	eb 01                	jmp    c0022a2a <paging_initialize_frame+0xd4>
c0022a29:	90                   	nop
c0022a2a:	c9                   	leave
c0022a2b:	c3                   	ret

c0022a2c <paging_dump_mapping>:
c0022a2c:	55                   	push   ebp
c0022a2d:	89 e5                	mov    ebp,esp
c0022a2f:	57                   	push   edi
c0022a30:	56                   	push   esi
c0022a31:	53                   	push   ebx
c0022a32:	83 ec 4c             	sub    esp,0x4c
c0022a35:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0022a38:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0022a3b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022a3e:	c1 e8 16             	shr    eax,0x16
c0022a41:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0022a44:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022a47:	c1 e8 0c             	shr    eax,0xc
c0022a4a:	25 ff 03 00 00       	and    eax,0x3ff
c0022a4f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0022a52:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022a55:	25 ff 0f 00 00       	and    eax,0xfff
c0022a5a:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
c0022a5d:	83 ec 08             	sub    esp,0x8
c0022a60:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c0022a63:	68 2c 37 02 c0       	push   0xc002372c
c0022a68:	e8 8d da ff ff       	call   c00204fa <kprintf>
c0022a6d:	83 c4 10             	add    esp,0x10
c0022a70:	83 ec 04             	sub    esp,0x4
c0022a73:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c0022a76:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c0022a79:	68 56 37 02 c0       	push   0xc0023756
c0022a7e:	e8 77 da ff ff       	call   c00204fa <kprintf>
c0022a83:	83 c4 10             	add    esp,0x10
c0022a86:	83 ec 04             	sub    esp,0x4
c0022a89:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c0022a8c:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c0022a8f:	68 70 37 02 c0       	push   0xc0023770
c0022a94:	e8 61 da ff ff       	call   c00204fa <kprintf>
c0022a99:	83 c4 10             	add    esp,0x10
c0022a9c:	83 ec 08             	sub    esp,0x8
c0022a9f:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
c0022aa2:	68 8a 37 02 c0       	push   0xc002378a
c0022aa7:	e8 4e da ff ff       	call   c00204fa <kprintf>
c0022aac:	83 c4 10             	add    esp,0x10
c0022aaf:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0022ab2:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022ab9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022abc:	01 d0                	add    eax,edx
c0022abe:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
c0022ac1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022ac4:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022ac8:	83 e0 10             	and    eax,0x10
c0022acb:	84 c0                	test   al,al
c0022acd:	75 15                	jne    c0022ae4 <paging_dump_mapping+0xb8>
c0022acf:	83 ec 0c             	sub    esp,0xc
c0022ad2:	68 9c 37 02 c0       	push   0xc002379c
c0022ad7:	e8 1e da ff ff       	call   c00204fa <kprintf>
c0022adc:	83 c4 10             	add    esp,0x10
c0022adf:	e9 3c 02 00 00       	jmp    c0022d20 <paging_dump_mapping+0x2f4>
c0022ae4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022ae7:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022aeb:	83 e0 08             	and    eax,0x8
c0022aee:	84 c0                	test   al,al
c0022af0:	0f 84 fb 00 00 00    	je     c0022bf1 <paging_dump_mapping+0x1c5>
c0022af6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022af9:	8b 00                	mov    eax,DWORD PTR [eax]
c0022afb:	25 ff ff 0f 00       	and    eax,0xfffff
c0022b00:	c1 e0 16             	shl    eax,0x16
c0022b03:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
c0022b06:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022b09:	25 ff ff 3f 00       	and    eax,0x3fffff
c0022b0e:	89 c2                	mov    edx,eax
c0022b10:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
c0022b13:	01 d0                	add    eax,edx
c0022b15:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
c0022b18:	83 ec 0c             	sub    esp,0xc
c0022b1b:	68 bc 37 02 c0       	push   0xc00237bc
c0022b20:	e8 d5 d9 ff ff       	call   c00204fa <kprintf>
c0022b25:	83 c4 10             	add    esp,0x10
c0022b28:	83 ec 08             	sub    esp,0x8
c0022b2b:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
c0022b2e:	68 d1 37 02 c0       	push   0xc00237d1
c0022b33:	e8 c2 d9 ff ff       	call   c00204fa <kprintf>
c0022b38:	83 c4 10             	add    esp,0x10
c0022b3b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b3e:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022b42:	c0 e8 04             	shr    al,0x4
c0022b45:	83 e0 01             	and    eax,0x1
c0022b48:	0f b6 d8             	movzx  ebx,al
c0022b4b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b4e:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022b52:	c0 e8 03             	shr    al,0x3
c0022b55:	83 e0 01             	and    eax,0x1
c0022b58:	0f b6 f0             	movzx  esi,al
c0022b5b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b5e:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022b62:	c0 e8 02             	shr    al,0x2
c0022b65:	83 e0 01             	and    eax,0x1
c0022b68:	0f b6 c0             	movzx  eax,al
c0022b6b:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
c0022b6e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b71:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022b75:	d0 e8                	shr    al,1
c0022b77:	83 e0 01             	and    eax,0x1
c0022b7a:	0f b6 c8             	movzx  ecx,al
c0022b7d:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
c0022b80:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b83:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022b87:	83 e0 01             	and    eax,0x1
c0022b8a:	0f b6 f8             	movzx  edi,al
c0022b8d:	89 7d ac             	mov    DWORD PTR [ebp-0x54],edi
c0022b90:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022b93:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022b97:	c0 e8 07             	shr    al,0x7
c0022b9a:	0f b6 f8             	movzx  edi,al
c0022b9d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022ba0:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022ba4:	c0 e8 06             	shr    al,0x6
c0022ba7:	83 e0 01             	and    eax,0x1
c0022baa:	0f b6 c8             	movzx  ecx,al
c0022bad:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022bb0:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022bb4:	c0 e8 05             	shr    al,0x5
c0022bb7:	83 e0 01             	and    eax,0x1
c0022bba:	0f b6 d0             	movzx  edx,al
c0022bbd:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0022bc0:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022bc4:	c0 e8 04             	shr    al,0x4
c0022bc7:	83 e0 01             	and    eax,0x1
c0022bca:	0f b6 c0             	movzx  eax,al
c0022bcd:	83 ec 08             	sub    esp,0x8
c0022bd0:	53                   	push   ebx
c0022bd1:	56                   	push   esi
c0022bd2:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
c0022bd5:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
c0022bd8:	ff 75 ac             	push   DWORD PTR [ebp-0x54]
c0022bdb:	57                   	push   edi
c0022bdc:	51                   	push   ecx
c0022bdd:	52                   	push   edx
c0022bde:	50                   	push   eax
c0022bdf:	68 f0 37 02 c0       	push   0xc00237f0
c0022be4:	e8 11 d9 ff ff       	call   c00204fa <kprintf>
c0022be9:	83 c4 30             	add    esp,0x30
c0022bec:	e9 2f 01 00 00       	jmp    c0022d20 <paging_dump_mapping+0x2f4>
c0022bf1:	83 ec 04             	sub    esp,0x4
c0022bf4:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c0022bf7:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c0022bfa:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0022bfd:	e8 f9 f9 ff ff       	call   c00225fb <paging_get_table_entry>
c0022c02:	83 c4 10             	add    esp,0x10
c0022c05:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
c0022c08:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
c0022c0c:	74 0e                	je     c0022c1c <paging_dump_mapping+0x1f0>
c0022c0e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022c11:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022c15:	83 e0 10             	and    eax,0x10
c0022c18:	84 c0                	test   al,al
c0022c1a:	75 15                	jne    c0022c31 <paging_dump_mapping+0x205>
c0022c1c:	83 ec 0c             	sub    esp,0xc
c0022c1f:	68 40 38 02 c0       	push   0xc0023840
c0022c24:	e8 d1 d8 ff ff       	call   c00204fa <kprintf>
c0022c29:	83 c4 10             	add    esp,0x10
c0022c2c:	e9 ef 00 00 00       	jmp    c0022d20 <paging_dump_mapping+0x2f4>
c0022c31:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022c34:	8b 00                	mov    eax,DWORD PTR [eax]
c0022c36:	25 ff ff 0f 00       	and    eax,0xfffff
c0022c3b:	c1 e0 0c             	shl    eax,0xc
c0022c3e:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
c0022c41:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
c0022c44:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c0022c47:	01 d0                	add    eax,edx
c0022c49:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
c0022c4c:	83 ec 0c             	sub    esp,0xc
c0022c4f:	68 60 38 02 c0       	push   0xc0023860
c0022c54:	e8 a1 d8 ff ff       	call   c00204fa <kprintf>
c0022c59:	83 c4 10             	add    esp,0x10
c0022c5c:	83 ec 08             	sub    esp,0x8
c0022c5f:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
c0022c62:	68 d1 37 02 c0       	push   0xc00237d1
c0022c67:	e8 8e d8 ff ff       	call   c00204fa <kprintf>
c0022c6c:	83 c4 10             	add    esp,0x10
c0022c6f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022c72:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022c76:	c0 e8 04             	shr    al,0x4
c0022c79:	83 e0 01             	and    eax,0x1
c0022c7c:	0f b6 d8             	movzx  ebx,al
c0022c7f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022c82:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022c86:	c0 e8 03             	shr    al,0x3
c0022c89:	83 e0 01             	and    eax,0x1
c0022c8c:	0f b6 f0             	movzx  esi,al
c0022c8f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022c92:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022c96:	c0 e8 02             	shr    al,0x2
c0022c99:	83 e0 01             	and    eax,0x1
c0022c9c:	0f b6 c0             	movzx  eax,al
c0022c9f:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
c0022ca2:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022ca5:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022ca9:	d0 e8                	shr    al,1
c0022cab:	83 e0 01             	and    eax,0x1
c0022cae:	0f b6 c8             	movzx  ecx,al
c0022cb1:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
c0022cb4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022cb7:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022cbb:	83 e0 01             	and    eax,0x1
c0022cbe:	0f b6 f8             	movzx  edi,al
c0022cc1:	89 7d ac             	mov    DWORD PTR [ebp-0x54],edi
c0022cc4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022cc7:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022ccb:	c0 e8 07             	shr    al,0x7
c0022cce:	0f b6 f8             	movzx  edi,al
c0022cd1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022cd4:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022cd8:	c0 e8 06             	shr    al,0x6
c0022cdb:	83 e0 01             	and    eax,0x1
c0022cde:	0f b6 c8             	movzx  ecx,al
c0022ce1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022ce4:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022ce8:	c0 e8 05             	shr    al,0x5
c0022ceb:	83 e0 01             	and    eax,0x1
c0022cee:	0f b6 d0             	movzx  edx,al
c0022cf1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c0022cf4:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022cf8:	c0 e8 04             	shr    al,0x4
c0022cfb:	83 e0 01             	and    eax,0x1
c0022cfe:	0f b6 c0             	movzx  eax,al
c0022d01:	83 ec 08             	sub    esp,0x8
c0022d04:	53                   	push   ebx
c0022d05:	56                   	push   esi
c0022d06:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
c0022d09:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
c0022d0c:	ff 75 ac             	push   DWORD PTR [ebp-0x54]
c0022d0f:	57                   	push   edi
c0022d10:	51                   	push   ecx
c0022d11:	52                   	push   edx
c0022d12:	50                   	push   eax
c0022d13:	68 78 38 02 c0       	push   0xc0023878
c0022d18:	e8 dd d7 ff ff       	call   c00204fa <kprintf>
c0022d1d:	83 c4 30             	add    esp,0x30
c0022d20:	8d 65 f4             	lea    esp,[ebp-0xc]
c0022d23:	5b                   	pop    ebx
c0022d24:	5e                   	pop    esi
c0022d25:	5f                   	pop    edi
c0022d26:	5d                   	pop    ebp
c0022d27:	c3                   	ret

c0022d28 <paging_validate_directory>:
c0022d28:	55                   	push   ebp
c0022d29:	89 e5                	mov    ebp,esp
c0022d2b:	83 ec 28             	sub    esp,0x28
c0022d2e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c0022d32:	75 0a                	jne    c0022d3e <paging_validate_directory+0x16>
c0022d34:	b8 00 00 00 00       	mov    eax,0x0
c0022d39:	e9 ae 01 00 00       	jmp    c0022eec <paging_validate_directory+0x1c4>
c0022d3e:	c7 45 f4 00 03 00 00 	mov    DWORD PTR [ebp-0xc],0x300
c0022d45:	e9 87 00 00 00       	jmp    c0022dd1 <paging_validate_directory+0xa9>
c0022d4a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022d4d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022d54:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022d57:	01 d0                	add    eax,edx
c0022d59:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0022d5c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0022d5f:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022d63:	83 e0 10             	and    eax,0x10
c0022d66:	84 c0                	test   al,al
c0022d68:	75 1d                	jne    c0022d87 <paging_validate_directory+0x5f>
c0022d6a:	83 ec 08             	sub    esp,0x8
c0022d6d:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0022d70:	68 c8 38 02 c0       	push   0xc00238c8
c0022d75:	e8 80 d7 ff ff       	call   c00204fa <kprintf>
c0022d7a:	83 c4 10             	add    esp,0x10
c0022d7d:	b8 00 00 00 00       	mov    eax,0x0
c0022d82:	e9 65 01 00 00       	jmp    c0022eec <paging_validate_directory+0x1c4>
c0022d87:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0022d8a:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022d8e:	83 e0 08             	and    eax,0x8
c0022d91:	84 c0                	test   al,al
c0022d93:	75 38                	jne    c0022dcd <paging_validate_directory+0xa5>
c0022d95:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0022d98:	8b 00                	mov    eax,DWORD PTR [eax]
c0022d9a:	25 ff ff 0f 00       	and    eax,0xfffff
c0022d9f:	c1 e0 0c             	shl    eax,0xc
c0022da2:	2d 00 00 00 40       	sub    eax,0x40000000
c0022da7:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0022daa:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
c0022dae:	75 1d                	jne    c0022dcd <paging_validate_directory+0xa5>
c0022db0:	83 ec 08             	sub    esp,0x8
c0022db3:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c0022db6:	68 00 39 02 c0       	push   0xc0023900
c0022dbb:	e8 3a d7 ff ff       	call   c00204fa <kprintf>
c0022dc0:	83 c4 10             	add    esp,0x10
c0022dc3:	b8 00 00 00 00       	mov    eax,0x0
c0022dc8:	e9 1f 01 00 00       	jmp    c0022eec <paging_validate_directory+0x1c4>
c0022dcd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c0022dd1:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
c0022dd8:	0f 8e 6c ff ff ff    	jle    c0022d4a <paging_validate_directory+0x22>
c0022dde:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c0022de5:	e9 f0 00 00 00       	jmp    c0022eda <paging_validate_directory+0x1b2>
c0022dea:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0022ded:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022df4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022df7:	01 d0                	add    eax,edx
c0022df9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0022dfc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022dff:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022e03:	83 e0 10             	and    eax,0x10
c0022e06:	84 c0                	test   al,al
c0022e08:	0f 84 c8 00 00 00    	je     c0022ed6 <paging_validate_directory+0x1ae>
c0022e0e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022e11:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022e15:	83 e0 40             	and    eax,0x40
c0022e18:	84 c0                	test   al,al
c0022e1a:	75 13                	jne    c0022e2f <paging_validate_directory+0x107>
c0022e1c:	83 ec 08             	sub    esp,0x8
c0022e1f:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022e22:	68 34 39 02 c0       	push   0xc0023934
c0022e27:	e8 ce d6 ff ff       	call   c00204fa <kprintf>
c0022e2c:	83 c4 10             	add    esp,0x10
c0022e2f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022e32:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022e36:	83 e0 08             	and    eax,0x8
c0022e39:	84 c0                	test   al,al
c0022e3b:	0f 85 95 00 00 00    	jne    c0022ed6 <paging_validate_directory+0x1ae>
c0022e41:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022e44:	8b 00                	mov    eax,DWORD PTR [eax]
c0022e46:	25 ff ff 0f 00       	and    eax,0xfffff
c0022e4b:	c1 e0 0c             	shl    eax,0xc
c0022e4e:	2d 00 00 00 40       	sub    eax,0x40000000
c0022e53:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0022e56:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
c0022e5a:	75 1a                	jne    c0022e76 <paging_validate_directory+0x14e>
c0022e5c:	83 ec 08             	sub    esp,0x8
c0022e5f:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022e62:	68 78 39 02 c0       	push   0xc0023978
c0022e67:	e8 8e d6 ff ff       	call   c00204fa <kprintf>
c0022e6c:	83 c4 10             	add    esp,0x10
c0022e6f:	b8 00 00 00 00       	mov    eax,0x0
c0022e74:	eb 76                	jmp    c0022eec <paging_validate_directory+0x1c4>
c0022e76:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
c0022e7d:	eb 4e                	jmp    c0022ecd <paging_validate_directory+0x1a5>
c0022e7f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022e82:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022e89:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022e8c:	01 d0                	add    eax,edx
c0022e8e:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022e92:	83 e0 10             	and    eax,0x10
c0022e95:	84 c0                	test   al,al
c0022e97:	74 30                	je     c0022ec9 <paging_validate_directory+0x1a1>
c0022e99:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022e9c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022ea3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022ea6:	01 d0                	add    eax,edx
c0022ea8:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022eac:	83 e0 40             	and    eax,0x40
c0022eaf:	84 c0                	test   al,al
c0022eb1:	75 16                	jne    c0022ec9 <paging_validate_directory+0x1a1>
c0022eb3:	83 ec 04             	sub    esp,0x4
c0022eb6:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c0022eb9:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c0022ebc:	68 ac 39 02 c0       	push   0xc00239ac
c0022ec1:	e8 34 d6 ff ff       	call   c00204fa <kprintf>
c0022ec6:	83 c4 10             	add    esp,0x10
c0022ec9:	83 6d ec 80          	sub    DWORD PTR [ebp-0x14],0xffffff80
c0022ecd:	81 7d ec ff 03 00 00 	cmp    DWORD PTR [ebp-0x14],0x3ff
c0022ed4:	7e a9                	jle    c0022e7f <paging_validate_directory+0x157>
c0022ed6:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0022eda:	81 7d f0 ff 02 00 00 	cmp    DWORD PTR [ebp-0x10],0x2ff
c0022ee1:	0f 8e 03 ff ff ff    	jle    c0022dea <paging_validate_directory+0xc2>
c0022ee7:	b8 01 00 00 00       	mov    eax,0x1
c0022eec:	c9                   	leave
c0022eed:	c3                   	ret

c0022eee <paging_destroy_directory>:
c0022eee:	55                   	push   ebp
c0022eef:	89 e5                	mov    ebp,esp
c0022ef1:	83 ec 28             	sub    esp,0x28
c0022ef4:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c0022ef8:	0f 84 33 01 00 00    	je     c0023031 <paging_destroy_directory+0x143>
c0022efe:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c0022f05:	e9 13 01 00 00       	jmp    c002301d <paging_destroy_directory+0x12f>
c0022f0a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0022f0d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022f14:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0022f17:	01 d0                	add    eax,edx
c0022f19:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
c0022f1c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022f1f:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022f23:	83 e0 10             	and    eax,0x10
c0022f26:	84 c0                	test   al,al
c0022f28:	0f 84 97 00 00 00    	je     c0022fc5 <paging_destroy_directory+0xd7>
c0022f2e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022f31:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022f35:	83 e0 08             	and    eax,0x8
c0022f38:	84 c0                	test   al,al
c0022f3a:	0f 85 85 00 00 00    	jne    c0022fc5 <paging_destroy_directory+0xd7>
c0022f40:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022f43:	8b 00                	mov    eax,DWORD PTR [eax]
c0022f45:	25 ff ff 0f 00       	and    eax,0xfffff
c0022f4a:	c1 e0 0c             	shl    eax,0xc
c0022f4d:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
c0022f50:	83 ec 0c             	sub    esp,0xc
c0022f53:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
c0022f56:	e8 e8 e3 ff ff       	call   c0021343 <pmm_free_frame>
c0022f5b:	83 c4 10             	add    esp,0x10
c0022f5e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
c0022f61:	2d 00 00 00 40       	sub    eax,0x40000000
c0022f66:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
c0022f69:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c0022f70:	eb 48                	jmp    c0022fba <paging_destroy_directory+0xcc>
c0022f72:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0022f75:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022f7c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022f7f:	01 d0                	add    eax,edx
c0022f81:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022f85:	83 e0 10             	and    eax,0x10
c0022f88:	84 c0                	test   al,al
c0022f8a:	74 2a                	je     c0022fb6 <paging_destroy_directory+0xc8>
c0022f8c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
c0022f8f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0022f96:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0022f99:	01 d0                	add    eax,edx
c0022f9b:	8b 00                	mov    eax,DWORD PTR [eax]
c0022f9d:	25 ff ff 0f 00       	and    eax,0xfffff
c0022fa2:	c1 e0 0c             	shl    eax,0xc
c0022fa5:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
c0022fa8:	83 ec 0c             	sub    esp,0xc
c0022fab:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c0022fae:	e8 90 e3 ff ff       	call   c0021343 <pmm_free_frame>
c0022fb3:	83 c4 10             	add    esp,0x10
c0022fb6:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0022fba:	81 7d f0 ff 03 00 00 	cmp    DWORD PTR [ebp-0x10],0x3ff
c0022fc1:	76 af                	jbe    c0022f72 <paging_destroy_directory+0x84>
c0022fc3:	eb 3a                	jmp    c0022fff <paging_destroy_directory+0x111>
c0022fc5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022fc8:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0022fcc:	83 e0 10             	and    eax,0x10
c0022fcf:	84 c0                	test   al,al
c0022fd1:	74 2c                	je     c0022fff <paging_destroy_directory+0x111>
c0022fd3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022fd6:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c0022fda:	83 e0 08             	and    eax,0x8
c0022fdd:	84 c0                	test   al,al
c0022fdf:	74 1e                	je     c0022fff <paging_destroy_directory+0x111>
c0022fe1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0022fe4:	8b 00                	mov    eax,DWORD PTR [eax]
c0022fe6:	25 ff ff 0f 00       	and    eax,0xfffff
c0022feb:	c1 e0 16             	shl    eax,0x16
c0022fee:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
c0022ff1:	83 ec 0c             	sub    esp,0xc
c0022ff4:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c0022ff7:	e8 47 e3 ff ff       	call   c0021343 <pmm_free_frame>
c0022ffc:	83 c4 10             	add    esp,0x10
c0022fff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c0023002:	0f b6 50 02          	movzx  edx,BYTE PTR [eax+0x2]
c0023006:	83 e2 ef             	and    edx,0xffffffef
c0023009:	88 50 02             	mov    BYTE PTR [eax+0x2],dl
c002300c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
c002300f:	8b 10                	mov    edx,DWORD PTR [eax]
c0023011:	81 e2 00 00 f0 ff    	and    edx,0xfff00000
c0023017:	89 10                	mov    DWORD PTR [eax],edx
c0023019:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c002301d:	81 7d f4 ff 02 00 00 	cmp    DWORD PTR [ebp-0xc],0x2ff
c0023024:	0f 86 e0 fe ff ff    	jbe    c0022f0a <paging_destroy_directory+0x1c>
c002302a:	e8 1d e6 ff ff       	call   c002164c <invalidate_TLB>
c002302f:	eb 01                	jmp    c0023032 <paging_destroy_directory+0x144>
c0023031:	90                   	nop
c0023032:	c9                   	leave
c0023033:	c3                   	ret

c0023034 <paging_print_stats>:
c0023034:	55                   	push   ebp
c0023035:	89 e5                	mov    ebp,esp
c0023037:	83 ec 38             	sub    esp,0x38
c002303a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
c002303e:	75 15                	jne    c0023055 <paging_print_stats+0x21>
c0023040:	83 ec 0c             	sub    esp,0xc
c0023043:	68 f4 39 02 c0       	push   0xc00239f4
c0023048:	e8 ad d4 ff ff       	call   c00204fa <kprintf>
c002304d:	83 c4 10             	add    esp,0x10
c0023050:	e9 cf 01 00 00       	jmp    c0023224 <paging_print_stats+0x1f0>
c0023055:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
c002305c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
c0023063:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
c002306a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
c0023071:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
c0023078:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
c002307f:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
c0023086:	e9 06 01 00 00       	jmp    c0023191 <paging_print_stats+0x15d>
c002308b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
c002308e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0023095:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
c0023098:	01 d0                	add    eax,edx
c002309a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
c002309d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c00230a0:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c00230a4:	83 e0 10             	and    eax,0x10
c00230a7:	84 c0                	test   al,al
c00230a9:	0f 84 de 00 00 00    	je     c002318d <paging_print_stats+0x159>
c00230af:	81 7d dc ff 02 00 00 	cmp    DWORD PTR [ebp-0x24],0x2ff
c00230b6:	77 6f                	ja     c0023127 <paging_print_stats+0xf3>
c00230b8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c00230bb:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c00230bf:	83 e0 08             	and    eax,0x8
c00230c2:	84 c0                	test   al,al
c00230c4:	74 09                	je     c00230cf <paging_print_stats+0x9b>
c00230c6:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
c00230ca:	e9 be 00 00 00       	jmp    c002318d <paging_print_stats+0x159>
c00230cf:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
c00230d3:	83 ec 08             	sub    esp,0x8
c00230d6:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c00230d9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c00230dc:	e8 16 f8 ff ff       	call   c00228f7 <paging_get_table>
c00230e1:	83 c4 10             	add    esp,0x10
c00230e4:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
c00230e7:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
c00230eb:	0f 84 9c 00 00 00    	je     c002318d <paging_print_stats+0x159>
c00230f1:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
c00230f8:	eb 22                	jmp    c002311c <paging_print_stats+0xe8>
c00230fa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
c00230fd:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c0023104:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
c0023107:	01 d0                	add    eax,edx
c0023109:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c002310d:	83 e0 10             	and    eax,0x10
c0023110:	84 c0                	test   al,al
c0023112:	74 04                	je     c0023118 <paging_print_stats+0xe4>
c0023114:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
c0023118:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
c002311c:	81 7d d8 ff 03 00 00 	cmp    DWORD PTR [ebp-0x28],0x3ff
c0023123:	76 d5                	jbe    c00230fa <paging_print_stats+0xc6>
c0023125:	eb 66                	jmp    c002318d <paging_print_stats+0x159>
c0023127:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
c002312a:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
c002312e:	83 e0 08             	and    eax,0x8
c0023131:	84 c0                	test   al,al
c0023133:	74 06                	je     c002313b <paging_print_stats+0x107>
c0023135:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
c0023139:	eb 52                	jmp    c002318d <paging_print_stats+0x159>
c002313b:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
c002313f:	83 ec 08             	sub    esp,0x8
c0023142:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
c0023145:	ff 75 08             	push   DWORD PTR [ebp+0x8]
c0023148:	e8 aa f7 ff ff       	call   c00228f7 <paging_get_table>
c002314d:	83 c4 10             	add    esp,0x10
c0023150:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
c0023153:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
c0023157:	74 34                	je     c002318d <paging_print_stats+0x159>
c0023159:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
c0023160:	eb 22                	jmp    c0023184 <paging_print_stats+0x150>
c0023162:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
c0023165:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
c002316c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
c002316f:	01 d0                	add    eax,edx
c0023171:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
c0023175:	83 e0 10             	and    eax,0x10
c0023178:	84 c0                	test   al,al
c002317a:	74 04                	je     c0023180 <paging_print_stats+0x14c>
c002317c:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
c0023180:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
c0023184:	81 7d d4 ff 03 00 00 	cmp    DWORD PTR [ebp-0x2c],0x3ff
c002318b:	76 d5                	jbe    c0023162 <paging_print_stats+0x12e>
c002318d:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
c0023191:	81 7d dc ff 03 00 00 	cmp    DWORD PTR [ebp-0x24],0x3ff
c0023198:	0f 86 ed fe ff ff    	jbe    c002308b <paging_print_stats+0x57>
c002319e:	83 ec 0c             	sub    esp,0xc
c00231a1:	68 15 3a 02 c0       	push   0xc0023a15
c00231a6:	e8 4f d3 ff ff       	call   c00204fa <kprintf>
c00231ab:	83 c4 10             	add    esp,0x10
c00231ae:	83 ec 0c             	sub    esp,0xc
c00231b1:	68 29 3a 02 c0       	push   0xc0023a29
c00231b6:	e8 3f d3 ff ff       	call   c00204fa <kprintf>
c00231bb:	83 c4 10             	add    esp,0x10
c00231be:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
c00231c1:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
c00231c4:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c00231c7:	68 38 3a 02 c0       	push   0xc0023a38
c00231cc:	e8 29 d3 ff ff       	call   c00204fa <kprintf>
c00231d1:	83 c4 10             	add    esp,0x10
c00231d4:	83 ec 0c             	sub    esp,0xc
c00231d7:	68 66 3a 02 c0       	push   0xc0023a66
c00231dc:	e8 19 d3 ff ff       	call   c00204fa <kprintf>
c00231e1:	83 c4 10             	add    esp,0x10
c00231e4:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
c00231e7:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
c00231ea:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
c00231ed:	68 38 3a 02 c0       	push   0xc0023a38
c00231f2:	e8 03 d3 ff ff       	call   c00204fa <kprintf>
c00231f7:	83 c4 10             	add    esp,0x10
c00231fa:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
c00231fd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
c0023200:	8d 0c 02             	lea    ecx,[edx+eax*1]
c0023203:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
c0023206:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
c0023209:	01 d0                	add    eax,edx
c002320b:	c1 e0 0a             	shl    eax,0xa
c002320e:	01 c8                	add    eax,ecx
c0023210:	c1 e0 02             	shl    eax,0x2
c0023213:	83 ec 08             	sub    esp,0x8
c0023216:	50                   	push   eax
c0023217:	68 77 3a 02 c0       	push   0xc0023a77
c002321c:	e8 d9 d2 ff ff       	call   c00204fa <kprintf>
c0023221:	83 c4 10             	add    esp,0x10
c0023224:	c9                   	leave
c0023225:	c3                   	ret
c0023226:	66 90                	xchg   ax,ax
c0023228:	66 90                	xchg   ax,ax
c002322a:	66 90                	xchg   ax,ax
c002322c:	66 90                	xchg   ax,ax
c002322e:	66 90                	xchg   ax,ax

c0023230 <gdt_init>:
c0023230:	0f 01 15 b4 3a 02 c0 	lgdtd  ds:0xc0023ab4
c0023237:	66 b8 10 00          	mov    ax,0x10
c002323b:	8e d8                	mov    ds,eax
c002323d:	8e c0                	mov    es,eax
c002323f:	8e e0                	mov    fs,eax
c0023241:	8e e8                	mov    gs,eax
c0023243:	8e d0                	mov    ss,eax
c0023245:	ea 4c 32 02 c0 08 00 	jmp    0x8:0xc002324c

c002324c <gdt_init.reload_cs>:
c002324c:	c3                   	ret
c002324d:	66 90                	xchg   ax,ax
c002324f:	90                   	nop

c0023250 <outb>:
c0023250:	55                   	push   ebp
c0023251:	89 e5                	mov    ebp,esp
c0023253:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c0023257:	8a 45 0c             	mov    al,BYTE PTR [ebp+0xc]
c002325a:	ee                   	out    dx,al
c002325b:	5d                   	pop    ebp
c002325c:	c3                   	ret

c002325d <outw>:
c002325d:	55                   	push   ebp
c002325e:	89 e5                	mov    ebp,esp
c0023260:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c0023264:	66 8b 45 0c          	mov    ax,WORD PTR [ebp+0xc]
c0023268:	66 ef                	out    dx,ax
c002326a:	5d                   	pop    ebp
c002326b:	c3                   	ret

c002326c <outl>:
c002326c:	55                   	push   ebp
c002326d:	89 e5                	mov    ebp,esp
c002326f:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c0023273:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
c0023276:	ef                   	out    dx,eax
c0023277:	5d                   	pop    ebp
c0023278:	c3                   	ret

c0023279 <inb>:
c0023279:	55                   	push   ebp
c002327a:	89 e5                	mov    ebp,esp
c002327c:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c0023280:	31 c0                	xor    eax,eax
c0023282:	ec                   	in     al,dx
c0023283:	5d                   	pop    ebp
c0023284:	c3                   	ret

c0023285 <inw>:
c0023285:	55                   	push   ebp
c0023286:	89 e5                	mov    ebp,esp
c0023288:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c002328c:	31 c0                	xor    eax,eax
c002328e:	66 ed                	in     ax,dx
c0023290:	5d                   	pop    ebp
c0023291:	c3                   	ret

c0023292 <inl>:
c0023292:	55                   	push   ebp
c0023293:	89 e5                	mov    ebp,esp
c0023295:	66 8b 55 08          	mov    dx,WORD PTR [ebp+0x8]
c0023299:	31 c0                	xor    eax,eax
c002329b:	ed                   	in     eax,dx
c002329c:	5d                   	pop    ebp
c002329d:	c3                   	ret

c002329e <in_out_wait>:
c002329e:	66 ba 80 00          	mov    dx,0x80
c00232a2:	66 b8 00 00          	mov    ax,0x0
c00232a6:	66 ef                	out    dx,ax

c00232a8 <in_ah>:
c00232a8:	8a 64 24 04          	mov    ah,BYTE PTR [esp+0x4]
c00232ac:	c3                   	ret

c00232ad <in_al>:
c00232ad:	8a 44 24 04          	mov    al,BYTE PTR [esp+0x4]
c00232b1:	c3                   	ret

c00232b2 <in_bh>:
c00232b2:	8a 7c 24 04          	mov    bh,BYTE PTR [esp+0x4]
c00232b6:	c3                   	ret

c00232b7 <in_bl>:
c00232b7:	8a 5c 24 04          	mov    bl,BYTE PTR [esp+0x4]
c00232bb:	c3                   	ret

c00232bc <in_ch>:
c00232bc:	8a 6c 24 04          	mov    ch,BYTE PTR [esp+0x4]
c00232c0:	c3                   	ret

c00232c1 <in_cl>:
c00232c1:	8a 4c 24 04          	mov    cl,BYTE PTR [esp+0x4]
c00232c5:	c3                   	ret

c00232c6 <in_dh>:
c00232c6:	8a 74 24 04          	mov    dh,BYTE PTR [esp+0x4]
c00232ca:	c3                   	ret

c00232cb <in_dl>:
c00232cb:	8a 54 24 04          	mov    dl,BYTE PTR [esp+0x4]
c00232cf:	c3                   	ret

c00232d0 <in_ax>:
c00232d0:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00232d5:	c3                   	ret

c00232d6 <in_bx>:
c00232d6:	66 8b 5c 24 04       	mov    bx,WORD PTR [esp+0x4]
c00232db:	c3                   	ret

c00232dc <in_cx>:
c00232dc:	66 8b 4c 24 04       	mov    cx,WORD PTR [esp+0x4]
c00232e1:	c3                   	ret

c00232e2 <in_dx>:
c00232e2:	66 8b 54 24 04       	mov    dx,WORD PTR [esp+0x4]
c00232e7:	c3                   	ret

c00232e8 <in_si>:
c00232e8:	66 8b 74 24 04       	mov    si,WORD PTR [esp+0x4]
c00232ed:	c3                   	ret

c00232ee <in_ebx>:
c00232ee:	8b 5c 24 04          	mov    ebx,DWORD PTR [esp+0x4]
c00232f2:	c3                   	ret

c00232f3 <in_edx>:
c00232f3:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
c00232f7:	c3                   	ret

c00232f8 <in_esi>:
c00232f8:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
c00232fc:	c3                   	ret

c00232fd <get_ah>:
c00232fd:	0f b6 c4             	movzx  eax,ah
c0023300:	c3                   	ret

c0023301 <get_al>:
c0023301:	0f b6 c0             	movzx  eax,al
c0023304:	c3                   	ret

c0023305 <get_bh>:
c0023305:	0f b6 c7             	movzx  eax,bh
c0023308:	c3                   	ret

c0023309 <get_bl>:
c0023309:	0f b6 c3             	movzx  eax,bl
c002330c:	c3                   	ret

c002330d <get_ch>:
c002330d:	0f b6 c5             	movzx  eax,ch
c0023310:	c3                   	ret

c0023311 <get_cl>:
c0023311:	0f b6 c1             	movzx  eax,cl
c0023314:	c3                   	ret

c0023315 <get_dh>:
c0023315:	0f b6 c6             	movzx  eax,dh
c0023318:	c3                   	ret

c0023319 <get_dl>:
c0023319:	0f b6 c2             	movzx  eax,dl
c002331c:	c3                   	ret

c002331d <get_ax>:
c002331d:	0f b7 c0             	movzx  eax,ax
c0023320:	c3                   	ret

c0023321 <get_bx>:
c0023321:	0f b7 c3             	movzx  eax,bx
c0023324:	c3                   	ret

c0023325 <get_cx>:
c0023325:	0f b7 c1             	movzx  eax,cx
c0023328:	c3                   	ret

c0023329 <get_dx>:
c0023329:	0f b7 c2             	movzx  eax,dx
c002332c:	c3                   	ret

c002332d <get_si>:
c002332d:	0f b7 c6             	movzx  eax,si
c0023330:	c3                   	ret

c0023331 <get_ebx>:
c0023331:	89 d8                	mov    eax,ebx
c0023333:	c3                   	ret

c0023334 <get_edx>:
c0023334:	89 d0                	mov    eax,edx
c0023336:	c3                   	ret

c0023337 <get_esi>:
c0023337:	89 f0                	mov    eax,esi
c0023339:	c3                   	ret

c002333a <clear_ah>:
c002333a:	30 e4                	xor    ah,ah
c002333c:	c3                   	ret

c002333d <clear_al>:
c002333d:	30 c0                	xor    al,al
c002333f:	c3                   	ret

c0023340 <clear_bh>:
c0023340:	30 ff                	xor    bh,bh
c0023342:	c3                   	ret

c0023343 <clear_bl>:
c0023343:	30 db                	xor    bl,bl
c0023345:	c3                   	ret

c0023346 <clear_ch>:
c0023346:	30 ed                	xor    ch,ch
c0023348:	c3                   	ret

c0023349 <clear_cl>:
c0023349:	30 c9                	xor    cl,cl
c002334b:	c3                   	ret

c002334c <clear_dh>:
c002334c:	30 f6                	xor    dh,dh
c002334e:	c3                   	ret

c002334f <clear_dl>:
c002334f:	30 d2                	xor    dl,dl
c0023351:	c3                   	ret

c0023352 <clear_ax>:
c0023352:	66 31 c0             	xor    ax,ax
c0023355:	c3                   	ret

c0023356 <clear_bx>:
c0023356:	66 31 db             	xor    bx,bx
c0023359:	c3                   	ret

c002335a <clear_cx>:
c002335a:	66 31 c9             	xor    cx,cx
c002335d:	c3                   	ret

c002335e <clear_dx>:
c002335e:	66 31 d2             	xor    dx,dx
c0023361:	c3                   	ret

c0023362 <get_cr0>:
c0023362:	0f 20 c0             	mov    eax,cr0
c0023365:	c3                   	ret

c0023366 <get_cr2>:
c0023366:	0f 20 d0             	mov    eax,cr2
c0023369:	c3                   	ret

c002336a <get_cr3>:
c002336a:	0f 20 d8             	mov    eax,cr3
c002336d:	c3                   	ret

c002336e <get_cr4>:
c002336e:	0f 20 e0             	mov    eax,cr4
c0023371:	c3                   	ret

c0023372 <set_cr0>:
c0023372:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023376:	0f 22 c0             	mov    cr0,eax
c0023379:	c3                   	ret

c002337a <set_cr2>:
c002337a:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002337e:	0f 22 d0             	mov    cr2,eax
c0023381:	c3                   	ret

c0023382 <set_cr3>:
c0023382:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023386:	0f 22 d8             	mov    cr3,eax
c0023389:	c3                   	ret

c002338a <set_cr4>:
c002338a:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002338e:	0f 22 e0             	mov    cr4,eax
c0023391:	c3                   	ret

c0023392 <get_cs>:
c0023392:	66 8c c8             	mov    ax,cs
c0023395:	c3                   	ret

c0023396 <get_ds>:
c0023396:	66 8c d8             	mov    ax,ds
c0023399:	c3                   	ret

c002339a <get_es>:
c002339a:	66 8c c0             	mov    ax,es
c002339d:	c3                   	ret

c002339e <get_fs>:
c002339e:	66 8c e0             	mov    ax,fs
c00233a1:	c3                   	ret

c00233a2 <get_gs>:
c00233a2:	66 8c e8             	mov    ax,gs
c00233a5:	c3                   	ret

c00233a6 <get_ss>:
c00233a6:	66 8c d0             	mov    ax,ss
c00233a9:	c3                   	ret

c00233aa <set_cs>:
c00233aa:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233af:	8e c8                	mov    cs,eax
c00233b1:	c3                   	ret

c00233b2 <set_ds>:
c00233b2:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233b7:	8e d8                	mov    ds,eax
c00233b9:	c3                   	ret

c00233ba <set_es>:
c00233ba:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233bf:	8e c0                	mov    es,eax
c00233c1:	c3                   	ret

c00233c2 <set_fs>:
c00233c2:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233c7:	8e e0                	mov    fs,eax
c00233c9:	c3                   	ret

c00233ca <set_gs>:
c00233ca:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233cf:	8e e8                	mov    gs,eax
c00233d1:	c3                   	ret

c00233d2 <set_ss>:
c00233d2:	66 8b 44 24 04       	mov    ax,WORD PTR [esp+0x4]
c00233d7:	8e d0                	mov    ss,eax
c00233d9:	c3                   	ret

c00233da <get_dr0>:
c00233da:	0f 21 c0             	mov    eax,dr0
c00233dd:	c3                   	ret

c00233de <get_dr1>:
c00233de:	0f 21 c8             	mov    eax,dr1
c00233e1:	c3                   	ret

c00233e2 <get_dr2>:
c00233e2:	0f 21 d0             	mov    eax,dr2
c00233e5:	c3                   	ret

c00233e6 <get_dr3>:
c00233e6:	0f 21 d8             	mov    eax,dr3
c00233e9:	c3                   	ret

c00233ea <get_dr6>:
c00233ea:	0f 21 f0             	mov    eax,dr6
c00233ed:	c3                   	ret

c00233ee <get_dr7>:
c00233ee:	0f 21 f8             	mov    eax,dr7
c00233f1:	c3                   	ret

c00233f2 <set_dr0>:
c00233f2:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c00233f6:	0f 23 c0             	mov    dr0,eax
c00233f9:	c3                   	ret

c00233fa <set_dr1>:
c00233fa:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c00233fe:	0f 23 c8             	mov    dr1,eax
c0023401:	c3                   	ret

c0023402 <set_dr2>:
c0023402:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023406:	0f 23 d0             	mov    dr2,eax
c0023409:	c3                   	ret

c002340a <set_dr3>:
c002340a:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002340e:	0f 23 d8             	mov    dr3,eax
c0023411:	c3                   	ret

c0023412 <set_dr6>:
c0023412:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023416:	0f 23 f0             	mov    dr6,eax
c0023419:	c3                   	ret

c002341a <set_dr7>:
c002341a:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002341e:	0f 23 f8             	mov    dr7,eax
c0023421:	c3                   	ret

c0023422 <get_tr6>:
c0023422:	0f 24 f0             	mov    eax,tr6
c0023425:	c3                   	ret

c0023426 <get_tr7>:
c0023426:	0f 24 f8             	mov    eax,tr7
c0023429:	c3                   	ret

c002342a <set_tr6>:
c002342a:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002342e:	0f 26 f0             	mov    tr6,eax
c0023431:	c3                   	ret

c0023432 <set_tr7>:
c0023432:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023436:	0f 26 f8             	mov    tr7,eax
c0023439:	c3                   	ret
c002343a:	66 90                	xchg   ax,ax
c002343c:	66 90                	xchg   ax,ax
c002343e:	66 90                	xchg   ax,ax

c0023440 <invalidate_table_TLB>:
c0023440:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c0023444:	c1 e0 0c             	shl    eax,0xc
c0023447:	0f 01 38             	invlpg BYTE PTR [eax]
c002344a:	c3                   	ret

c002344b <invalidate_directory_TLB>:
c002344b:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
c002344f:	c1 e0 16             	shl    eax,0x16
c0023452:	0f 01 38             	invlpg BYTE PTR [eax]
c0023455:	c3                   	ret

Дизассемблирование раздела .init_section:

c0023456 <kmain>:
c0023456:	55                   	push   ebp
c0023457:	89 e5                	mov    ebp,esp
c0023459:	83 ec 48             	sub    esp,0x48
c002345c:	e8 13 cc ff ff       	call   c0020074 <terminal_initialize>
c0023461:	83 ec 0c             	sub    esp,0xc
c0023464:	68 5c 35 02 c0       	push   0xc002355c
c0023469:	e8 8c d0 ff ff       	call   c00204fa <kprintf>
c002346e:	83 c4 10             	add    esp,0x10
c0023471:	e8 ba fd ff ff       	call   c0023230 <gdt_init>
c0023476:	e8 b6 fe ff ff       	call   c0023331 <get_ebx>
c002347b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
c002347e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
c0023481:	8b 10                	mov    edx,DWORD PTR [eax]
c0023483:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
c0023486:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
c0023489:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
c002348c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
c002348f:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
c0023492:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
c0023495:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
c0023498:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
c002349b:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
c002349e:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
c00234a1:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
c00234a4:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
c00234a7:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
c00234aa:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
c00234ad:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
c00234b0:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
c00234b3:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
c00234b6:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
c00234b9:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
c00234bc:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
c00234bf:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
c00234c2:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
c00234c5:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
c00234c8:	83 ec 0c             	sub    esp,0xc
c00234cb:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
c00234ce:	e8 21 d8 ff ff       	call   c0020cf4 <init_memory>
c00234d3:	83 c4 10             	add    esp,0x10
c00234d6:	e8 3d d7 ff ff       	call   c0020c18 <PIC_remap>
c00234db:	e8 fa d6 ff ff       	call   c0020bda <IDT_load>
c00234e0:	83 ec 0c             	sub    esp,0xc
c00234e3:	68 84 35 02 c0       	push   0xc0023584
c00234e8:	e8 0d d0 ff ff       	call   c00204fa <kprintf>
c00234ed:	83 c4 10             	add    esp,0x10
c00234f0:	b8 00 10 00 00       	mov    eax,0x1000
c00234f5:	0f 22 d8             	mov    cr3,eax
c00234f8:	83 ec 0c             	sub    esp,0xc
c00234fb:	68 88 35 02 c0       	push   0xc0023588
c0023500:	e8 f5 cf ff ff       	call   c00204fa <kprintf>
c0023505:	83 c4 10             	add    esp,0x10
c0023508:	e8 f3 ca ff ff       	call   c0020000 <init_section>
c002350d:	83 ec 0c             	sub    esp,0xc
c0023510:	68 8d 35 02 c0       	push   0xc002358d
c0023515:	e8 d0 d2 ff ff       	call   c00207ea <kpanic>
c002351a:	83 c4 10             	add    esp,0x10
c002351d:	90                   	nop
c002351e:	c9                   	leave
c002351f:	c3                   	ret

Дизассемблирование раздела .rodata:

c0023520 <.rodata>:
c0023520:	43                   	inc    ebx
c0023521:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023522:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023523:	74 72                	je     c0023597 <kmain+0x141>
c0023525:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023526:	6c                   	ins    BYTE PTR es:[edi],dx
c0023527:	20 68 61             	and    BYTE PTR [eax+0x61],ch
c002352a:	73 20                	jae    c002354c <kmain+0xf6>
c002352c:	62 65 65             	bound  esp,QWORD PTR [ebp+0x65]
c002352f:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023530:	20 74 72 61          	and    BYTE PTR [edx+esi*2+0x61],dh
c0023534:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023535:	73 66                	jae    c002359d <kmain+0x147>
c0023537:	65 72 72             	gs jb  c00235ac <kmain+0x156>
c002353a:	65 64 20 74 6f 20    	gs and BYTE PTR fs:[edi+ebp*2+0x20],dh
c0023540:	74 68                	je     c00235aa <kmain+0x154>
c0023542:	65 20 69 6e          	and    BYTE PTR gs:[ecx+0x6e],ch
c0023546:	69 74 69 61 6c 69 7a 	imul   esi,DWORD PTR [ecx+ebp*2+0x61],0x617a696c
c002354d:	61 
c002354e:	74 69                	je     c00235b9 <kmain+0x163>
c0023550:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023551:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023552:	20 73 79             	and    BYTE PTR [ebx+0x79],dh
c0023555:	73 74                	jae    c00235cb <kmain+0x175>
c0023557:	65 6d                	gs ins DWORD PTR es:[edi],dx
c0023559:	00 00                	add    BYTE PTR [eax],al
c002355b:	00 53 4e             	add    BYTE PTR [ebx+0x4e],dl
c002355e:	4b                   	dec    ebx
c002355f:	20 42 6f             	and    BYTE PTR [edx+0x6f],al
c0023562:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023563:	74 65                	je     c00235ca <kmain+0x174>
c0023565:	64 21 20             	and    DWORD PTR fs:[eax],esp
c0023568:	53                   	push   ebx
c0023569:	74 61                	je     c00235cc <kmain+0x176>
c002356b:	72 74                	jb     c00235e1 <kmain+0x18b>
c002356d:	69 6e 67 20 69 6e 69 	imul   ebp,DWORD PTR [esi+0x67],0x696e6920
c0023574:	74 69                	je     c00235df <kmain+0x189>
c0023576:	61                   	popa
c0023577:	6c                   	ins    BYTE PTR es:[edi],dx
c0023578:	69 7a 61 74 69 6f 6e 	imul   edi,DWORD PTR [edx+0x61],0x6e6f6974
c002357f:	2e 2e 2e 0a 00       	cs cs or al,BYTE PTR cs:[eax]
c0023584:	54                   	push   esp
c0023585:	4c                   	dec    esp
c0023586:	42                   	inc    edx
c0023587:	00 54 4c 42          	add    BYTE PTR [esp+ecx*2+0x42],dl
c002358b:	21 00                	and    DWORD PTR [eax],eax
c002358d:	4b                   	dec    ebx
c002358e:	65 72 6e             	gs jb  c00235ff <kmain+0x1a9>
c0023591:	65 6c                	gs ins BYTE PTR es:[edi],dx
c0023593:	20 69 6e             	and    BYTE PTR [ecx+0x6e],ch
c0023596:	69 74 2d 74 69 6f 6e 	imul   esi,DWORD PTR [ebp+ebp*1+0x74],0x206e6f69
c002359d:	20 
c002359e:	66 69 6e 69 73 68    	imul   bp,WORD PTR [esi+0x69],0x6873
c00235a4:	65 64 21 00          	gs and DWORD PTR fs:[eax],eax
c00235a8:	53                   	push   ebx
c00235a9:	65 72 69             	gs jb  c0023615 <kmain+0x1bf>
c00235ac:	61                   	popa
c00235ad:	6c                   	ins    BYTE PTR es:[edi],dx
c00235ae:	20 63 6f             	and    BYTE PTR [ebx+0x6f],ah
c00235b1:	6e                   	outs   dx,BYTE PTR ds:[esi]
c00235b2:	73 6f                	jae    c0023623 <kmain+0x1cd>
c00235b4:	6c                   	ins    BYTE PTR es:[edi],dx
c00235b5:	65 20 69 6e          	and    BYTE PTR gs:[ecx+0x6e],ch
c00235b9:	69 74 69 61 6c 69 7a 	imul   esi,DWORD PTR [ecx+ebp*2+0x61],0x657a696c
c00235c0:	65 
c00235c1:	64 0a 00             	or     al,BYTE PTR fs:[eax]
c00235c4:	30 31                	xor    BYTE PTR [ecx],dh
c00235c6:	32 33                	xor    dh,BYTE PTR [ebx]
c00235c8:	34 35                	xor    al,0x35
c00235ca:	36 37                	ss aaa
c00235cc:	38 39                	cmp    BYTE PTR [ecx],bh
c00235ce:	41                   	inc    ecx
c00235cf:	42                   	inc    edx
c00235d0:	43                   	inc    ebx
c00235d1:	44                   	inc    esp
c00235d2:	45                   	inc    ebp
c00235d3:	46                   	inc    esi
c00235d4:	00 25 6c 6c 00 00    	add    BYTE PTR ds:0x6c6c,ah
c00235da:	00 00                	add    BYTE PTR [eax],al
c00235dc:	6c                   	ins    BYTE PTR es:[edi],dx
c00235dd:	07                   	pop    es
c00235de:	02 c0                	add    al,al
c00235e0:	d2 06                	rol    BYTE PTR [esi],cl
c00235e2:	02 c0                	add    al,al
c00235e4:	9b                   	fwait
c00235e5:	07                   	pop    es
c00235e6:	02 c0                	add    al,al
c00235e8:	9b                   	fwait
c00235e9:	07                   	pop    es
c00235ea:	02 c0                	add    al,al
c00235ec:	9b                   	fwait
c00235ed:	07                   	pop    es
c00235ee:	02 c0                	add    al,al
c00235f0:	9b                   	fwait
c00235f1:	07                   	pop    es
c00235f2:	02 c0                	add    al,al
c00235f4:	9b                   	fwait
c00235f5:	07                   	pop    es
c00235f6:	02 c0                	add    al,al
c00235f8:	9b                   	fwait
c00235f9:	07                   	pop    es
c00235fa:	02 c0                	add    al,al
c00235fc:	9b                   	fwait
c00235fd:	07                   	pop    es
c00235fe:	02 c0                	add    al,al
c0023600:	9b                   	fwait
c0023601:	07                   	pop    es
c0023602:	02 c0                	add    al,al
c0023604:	9b                   	fwait
c0023605:	07                   	pop    es
c0023606:	02 c0                	add    al,al
c0023608:	9b                   	fwait
c0023609:	07                   	pop    es
c002360a:	02 c0                	add    al,al
c002360c:	9b                   	fwait
c002360d:	07                   	pop    es
c002360e:	02 c0                	add    al,al
c0023610:	9b                   	fwait
c0023611:	07                   	pop    es
c0023612:	02 c0                	add    al,al
c0023614:	9b                   	fwait
c0023615:	07                   	pop    es
c0023616:	02 c0                	add    al,al
c0023618:	9b                   	fwait
c0023619:	07                   	pop    es
c002361a:	02 c0                	add    al,al
c002361c:	b1 06                	mov    cl,0x6
c002361e:	02 c0                	add    al,al
c0023620:	9b                   	fwait
c0023621:	07                   	pop    es
c0023622:	02 c0                	add    al,al
c0023624:	3a 07                	cmp    al,BYTE PTR [edi]
c0023626:	02 c0                	add    al,al
c0023628:	9b                   	fwait
c0023629:	07                   	pop    es
c002362a:	02 c0                	add    al,al
c002362c:	9b                   	fwait
c002362d:	07                   	pop    es
c002362e:	02 c0                	add    al,al
c0023630:	06                   	push   es
c0023631:	07                   	pop    es
c0023632:	02 c0                	add    al,al
c0023634:	0a 21                	or     ah,BYTE PTR [ecx]
c0023636:	21 21                	and    DWORD PTR [ecx],esp
c0023638:	20 4b 45             	and    BYTE PTR [ebx+0x45],cl
c002363b:	52                   	push   edx
c002363c:	4e                   	dec    esi
c002363d:	45                   	inc    ebp
c002363e:	4c                   	dec    esp
c002363f:	20 50 41             	and    BYTE PTR [eax+0x41],dl
c0023642:	4e                   	dec    esi
c0023643:	49                   	dec    ecx
c0023644:	43                   	inc    ebx
c0023645:	20 21                	and    BYTE PTR [ecx],ah
c0023647:	21 21                	and    DWORD PTR [ecx],esp
c0023649:	0a 00                	or     al,BYTE PTR [eax]
c002364b:	52                   	push   edx
c002364c:	65 61                	gs popa
c002364e:	73 6f                	jae    c00236bf <kmain+0x269>
c0023650:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023651:	3a 20                	cmp    ah,BYTE PTR [eax]
c0023653:	25 73 0a 00 53       	and    eax,0x53000a73
c0023658:	79 73                	jns    c00236cd <kmain+0x277>
c002365a:	74 65                	je     c00236c1 <kmain+0x26b>
c002365c:	6d                   	ins    DWORD PTR es:[edi],dx
c002365d:	20 68 61             	and    BYTE PTR [eax+0x61],ch
c0023660:	6c                   	ins    BYTE PTR es:[edi],dx
c0023661:	74 65                	je     c00236c8 <kmain+0x272>
c0023663:	64 2e 0a 00          	fs or  al,BYTE PTR cs:[eax]
c0023667:	30 31                	xor    BYTE PTR [ecx],dh
c0023669:	32 33                	xor    dh,BYTE PTR [ebx]
c002366b:	34 35                	xor    al,0x35
c002366d:	36 37                	ss aaa
c002366f:	38 39                	cmp    BYTE PTR [ecx],bh
c0023671:	41                   	inc    ecx
c0023672:	42                   	inc    edx
c0023673:	43                   	inc    ebx
c0023674:	44                   	inc    esp
c0023675:	45                   	inc    ebp
c0023676:	46                   	inc    esi
c0023677:	00 4d 75             	add    BYTE PTR [ebp+0x75],cl
c002367a:	6c                   	ins    BYTE PTR es:[edi],dx
c002367b:	74 69                	je     c00236e6 <kmain+0x290>
c002367d:	62 6f 6f             	bound  ebp,QWORD PTR [edi+0x6f]
c0023680:	74 20                	je     c00236a2 <kmain+0x24c>
c0023682:	64 6f                	outs   dx,DWORD PTR fs:[esi]
c0023684:	65 73 6e             	gs jae c00236f5 <kmain+0x29f>
c0023687:	27                   	daa
c0023688:	74 20                	je     c00236aa <kmain+0x254>
c002368a:	70 72                	jo     c00236fe <kmain+0x2a8>
c002368c:	6f                   	outs   dx,DWORD PTR ds:[esi]
c002368d:	76 69                	jbe    c00236f8 <kmain+0x2a2>
c002368f:	64 65 20 6d 65       	fs and BYTE PTR gs:[ebp+0x65],ch
c0023694:	6d                   	ins    DWORD PTR es:[edi],dx
c0023695:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023696:	72 79                	jb     c0023711 <kmain+0x2bb>
c0023698:	20 69 6e             	and    BYTE PTR [ecx+0x6e],ch
c002369b:	66 6f                	outs   dx,WORD PTR ds:[esi]
c002369d:	72 6d                	jb     c002370c <kmain+0x2b6>
c002369f:	61                   	popa
c00236a0:	74 69                	je     c002370b <kmain+0x2b5>
c00236a2:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236a3:	6e                   	outs   dx,BYTE PTR ds:[esi]
c00236a4:	21 00                	and    DWORD PTR [eax],eax
c00236a6:	00 00                	add    BYTE PTR [eax],al
c00236a8:	4e                   	dec    esi
c00236a9:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236aa:	20 6d 65             	and    BYTE PTR [ebp+0x65],ch
c00236ad:	6d                   	ins    DWORD PTR es:[edi],dx
c00236ae:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236af:	72 79                	jb     c002372a <kmain+0x2d4>
c00236b1:	20 6d 61             	and    BYTE PTR [ebp+0x61],ch
c00236b4:	70 20                	jo     c00236d6 <kmain+0x280>
c00236b6:	61                   	popa
c00236b7:	76 61                	jbe    c002371a <kmain+0x2c4>
c00236b9:	69 6c 61 62 6c 65 20 	imul   ebp,DWORD PTR [ecx+eiz*2+0x62],0x6620656c
c00236c0:	66 
c00236c1:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236c2:	72 20                	jb     c00236e4 <kmain+0x28e>
c00236c4:	72 65                	jb     c002372b <kmain+0x2d5>
c00236c6:	67 69 6f 6e 20 66 69 	imul   ebp,DWORD PTR [bx+0x6e],0x6e696620
c00236cd:	6e 
c00236ce:	64 69 6e 67 21 00 50 	imul   ebp,DWORD PTR fs:[esi+0x67],0x4d500021
c00236d5:	4d 
c00236d6:	4d                   	dec    ebp
c00236d7:	3a 20                	cmp    ah,BYTE PTR [eax]
c00236d9:	4e                   	dec    esi
c00236da:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236db:	20 6d 65             	and    BYTE PTR [ebp+0x65],ch
c00236de:	6d                   	ins    DWORD PTR es:[edi],dx
c00236df:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236e0:	72 79                	jb     c002375b <kmain+0x305>
c00236e2:	20 6d 61             	and    BYTE PTR [ebp+0x61],ch
c00236e5:	70 20                	jo     c0023707 <kmain+0x2b1>
c00236e7:	70 72                	jo     c002375b <kmain+0x305>
c00236e9:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236ea:	76 69                	jbe    c0023755 <kmain+0x2ff>
c00236ec:	64 65 64 20 62 79    	fs gs and BYTE PTR fs:[edx+0x79],ah
c00236f2:	20 62 6f             	and    BYTE PTR [edx+0x6f],ah
c00236f5:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236f6:	74 6c                	je     c0023764 <kmain+0x30e>
c00236f8:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00236f9:	61                   	popa
c00236fa:	64 65 72 21          	fs gs jb c002371f <kmain+0x2c9>
c00236fe:	00 00                	add    BYTE PTR [eax],al
c0023700:	42                   	inc    edx
c0023701:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023702:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023703:	74 6c                	je     c0023771 <kmain+0x31b>
c0023705:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023706:	61                   	popa
c0023707:	64 65 72 20          	fs gs jb c002372b <kmain+0x2d5>
c002370b:	6f                   	outs   dx,DWORD PTR ds:[esi]
c002370c:	72 20                	jb     c002372e <kmain+0x2d8>
c002370e:	53                   	push   ebx
c002370f:	79 73                	jns    c0023784 <kmain+0x32e>
c0023711:	74 65                	je     c0023778 <kmain+0x322>
c0023713:	6d                   	ins    DWORD PTR es:[edi],dx
c0023714:	20 69 73             	and    BYTE PTR [ecx+0x73],ch
c0023717:	20 6e 6f             	and    BYTE PTR [esi+0x6f],ch
c002371a:	74 20                	je     c002373c <kmain+0x2e6>
c002371c:	70 72                	jo     c0023790 <kmain+0x33a>
c002371e:	6f                   	outs   dx,DWORD PTR ds:[esi]
c002371f:	76 69                	jbe    c002378a <kmain+0x334>
c0023721:	64 65 64 20 6d 65    	fs gs and BYTE PTR fs:[ebp+0x65],ch
c0023727:	6d                   	ins    DWORD PTR es:[edi],dx
c0023728:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023729:	72 79                	jb     c00237a4 <kmain+0x34e>
c002372b:	00 4d 61             	add    BYTE PTR [ebp+0x61],cl
c002372e:	70 70                	jo     c00237a0 <kmain+0x34a>
c0023730:	69 6e 67 20 69 6e 66 	imul   ebp,DWORD PTR [esi+0x67],0x666e6920
c0023737:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023738:	20 66 6f             	and    BYTE PTR [esi+0x6f],ah
c002373b:	72 20                	jb     c002375d <kmain+0x307>
c002373d:	76 69                	jbe    c00237a8 <kmain+0x352>
c002373f:	72 74                	jb     c00237b5 <kmain+0x35f>
c0023741:	75 61                	jne    c00237a4 <kmain+0x34e>
c0023743:	6c                   	ins    BYTE PTR es:[edi],dx
c0023744:	20 61 64             	and    BYTE PTR [ecx+0x64],ah
c0023747:	64 72 65             	fs jb  c00237af <kmain+0x359>
c002374a:	73 73                	jae    c00237bf <kmain+0x369>
c002374c:	20 30                	and    BYTE PTR [eax],dh
c002374e:	78 25                	js     c0023775 <kmain+0x31f>
c0023750:	30 38                	xor    BYTE PTR [eax],bh
c0023752:	58                   	pop    eax
c0023753:	3a 0a                	cmp    cl,BYTE PTR [edx]
c0023755:	00 20                	add    BYTE PTR [eax],ah
c0023757:	20 50 44             	and    BYTE PTR [eax+0x44],dl
c002375a:	45                   	inc    ebp
c002375b:	20 49 6e             	and    BYTE PTR [ecx+0x6e],cl
c002375e:	64 65 78 3a          	fs gs js c002379c <kmain+0x346>
c0023762:	20 25 75 20 28 30    	and    BYTE PTR ds:0x30282075,ah
c0023768:	78 25                	js     c002378f <kmain+0x339>
c002376a:	30 33                	xor    BYTE PTR [ebx],dh
c002376c:	58                   	pop    eax
c002376d:	29 0a                	sub    DWORD PTR [edx],ecx
c002376f:	00 20                	add    BYTE PTR [eax],ah
c0023771:	20 50 54             	and    BYTE PTR [eax+0x54],dl
c0023774:	45                   	inc    ebp
c0023775:	20 49 6e             	and    BYTE PTR [ecx+0x6e],cl
c0023778:	64 65 78 3a          	fs gs js c00237b6 <kmain+0x360>
c002377c:	20 25 75 20 28 30    	and    BYTE PTR ds:0x30282075,ah
c0023782:	78 25                	js     c00237a9 <kmain+0x353>
c0023784:	30 33                	xor    BYTE PTR [ebx],dh
c0023786:	58                   	pop    eax
c0023787:	29 0a                	sub    DWORD PTR [edx],ecx
c0023789:	00 20                	add    BYTE PTR [eax],ah
c002378b:	20 4f 66             	and    BYTE PTR [edi+0x66],cl
c002378e:	66 73 65             	data16 jae c00237f6 <kmain+0x3a0>
c0023791:	74 3a                	je     c00237cd <kmain+0x377>
c0023793:	20 30                	and    BYTE PTR [eax],dh
c0023795:	78 25                	js     c00237bc <kmain+0x366>
c0023797:	30 33                	xor    BYTE PTR [ebx],dh
c0023799:	58                   	pop    eax
c002379a:	0a 00                	or     al,BYTE PTR [eax]
c002379c:	20 20                	and    BYTE PTR [eax],ah
c002379e:	5b                   	pop    ebx
c002379f:	4e                   	dec    esi
c00237a0:	4f                   	dec    edi
c00237a1:	54                   	push   esp
c00237a2:	20 4d 41             	and    BYTE PTR [ebp+0x41],cl
c00237a5:	50                   	push   eax
c00237a6:	50                   	push   eax
c00237a7:	45                   	inc    ebp
c00237a8:	44                   	inc    esp
c00237a9:	5d                   	pop    ebp
c00237aa:	20 50 44             	and    BYTE PTR [eax+0x44],dl
c00237ad:	45                   	inc    ebp
c00237ae:	20 6e 6f             	and    BYTE PTR [esi+0x6f],ch
c00237b1:	74 20                	je     c00237d3 <kmain+0x37d>
c00237b3:	70 72                	jo     c0023827 <kmain+0x3d1>
c00237b5:	65 73 65             	gs jae c002381d <kmain+0x3c7>
c00237b8:	6e                   	outs   dx,BYTE PTR ds:[esi]
c00237b9:	74 0a                	je     c00237c5 <kmain+0x36f>
c00237bb:	00 20                	add    BYTE PTR [eax],ah
c00237bd:	20 34 4d 42 20 50 61 	and    BYTE PTR [ecx*2+0x61502042],dh
c00237c4:	67 65 20 4d 61       	and    BYTE PTR gs:[di+0x61],cl
c00237c9:	70 70                	jo     c002383b <kmain+0x3e5>
c00237cb:	69 6e 67 3a 0a 00 20 	imul   ebp,DWORD PTR [esi+0x67],0x20000a3a
c00237d2:	20 20                	and    BYTE PTR [eax],ah
c00237d4:	20 50 68             	and    BYTE PTR [eax+0x68],dl
c00237d7:	79 73                	jns    c002384c <kmain+0x3f6>
c00237d9:	69 63 61 6c 20 41 64 	imul   esp,DWORD PTR [ebx+0x61],0x6441206c
c00237e0:	64 72 65             	fs jb  c0023848 <kmain+0x3f2>
c00237e3:	73 73                	jae    c0023858 <kmain+0x402>
c00237e5:	3a 20                	cmp    ah,BYTE PTR [eax]
c00237e7:	30 78 25             	xor    BYTE PTR [eax+0x25],bh
c00237ea:	30 38                	xor    BYTE PTR [eax],bh
c00237ec:	58                   	pop    eax
c00237ed:	0a 00                	or     al,BYTE PTR [eax]
c00237ef:	00 20                	add    BYTE PTR [eax],ah
c00237f1:	20 20                	and    BYTE PTR [eax],ah
c00237f3:	20 50 44             	and    BYTE PTR [eax+0x44],dl
c00237f6:	45                   	inc    ebp
c00237f7:	20 46 6c             	and    BYTE PTR [esi+0x6c],al
c00237fa:	61                   	popa
c00237fb:	67 73 3a             	addr16 jae c0023838 <kmain+0x3e2>
c00237fe:	20 50 3d             	and    BYTE PTR [eax+0x3d],dl
c0023801:	25 64 2c 20 52       	and    eax,0x52202c64
c0023806:	2f                   	das
c0023807:	57                   	push   edi
c0023808:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c002380d:	55                   	push   ebp
c002380e:	2f                   	das
c002380f:	53                   	push   ebx
c0023810:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c0023815:	50                   	push   eax
c0023816:	57                   	push   edi
c0023817:	54                   	push   esp
c0023818:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c002381d:	50                   	push   eax
c002381e:	43                   	inc    ebx
c002381f:	44                   	inc    esp
c0023820:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c0023825:	41                   	inc    ecx
c0023826:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c002382b:	44                   	inc    esp
c002382c:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c0023831:	50                   	push   eax
c0023832:	53                   	push   ebx
c0023833:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c0023838:	47                   	inc    edi
c0023839:	3d 25 64 0a 00       	cmp    eax,0xa6425
c002383e:	00 00                	add    BYTE PTR [eax],al
c0023840:	20 20                	and    BYTE PTR [eax],ah
c0023842:	5b                   	pop    ebx
c0023843:	4e                   	dec    esi
c0023844:	4f                   	dec    edi
c0023845:	54                   	push   esp
c0023846:	20 4d 41             	and    BYTE PTR [ebp+0x41],cl
c0023849:	50                   	push   eax
c002384a:	50                   	push   eax
c002384b:	45                   	inc    ebp
c002384c:	44                   	inc    esp
c002384d:	5d                   	pop    ebp
c002384e:	20 50 54             	and    BYTE PTR [eax+0x54],dl
c0023851:	45                   	inc    ebp
c0023852:	20 6e 6f             	and    BYTE PTR [esi+0x6f],ch
c0023855:	74 20                	je     c0023877 <kmain+0x421>
c0023857:	70 72                	jo     c00238cb <kmain+0x475>
c0023859:	65 73 65             	gs jae c00238c1 <kmain+0x46b>
c002385c:	6e                   	outs   dx,BYTE PTR ds:[esi]
c002385d:	74 0a                	je     c0023869 <kmain+0x413>
c002385f:	00 20                	add    BYTE PTR [eax],ah
c0023861:	20 34 4b             	and    BYTE PTR [ebx+ecx*2],dh
c0023864:	42                   	inc    edx
c0023865:	20 50 61             	and    BYTE PTR [eax+0x61],dl
c0023868:	67 65 20 4d 61       	and    BYTE PTR gs:[di+0x61],cl
c002386d:	70 70                	jo     c00238df <kmain+0x489>
c002386f:	69 6e 67 3a 0a 00 00 	imul   ebp,DWORD PTR [esi+0x67],0xa3a
c0023876:	00 00                	add    BYTE PTR [eax],al
c0023878:	20 20                	and    BYTE PTR [eax],ah
c002387a:	20 20                	and    BYTE PTR [eax],ah
c002387c:	50                   	push   eax
c002387d:	54                   	push   esp
c002387e:	45                   	inc    ebp
c002387f:	20 46 6c             	and    BYTE PTR [esi+0x6c],al
c0023882:	61                   	popa
c0023883:	67 73 3a             	addr16 jae c00238c0 <kmain+0x46a>
c0023886:	20 50 3d             	and    BYTE PTR [eax+0x3d],dl
c0023889:	25 64 2c 20 52       	and    eax,0x52202c64
c002388e:	2f                   	das
c002388f:	57                   	push   edi
c0023890:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c0023895:	55                   	push   ebp
c0023896:	2f                   	das
c0023897:	53                   	push   ebx
c0023898:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c002389d:	50                   	push   eax
c002389e:	57                   	push   edi
c002389f:	54                   	push   esp
c00238a0:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c00238a5:	50                   	push   eax
c00238a6:	43                   	inc    ebx
c00238a7:	44                   	inc    esp
c00238a8:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c00238ad:	41                   	inc    ecx
c00238ae:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c00238b3:	44                   	inc    esp
c00238b4:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c00238b9:	50                   	push   eax
c00238ba:	41                   	inc    ecx
c00238bb:	54                   	push   esp
c00238bc:	3d 25 64 2c 20       	cmp    eax,0x202c6425
c00238c1:	47                   	inc    edi
c00238c2:	3d 25 64 0a 00       	cmp    eax,0xa6425
c00238c7:	00 50 61             	add    BYTE PTR [eax+0x61],dl
c00238ca:	67 69 6e 67 20 56 61 	imul   ebp,DWORD PTR [bp+0x67],0x6c615620
c00238d1:	6c 
c00238d2:	69 64 61 74 69 6f 6e 	imul   esp,DWORD PTR [ecx+eiz*2+0x74],0x206e6f69
c00238d9:	20 
c00238da:	45                   	inc    ebp
c00238db:	72 72                	jb     c002394f <kmain+0x4f9>
c00238dd:	6f                   	outs   dx,DWORD PTR ds:[esi]
c00238de:	72 3a                	jb     c002391a <kmain+0x4c4>
c00238e0:	20 4b 65             	and    BYTE PTR [ebx+0x65],cl
c00238e3:	72 6e                	jb     c0023953 <kmain+0x4fd>
c00238e5:	65 6c                	gs ins BYTE PTR es:[edi],dx
c00238e7:	20 50 44             	and    BYTE PTR [eax+0x44],dl
c00238ea:	45                   	inc    ebp
c00238eb:	20 25 64 20 6e 6f    	and    BYTE PTR ds:0x6f6e2064,ah
c00238f1:	74 20                	je     c0023913 <kmain+0x4bd>
c00238f3:	70 72                	jo     c0023967 <kmain+0x511>
c00238f5:	65 73 65             	gs jae c002395d <kmain+0x507>
c00238f8:	6e                   	outs   dx,BYTE PTR ds:[esi]
c00238f9:	74 21                	je     c002391c <kmain+0x4c6>
c00238fb:	0a 00                	or     al,BYTE PTR [eax]
c00238fd:	00 00                	add    BYTE PTR [eax],al
c00238ff:	00 50 61             	add    BYTE PTR [eax+0x61],dl
c0023902:	67 69 6e 67 20 56 61 	imul   ebp,DWORD PTR [bp+0x67],0x6c615620
c0023909:	6c 
c002390a:	69 64 61 74 69 6f 6e 	imul   esp,DWORD PTR [ecx+eiz*2+0x74],0x206e6f69
c0023911:	20 
c0023912:	45                   	inc    ebp
c0023913:	72 72                	jb     c0023987 <kmain+0x531>
c0023915:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023916:	72 3a                	jb     c0023952 <kmain+0x4fc>
c0023918:	20 4b 65             	and    BYTE PTR [ebx+0x65],cl
c002391b:	72 6e                	jb     c002398b <kmain+0x535>
c002391d:	65 6c                	gs ins BYTE PTR es:[edi],dx
c002391f:	20 74 61 62          	and    BYTE PTR [ecx+eiz*2+0x62],dh
c0023923:	6c                   	ins    BYTE PTR es:[edi],dx
c0023924:	65 20 25 64 20 69 73 	and    BYTE PTR gs:0x73692064,ah
c002392b:	20 4e 55             	and    BYTE PTR [esi+0x55],cl
c002392e:	4c                   	dec    esp
c002392f:	4c                   	dec    esp
c0023930:	21 0a                	and    DWORD PTR [edx],ecx
c0023932:	00 00                	add    BYTE PTR [eax],al
c0023934:	50                   	push   eax
c0023935:	61                   	popa
c0023936:	67 69 6e 67 20 56 61 	imul   ebp,DWORD PTR [bp+0x67],0x6c615620
c002393d:	6c 
c002393e:	69 64 61 74 69 6f 6e 	imul   esp,DWORD PTR [ecx+eiz*2+0x74],0x206e6f69
c0023945:	20 
c0023946:	57                   	push   edi
c0023947:	61                   	popa
c0023948:	72 6e                	jb     c00239b8 <kmain+0x562>
c002394a:	69 6e 67 3a 20 55 73 	imul   ebp,DWORD PTR [esi+0x67],0x7355203a
c0023951:	65 72 20             	gs jb  c0023974 <kmain+0x51e>
c0023954:	50                   	push   eax
c0023955:	44                   	inc    esp
c0023956:	45                   	inc    ebp
c0023957:	20 25 64 20 68 61    	and    BYTE PTR ds:0x61682064,ah
c002395d:	73 20                	jae    c002397f <kmain+0x529>
c002395f:	73 75                	jae    c00239d6 <kmain+0x580>
c0023961:	70 65                	jo     c00239c8 <kmain+0x572>
c0023963:	72 76                	jb     c00239db <kmain+0x585>
c0023965:	69 73 6f 72 20 70 72 	imul   esi,DWORD PTR [ebx+0x6f],0x72702072
c002396c:	69 76 69 6c 65 67 65 	imul   esi,DWORD PTR [esi+0x69],0x6567656c
c0023973:	73 0a                	jae    c002397f <kmain+0x529>
c0023975:	00 00                	add    BYTE PTR [eax],al
c0023977:	00 50 61             	add    BYTE PTR [eax+0x61],dl
c002397a:	67 69 6e 67 20 56 61 	imul   ebp,DWORD PTR [bp+0x67],0x6c615620
c0023981:	6c 
c0023982:	69 64 61 74 69 6f 6e 	imul   esp,DWORD PTR [ecx+eiz*2+0x74],0x206e6f69
c0023989:	20 
c002398a:	45                   	inc    ebp
c002398b:	72 72                	jb     c00239ff <kmain+0x5a9>
c002398d:	6f                   	outs   dx,DWORD PTR ds:[esi]
c002398e:	72 3a                	jb     c00239ca <kmain+0x574>
c0023990:	20 55 73             	and    BYTE PTR [ebp+0x73],dl
c0023993:	65 72 20             	gs jb  c00239b6 <kmain+0x560>
c0023996:	74 61                	je     c00239f9 <kmain+0x5a3>
c0023998:	62 6c 65 20          	bound  ebp,QWORD PTR [ebp+eiz*2+0x20]
c002399c:	25 64 20 69 73       	and    eax,0x73692064
c00239a1:	20 4e 55             	and    BYTE PTR [esi+0x55],cl
c00239a4:	4c                   	dec    esp
c00239a5:	4c                   	dec    esp
c00239a6:	21 0a                	and    DWORD PTR [edx],ecx
c00239a8:	00 00                	add    BYTE PTR [eax],al
c00239aa:	00 00                	add    BYTE PTR [eax],al
c00239ac:	50                   	push   eax
c00239ad:	61                   	popa
c00239ae:	67 69 6e 67 20 56 61 	imul   ebp,DWORD PTR [bp+0x67],0x6c615620
c00239b5:	6c 
c00239b6:	69 64 61 74 69 6f 6e 	imul   esp,DWORD PTR [ecx+eiz*2+0x74],0x206e6f69
c00239bd:	20 
c00239be:	57                   	push   edi
c00239bf:	61                   	popa
c00239c0:	72 6e                	jb     c0023a30 <kmain+0x5da>
c00239c2:	69 6e 67 3a 20 55 73 	imul   ebp,DWORD PTR [esi+0x67],0x7355203a
c00239c9:	65 72 20             	gs jb  c00239ec <kmain+0x596>
c00239cc:	50                   	push   eax
c00239cd:	54                   	push   esp
c00239ce:	45                   	inc    ebp
c00239cf:	20 25 64 3a 25 64    	and    BYTE PTR ds:0x64253a64,ah
c00239d5:	20 68 61             	and    BYTE PTR [eax+0x61],ch
c00239d8:	73 20                	jae    c00239fa <kmain+0x5a4>
c00239da:	73 75                	jae    c0023a51 <kmain+0x5fb>
c00239dc:	70 65                	jo     c0023a43 <kmain+0x5ed>
c00239de:	72 76                	jb     c0023a56 <kmain+0x600>
c00239e0:	69 73 6f 72 20 70 72 	imul   esi,DWORD PTR [ebx+0x6f],0x72702072
c00239e7:	69 76 69 6c 65 67 65 	imul   esi,DWORD PTR [esi+0x69],0x6567656c
c00239ee:	73 0a                	jae    c00239fa <kmain+0x5a4>
c00239f0:	00 00                	add    BYTE PTR [eax],al
c00239f2:	00 00                	add    BYTE PTR [eax],al
c00239f4:	50                   	push   eax
c00239f5:	61                   	popa
c00239f6:	67 69 6e 67 20 53 74 	imul   ebp,DWORD PTR [bp+0x67],0x61745320
c00239fd:	61 
c00239fe:	74 73                	je     c0023a73 <kmain+0x61d>
c0023a00:	3a 20                	cmp    ah,BYTE PTR [eax]
c0023a02:	49                   	dec    ecx
c0023a03:	6e                   	outs   dx,BYTE PTR ds:[esi]
c0023a04:	76 61                	jbe    c0023a67 <kmain+0x611>
c0023a06:	6c                   	ins    BYTE PTR es:[edi],dx
c0023a07:	69 64 20 64 69 72 65 	imul   esp,DWORD PTR [eax+eiz*1+0x64],0x63657269
c0023a0e:	63 
c0023a0f:	74 6f                	je     c0023a80 <kmain+0x62a>
c0023a11:	72 79                	jb     c0023a8c <kmain+0x636>
c0023a13:	0a 00                	or     al,BYTE PTR [eax]
c0023a15:	50                   	push   eax
c0023a16:	61                   	popa
c0023a17:	67 69 6e 67 20 53 74 	imul   ebp,DWORD PTR [bp+0x67],0x61745320
c0023a1e:	61 
c0023a1f:	74 69                	je     c0023a8a <kmain+0x634>
c0023a21:	73 74                	jae    c0023a97 <vga_color+0x3>
c0023a23:	69 63 73 3a 0a 00 20 	imul   esp,DWORD PTR [ebx+0x73],0x20000a3a
c0023a2a:	20 55 73             	and    BYTE PTR [ebp+0x73],dl
c0023a2d:	65 72 20             	gs jb  c0023a50 <kmain+0x5fa>
c0023a30:	53                   	push   ebx
c0023a31:	70 61                	jo     c0023a94 <vga_color>
c0023a33:	63 65 3a             	arpl   WORD PTR [ebp+0x3a],sp
c0023a36:	0a 00                	or     al,BYTE PTR [eax]
c0023a38:	20 20                	and    BYTE PTR [eax],ah
c0023a3a:	20 20                	and    BYTE PTR [eax],ah
c0023a3c:	54                   	push   esp
c0023a3d:	61                   	popa
c0023a3e:	62 6c 65 73          	bound  ebp,QWORD PTR [ebp+eiz*2+0x73]
c0023a42:	3a 20                	cmp    ah,BYTE PTR [eax]
c0023a44:	25 75 2c 20 34       	and    eax,0x34202c75
c0023a49:	4b                   	dec    ebx
c0023a4a:	42                   	inc    edx
c0023a4b:	20 50 61             	and    BYTE PTR [eax+0x61],dl
c0023a4e:	67 65 73 3a          	addr16 gs jae c0023a8c <kmain+0x636>
c0023a52:	20 25 75 2c 20 34    	and    BYTE PTR ds:0x34202c75,ah
c0023a58:	4d                   	dec    ebp
c0023a59:	42                   	inc    edx
c0023a5a:	20 50 61             	and    BYTE PTR [eax+0x61],dl
c0023a5d:	67 65 73 3a          	addr16 gs jae c0023a9b <last_alloc.0+0x3>
c0023a61:	20 25 75 0a 00 20    	and    BYTE PTR ds:0x20000a75,ah
c0023a67:	20 4b 65             	and    BYTE PTR [ebx+0x65],cl
c0023a6a:	72 6e                	jb     c0023ada <serial_enabled+0x12>
c0023a6c:	65 6c                	gs ins BYTE PTR es:[edi],dx
c0023a6e:	20 53 70             	and    BYTE PTR [ebx+0x70],dl
c0023a71:	61                   	popa
c0023a72:	63 65 3a             	arpl   WORD PTR [ebp+0x3a],sp
c0023a75:	0a 00                	or     al,BYTE PTR [eax]
c0023a77:	20 20                	and    BYTE PTR [eax],ah
c0023a79:	54                   	push   esp
c0023a7a:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023a7b:	74 61                	je     c0023ade <serial_enabled+0x16>
c0023a7d:	6c                   	ins    BYTE PTR es:[edi],dx
c0023a7e:	20 4d 65             	and    BYTE PTR [ebp+0x65],cl
c0023a81:	6d                   	ins    DWORD PTR es:[edi],dx
c0023a82:	6f                   	outs   dx,DWORD PTR ds:[esi]
c0023a83:	72 79                	jb     c0023afe <IDT_table+0x1e>
c0023a85:	3a 20                	cmp    ah,BYTE PTR [eax]
c0023a87:	25 75 20 4b 42       	and    eax,0x424b2075
c0023a8c:	0a 00                	or     al,BYTE PTR [eax]

Дизассемблирование раздела .data:

c0023a90 <vga_buffer>:
c0023a90:	00 80 0b 00      	add    BYTE PTR [eax+0xf000b],al

c0023a94 <vga_color>:
c0023a94:	0f 00 00             	sldt   WORD PTR [eax]
	...

c0023a98 <last_alloc.0>:
c0023a98:	00 01                	add    BYTE PTR [ecx],al
	...

c0023a9c <gdt>:
	...
c0023aa4:	ff                   	(bad)
c0023aa5:	ff 00                	inc    DWORD PTR [eax]
c0023aa7:	00 00                	add    BYTE PTR [eax],al
c0023aa9:	9a cf 00 ff ff 00 00 	call   0x0:0xffff00cf
c0023ab0:	00 92 cf 00      	add    BYTE PTR [edx+0x1700cf],dl

c0023ab4 <gdt_info>:
c0023ab4:	17                   	pop    ss
c0023ab5:	00                   	.byte 0x0
c0023ab6:	9c                   	pushf
c0023ab7:	3a 02                	cmp    al,BYTE PTR [edx]
c0023ab9:	c0                   	.byte 0xc0

Дизассемблирование раздела .bss:

c0023ac0 <vga_row>:
c0023ac0:	00 00                	add    BYTE PTR [eax],al
	...

c0023ac4 <vga_column>:
c0023ac4:	00 00                	add    BYTE PTR [eax],al
	...

c0023ac8 <serial_enabled>:
	...

c0023ae0 <IDT_table>:
	...

c00242e0 <IDT_desc>:
	...

c00242e8 <pmm_state>:
	...

c0024304 <current_space>:
c0024304:	00 00                	add    BYTE PTR [eax],al
	...

Дизассемблирование раздела .comment:

00000000 <.comment>:
   0:	47                   	inc    edi
   1:	43                   	inc    ebx
   2:	43                   	inc    ebx
   3:	3a 20                	cmp    ah,BYTE PTR [eax]
   5:	28 47 4e             	sub    BYTE PTR [edi+0x4e],al
   8:	55                   	push   ebp
   9:	29 20                	sub    DWORD PTR [eax],esp
   b:	31 33                	xor    DWORD PTR [ebx],esi
   d:	2e 33 2e             	xor    ebp,DWORD PTR cs:[esi]
  10:	31 20                	xor    DWORD PTR [eax],esp
  12:	32 30                	xor    dh,BYTE PTR [eax]
  14:	32 35 30 34 31 38    	xor    dh,BYTE PTR ds:0x38313430
  1a:	20 28                	and    BYTE PTR [eax],ch
  1c:	52                   	push   edx
  1d:	45                   	inc    ebp
  1e:	44                   	inc    esp
  1f:	20 53 4f             	and    BYTE PTR [ebx+0x4f],dl
  22:	46                   	inc    esi
  23:	54                   	push   esp
  24:	20 31                	and    BYTE PTR [ecx],dh
  26:	33 2e                	xor    ebp,DWORD PTR [esi]
  28:	33 2e                	xor    ebp,DWORD PTR [esi]
  2a:	31                   	.byte 0x31
  2b:	2d                   	.byte 0x2d
  2c:	33 29                	xor    ebp,DWORD PTR [ecx]
	...
