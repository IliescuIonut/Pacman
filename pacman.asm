.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "PACMAN HARDCORE",0
area_width EQU 1000
area_height EQU 480
area DD 0
var db 0
var2 db 4
game_over db 0
sageata_st_x EQU 760
sageata_st_y EQU 260
sageata_dr_x EQU 880 
sageata_dr_y EQU 260
sageata_sus_x EQU 820
sageata_sus_y EQU 200
sageata_jos_x EQU 820
sageata_jos_y EQU 260
sageata_size EQU 60
counter DD 0 ; numara evenimentele de tip timer
counter_2 DB 0
counter_3 db 0
counter_powerup dd -1
scor DD 0
stanga db 0
dreapta db 1
sus db 0
jos db 0

nr_puncte db 186

game_matrix dd 7,   6,  6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6,  6,  6,  9
			dd 8,  12,  5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5,  5, 12,  8
			dd 8,   5,  7,  9, 5, 15, 5,  7, 6,  6, 6,  6, 6,  9, 5,  7, 6,  6, 6,  6, 6,  9, 5, 15, 5,  7,  9,  5,  8
			dd 8,   5,  8,  8, 5,  8, 5,  8, 0,  0, 0,  0, 0,  8, 5,  8, 0,  0, 0,  0, 0,  8, 5,  8, 5,  8,  8,  5,  8
			dd 8,   5, 10, 11, 5, 14, 5, 10, 6,  6, 6,  6, 6, 11, 5, 10, 6,  6, 6,  6, 6, 11, 5, 14, 5, 10, 11,  5,  8
			dd 8,   5,  5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5,  5,  5,  8
			dd 8,   5,  7,  6, 6,  6, 6,  6, 6,  9, 5,  7, 6,  6, 0,  6, 6,  9, 5,  7, 6,  6, 6,  6, 6,  6,  9,  5,  8
			dd 8,   5, 10,  6, 6,  6, 6,  6, 6, 11, 5,  8, 0,  0, 0,  0, 0,  8, 5, 10, 6,  6, 6,  6, 6,  6, 11,  5,  8
			dd 8,   5,  5,  5, 5,  5, 5,  5, 5,  5, 5,  0, 0,  0, 0,  0, 0,  0, 5,  5, 5,  5, 5,  5, 5,  5,  5,  5,  8
			dd 8,   5,  7,  6, 6,  6, 6,  6, 6,  9, 5,  8, 0,  0, 0,  0, 0,  8, 5,  7, 6,  6, 6,  6, 6,  6,  9,  5,  8
			dd 8,   5, 10,  6, 6,  6, 6,  6, 6, 11, 5, 10, 6,  6, 0,  6, 6, 11, 5, 10, 6,  6, 6,  6, 6,  6, 11,  5,  8
			dd 8,   5,  5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5,  5,  5,  8
			dd 8,   5,  7,  9, 5, 15, 5,  7, 6,  6, 6,  6, 6,  9, 5,  7, 6,  6, 6,  6, 6,  9, 5, 15, 5,  7,  9,  5,  8
			dd 8,   5,  8,  8, 5,  8, 5,  8, 0,  0, 0,  0, 0,  8, 5,  8, 0,  0, 0,  0, 0,  8, 5,  8, 5,  8,  8,  5,  8
			dd 8,   5, 10, 11, 5, 14, 5, 10, 6,  6, 6,  6, 6, 11, 5, 10, 6,  6, 6,  6, 6, 11, 5, 14, 5, 10, 11,  5,  8
			dd 8,  12,  5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5, 5,  5,  5, 12,  8
			dd 10,  6,  6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6, 6,  6,  6,  6, 11
	
spawn_i dd 14
spawn_j dd 8	
arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20
x dd 40
y dd 20
pac_curent dd 16
player_i dd 14
player_j dd 11
player_x dd 0
player_y dd 0
player_form dd 17
player_adress dd 0

f1_i dd 14
f1_j dd 6
f1_x dd 0
f1_y dd 0
f1_adress dd 0

f2_i dd 14
f2_j dd 8
f2_x dd 0
f2_y dd 0
f2_adress dd 0

f3_i dd 12
f3_j dd 8
f3_x dd 0
f3_y dd 0
f3_adress dd 0

f4_i dd 16
f4_j dd 8
f4_x dd 0
f4_y dd 0
f4_adress dd 0

counter_f1 dd 0
counter_f2 dd 0
counter_f3 dd 0
counter_f4 dd 0
dir_f1 db 2
dir_f2 db 3
dir_f3 db 0
dir_f4 db 1
matrix_width EQU 29
matrix_height EQU 17
symbol_width EQU 10
symbol_width_pac EQU 20
symbol_height EQU 20
include digits.inc
include letters.inc
include pacman.inc

.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_negru
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

