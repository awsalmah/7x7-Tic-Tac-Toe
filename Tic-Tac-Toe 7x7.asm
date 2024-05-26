
         ;186//187 and 188//201 and 200 upper and lower left        
         
   ;;add inc size      
         
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
;note if you want to clear screen and then print error or win message just delete the ; before the 3 lines below when found inside their respective functions
;mov ah,0x0h
;mov al,0x3h
;int 10h  

org 100h

.data 

var1 db 7 dup(0)
var2 db 7 dup(0)
var3 db 7 dup(0)
var4 db 7 dup(0)
var5 db 7 dup(0)
var6 db 7 dup(0)
var7 db 7 dup(0)

rowcount db 0

location db 0x7h

entercount db 0 

vertical db 0x8h 
vertical1 db 0x8h
vertical2 db 0x8h

horizontal db 0x25h

error db "can't overwrite an existing entry exit$"
error2 db "user entered an invalid key prompt$"   
winner1 db "USER A WINS!$"
winner2 db "USER B WINS!$"
winner3 db "It's a draw!$"  

size db 0

equal db 0


.code
mov ax,@data
mov ds,ax



;code to print upper borders
call startlocation 
mov ah,2
mov dl,201;upper left corner
int 21h
mov cx,7
l1: 
mov ah,2
mov dl,205;=
int 21h  
loop l1 
mov dl,187;upper right corner
int 21h  
;newline and cret          
mov ah,2
mov dl,0ah
int 21h
mov dl,0dh
int 21h 
;code to print out each row not including upper and lower   ////////////////////////////////////////////////////////////////////////
row: 
call startlocation
mov ah,2     
mov dl,186 ;code to print left ||
int 21h        
mov cx,7
mov ah,2
l2:
mov dl,32
int 21h                                           
loop l2       
mov dl,186 ;code to print right ||
int 21h 
mov ah,2 ;newline and cret
mov dl,0ah
int 21h
mov dl,0dh
int 21h  
add rowcount,1
cmp rowcount,7
je end 
jmp row
end:
call startlocation
mov ah,2
mov dl,200;lower left corner
int 21h
mov cx,7
l12: 
mov ah,2
mov dl,205
int 21h  
loop l12 
mov dl,188;lower right corner
int 21h 
;newline and cret
mov ah,2
mov dl,0ah
int 21h
mov dl,0dh
int 21h 









mov dh, 0x8h;ROW  
mov dl, 0x25h;COLUMN                                
mov bh, 0;PAGE NUM                            
mov ah, 2                                      
int 10h
;inc location 
	

    
;code to move cursor depending on arrow key to exit press anything except enter or arrow keys   
   movementloop: mov ah,0
    int 16h
    cmp ah,0x48
    je up
    cmp ah,0x50
    je down 
    cmp ah,0x4B
    je left
    cmp ah,0x4D
    je right
    cmp ah,0x1C
    je enter    
    jmp done
    up:  
    cmp vertical,0x8h
    je upnext
    dec vertical
    call move
    upnext:
    jmp movementloop
    down:
    cmp vertical,0xEh
    je downnext 
    inc vertical
    call move  
    downnext:
    jmp movementloop
    left: 
    cmp horizontal,0x25h
    je leftnext
    dec horizontal
    call move
    leftnext:
    jmp movementloop
    right: 
    cmp horizontal,0x2bh
    je rightnext:
    inc horizontal
    call move
    rightnext:
    jmp movementloop
    
    
    
    
    
      
    ;cmp count,5 jae checkforwinner
  enter:
  
    ;if space not empty then cant enter  
    
    
    
    
     
     
    ;if counter is odd then print a else print b 
    add entercount,1
    mov dx,0
    mov ah,0
    mov al,entercount   
    mov cx,2
    div cx    
    cmp dx,0
    je printB
    mov ah,2
    mov dl,"A"
    int 21h;here call to add to array
    call arrayA
    jmp line
    printB:
    mov ah,2
    mov dl,"B"
    int 21h 
    call arrayB
    ;if at any right edge except for bottom right then go down a line and start from intial vertical position
    line: 
    cmp entercount,4
    jae checkwinner 
    back:
    ;inc horizontal 
    cmp horizontal,0x2bh
    je newline
    inc horizontal 
    jmp movementloop  

    newline:
    cmp vertical , 0xEh
    je firstpos
    mov horizontal,25h
    inc vertical    
    call move
    jmp movementloop 
    ;if at bottom right edge then go to the first position 
    firstpos:
    mov horizontal,25h
    mov vertical,8h
    call move
    jmp movementloop
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
;code to run through the loop and check for a winner       
    checkwinner:
    cmp size,49
    je endl
    call checkrow
    call checkcolumn
    jmp back   
   
    ;draw msg
    endl:
    call winner
    ;error msg
    done:
    jmp doneprint