show_symbol proc
	push ebp
	mov ebp, esp
	pusha
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi, pacman
draw_text:
	mov ebx, symbol_width_pac
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width_pac
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_negru
	cmp byte ptr [esi], 1
	je simbol_pixel_rosu
	cmp byte ptr [esi], 2
	je simbol_pixel_albastru_deschis
	cmp byte ptr [esi], 3
	je simbol_pixel_albastru_inchis
	cmp byte ptr [esi], 4
	je simbol_pixel_roz
	cmp byte ptr [esi], 5
	je simbol_pixel_portocaliu
	cmp byte ptr [esi], 6
	je simbol_pixel_galben
	cmp byte ptr [esi], 7
	je simbol_pixel_alb
	cmp byte ptr [esi], 8
	je simbol_pixel_punct
	cmp byte ptr [esi], 9
	je simbol_pixel_gri
simbol_pixel_rosu:
mov dword ptr [edi], 0FF0000h
jmp simbol_pixel_next
simbol_pixel_albastru_deschis:
mov dword ptr [edi], 33CCFFh
jmp simbol_pixel_next
simbol_pixel_albastru_inchis:
mov dword ptr [edi], 0000FFh
jmp simbol_pixel_next
simbol_pixel_roz:
mov dword ptr [edi], 0FF99FFh
jmp simbol_pixel_next
simbol_pixel_portocaliu:
mov dword ptr [edi], 0FF9933h
jmp simbol_pixel_next
simbol_pixel_negru:
mov dword ptr [edi], 0
jmp simbol_pixel_next
simbol_pixel_galben:
mov dword ptr [edi], 0FFFF00h
jmp simbol_pixel_next
simbol_pixel_punct:
mov dword ptr [edi], 0D5A6BDh
jmp simbol_pixel_next
simbol_pixel_gri:
mov dword ptr [edi], 808080h
jmp simbol_pixel_next 
simbol_pixel_alb:
mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	dec ecx
	cmp ecx, 0
	jne bucla_simbol_coloane
	pop ecx
	dec ecx
	jne bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
	show_symbol endp
show_symbol_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call show_symbol
	add esp, 16
endm 

parcurgere macro 
local primu_for
local al_doilea_for
lea ebp, game_matrix
	mov edx, matrix_height
	mov y, 20
	primu_for:
	mov ecx, matrix_width
	add y, 20
	mov x, 40
	al_doilea_for:
	add x, 20
	show_symbol_macro [ebp], area, x, y
	add ebp, 4
	loop al_doilea_for
	dec edx
	cmp edx, 0
	jne primu_for
	endm
 
adresa macro
	mov eax, player_j
	mov ebx, symbol_height
	mul ebx
	add eax, 40
	mov player_y, eax
	mov eax, player_i
	mov ebx, symbol_width_pac
	mul ebx
    add eax, 60
	mov player_x, eax
	endm
	
adresa_f1 macro
	mov eax, f1_j
	mov ebx, symbol_height
	mul ebx
	add eax, 40
	mov f1_y, eax
	mov eax, f1_i
	mov ebx, symbol_width_pac
	mul ebx
    add eax, 60
	mov f1_x, eax
	endm
	
adresa_f2 macro
	mov eax, f2_j
	mov ebx, symbol_height
	mul ebx
	add eax, 40
	mov f2_y, eax
	mov eax, f2_i
	mov ebx, symbol_width_pac
	mul ebx
    add eax, 60
	mov f2_x, eax
	endm
	
adresa_f3 macro
	mov eax, f3_j
	mov ebx, symbol_height
	mul ebx
	add eax, 40
	mov f3_y, eax
	mov eax, f3_i
	mov ebx, symbol_width_pac
	mul ebx
    add eax, 60
	mov f3_x, eax
	endm
	
adresa_f4 macro
	mov eax, f4_j
	mov ebx, symbol_height
	mul ebx
	add eax, 40
	mov f4_y, eax
	mov eax, f4_i
	mov ebx, symbol_width_pac
	mul ebx
    add eax, 60
	mov f4_x, eax
	endm
	
adresa_matrice_f1 macro
    mov eax, f1_j
	mov ebx, matrix_width
	mul ebx
	add eax, f1_i
	shl eax, 2
	mov f1_adress, eax
	endm 
	
adresa_matrice_f2 macro
    mov eax, f2_j
	mov ebx, matrix_width
	mul ebx
	add eax, f2_i
	shl eax, 2
	mov f2_adress, eax
	endm 

adresa_matrice_f3 macro
    mov eax, f3_j
	mov ebx, matrix_width
	mul ebx
	add eax, f3_i
	shl eax, 2
	mov f3_adress, eax
	endm 

adresa_matrice_f4 macro
    mov eax, f4_j
	mov ebx, matrix_width
	mul ebx
	add eax, f4_i
	shl eax, 2
	mov f4_adress, eax
	endm 
adresa_matrice macro
    mov eax, player_j
	mov ebx, matrix_width
	mul ebx
	add eax, player_i
	shl eax, 2
	mov player_adress, eax
	endm 
	
	schimbare macro 
    adresa
	show_symbol_macro player_form, area, player_x, player_y
	endm 
	
l_orizontala macro x, y, len, color
	local bucla_linie
	 mov eax, y
	 mov ebx, area_width
	 mul ebx
	 add eax, x
	 shl eax, 2
	 add eax ,area
	 mov ecx, len
	 bucla_linie:
	 mov dword ptr [eax], color
	 add eax, 4
	 loop bucla_linie
	endm

l_verticala macro x, y, len, color
	local bucla_linie
	 mov eax, y
	 mov ebx, area_width
	 mul ebx
	 add eax, x
	 shl eax, 2
	 add eax ,area
	 mov ecx, len
	 bucla_linie:
	 mov dword ptr [eax], color
	 add eax, 4*area_width
	 loop bucla_linie
	endm
; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	mov eax, player_i
	mov ebx, player_j
	cmp nr_puncte, 0
	je stop_scor
	cmp game_over, 1
	je final_draw
	
	cmp counter_powerup, 0
	jg cont_powerup
	cmp eax, f1_i
	jne fantoma2
	cmp ebx, f1_j
	je stop

	fantoma2:
	cmp eax, f2_i
	jne fantoma3
	cmp ebx, f2_j
	je stop
	
	fantoma3:
	cmp eax, f3_i
	jne fantoma4
	cmp ebx, f3_j
	je stop
	
	fantoma4:
	cmp eax, f4_i
	jne cont
	cmp ebx, f4_j
	je stop
	jmp cont 
	stop_scor:
	parcurgere
	show_symbol_macro 2, area, f1_x, f1_y
	show_symbol_macro 1, area, f2_x, f2_y
	show_symbol_macro 3, area, f3_x, f3_y
    show_symbol_macro 4, area, f4_x, f4_y
	show_symbol_macro pac_curent, area, player_x, player_y
	stop:
	mov game_over, 1
	jmp cont
	cont_powerup:
	mov edx, spawn_i
	mov ecx, spawn_j
	cmp eax, f1_i
	jne fantoma2_pr
	cmp ebx, f1_j
	jne fantoma2_pr
	add scor, 200
	mov f1_i, edx
	mov f1_j, ecx

	fantoma2_pr:
	cmp eax, f2_i
	jne fantoma3_pr
	cmp ebx, f2_j
	jne fantoma3_pr
	add scor, 200
	mov f2_i, edx
	mov f2_j, ecx
	
	fantoma3_pr:
	cmp eax, f3_i
	jne fantoma4_pr
	cmp ebx, f3_j
	jne fantoma4_pr
	add scor, 200
	mov f3_i, edx
	mov f3_j, ecx
	
	fantoma4_pr:
	cmp eax, f4_i
	jne cont
	cmp ebx, f4_j
	jNe cont 
	add scor, 200
	mov f4_i, edx
	mov f4_j, ecx
	cont:
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 0
	push area
	call memset
	add esp, 12
	parcurgere 
	l_verticala 720, 0, 480, 959c99h
	l_verticala 721, 0, 480, 959c99h
	l_verticala 722, 0, 480, 959c99h
	l_verticala 723, 0, 480, 959c99h
	l_verticala 724, 0, 480, 959c99h
	l_verticala 725, 0, 480, 959c99h
	jmp afisare_litere
	
evt_click:
    mov eax, [ebp+arg2]
    cmp eax, sageata_st_x
	jl buton_dr
	cmp eax, sageata_st_x+sageata_size
	jg buton_dr
	mov eax, [ebp+arg3]
	cmp eax, sageata_st_y
	jl buton_dr
	cmp eax, sageata_st_y+sageata_size
	jg buton_dr
	adresa
	adresa_matrice
	lea eax, game_matrix
	add eax, player_adress
	mov ebx, [eax-4]
	cmp ebx, 8
	je evt_timer
	cmp ebx, 9
	je evt_timer
	cmp ebx, 11
	je evt_timer
	cmp ebx, 15
	je evt_timer
	cmp ebx, 14
	je evt_timer
	mov stanga, 1
	mov jos, 0
	mov sus, 0
    mov dreapta, 0
    jmp	evt_timer

	buton_dr:
	mov eax, [ebp+arg2]
    cmp eax, sageata_dr_x
	jl buton_sus
	cmp eax, sageata_dr_x+sageata_size
	jg buton_sus
	mov eax, [ebp+arg3]
	cmp eax, sageata_dr_y
	jl buton_sus
	cmp eax, sageata_dr_y+sageata_size
	jg buton_sus
	adresa
	adresa_matrice
	lea eax, game_matrix
	add eax, player_adress
	mov ebx, [eax+4]
	cmp ebx, 8
	je evt_timer
	cmp ebx, 7
	je evt_timer
	cmp ebx, 10
	je evt_timer
	cmp ebx, 15
	je evt_timer
	cmp ebx, 14
	je evt_timer
	mov stanga, 0
	mov jos, 0
	mov sus, 0
    mov dreapta, 1
    jmp	evt_timer
	
	buton_sus:
	mov eax, [ebp+arg2]
    cmp eax, sageata_sus_x
	jl buton_jos
	cmp eax, sageata_sus_x+sageata_size
	jg buton_jos
	mov eax, [ebp+arg3]
	cmp eax, sageata_sus_y
	jl buton_jos
	cmp eax, sageata_sus_y+sageata_size
	jg buton_jos
	adresa
	adresa_matrice
	lea eax, game_matrix
	add eax, player_adress
	mov ebx, [eax-4*matrix_width]
	cmp ebx, 6
	je evt_timer
	cmp ebx, 10
	je evt_timer
	cmp ebx, 11
	je evt_timer
	cmp ebx, 14
	je evt_timer
	mov stanga, 0
	mov jos, 0
	mov sus, 1
    mov dreapta, 0
    jmp	evt_timer
	
	buton_jos:
    mov eax, [ebp+arg2]
    cmp eax, sageata_jos_x
	jl evt_timer
	cmp eax, sageata_jos_x+sageata_size
	jg evt_timer
	mov eax, [ebp+arg3]
	cmp eax, sageata_jos_y
	jl evt_timer
	cmp eax, sageata_jos_y+sageata_size
	jg evt_timer
	adresa
	adresa_matrice
	lea eax, game_matrix
	add eax, player_adress
	mov ebx, [eax+4*matrix_width]
	cmp ebx, 6
	je evt_timer
	cmp ebx, 7
	je evt_timer
	cmp ebx, 9
	je evt_timer
	cmp ebx, 15	
	je evt_timer
	mov stanga, 0
	mov jos, 1
	mov sus, 0
    mov dreapta, 0
	