ret 












startlocation PROC
	mov dh, location;ROW  
	mov dl, 0x24h;COLUMN                                
	mov bh, 0;PAGE NUM                            
	mov ah, 2                                      
	int 10h
	inc location  
	ret
startlocation ENDP

move PROC ;code to move cursor depending on arrow keys
    mov dh,vertical;row
    mov dl,horizontal;column
    mov bh,0
    mov ah,2
    int 10h
    ret
move ENDP    

;code to add A                                                                             
arrayA proc
pusha
pushf 
cmp vertical,0x8h
jne r2
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var1[si],"A"
je Lexit  
cmp var1[si],"B"
je Lexit
mov var1[si],"A"
jmp rfinal
r2:
cmp vertical,0x9h
jne r3
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var2[si],"A"
je Lexit  
cmp var2[si],"B"
je Lexit
mov var2[si],"A"
jmp rfinal
r3:  
cmp vertical,0xah
jne r4
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var3[si],"A"
je Lexit  
cmp var3[si],"B"
je Lexit
mov var3[si],"A"
jmp rfinal
r4: 
cmp vertical,0xbh
jne r5 
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var4[si],"A"
je Lexit  
cmp var4[si],"B"
je Lexit
mov var4[si],"A"
jmp rfinal 
r5:
cmp vertical,0xch
jne r6
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var5[si],"A"
je Lexit  
cmp var5[si],"B"
je Lexit
mov var5[si],"A"
jmp rfinal
r6: 
cmp vertical,0xdh
jne r7      
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var6[si],"A"
je Lexit  
cmp var6[si],"B"
je Lexit
mov var6[si],"A"
jmp rfinal
r7:              
cmp vertical,0xeh
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var7[si],"A"
je Lexit  
cmp var7[si],"B"
je Lexit
mov var7[si],"A"
jmp rfinal
rfinal:
inc size
popf
popa
   ret
arrayA endp
;code to add B                                                                          
arrayB proc
pusha
pushf
cmp vertical,0x8h
jne r2B 
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var1[si],"A"
je Lexit  
cmp var1[si],"B"
je Lexit
mov var1[si],"B"
jmp rfinalB
r2B:
cmp vertical,0x9h
jne r3B
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax  
cmp var2[si],"A"
je Lexit  
cmp var2[si],"B"
je Lexit
mov var2[si],"B"
jmp rfinalB
r3B:  
cmp vertical,0xah
jne r4B
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var3[si],"A"
je Lexit  
cmp var3[si],"B"
je Lexit
mov var3[si],"B"
jmp rfinalB
r4B: 
cmp vertical,0xbh
jne r5B 
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax
cmp var4[si],"A"
je Lexit  
cmp var4[si],"B"
je Lexit
mov var4[si],"B"
jmp rfinalB 
r5B:
cmp vertical,0xch
jne r6B
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var5[si],"A"
je Lexit  
cmp var5[si],"B"
je Lexit
mov var5[si],"B"
jmp rfinalB
r6B: 
cmp vertical,0xdh
jne r7B      
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var6[si],"A"
je Lexit  
cmp var6[si],"B"
je Lexit
mov var6[si],"B"
jmp rfinalB
r7B:              
cmp vertical,0xeh
mov ah,0  
mov al,horizontal
sub ax,25h
mov si,ax 
cmp var7[si],"A"
je Lexit  
cmp var7[si],"B"
je Lexit
mov var7[si],"B"
jmp rfinalB
rfinalB:
inc size
popf
popa
   ret