evt_timer:
	inc counter
	inc counter_2
	inc counter_3
	dec counter_powerup
	adresa
	adresa_matrice
	adresa_f1
	adresa_matrice_f1
	adresa_f2
	adresa_matrice_f2
	adresa_f3
	adresa_matrice_f3
	adresa_f4
	adresa_matrice_f4
	parcurgere 
	show_symbol_macro pac_curent, area, player_x, player_y
	show_symbol_macro 2, area, f1_x, f1_y
	show_symbol_macro 1, area, f2_x, f2_y
	show_symbol_macro 3, area, f3_x, f3_y
    show_symbol_macro 4, area, f4_x, f4_y
	cmp counter_3, 3
	jne continua
	mov counter_3, 0
	
	jmp cont_mv1
	decizie_random:
	rdtsc
	xor ah, ah
	div var2
	mov dir_f1, ah
	mov counter_f1, 0
	cmp counter_2, 2
	jne nu_ex_cond_f1
	add dir_f1, 1
	jmp nu_ex_cond_f1
	cont_mv1:
	cmp counter_f1, 7
	jl nu_ex_cond_f1
	lea ebx, game_matrix
	add ebx, f1_adress
	mov eax, [ebx+4]
	cmp eax, 5
	je subconditie1_f1
	cmp eax, 0
	je subconditie1_f1
	jmp decizie2_f1
	subconditie1_f1:
	mov eax, [ebx-4]
	cmp eax, 5
	je conditie_f1
	cmp eax, 0
	je conditie_f1
	jmp decizie2_f1
	conditie_f1:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je decizie_random
	cmp eax, 0
	je decizie_random
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je decizie_random
	cmp eax, 0
	je decizie_random
	
	decizie2_f1:
	lea ebx, game_matrix
	add ebx, f1_adress
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je subconditie2_f1
	cmp eax, 0
	je subconditie2_f1
	jmp nu_ex_cond_f1
	subconditie2_f1:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je conditie2_f1
	cmp eax, 0
	je conditie2_f1
	jmp nu_ex_cond_f1
	conditie2_f1:
	mov eax, [ebx-4]
	cmp eax, 5
	je decizie_random
	cmp eax, 0
	je decizie_random
	mov eax, [ebx+4]
	cmp eax, 5
	je decizie_random
	cmp eax, 0
	je decizie_random
    nu_ex_cond_f1:
	lea ebx, game_matrix
	add ebx, f1_adress
	cmp dir_f1, 0
	je f1_st
	cmp dir_f1, 1
	je f1_dr
	cmp dir_f1, 2
	je f1_sus
	cmp dir_f1, 3
	je f1_jos
	f1_st:
	mov dir_f1, 0
	mov edx, [ebx-4]
	cmp edx, 8
	je f1_jos
	cmp edx, 6
	je f1_jos
	cmp edx, 9
	je f1_jos
	cmp edx, 11
	je f1_jos
	cmp edx, 15
	je f1_jos
	cmp edx, 14
	je f1_jos
	dec f1_i
	inc counter_f1
	jmp continua_f2
	f1_dr:
	mov dir_f1, 1
	mov edx, [ebx+4]
	cmp edx, 8
	je f1_sus
	cmp edx, 6
	je f1_sus
	cmp edx, 7
	je f1_sus
	cmp edx, 10
	je f1_sus
	cmp edx, 15
	je f1_sus
	cmp edx, 14
	je f1_sus
	inc f1_i
	inc counter_f1
	jmp continua_f2
	
	f1_sus:
	mov dir_f1, 2
	mov edx, [ebx-4*matrix_width]
	cmp edx, 6
	je f1_st
	cmp edx, 8
	je f1_st
	cmp edx, 10
	je f1_st
	cmp edx, 11
	je f1_st
	cmp edx, 14
	je f1_st
	dec f1_j
	inc counter_f1
	jmp continua_f2
	f1_jos:
	mov dir_f1, 3
	mov edx, [ebx+4*matrix_width]
	cmp edx, 6
	je f1_dr
	cmp edx, 8
	je f1_dr
	cmp edx, 15
	je f1_dr
	cmp edx, 7
	je f1_dr
	cmp edx, 9
	je f1_dr
	inc f1_j
	inc counter_f1
	
	continua_f2:
	jmp cont_mv2
	decizie_random2:
	rdtsc
	xor ah, ah
	div var2
	mov dir_f2, ah
	mov counter_f2, 0
	cmp counter_2, 2
	jne nu_ex_cond_f2
	add dir_f2, 1
	jmp nu_ex_cond_f2
	cont_mv2:
	cmp counter_f2, 5
	jl nu_ex_cond_f2
	lea ebx, game_matrix
	add ebx, f2_adress
	mov eax, [ebx+4]
	cmp eax, 5
	je subconditie1_f2
	cmp eax, 0
	je subconditie1_f2
	jmp decizie2_f2
	subconditie1_f2:
	mov eax, [ebx-4]
	cmp eax, 5
	je conditie_f2
	cmp eax, 0
	je conditie_f2
	jmp decizie2_f2
	conditie_f2:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je decizie_random2
	cmp eax, 0
	je decizie_random2
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je decizie_random2
	cmp eax, 0
	je decizie_random2
	
	decizie2_f2:
	lea ebx, game_matrix
	add ebx, f2_adress
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je subconditie2_f2
	cmp eax, 0
	je subconditie2_f2
	jmp nu_ex_cond_f2
	subconditie2_f2:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je conditie2_f2
	cmp eax, 0
	je conditie2_f2
	jmp nu_ex_cond_f2
	conditie2_f2:
	mov eax, [ebx-4]
	cmp eax, 5
	je decizie_random2
	cmp eax, 0
	je decizie_random2
	mov eax, [ebx+4]
	cmp eax, 5
	je decizie_random2
	cmp eax, 0
	je decizie_random2
nu_ex_cond_f2:
	lea ebx, game_matrix
	add ebx, f2_adress
	cmp dir_f2, 0
	je f2_st
	cmp dir_f2, 1
	je f2_dr
	cmp dir_f2, 2
	je f2_sus
	cmp dir_f2, 3
	je f2_jos
	f2_st:
	mov dir_f2, 0
	mov edx, [ebx-4]
	cmp edx, 8
	je f2_jos
	cmp edx, 6
	je f2_jos
	cmp edx, 9
	je f2_jos
	cmp edx, 11
	je f2_jos
	cmp edx, 15
	je f2_jos
	cmp edx, 14
	je f2_jos
	dec f2_i
	inc counter_f2
	jmp continua_f3
	
	f2_dr:
	mov dir_f2, 1
	mov edx, [ebx+4]
	cmp edx, 8
	je f2_sus
	cmp edx, 6
	je f2_sus
	cmp edx, 7
	je f2_sus
	cmp edx, 10
	je f2_sus
	cmp edx, 15
	je f2_sus
	cmp edx, 14
	je f2_sus
	inc f2_i
	inc counter_f2
	jmp continua_f3
	f2_sus:
	mov dir_f2, 2
	mov edx, [ebx-4*matrix_width]
	cmp edx, 6
	je f2_st
	cmp edx, 8
	je f2_st
	cmp edx, 10
	je f2_st
	cmp edx, 11
	je f2_st
	cmp edx, 14
	je f2_st
	dec f2_j
	inc counter_f2
	jmp continua_f3
	f2_jos:
	mov dir_f2, 3
	mov edx, [ebx+4*matrix_width]
	cmp edx, 6
	je f2_dr
	cmp edx, 8
	je f2_dr
	cmp edx, 15
	je f2_dr
	cmp edx, 7
	je f2_dr
	cmp edx, 9
	je f2_dr
	inc f2_j
	inc counter_f2
	
	continua_f3:
	jmp cont_mv3
	decizie_random3:
	rdtsc
	xor ah, ah
	div var2
	mov dir_f3, ah
	mov counter_f3, 0
	cmp counter_2, 2
	jne nu_ex_cond_f3
	add dir_f3, 1
	jmp nu_ex_cond_f3
	cont_mv3:
	cmp counter_f3, 10
	jl nu_ex_cond_f3
	lea ebx, game_matrix
	add ebx, f3_adress
	mov eax, [ebx+4]
	cmp eax, 5
	je subconditie1_f3
	cmp eax, 0
	je subconditie1_f3
	jmp decizie2_f3
	subconditie1_f3:
	mov eax, [ebx-4]
	cmp eax, 5
	je conditie_f3
	cmp eax, 0
	je conditie_f3
	jmp decizie2_f3
	conditie_f3:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je decizie_random3
	cmp eax, 0
	je decizie_random3
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je decizie_random3
	cmp eax, 0
	je decizie_random3
	
	decizie2_f3:
	lea ebx, game_matrix
	add ebx, f3_adress
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je subconditie2_f3
	cmp eax, 0
	je subconditie2_f3
	jmp nu_ex_cond_f3
	subconditie2_f3:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je conditie2_f3
	cmp eax, 0
	je conditie2_f3
	jmp nu_ex_cond_f3
	conditie2_f3:
	mov eax, [ebx-4]
	cmp eax, 5
	je decizie_random3
	cmp eax, 0
	je decizie_random3
	mov eax, [ebx+4]
	cmp eax, 5
	je decizie_random3
	cmp eax, 0
	je decizie_random3
	
	nu_ex_cond_f3:
	lea ebx, game_matrix
	add ebx, f3_adress
	cmp dir_f3, 0
	je f3_st
	cmp dir_f3, 1
	je f3_dr
	cmp dir_f3, 2
	je f3_sus
	cmp dir_f3, 3
	je f3_jos
	f3_st:
	mov dir_f3, 0
	mov edx, [ebx-4]
	cmp edx, 8
	je f3_jos
	cmp edx, 6
	je f3_jos
	cmp edx, 9
	je f3_jos
	cmp edx, 11
	je f3_jos
	cmp edx, 15
	je f3_jos
	cmp edx, 14
	je f3_jos
	dec f3_i
	inc counter_f3
	jmp continua_f4
	f3_dr:
	mov dir_f3, 1
	mov edx, [ebx+4]
	cmp edx, 8
	je f3_sus
	cmp edx, 6
	je f3_sus
	cmp edx, 7
	je f3_sus
	cmp edx, 10
	je f3_sus
	cmp edx, 15
	je f3_sus
	cmp edx, 14
	je f3_sus
	inc f3_i
	inc counter_f3
	jmp continua_f4
	f3_sus:
	mov dir_f3, 2
	mov edx, [ebx-4*matrix_width]
	cmp edx, 6
	je f3_st
	cmp edx, 8
	je f3_st
	cmp edx, 10
	je f3_st
	cmp edx, 11
	je f3_st
	cmp edx, 14
	je f3_st
	dec f3_j
	inc counter_f3
	jmp continua_f4
	f3_jos:
	mov dir_f3, 3
	mov edx, [ebx+4*matrix_width]
	cmp edx, 6
	je f3_dr
	cmp edx, 8
	je f3_dr
	cmp edx, 15
	je f3_dr
	cmp edx, 7
	je f3_dr
	cmp edx, 9
	je f3_dr
	inc f3_j
	inc counter_f3
	
	continua_f4:
	jmp cont_mv4
	decizie_random4:
	rdtsc
	xor ah, ah
	div var2
	mov dir_f4, ah
	mov counter_f4, 0
	cmp counter_2, 2
	jne nu_ex_cond_f4
	add dir_f4, 1
	jmp nu_ex_cond_f4
	cont_mv4:
	cmp counter_f4, 7
	jl nu_ex_cond_f4
	lea ebx, game_matrix
	add ebx, f4_adress
	mov eax, [ebx+4]
	cmp eax, 5
	je subconditie1_f4
	cmp eax, 0
	je subconditie1_f4
	jmp decizie2_f4
	subconditie1_f4:
	mov eax, [ebx-4]
	cmp eax, 5
	je conditie_f4
	cmp eax, 0
	je conditie_f4
	jmp decizie2_f4
	conditie_f4:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je decizie_random4
	cmp eax, 0
	je decizie_random4
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je decizie_random4
	cmp eax, 0
	je decizie_random4
	
	decizie2_f4:
	lea ebx, game_matrix
	add ebx, f4_adress
	mov eax, [ebx+4*matrix_width]
	cmp eax, 5
	je subconditie2_f4
	cmp eax, 0
	je subconditie2_f4
	jmp nu_ex_cond_f4
	subconditie2_f4:
	mov eax, [ebx-4*matrix_width]
	cmp eax, 5
	je conditie2_f4
	cmp eax, 0
	je conditie2_f4
	jmp nu_ex_cond_f4
	conditie2_f4:
	mov eax, [ebx-4]
	cmp eax, 5
	je decizie_random4
	cmp eax, 0
	je decizie_random4
	mov eax, [ebx+4]
	cmp eax, 5
	je decizie_random4
	cmp eax, 0
	je decizie_random4
	nu_ex_cond_f4:
	lea ebx, game_matrix
	add ebx, f4_adress
	cmp dir_f4, 0
	je f4_st
	cmp dir_f4, 1
	je f4_dr
	cmp dir_f4, 2
	je f4_sus
	cmp dir_f4, 3
	je f4_jos
    f4_st:
	mov dir_f4, 0
	mov edx, [ebx-4]
	cmp edx, 8
	je f4_dr
	cmp edx, 6
	je f4_dr
	cmp edx, 9
	je f4_dr
	cmp edx, 11
	je f4_dr
	cmp edx, 15
	je f4_dr
	cmp edx, 14
	je f4_dr
	dec f4_i
	inc counter_f4
	jmp continua
	f4_dr:
	mov dir_f4, 1
	mov edx, [ebx+4]
	cmp edx, 8
	je f4_sus
	cmp edx, 6
	je f4_sus
	cmp edx, 7
	je f4_sus
	cmp edx, 10
	je f4_sus
	cmp edx, 15
	je f4_sus
	cmp edx, 14
	je f4_sus
	inc f4_i
	inc counter_f4
	jmp continua
	f4_sus:
	mov dir_f4, 2
	mov edx, [ebx-4*matrix_width]
	cmp edx, 6
	je f4_jos
	cmp edx, 8
	je f4_jos
	cmp edx, 10
	je f4_jos
	cmp edx, 11
	je f4_jos
	cmp edx, 14
	je f4_jos
	dec f4_j
	inc counter_f4
	jmp continua
	f4_jos:
	mov dir_f4, 3
	mov edx, [ebx+4*matrix_width]
	cmp edx, 6
	je f4_st
	cmp edx, 8
	je f4_st
	cmp edx, 15
	je f4_st
	cmp edx, 7
	je f4_st
	cmp edx, 9
	je f4_st
	inc f4_j
	inc counter_f4
	continua:
	cmp counter_2, 2
	jne afisare_litere
	schimbare
	mov counter_2, 0
	cmp stanga, 1
	je mergi_stanga
	cmp dreapta, 1
	je mergi_dreapta
	cmp sus, 1
	je mergi_sus
	cmp jos, 1
	je mergi_jos
	jmp afisare_litere
	
    mergi_stanga:
	lea eax, game_matrix
	add eax, player_adress
	mov pac_curent, 18
	mov edx, [eax-4]
	mov ebx, [eax]
	cmp ebx, 5
	je mancare_st
	cmp ebx, 12
	je mancare_st
    cmp edx, 8
    je afisare_litere 
    cmp edx, 6
	je afisare_litere
	cmp edx, 9
    je afisare_litere 	
	cmp edx, 11
    je afisare_litere
    cmp edx, 15
    je afisare_litere
    cmp edx, 14
    je afisare_litere 		
	dec player_i
	jmp afisare_litere
	
	mergi_dreapta:
	lea eax, game_matrix
	add eax, player_adress
	mov pac_curent, 16
	mov edx, [eax+4]
	mov ebx, [eax]
	cmp ebx, 5
	je mancare_dr
	cmp ebx, 12
	je mancare_dr
	cmp edx, 6
	je afisare_litere
    cmp edx, 8
    je afisare_litere 	
	cmp edx, 7
    je afisare_litere 	
	cmp edx, 10
    je afisare_litere
    cmp edx, 15
    je afisare_litere
    cmp edx, 14
    je afisare_litere 		
	inc player_i
	jmp afisare_litere
	
	
	mergi_sus:
	lea eax, game_matrix
	add eax, player_adress
	mov pac_curent, 19
	mov edx, [eax-4*matrix_width]
	mov ebx, [eax]
	cmp ebx, 5
	je mancare_sus
	cmp ebx, 12
	je mancare_sus
    cmp edx, 6
    je afisare_litere 	
	cmp edx, 8
    je afisare_litere 	
	cmp edx, 14
    je afisare_litere 	
	cmp edx, 11
    je afisare_litere
    cmp edx, 10
    je afisare_litere
    cmp edx, 14
   je afisare_litere 		
	dec player_j
	jmp afisare_litere
	
	mergi_jos:
	lea eax, game_matrix
	add eax, player_adress
	mov pac_curent, 20
	mov edx, [eax+4*matrix_width]
	mov ebx, [eax]
	cmp ebx, 5
	je mancare_jos
	cmp ebx, 12
	je mancare_jos
    cmp edx, 6
    je afisare_litere 	
	cmp edx, 8
    je afisare_litere
	cmp edx, 15
    je afisare_litere 	
	cmp edx, 7
    je afisare_litere
    cmp edx, 9
    je afisare_litere 		
	inc player_j
	jmp afisare_litere
	
	mancare_dr:
	dec nr_puncte
	cmp edx, 5
	je cont1
	cmp edx, 12
	jne cont1
	add scor, 40
	mov counter_powerup, 50
	cont1:
	add scor,10
	mov edx, 0
	mov [eax], edx
	mov ebx, [eax+4]
	cmp ebx, 5
	jne urm_comparatie
	inc player_i
	jmp afisare_litere
	urm_comparatie:
	cmp ebx, 12
	jne afisare_litere
	inc player_i
	jmp afisare_litere
	
	mancare_st:
	dec nr_puncte
	cmp edx, 5
	je cont2
	cmp edx, 12
	jne cont2
	add scor, 40
	mov counter_powerup, 50
	cont2:
	add scor,10
    mov edx, 0
	mov [eax], edx
	mov ebx, [eax-4]
	cmp ebx, 5
	jne urm_comparatie1
	dec player_i
	jmp afisare_litere
	urm_comparatie1:
	cmp ebx, 12
	jne afisare_litere
	dec player_i
	jmp afisare_litere
	
	mancare_sus:
	dec nr_puncte
	cmp edx, 5
	je cont3
	cmp edx, 12
	jne cont3
	add scor, 40
	mov counter_powerup, 50
	cont3:
	add scor,10
    mov edx, 0
	mov [eax], edx
	mov ebx, [eax-4*matrix_width]
	cmp ebx, 5
	jne urm_comparatie2
	dec player_j
	jmp afisare_litere
	urm_comparatie2:
	cmp ebx, 12
	jne afisare_litere
	dec player_j
	jmp afisare_litere
	
	mancare_jos:
	dec nr_puncte
	cmp edx, 5
	je cont4
	cmp edx, 12
	jne cont4
	add scor, 40
	mov counter_powerup, 50
	cont4:
	add scor,10
	mov edx, 0
	mov [eax], edx
	mov ebx, [eax+4*matrix_width]
	cmp ebx, 5
	jne urm_comparatie3
	inc player_j
	jmp afisare_litere
	urm_comparatie3:
	cmp ebx, 12
	jne afisare_litere
	inc player_j
	jmp afisare_litere
	