arrayB endp
;code to end if overwrite happens
overwrite proc
Lexit::
mov ah,0x0h
mov al,0x3h
int 10h   
mov dh,5;row
mov dl,20;column
mov bh,0
mov ah,2
int 10h 
mov dx,offset error
mov ah,9
int 21h
mov ax,0x4c01
int 0x21 
    ret
overwrite endp

checkcolumn proc
pusha
pushf
mov si,0 
rowposition: 
cmp si,7
ja lrowne
cmp var1[si],"A"
jne cc1b
mov al,var2[si]
cmp var1[si],al
jne cc1b:
mov al,var3[si]
cmp var1[si],al
jne cc1b
jmp win1
cc1b:   
cmp var1[si],"B"
jne cc2
mov al,var2[si]
cmp var1[si],al
jne cc2:
mov al,var3[si]
cmp var1[si],al
jne cc2
jmp win2

cc2: 
cmp var2[si],"A"
jne cc2b
mov al,var3[si]
cmp var2[si],al
jne cc2b:
mov al,var4[si]
cmp var2[si],al
jne cc2b
jmp win1
cc2b:
cmp var2[si],"B"
jne cc3
mov al,var3[si]
cmp var2[si],al
jne cc3:
mov al,var4[si]
cmp var2[si],al
jne cc3
jmp win2


cc3:
cmp var3[si],"A"
jne cc3b
mov al,var4[si]
cmp var3[si],al
jne cc3b:
mov al,var5[si]
cmp var3[si],al
jne cc3b
jmp win1
cc3b:
cmp var3[si],"B"
jne cc4
mov al,var4[si]
cmp var3[si],al
jne cc4:
mov al,var5[si]
cmp var3[si],al
jne cc4
jmp win2


cc4:
cmp var4[si],"A"
jne cc4b
mov al,var5[si]
cmp var4[si],al
jne cc4b:
mov al,var6[si]
cmp var4[si],al
jne cc4b
jmp win1
cc4b:
cmp var4[si],"B"
jne cc5
mov al,var5[si]
cmp var4[si],al
jne cc5:
mov al,var6[si]
cmp var4[si],al
jne cc5
jmp win2

cc5:
cmp var5[si],"A"
jne cc5b
mov al,var6[si]
cmp var5[si],al
jne cc5b:
mov al,var7[si]
cmp var5[si],al
jne cc5b
jmp win1
cc5b:
cmp var5[si],"B"
jne ccl
mov al,var6[si]
cmp var5[si],al
jne ccl:
mov al,var7[si]
cmp var5[si],al
jne ccl
jmp win2
ccl:
inc si
jmp rowposition
lrowne:
popf
popa
    ret
checkcolumn endp
checkrow PROC
pusha
pushf 
cmp vertical1,0x8h
jne rc2     
mov equal,0 
mov si,0
loopr1a:
cmp equal,2
je win1
cmp si,6 ;
je r1p2
cmp var1[si],"A"
jne r1anext
mov al,var1[si+1]
cmp var1[si],al
jne r1anext:
inc equal
r1anext:
inc si
jmp loopr1a
r1p2:
mov equal,0
mov si,0
loopr1b:
cmp equal,2;
jne lq
;red
cmp equal,2
je win2
lq:
cmp si,6 
je rc2
cmp var1[si],"B"
jne r1bnext
mov al,var1[si+1]
cmp var1[si],al
jne r1bnext:
inc equal
r1bnext:
inc si
jmp loopr1b