afisare_litere:
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	
	make_text_macro 'S', area, 70, 10
	make_text_macro 'C', area, 80, 10
	make_text_macro 'O', area, 90, 10
	make_text_macro 'R', area, 100, 10
	make_text_macro 'E', area, 110, 10
	
	cmp counter_powerup, 0
	jle terminat
	make_text_macro 'P', area, 430, 10
	make_text_macro 'O', area, 440, 10
	make_text_macro 'W', area, 450, 10
	make_text_macro 'E', area, 460, 10
	make_text_macro 'R', area, 470, 10
	make_text_macro ' ', area, 480, 10
	make_text_macro 'U', area, 490, 10
	make_text_macro 'P', area, 500, 10
	show_symbol_macro 28, area, 510, 10
	mov ebx, 10
	mov eax, counter_powerup
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 540, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 530, 10
	jmp score
	terminat:
	make_text_macro ' ', area, 430, 10
	make_text_macro ' ', area, 440, 10
	make_text_macro ' ', area, 450, 10
	make_text_macro ' ', area, 460, 10
	make_text_macro ' ', area, 470, 10
	make_text_macro ' ', area, 480, 10
	make_text_macro ' ', area, 490, 10
	make_text_macro ' ', area, 500, 10
	show_symbol_macro 0, area, 510, 10
	make_text_macro ' ', area, 540, 10
	make_text_macro ' ', area, 530, 10
	
	score:
	mov ebx, 10
	mov eax, scor
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 160, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 150, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 140, 10
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 130, 10
	
    l_verticala sageata_dr_x, sageata_dr_y, sageata_size, 959c99h;
	l_verticala sageata_dr_x+sageata_size, sageata_dr_y, sageata_size, 959c99h;
	l_orizontala sageata_dr_x, sageata_dr_y, sageata_size, 959c99h;
	l_orizontala sageata_dr_x, sageata_dr_y+sageata_size, sageata_size, 959c99h;
	
	l_verticala sageata_sus_x, sageata_sus_y, sageata_size, 959c99h;
	l_verticala sageata_sus_x+sageata_size, sageata_sus_y, sageata_size, 959c99h;
	l_orizontala sageata_sus_x, sageata_sus_y, sageata_size, 959c99h;
	l_orizontala sageata_sus_x, sageata_sus_y+sageata_size, sageata_size, 959c99h;
	
	l_verticala sageata_st_x, sageata_st_y, sageata_size, 959c99h;
	l_verticala sageata_st_x+sageata_size, sageata_st_y, sageata_size, 959c99h;
	l_orizontala sageata_st_x, sageata_st_y, sageata_size, 959c99h;
	l_orizontala sageata_st_x, sageata_st_y+sageata_size, sageata_size, 959c99h;
	
	l_verticala sageata_jos_x, sageata_jos_y, sageata_size, 959c99h;
	l_verticala sageata_jos_x+sageata_size, sageata_jos_y, sageata_size, 959c99h;
	l_orizontala sageata_jos_x, sageata_jos_y, sageata_size, 959c99h;
	l_orizontala sageata_jos_x, sageata_jos_y+sageata_size, sageata_size, 959c99h;
	
	
final_draw:
cmp game_over, 1
jne final
    show_symbol_macro 21, area, 170, 400
	show_symbol_macro 22, area, 190, 400
	show_symbol_macro 23, area, 210, 400
	show_symbol_macro 24, area, 230, 400
	make_text_macro ' ', area, 250, 400
	show_symbol_macro 25, area, 260, 400
	show_symbol_macro 26, area, 280, 400
	show_symbol_macro 24, area, 300, 400
	show_symbol_macro 27, area, 320, 400
	final:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start