rc2:
inc vertical1
cmp vertical1,0x9h;;
jne rc3;;     
mov equal,0 
mov si,0
loopr2a:;;
cmp equal,2
je win1
cmp si,6 
je r2p2;;
cmp var2[si],"A";;;
jne r2anext;;
mov al,var2[si+1];;;
cmp var2[si],al;;;
jne r2anext:;;
inc equal
r2anext:;;
inc si
jmp loopr2a;;
r2p2:;;
mov equal,0
mov si,0
loopr2b:;;
cmp equal,2
je win2
cmp si,6 
je rc3  ;;
cmp var2[si],"B";;;
jne r2bnext;;
mov al,var2[si+1];;;
cmp var2[si],al;;;
jne r2bnext: ;;
inc equal
r2bnext:;;
inc si
jmp loopr2b;;



rc3:
inc vertical1
cmp vertical1,0xAh;;
jne rc4;;     
mov equal,0 
mov si,0
loopr3a:;;
cmp equal,2
je win1
cmp si,6 
je r3p2;;
cmp var3[si],"A";;;
jne r3anext;;
mov al,var3[si+1];;;
cmp var3[si],al;;;
jne r3anext:;;
inc equal
r3anext:;;
inc si
jmp loopr3a;;
r3p2:;;
mov equal,0
mov si,0
loopr3b:;;
cmp equal,2
je win2
cmp si,6 
je rc4  ;;
cmp var3[si],"B";;;
jne r3bnext;;
mov al,var3[si+1];;;
cmp var3[si],al;;;
jne r3bnext: ;;
inc equal
r3bnext:;;
inc si
jmp loopr3b;;




rc4:
inc vertical1
cmp vertical1,0xBh;;
jne rc5;;     
mov equal,0 
mov si,0
loopr4a:;;
cmp equal,2
je win1
cmp si,6 
je r4p2;;
cmp var4[si],"A";;;
jne r4anext;;
mov al,var4[si+1];;;
cmp var4[si],al;;;
jne r4anext:;;
inc equal
r4anext:;;
inc si
jmp loopr4a;;
r4p2:;;
mov equal,0
mov si,0
loopr4b:;;
cmp equal,2
je win2
cmp si,6 
je rc5  ;;
cmp var4[si],"B";;;
jne r4bnext;;
mov al,var4[si+1];;;
cmp var4[si],al;;;
jne r4bnext: ;;
inc equal
r4bnext:;;
inc si
jmp loopr4b;;





rc5:
inc vertical1
cmp vertical1,0xCh;;
jne rc6;;     
mov equal,0 
mov si,0
loopr5a:;;
cmp equal,2
je win1
cmp si,6 
je r5p2;;
cmp var5[si],"A";;;
jne r5anext;;
mov al,var5[si+1];;;
cmp var5[si],al;;;
jne r5anext:;;
inc equal
r5anext:;;
inc si
jmp loopr5a;;
r5p2:;;
mov equal,0
mov si,0
loopr5b:;;
cmp equal,2
je win2
cmp si,6 
je rc6  ;;
cmp var5[si],"B";;;
jne r5bnext;;
mov al,var5[si+1];;;
cmp var5[si],al;;;
jne r5bnext: ;;
inc equal
r5bnext:;;
inc si
jmp loopr5b;;






rc6:
inc vertical1
cmp vertical1,0xDh;;
jne rc7;;     
mov equal,0 
mov si,0
loopr6a:;;
cmp equal,2
je win1
cmp si,6 
je r6p2;;
cmp var6[si],"A";;;
jne r6anext;;
mov al,var6[si+1];;;
cmp var6[si],al;;;
jne r6anext:;;
inc equal
r6anext:;;
inc si
jmp loopr6a;;
r6p2:;;
mov equal,0
mov si,0
loopr6b:;;
cmp equal,2
je win2
cmp si,6 
je rc7  ;;
cmp var6[si],"B";;;
jne r6bnext;;
mov al,var6[si+1];;;
cmp var6[si],al;;;
jne r6bnext: ;;
inc equal
r6bnext:;;
inc si
jmp loopr6b;;







rc7:
inc vertical1
cmp vertical1,0xEh;;
jne rc8;;     
mov equal,0 
mov si,0
loopr7a:;;
cmp equal,2
je win1
cmp si,6 
je r7p2;;
cmp var7[si],"A";;;
jne r7anext;;
mov al,var7[si+1];;;
cmp var7[si],al;;;
jne r7anext:;;
inc equal
r7anext:;;
inc si
jmp loopr7a;;
r7p2:;;
mov equal,0
mov si,0
loopr7b:;;
cmp equal,2
je win2
cmp si,6 
je rc8  ;;
cmp var7[si],"B";;;
jne r7bnext;;
mov al,var7[si+1];;;
cmp var7[si],al;;;
jne r7bnext: ;;
inc equal
r7bnext:;;
inc si
jmp loopr7b;;
rc8:
mov vertical1,0x8h
popf
popa    
    ret
checkrow ENDP




Winner PROC
win3::
;mov ah,0x0h
;mov al,0x3h
;int 10h
mov dh,4;row
mov dl,33;column
mov bh,0;
mov ah,2;
int 10h
mov ah,2
mov dl,201
int 21h
mov cx,12
lp321: 
mov dl,205
int 21h  
loop lp321
mov dl,187
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h 
mov dh,5;
mov dl,33;
mov bh,0;
mov ah,2;
int 10h;
mov ah,2     
mov dl,186 
int 21h 
mov dx,offset winner3
mov ah,9
int 21h 
mov ah,2     
mov dl,186 
int 21h        
mov dh,6;
mov dl,33;
mov bh,0;
mov ah,2;
int 10h; 

mov ah,2
mov dl,200
int 21h
mov cx,12
lp322: 
mov dl,205
int 21h  
loop lp322
mov dl,188
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h    
mov ax,0x4c01
int 0x21 
   ; ret
win2::
;mov ah,0x0h
;mov al,0x3h
;int 10h
mov dh,4;row
mov dl,33;column
mov bh,0;
mov ah,2;
int 10h;
mov ah,2
mov dl,201
int 21h
mov cx,12
lp21: 
mov dl,205
int 21h  
loop lp21
mov dl,187
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h 
mov dh,5;
mov dl,33;
mov bh,0;
mov ah,2;
int 10h;
mov ah,2     
mov dl,186 
int 21h 
mov dx,offset winner2
mov ah,9
int 21h 
mov ah,2     
mov dl,186 
int 21h        
mov dh,6;
mov dl,33;
mov bh,0;
mov ah,2;
int 10h;  

mov ah,2
mov dl,200
int 21h
mov cx,12
lp22: 
mov dl,205
int 21h  
loop lp22
mov dl,188
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h    
mov ax,0x4c01
int 0x21 
   ; ret  

win1::
;mov ah,0x0h
;mov al,0x3h
;int 10h
mov dh,4;row
mov dl,33;column
mov bh,0
mov ah,2
int 10h
mov ah,2
mov dl,201
int 21h
mov cx,12
lp1: 
mov dl,205
int 21h  
loop lp1
mov dl,187
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h 
mov dh,5;
mov dl,33;
mov bh,0 ;
mov ah,2 ;
int 10h  ;
mov ah,2     
mov dl,186 
int 21h 
mov dx,offset winner1
mov ah,9
int 21h 
mov ah,2     
mov dl,186 
int 21h        
mov dh,6  ;
mov dl,33 ;
mov bh,0  ;
mov ah,2  ;
int 10h   ;

mov ah,2
mov dl,200
int 21h
mov cx,12
lp2: 
mov dl,205
int 21h  
loop lp2
mov dl,188
int 21h 
mov dl,0ah
int 21h
mov dl,0dh
int 21h    
mov ax,0x4c01
int 0x21 
    ;ret 
doneprint::
;mov ah,0x0h
;mov al,0x3h
;int 10h  
mov dh,5;row
mov dl,22;column
mov bh,0
mov ah,2
int 10h 
mov dx,offset error2
mov ah,9
int 21h
mov ax,0x4c01
int 0x21
    ret
Winner ENDP

