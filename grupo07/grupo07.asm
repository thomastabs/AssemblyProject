; ***********************************************************************
; * Proj1 ---> grupo nº7												*
; *																		*
; * Nº 1102491 - João Xiao Ma											*
; * Nº 1103641 - Tomás dos Santos Taborda								*
; * Nº 1103803 - Pedro Leitão Laranjeira								*
; *																		*			  
; ***********************************************************************


; #####################################################################
; #### Variaveis e constantes #########################################
; #####################################################################


DISPLAYS      					EQU 0A000H  ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN       					EQU 0C000H  ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL       					EQU 0E000H  ; endereço das colunas do teclado (periférico PIN)
LINHA         					EQU 1       ; linha a testar (1ª linha, 0001b)
LINHA_A       					EQU 4       ; linha a testar (4ª linha, 1000b)
MASCARA       					EQU 0FH     ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
LINHALIM      					EQU 8       ; variavel que contem o valor da 4ªa linha
CONTADOR      					EQU 0       ; Contador para o valor da linha/coluna
ENERGIA       					EQU 064H    ; contador da energia que vai ser decrementado ou incrementado com uma tecla
HELP							EQU 10		; valor auxiliar
TECLA_START   					EQU 0AH     ; tecla que comeca o display do jogo
ALCANCE_TIRO					EQU 16		; linha que o tiro vai ate
LINHA_INICIAL_TIRO				EQU 24		; linha incial em que o tiro comeca
TECLA_ESQUERDA					EQU 00H		; tecla para andar para a esquerda (tecla 0)
TECLA_DIREITA					EQU 02H		; tecla para andar para a direita (tecla 2)
TECLA_TIRO						EQU 01H		; tecla para disparar o míssil
TECLA_METEORO_BOM_SPAWN			EQU 03H		; tecla para meter um meteoro bom no tamanho máximo no canto do ecrã
TECLA_METEORO_MAU_SPAWN			EQU 07H		; tecla para meter um meteoro mau no tamanho máximo no canto do ecrã
TECLA_STOP_MUSIC				EQU 04H 	; tecla que para a música, caso seja chato
TECLAINC      					EQU 05H     ; tecla que incrementa o valor do display
TECLADEC      					EQU 06H     ; tecla que decrementa o valor do display

TECLA_PAUSAR_JOGO				EQU 0EH     ; tecla para pausar o jogo
TECLA_PARAR_JOGO        		EQU 0FH     ; tecla para parar completamente o jogo e iniciar a tela de game over 
TECLA_MAIN_MENU			        EQU 0BH     ; tecla para voltar ao main manu
TECLA_CONTROLOS					EQU 0CH		; tecla para aceder ao ecrã de controlos 

DEFINE_LINHA    				EQU 600AH      ; endereço do comando para definir a linha
DEFINE_COLUNA   				EQU 600CH      ; endereço do comando para definir a coluna
DEFINE_PIXEL    				EQU 6012H      ; endereço do comando para escrever um pixel
APAGA_AVISO     				EQU 6040H      ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ						EQU 6002H      ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO			EQU 6042H      ; endereço do comando para selecionar uma imagem de fundo
SELECIONA_SOM					EQU 605AH      ; endereço do comando para tocar o som selecionado
STOP_MUSIC						EQU 6062H      ; para a música do menu principal
SELECIONA_PARA_COMANDO_SOM		EQU 6048H      ; para selecionar o som para futuros comandos 
STOP_SPECIFIC_MUSIC				EQU 604CH      ; para cortar o volume de uma musica especifica
CONTROLA_VOLUME_SOM				EQU 604AH      ; para controlar o volume do som selecionado
REPETE_VIDEO					EQU 605CH      ; para repetir certos loops de videos
MOSTRA_ECRA						EQU 6006H      ; mostra o ecrã especificado
SELECIONA_ECRA					EQU 6004H      ; seleciona o ecra especificado
GUARDA_COR_PIXEL				EQU 6010H	   ; guarda a cor do pixel na posição corrente 
VERIFICA_PIXEL					EQU 6014H      ; verifica se existe um pixel com cor no lugar especificado
ESCONDE_ECRA					EQU 6008H      ; esconde o ecra especificado
COLUNA_TOTAL					EQU 64         ; colunas
LINHA_TOTAL						EQU 32         ; linhas 
LINHA_BONECO        			EQU  26        ; linha do boneco (a meio do ecrã))
COLUNA_BONECO					EQU  30        ; coluna do boneco (a meio do ecrã)
COLUNA_BONECO2					EQU 32		   ; coluna do meio do boneco


LINHA_TECLA_MM					EQU  1			; linha do meteoro mau
COLUNA_TECLA_MM					EQU  1			; coluna do meteoro mau

LINHA_TECLA_MB					EQU  1			; linha do meteoro bom
COLUNA_TECLA_MB                	EQU  58			; coluna do meteoro bom

LARGURA_EXPLOSAO				EQU 5			; largura para o desenho e elimnação da explosão
ALTURA_EXPLOSAO					EQU 5			; altura para o desenho e eliminação da explosão
LARGURA_APAGA					EQU 5			; largura para apagar coisas
ALTURA_APAGA					EQU 6			; largura para apagar coisas

LARGURA_TIRO					EQU 1			; largura do missil/tiro
ALTURA_TIRO						EQU 1			; altura do missil/tiro

LARGURA_BONECO					EQU	5		; largura do boneco
ALTURA_BONECO                	EQU	5		; altura do boneco

LARGURA_DEFAULTM1				EQU 1		; largura do meteoro default 1
ALTURA_DEFAULTM1				EQU 1		; altura do meteoro default 1

LARGURA_DEFAULTM2				EQU 2		; largura do meteoro default 2
ALTURA_DEFAULTM2				EQU 2		; largura do meteoro default 2

LARGURA_MM_PEQUENO				EQU 3		; largura do meteoro bom pequeno 
ALTURA_MM_PEQUENO				EQU 3		; altura do meteoro bom pequeno
LARGURA_MM_MEDIO				EQU 4		; largura do meteoro bom médio
ALTURA_MM_MEDIO					EQU 4		; altura do meteoro bom médio
LARGURA_MM_MAXIMO				EQU	5		; largura dos meteoros maus máximos
ALTURA_MM_MAXIMO          		EQU	5 		; altura dos meteoros maus máximos

LARGURA_MB_PEQUENO				EQU 3		; largura do meteoro bom pequeno 
ALTURA_MB_PEQUENO				EQU 3		; altura do meteoro bom pequeno
LARGURA_MB_MEDIO				EQU 4		; largura do meteoro bom médio
ALTURA_MB_MEDIO					EQU 4		; altura do meteoro bom médio
LARGURA_MB_MAXIMO				EQU	5		; largura dos meteoros bons máximos
ALTURA_MB_MAXIMO				EQU	5		; altura dos meteoros bons máximos

LARANJA					EQU 0FFA0H		; cor laranja 
VERMELHO				EQU	0FF00H		; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
VERDE_CLARO             EQU	0F0F0H		; cor verde   
AMARELO             	EQU	0FFE5H		; cor amarela
BRANCO           		EQU	0FFFFH		; cor branca
PRETO					EQU	0F000H		; cor preta
AZUL_CLARO				EQU	0FAFFH		; cor azul clara
LILAS					EQU	0F80FH		; cor lilás
VERDE_ESCURO			EQU	0F080H		; cor verde escuro

MIN_COLUNA				EQU  0			; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA				EQU  63			; número da coluna mais à direita que o objeto pode ocupar
ATRASO					EQU  900H		; atraso para limitar a velocidade de movimento do boneco
ATRASO_LOADING			EQU  0BFFFH		; pequena animação para o game over 
ATRASO_EXPLOSAO			EQU  1500H		; valor para o atraso da eliminação da explosão depois de ser desenhada 
VALOR_DEC_ENERGIA		EQU  5			; valor para o qual a energia será decrementada durante o tempo


; #######################################################################
; #### ZONA DE DADOS ####################################################
; #######################################################################

	PLACE		1000H				

; ###### DADOS DO BONECO #########################################################

DEF_BONECO:													; tabela que define o boneco (cor, largura, pixels)
	WORD		LARGURA_BONECO, ALTURA_BONECO
	WORD		0, 0, VERMELHO, 0, 0
	WORD		0, PRETO, VERMELHO, PRETO, 0
	WORD		VERMELHO, BRANCO, AZUL_CLARO, BRANCO, VERMELHO		         	
	WORD		PRETO, VERMELHO, BRANCO, VERMELHO, PRETO                             
	WORD		VERMELHO, 0, BRANCO, 0, VERMELHO

; ##### DADOS AUXILIARES #########################################################

energia_atual:					; tabela responsável por guardar a energia atual 
	WORD 0

determina_meteoro:				; tabela responsavel por guardar o valor que faz dar spawn do meteoro bom ou do meteoro mau 
	WORD 0

verifica_tiro:					; flag responsavel por guardar o estado da interrupcao 2, e se o missil foi ja desenhado ou nao. e se existe
	WORD 1

e_possivel_tiro:				; flag responsavel por determinar se ]e possivel clicar na tecla 1, e esta ter algum efeito
	WORD 0

detetor_de_colisoes:			; flag responsável por bloquear a interrupção se tiver acontecido uma colisão, reiniciando outro meteoro 
	WORD 0

detetor_de_colisoes2:			; flag auxiliar que possui o mesmo trabalho da anterior
	WORD 0

matou_mau:						; flag resppnsavel por detetar se um meteoro mau foi morto ou nao
	WORD 0

game_over_colisao:				; flag responsável por detetar se existe colisão entre o rover e um meteoro mau, logo game over 
	WORD 0

passou_meteoro_mau:				; flag responsável por guardar quantos meteoros maus já passaram pelo rover
	WORD 0

largura_atual_meteoro:			; tabela responsável por guardar a largura atual do meteoro que está no ecrã
	WORD 1

linha_tiro:						; linha inicial do tiro
	WORD 24

coluna_perma:					; tabela responsavel por guardar a ultima coluna pela qual o missil foi disparadop de modo
	WORD 32						; a fazer a sua eliminação eficientemente

coluna_temporaria:
	WORD 0

coluna_boneco:					; coluna que é atualizada e guardada ao longo do tempo que é responsavel por guardar 
	WORD 32						; o "sitio" por one "sai" o missil 

coluna_desenha_boneco:			; coluna pela qual o boneco é desenhado, guardado e alterado
	WORD 30

linha_desenha_boneco:			; linha pela qual o boneco é desenhado, guardado e alterado
	WORD 26

coluna_meteoro:					; tabela responsavel por guardar a coluna do meteoro
	WORD 0

linha_meteoro:					; linha atual do meteoro a descer 
	WORD 0

contador_meteoro1:				; contador que ajuda na queda dos meteoros 
	WORD 0

contador_extra:					; contador extra que ajuda na queda dos meteoros
	WORD 0

; ###### DADOS DO MISSIL ##########################################################

DEF_TIRO:													; tabela que define missil de tamanho 1x1 (cor, largura, pixels)
	WORD		LARGURA_TIRO, ALTURA_TIRO
	WORD		AMARELO

DEF_PARA_APAGAR_TIRO_E_METEORO:								; tabela que define a largura e a altura para apagar o meteoro quando existe uma colisao
	WORD		LARGURA_APAGA, ALTURA_APAGA
	

; ###### DADOS DOS METEOROS #######################################################

DEF_METEORO1_DEFAULT:										; tabela que define o meteoro default cinzento de tamanho 1x1 (cor, largura, pixels)
	WORD		LARGURA_DEFAULTM1, ALTURA_DEFAULTM1
	WORD		BRANCO

DEF_METEORO2_DEFAULT:										; tabela que define o meteoro default cinzento de tamanho 2x2 (cor, largura, pixels)
	WORD		LARGURA_DEFAULTM2, ALTURA_DEFAULTM2
	WORD		BRANCO, BRANCO
	WORD		BRANCO, BRANCO

DEF_METEORO_MAU_PEQUENO:									; tabela que define o meteoro mau pequeno (cor, largura, pixels)
	WORD		LARGURA_MM_PEQUENO, ALTURA_MM_PEQUENO
	WORD		0, LILAS, 0
	WORD		LILAS, PRETO, LILAS
	WORD		0, LILAS, 0

DEF_METEORO_MAU_MEDIO:										; tabela que define o meteoro mau medio (cor, largura, pixels)
	WORD		LARGURA_MM_MEDIO, ALTURA_MM_MEDIO
	WORD		0, LILAS, LILAS, 0
	WORD		LILAS, PRETO, PRETO, LILAS
	WORD		LILAS, VERMELHO, VERMELHO, LILAS
	WORD		0, LILAS, LILAS, 0

DEF_METEORO_MAU_MAXIMO:										; tabela que define o meteoro mau maximo (cor, largura, pixels)
	WORD		LARGURA_MM_MAXIMO, ALTURA_MM_MAXIMO
	WORD		0, LILAS, VERMELHO, LILAS, 0
	WORD		LILAS, VERMELHO, VERMELHO, VERMELHO, LILAS
	WORD		LILAS, VERMELHO, PRETO, VERMELHO, LILAS				
	WORD		LILAS, VERMELHO, VERMELHO, VERMELHO, LILAS			
	WORD		0, LILAS, VERMELHO, LILAS, 0

DEF_METEORO_BOM_PEQUENO:									; tabela que define o meteoro bom pequeno (cor, largura, pixels)
	WORD		LARGURA_MB_PEQUENO, ALTURA_MB_PEQUENO
	WORD		0, VERDE_CLARO, 0
	WORD		VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO
	WORD		0, VERDE_CLARO, 0

DEF_METEORO_BOM_MEDIO:										; tabela que define o meteoro bom medio (cor, largura, pixels)
	WORD		LARGURA_MB_MEDIO, ALTURA_MB_MEDIO
	WORD		0, VERDE_CLARO, VERDE_CLARO, 0
	WORD		VERDE_CLARO, VERDE_ESCURO, VERDE_ESCURO, VERDE_CLARO
	WORD		VERDE_CLARO, VERDE_ESCURO, VERDE_ESCURO, VERDE_CLARO
	WORD		0, VERDE_CLARO, VERDE_CLARO, 0
DEF_METEORO_BOM_MAXIMO:										; tabela que define o meteoro bom maximo (cor, largura, pixels) 
	WORD		LARGURA_MB_MAXIMO, ALTURA_MB_MAXIMO
	WORD		0, VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO, 0
	WORD		VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO
	WORD		VERDE_ESCURO, VERDE_CLARO, VERDE_CLARO, VERDE_CLARO, VERDE_ESCURO
	WORD		VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO
	WORD		0, VERDE_CLARO, VERDE_ESCURO, VERDE_CLARO, 0     

; ###### TABELA DAS INTERRUPÇOES #########################################################

tab: 														; esta tabela é responsável por conter as 3 rotinas de interrupção 
	WORD rot_int_0											; respetivas aos 3 relógios 
	WORD rot_int_1
	WORD rot_int_2						


	
	PLACE 1300H
	
st: STACK 200H						; stack com 200H de espaço só para prevenir


SP_inicial: WORD 0					; e o sp com word 0 também só para prevenir 


	PLACE 0 
	
inicio_geral:	
	MOV  SP, SP_inicial				; inicializa SP para a palavra a seguir
									; à última da pilha
main_menu:
	MOV R10, 0
	MOV [linha_meteoro], R10
	MOV [contador_meteoro1], R10
	
	MOV R10, LINHA_BONECO					; aqui é tudo reiniciado ao estado original
	MOV [linha_desenha_boneco], R10			; de modo ao nao entrar em conflito
	MOV R10, COLUNA_BONECO					; no caso de uma segunda vez a jogar seguida
	MOV [coluna_desenha_boneco], R10
	MOV R10, COLUNA_BONECO2
	MOV [coluna_boneco], R10
	MOV [coluna_perma], R10
	MOV R10, 1
	MOV [verifica_tiro], R10
	MOV R10, 0
	MOV [detetor_de_colisoes], R10
	MOV [game_over_colisao], R10
	MOV [passou_meteoro_mau], R10

	MOV  R10, DISPLAYS						; inicia o display de energia a 100, para poder ser alterado durante o jogo
	MOV  R1, ENERGIA
	MOV  [R10], R1
	
	MOV  [energia_atual], R1
	CALL atualiza_displays
	
	MOV R1, 0
	MOV [SELECIONA_PARA_COMANDO_SOM], R1		; mete musica para o menu inicial
	MOV R1, 20									; controla o volume para 20
	MOV [CONTROLA_VOLUME_SOM], R1
	MOV R1, 0
	MOV [SELECIONA_SOM], R1


	MOV  [APAGA_AVISO], R1					; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
	MOV  [APAGA_ECRÃ], R1					; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
	MOV  R1, 1								; cenário de fundo número 1
	MOV  [SELECIONA_CENARIO_FUNDO], R1		; seleciona o cenário de fundo					
	
	
verifica_inputA:							; aqui é verificado o input do teclado durante a tecla inicial 
	CALL teclado_push
	
	MOV R11, TECLA_START					; se a tecla for a letra A então o jogo começa
	CMP R8, R11
	JZ boneco_time					
	MOV R11, TECLA_CONTROLOS				; se a tecla for a letra C entao o background muda para um novo 
	CMP R8, R11								; background que mostra os controlos disponiveis dentro do jogo 
	JZ tela_controlos
	JMP verifica_inputA						; se não for introduzida nenhuma destas teclas então volta a verificar o input do teclado

tela_controlos:									; nesta função apenas é introduzido o background responsável por demonstrar os
	MOV R1, 5									; controlos dentro do jogo 
	MOV [SELECIONA_CENARIO_FUNDO], R1	
	MOV R1, 0		
	MOV [SELECIONA_PARA_COMANDO_SOM], R1		
	MOV R1, 5									; também foi diminuido o volume da música de fundo para o utilizador poder ler com calma
	MOV [CONTROLA_VOLUME_SOM], R1

espera_teclaA:							; função responsável por apenas esperar pela tecla A durante a tela de controlos
	CALL teclado_push					; para poder voltar ao main menu 

	MOV R11, TECLA_START
	CMP R8, R11
	JZ  main_menu
	JMP espera_teclaA

verifica_input_gameover:				; esta função é responsável por determinar o input dentro da tela de game over 
	CALL teclado_push					; depois de chamado o teclado, R8 é comparado aos valores da tecla presentes no game over 
	MOV R11, TECLA_START				
	CMP R8, R11							; se a tecla premida foi A então volta ao inicio da função boneco_time2 para começar outro jogo rapidamente
	JZ boneco_time2						
	MOV R11, TECLA_MAIN_MENU
	CMP R8, R11							; se a tecla premida for B então volta ao incio da função main_menu a partir da main_menu_silence de modo a 
	JZ main_menu_silence				; poder tirar a musica antes de voltar ao menu incial
	JMP verifica_input_gameover

main_menu_silence:						; silencia a musica de fundo antes de voltar ao menu principal
	MOV R1, 0
	MOV [STOP_MUSIC], R1
	JMP main_menu

; ###########################################################################################################
; ### Inicio do desenho do rover e do jogo inicial ##########################################################
; ###########################################################################################################
	
boneco_time:
	MOV  BTE, tab							; inicializa BTE 
	
	
	MOV R1, 0								; mostra o ecrã para não haver conflitos 
	MOV [MOSTRA_ECRA], R1

boneco_time2:								
	DI
	MOV R1, 0								
	MOV [STOP_MUSIC], R1					; a musica anterior do main menu para, e uma nova musica
	CALL mega_aleatorio						; durante a primeira vez em que o boneco é desenhado, é decidido que tipo de meteoro vai spawnar
	MOV R1, [coluna_meteoro]				; e em que coluna irá spawnar 

	MOV R1, COLUNA_BONECO2
	MOV [coluna_perma], R1					; os sitios onde são guardados na memoria a coluna pela qual "sai" o missil e a ultima coluna 
	MOV [coluna_boneco], R1					; guardada em que o tiro foi disparado por
	MOV R1, 0
	MOV [detetor_de_colisoes], R1			; foram metidos os valores inicias das tabelas que guardam estes valores 
	MOV [game_over_colisao], R1
	MOV [passou_meteoro_mau], R1


	MOV R10, ENERGIA
	MOV [energia_atual], R10
	CALL atualiza_displays					; assim que o jogo começa o valor da energia é passado logo para decimal e transportado para os displays 
	
	MOV R1, 1								
	MOV  [SELECIONA_PARA_COMANDO_SOM], R1
	MOV R1, 15
	MOV [CONTROLA_VOLUME_SOM], R1
	MOV R1, 1
	MOV [REPETE_VIDEO], R1					; repete a música de fundo até esta ser parada

	MOV  [APAGA_AVISO], R1					; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
	MOV  [APAGA_ECRÃ], R1					; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
	MOV	 R1, 0								; cenário de fundo número 0
	MOV  [SELECIONA_CENARIO_FUNDO], R1		; seleciona o cenário de fundo
	MOV  R11, 1								; dá set no R11 a 1 que sera responsável pelo testa limites
	
	
posição_boneco:
	MOV  R1, LINHA_BONECO					; linha do boneco
	MOV  R2, COLUNA_BONECO					; coluna do boneco
	MOV  R4, DEF_BONECO	
	
	EI0
	EI1
	EI2									; permite interrupções 
	EI

show_boneco:
	DI
	CALL	desenha_boneco1				; é desenhado o boneco na sua posição inicial
	EI

espera_teclaK:
	CALL	teclado_push				; é chamado a função corresponde ao teclado para	
										; verificar as teclas do teclado e guardá-las no R8 se forem premidas
										; o valor da tecla que foi premida é comparado aos várias variáveis que 
										; contém o valor das teclas, conforme a tecla tem uma ação diferete
	
	MOV R10, [passou_meteoro_mau]		; verifica se passaram 3 meteoros pela linha 0, se sim então começa a parar o jogo
	CMP R10, 3
	JZ para_jogo
	MOV R10, [game_over_colisao]		; se existir uma colisao com um meteoro mau então começa a parar o jogo
	CMP R10, 2
	JZ para_jogo
	MOV R10, [energia_atual]			; se a energia chegar a 0, então começa a parar o jogo
	CMP R10, 1							
	JZ zero_again
	CMP R8, TECLA_TIRO					; tecla 1
	JZ enable_interrupcao_tiro
	CMP R8, TECLA_ESQUERDA				; as teclas 0 e 2 movem o boneco para a esquerda e direita, respetivamente
	JZ testa_esquerda
	CMP R8, TECLA_DIREITA				
	JZ testa_direita					
	;CMP R8, TECLA_METEORO_BOM_SPAWN	; as teclas 3 e 7 criam um meteoro bom e mau, respetivamente, estas teclas foram retiradas 
	;JZ spawna1_meteoro_bom				; pois ja nao sao necessarias
	;CMP R8, TECLA_METEORO_MAU_SPAWN	
	;JZ spawna1_meteoro_mau				
	CMP R8, TECLA_STOP_MUSIC			; a tecla 4 para a musica do jogo
	JZ para_musica						; foram implementadas mais duas teclas para a incrementação e decrementação do valor do
										; display mas elas encontram-se na função do teclado em si para maior facilidade
	
	MOV R11, TECLA_PAUSAR_JOGO			; tecla E
	CMP R8, R11
	JZ pausa_jogo
	MOV R11, TECLA_PARAR_JOGO			; tecla F para parar manualmente o jogo 
	CMP R8, R11
	JZ para_jogo
	
	JMP espera_teclaK					; caso não haja tecla volta ao inicio 

para_musica:						; tecla 4, para a musica do jogo
	MOV [STOP_MUSIC], R1
	JMP espera_teclaK

enable_interrupcao_tiro:			; tecla 1, dispara o missil se possivel
	CALL possibilidade_de_tiro
	JMP espera_teclaK

possibilidade_de_tiro:				; esta funcao é responsável por verificar se é 
	PUSH R3							; possivel disparar, pois só é possivel disparar um 
									; missil ate o outro ter desaparecido
	MOV R3, [e_possivel_tiro]
	CMP R3, 0						; se a flag que está na memória estiver a 1 significa,
	JZ nao_ha_missil_atual			; que é possivel inicir a movimentação do tiro a partir 
									; da interrupção
	JMP volta_teclado

nao_ha_missil_atual:
	MOV R3, 0
	MOV [verifica_tiro], R3			; se nao existe um missil a ser desenhado no ecra entao 
	MOV R3, 1						; a flag responsável por iniciar a interrupção fica ativa e 
	MOV [e_possivel_tiro], R3		; outra flag responável por bloquear a tela 1 é ativada de modo a nao 
	MOV R3, [coluna_boneco]			; poder "disparar" de maneira a nao entrar em conlito com a interrupcao 
	MOV [coluna_perma], R3
	
	MOV R10, [energia_atual]		; decrementa a energia atual com 5 por causa da tecla 1 
	SUB R10, VALOR_DEC_ENERGIA
	MOV [energia_atual], R10
	CALL atualiza_displays
	MOV R3, 4
	MOV [SELECIONA_SOM], R3			; e toca o sound effect do tiro 
	JMP volta_teclado

volta_teclado:
	POP R3
	RET

para_jogo:										; tecla F ou game over caso a energia chegue a zero ou caso passem 3 meteoros maus 
	DI											; pelo rover ou ou caso haja uma colisao com um meteoro mau 

	CALL game_over_push							; é começada uma pequena animação para começar a tela de game over
	CALL renova
	
	
	MOV R10, [energia_atual]
	CMP R10, 1									; mas primeiro é verificado qual das telas de game over vai ser apresentada
	JLE tela_de_game_over_ENERGIA

	MOV R10, [game_over_colisao]
	CMP R10, 2
	JZ tela_de_game_over_COLISAO_MAU			; se for por causa da energia ter chegado a 0 então a tela de game over da
	MOV R10, [passou_meteoro_mau]				; energia será apresentada, se o game over tiver sido feito manualmente a partir da tecla F 
	CMP R10, 3									; então a tela de game over manual começa, e assim para as restantes propriedades do game over 
	JZ tela_de_game_over_PASSOU_METEORO_MAU
	
	JMP tela_de_game_over_TECLA					
										

; ##################################################################################################################
; #### Pausa e os seus componentes #################################################################################
; ##################################################################################################################

pausa_jogo:										; tecla E, pausar o jogo
	PUSH R1 

	DI											; antes de tudo são desabilitadas as interrupções de modo a 
												; nao perder "tempo" ao pausar a gameplay
	MOV R1, 1								
	MOV [SELECIONA_PARA_COMANDO_SOM], R1		; o volume da musica de fundo é reduzida de modo a não incomodar o utilizador
	MOV R1, 5
	MOV [CONTROLA_VOLUME_SOM], R1

	MOV R1, 0									; o ecra que possui os pixeis é escondido e é selecionado
	MOV [ESCONDE_ECRA], R1						; o fundo responsável pela pausa
	MOV R1, 4
	MOV [SELECIONA_CENARIO_FUNDO], R1
	POP R1

pausa_jogo_loop:						; assim depois da pausa ser feita, está se num loop infinito em que é apenas 
	CALL teclado_push					; quebrado se e apenas se a mesma tecla que foi premida para pausar o jogo, for premida de novo
										
	MOV R11, TECLA_PAUSAR_JOGO
	CMP R8, R11
	JNZ pausa_jogo_loop

continua_jogo:									; se o jogo for despausado, então as interrupções são ativadas outra vez 
	PUSH R1 

	EI0
	EI1
	EI2											; permite interrupções 
	EI

	MOV R1, 1									
	MOV [SELECIONA_PARA_COMANDO_SOM], R1		; a música é metida ao seu volume original
	MOV R1, 15
	MOV [CONTROLA_VOLUME_SOM], R1

	MOV R1, 0
	MOV [MOSTRA_ECRA], R1						
	MOV R1, 0
	MOV [SELECIONA_CENARIO_FUNDO], R1			; é escolhido o background do jogo outra vez e 
												; volta à espera de uma nova tecla no espera teclaK
	POP R1
	JMP espera_teclaK

; #########################################################################################################
; #### Testa Limites ######################################################################################
; #########################################################################################################

testa_esquerda:			; tecla 0
	MOV	R7, -1			; vai deslocar para a esquerda, e vai ver se é possivel
	JMP	ve_limites

testa_direita:				; tecla 2 
	MOV	R7, +1				; vai deslocar para a direita, e vai ver se é possivel
	JMP	ve_limites

ve_limites:
	MOV R4, DEF_BONECO			; obtém o endereço responsável pela tabela da definição do boneco
	MOV	R6, [R4]				; obtém a largura do boneco
	CALL testa_limites			; vê se chegou aos limites do ecrã e se sim força R7 a 0
	CMP	R7, 0					; se for 0 então espera mais uma vez outra ação do teclado
	JZ	espera_teclaK
	
move_boneco:
	CALL	apaga_boneco		; apaga o boneco na sua posição corrente
	
coluna_seguinte:
	MOV R2, [coluna_desenha_boneco]
	ADD	R2, R7								; para desenhar objeto na coluna seguinte 
	MOV [coluna_desenha_boneco], R2			; é guardada a coluna corrente do boneco na memória
	ADD R2, 2
	MOV [coluna_boneco], R2					; é guardada também o mesmo valor mais 2 na tabela que guarda
	MOV R2, [coluna_desenha_boneco]			; a coluna pela qual o missil "sai"

	JMP	show_boneco


; ################################################################################
; #### Pequenas funções que atualizam alguns dados ###############################
; ################################################################################

zero_again:					; esta função certifica-se de meter o display a zero
							; quando assim é desejado e de iniciar o game over
	PUSH R1
	MOV R1, DISPLAYS
	MOV R10, 0
	MOV [R1], R10
	MOV [energia_atual], R10
	POP R1
	JMP para_jogo


renova:									; esta função ajuda a meter os valores originais 
	PUSH R1								; das tabelas na memória outra vez
	MOV R1, 0
	MOV [linha_meteoro], R1							; assim são atualizados: contador, linha_meteoro, 
	MOV [contador_meteoro1], R1						; linha_desenha_boneco, coluna_desenha_boneco, 
	MOV R1, LINHA_BONECO							; coluna_boneco e coluna_perma
	MOV [linha_desenha_boneco], R1
	MOV R1, COLUNA_BONECO
	MOV [coluna_desenha_boneco], R1
	MOV R1, COLUNA_BONECO2
	MOV [coluna_boneco], R1
	MOV [coluna_perma], R1
	POP R1
	RET		

; ##############################################################################################
; #### Para o jogo, game over e volta ao main menu #############################################
; ##############################################################################################

tela_de_game_over_ENERGIA:				; as quatro funções são iguais e apenas mudam no background, para os diferentes game overs
	PUSH R1
	MOV R1, 3
	MOV [SELECIONA_CENARIO_FUNDO], R1
	MOV [APAGA_ECRÃ], R1
	MOV R1, 3
	MOV [SELECIONA_SOM], R1

	POP R1
	JMP verifica_input_gameover

tela_de_game_over_COLISAO_MAU:					
	PUSH R1
	MOV R1, 6
	MOV [SELECIONA_CENARIO_FUNDO], R1
	MOV [APAGA_ECRÃ], R1
	MOV R1, 3
	MOV [SELECIONA_SOM], R1
	MOV R1, 0
	MOV [game_over_colisao], R1

	POP R1
	JMP verifica_input_gameover


tela_de_game_over_TECLA:					
	PUSH R1
	MOV R1, 2
	MOV [SELECIONA_CENARIO_FUNDO], R1
	MOV [APAGA_ECRÃ], R1
	MOV R1, 3
	MOV [SELECIONA_SOM], R1

	POP R1
	JMP verifica_input_gameover

tela_de_game_over_PASSOU_METEORO_MAU:					
	PUSH R1
	
	MOV R1, 0
	MOV [passou_meteoro_mau], R1
	MOV R1, 7
	MOV [SELECIONA_CENARIO_FUNDO], R1
	MOV [APAGA_ECRÃ], R1
	MOV R1, 3
	MOV [SELECIONA_SOM], R1

	POP R1
	JMP verifica_input_gameover

game_over_push:							; esta é a função responsável pela animação de game over 
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R11
	
	DI									; primeiro são desativadas as interrupções

	MOV	R5, COLUNA_TOTAL				; são guardados assim os valores máximos de linhas e colunas
	MOV	R6, LINHA_TOTAL					; nos respetivos registos
	MOV	R1, 0
	MOV	R2, 0
	
game_over_animation:
	MOV R11, ATRASO_LOADING				
	
	MOV  R3, PRETO					; é selecionado a cor preta
	MOV  [DEFINE_LINHA], R1				; seleciona a linha
	MOV  [DEFINE_COLUNA], R2			; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3				; altera a cor do pixel na linha e coluna selecionadas
	ADD  R2, 1               			; próxima coluna
	SUB  R5, 1							; menos uma coluna para tratar
	JNZ  game_over_animation      		; continua até percorrer toda a largura do ecrã
	
ciclo_atraso_loading:					; atrasa um pouco a animação 	
	SUB	R11, 1			
	JNZ	ciclo_atraso_loading	
	
	MOV  R5, COLUNA_TOTAL			
	MOV  R2, 0
	ADD  R1, 1
	SUB  R6, 1
    JNZ  game_over_animation

stop_current_music:
	MOV R1, 0
	MOV [STOP_MUSIC], R1				; a musica anterior do main menu para, e uma nova musica é depois introduzida
	
	POP	R11								; --> é feito pop dos registos usados no desenha_boneco1 e no atraso
    POP	R6
    POP	R5
	POP	R4
	POP	R3
	POP	R2
	POP	R1
	RET

; ###############################################################################################
; #### Rotinas de interrupção  ###################################################################
; ###############################################################################################

rot_int_0:
	CALL queda_meteoro1				; é chamada a função queda_meteoro
	RFE

rot_int_1:							; é chamada a função movimentacao_tiro
	CALL movimentacao_tiro
	RFE
	
rot_int_2:
	MOV R10, [energia_atual]
	CMP R10, 5
	JLE so_atualiza					; se durante a próxima verificação da interrupção o valor responsável por 
	
	MOV R10, [energia_atual]
	SUB R10, VALOR_DEC_ENERGIA 		; guardar a energia for menor que 5, entao é a mesma coisa que game over
	MOV [energia_atual], R10
	CALL atualiza_displays			; decrementa a energia com 5
	RFE								; Return From Exception (diferente do RET)

so_atualiza:
	MOV R10, 0
	MOV [energia_atual], R10
	MOV [DISPLAYS], R10			; mete os displays a zero e automaticamente começa a tela de game over de 0 energia
	RFE


; ###############################################################################################
; ### Transforma o valor hexadecimal da energia em decimal  #####################################
; ###############################################################################################

atualiza_displays:			; esta função é responsável por transformar o valor 
	PUSH R1					; hexadecimal dos displays em um valor decimal
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R9
	
	MOV R1, DISPLAYS
	MOV R3, ENERGIA
	MOV R2, [energia_atual]
	MOV R6, [energia_atual]
	
	DIV R2, R3        ; ---> valor da divisao inteira ---> R2
	
	MOD R6, R3
	
	SHL R2 , 4        ; ---> SHL do valor da divisao inteira
	MOV R5, 10        ; ---> guarda-se o valor de 10 no R5
	MOV R9, R6
	
	DIV R6, R5        ; ---> divide-se o valor do resto da divisao por 10
	
	OR R2, R6         ; ---> OR com o R2 e o resultado da divisao inteira, guardado no R2
	SHL R2, 4         ; ---> SHL do valor da divisao inteira
	MOD R9, R5
	
	OR R2, R9         ; ---> OR com R2 e o valor do resto que foi dividido por 10, guardado no R2 
	
	MOV [R1], R2      ; é metido o valor de R2 nos displays
	
	POP	R9
	POP	R6
    POP	R5
	POP	R3
	POP	R2
	POP	R1
	RET
	
		
; ###########################################################################################################
; #### Desenha o bonequinho #################################################################################
; ###########################################################################################################	

desenha_boneco1:				; ----> dá push dos registos necessários 
	PUSH	R1
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	PUSH	R6	
	PUSH	R11					; desenha o boneco a partir da tabela
	
desenha_boneco2:				
	MOV R4, DEF_BONECO			
	MOV	R5, [R4]				; obtém a largura do boneco
	ADD	R4, 2
	MOV	R6, [R4]				; obtem altura 
	ADD	R4, 2
	
	MOV R2, [coluna_desenha_boneco]
	MOV R1, [linha_desenha_boneco]

desenha_pixels_boneco:       				; desenha os pixels do boneco a partir da tabela
	MOV	 R3, [R4]							; obtém a cor do próximo pixel do boneco
	MOV  [DEFINE_LINHA], R1					; seleciona a linha
	MOV  [DEFINE_COLUNA], R2				; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3					; altera a cor do pixel na linha e coluna selecionadas
	ADD	 R4, 2								; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
	ADD  R2, 1               				; próxima coluna
	SUB  R5, 1								; menos uma coluna para tratar
	JNZ  desenha_pixels_boneco      		; continua até percorrer toda a largura do objeto
	
	MOV  R5, LARGURA_BONECO					; continua até percorrer toda a altura
	ADD  R1, 1
	SUB  R2, R5
	SUB  R6, 1

    JNZ  desenha_pixels_boneco

; ###########################################################################################################
; ### Atraso ################################################################################################
; ###########################################################################################################    	
   	
atraso:						; o atraso dá imenso jeito em tornar mais "visivel" e fluida
   	MOV R11, ATRASO			; a movimentação do boneco, antes do boneco ser reescrito, esta
ciclo_atraso:				; função simplesmente usa o valor da variável ATRASO e decremen-
	SUB	R11, 1				; ta-o até 0 para "dar tempo" ao boneco depois de ser apagado e 
	JNZ	ciclo_atraso		; antes de ser reescrito na nova posição 
	
	MOV R1, 2
	MOV [SELECIONA_SOM], R1
	
	POP	R11					; --> é feito pop dos registos usados no desenha_boneco1 e no atraso
    POP	R6
    POP	R5
	POP	R4
	POP	R3
	POP	R2
	POP	R1
	RET


; ###########################################################################################################
; ### Apaga o boneco ########################################################################################
; ###########################################################################################################


apaga_boneco:
	PUSH	R1				; ----> dá push dos registos necessários 
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	PUSH	R6

	MOV R4, DEF_BONECO
	MOV	R5, [R4]			; obtém a largura do boneco
	ADD	R4, 2				; endereço da cor do 1º pixel (2 porque a largura é uma word)
	MOV	R6, [R4]
	ADD	R6, 2
	
apaga_pixels:       				; desenha os pixels do boneco a partir da tabela
	MOV	R3, 0						; cor para apagar o próximo pixel do boneco
	MOV  [DEFINE_LINHA], R1		
	MOV  [DEFINE_COLUNA], R2		
	MOV  [DEFINE_PIXEL], R3		
	ADD	R4, 2				
	ADD	R2, 1               		; próxima coluna
	SUB	R5, 1						; menos uma coluna para tratar
	JNZ	apaga_pixels      			; continua até percorrer toda a largura do objeto
	
	MOV	R5, LARGURA_BONECO			; continua até percorrer toda a altura
	ADD	R1, 1				
	SUB	R2, R5				
	SUB	R6, 1						; esta função é fundamentalmente a mesma que a desenha boneco
    JNZ	apaga_pixels			; apenas "desenha" com uma "tinta transparente" que apaga os pixeis anteriores
    	

liberta_stuff:
	POP	R6					; --> é feito pop dos registos usados
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	POP	R1
	RET
	
	
; ###############################################################################################
; #### Verifica Limites #########################################################################
; ###############################################################################################


testa_limites:				; ----> dá push dos registos necessários 
	PUSH	R1
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	PUSH	R6
	PUSH	R9

testa_limite_esquerdo:			; verifica se o boneco chegou ao limite esquerdo
	MOV	R5, MIN_COLUNA
	MOV R2, [coluna_desenha_boneco]

	CMP	R2, R5
	JGT	testa_limite_direito
	CMP	R7, 0					; se sim, passa a deslocar-se para a direita
	JGE	sai_testa_limites
	MOV R9, [coluna_boneco]
	SUB R9, 1
	MOV [coluna_boneco], R9
	JMP	impede_movimento		; se ainda não está no limite máximo, o valor de R7 mantém se

testa_limite_direito:			
	ADD	R6, R2					; verifica se o boneco chegou ao limite direito
	MOV	R5, MAX_COLUNA
	CMP	R6, R5
	JLE	sai_testa_limites		; se sim, passa a deslocar-se para a esquerda
	CMP	R7, 0					;  se ainda não está no limite máximo, o valor de R7 mantém se
	JGT	impede_movimento
	MOV R9, [coluna_boneco]
	ADD R9, 1
	MOV [coluna_boneco], R9
	JMP	sai_testa_limites

impede_movimento:
	MOV	R7, 0					; se chegar ao limite, o boneco para e não se mexe, forçando o 
								; o valor de R7 a 0
sai_testa_limites:	
	POP R9	
	POP	R6					; --> é feito pop dos registos usados
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	POP	R1
	RET	
	
; ####################################################################################################
; ### Queda do Meteoro ###############################################################################
; ####################################################################################################

queda_meteoro1:						; dá push dos registos necessários
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11
	
qqqueda_meteoros1:						; esta funçao é responsável pela queda dos meteoros
	MOV R11, [game_over_colisao]
	CMP R11, 1
	JGT liberta_pops1					; se houver uma colisão com um meteoro mau então sai e começa game over 

	MOV R11, [detetor_de_colisoes]		; se o detetor de colisões estiver ativo, significa que uma colisao ocorreu
	CMP R11, 1							; assim esse meteoro foi apagado e irá ser reiniciada otra queda do meteoro
	JZ aleatorio1

	MOV R11, [detetor_de_colisoes2]     ; o mesmo para qui 
	CMP R11, 1
	JZ aleatorio1
	
	MOV R11, [determina_meteoro]		; dá load nas coisas e começa a avaliar a queda e quando mudar de meteoro e que tipo
	MOV R7, [contador_meteoro1]			; de meteoro será mostrado
	MOV R9, R7
	MOV R8, ATRASO_LOADING
	
	MOV R7, [contador_extra]
	CMP R7, 1
	JZ aleatorio1
	CMP R11, 2							; aqui estão demontradas as probabilidades dos meteoros 
	JGT queda_meteoro2_mau1				; após apliacada a funçao aleatorio1 e o mega_aleatorio
	JMP queda_meteoro2_bom1				; se o valor for menor que 2 é um meteoro bom, se for maior é um meteoro mau
										; assim temos 25% de meteoros bons e 75% de meteoros maus 
liberta_pops1:
	POP R11
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
 	POP R3
	POP R2
	POP R1
	POP R0
	RET	

aleatorio1:
	CALL mega_aleatorio					; chama a função mega_aleatorio e volta a atualizar os 
	MOV R7, 0							; valores necessários 
	MOV [detetor_de_colisoes], R7
	MOV [detetor_de_colisoes2], R7
	MOV [contador_meteoro1], R7
	MOV [contador_extra], R7
	MOV [linha_meteoro], R7
	MOV R11, [determina_meteoro]		; volta a verificar o valor do determina_meteoro e seleciona o
	CMP R11, 2							; tipo de meteoro
	JGT queda_meteoro2_mau1

queda_meteoro2_bom1:	
	MOV R7, LINHA_TOTAL						; esta função é responsável por fazer a queda do meteoro bom						
	MOV R2, [linha_meteoro]										
	MOV R1, [coluna_meteoro]
	CMP R9, 0
	JZ so_desenha_bom1
	CALL apaga_meteoro_bom_queda_maximo1
	MOV R2, [linha_meteoro]
	ADD R2, 1
	MOV [linha_meteoro], R2
	CALL deteta_colisoes
	MOV R11, [detetor_de_colisoes]
	CMP R11, 1
	JZ liberta_pops1
	CMP R2, R7
	JZ renova_linha1_bom 
	JMP continua_queda_bom1

renova_linha1_bom:							; renova a linha e o contador do meteoro bom
	MOV R2, 1
	MOV [contador_extra], R2
	MOV R2, 0
	MOV [linha_meteoro], R2
	MOV R9, 0
	MOV [contador_meteoro1], R9
	JMP liberta_pops1

queda_meteoro2_mau1:	
	MOV R7, LINHA_TOTAL						; esta função é responsável por fazer a queda do meteoro mau							
	MOV R2, [linha_meteoro]										
	MOV R1, [coluna_meteoro]
	CMP R9, 0
	JZ so_desenha_mau1
	CALL apaga_meteoro_mau_queda_maximo1
	MOV R2, [linha_meteoro]
	ADD R2, 1
	MOV [linha_meteoro], R2
	CALL deteta_colisoes
	MOV R11, [detetor_de_colisoes]
	CMP R11, 1
	JGT liberta_pops1
	MOV R11, [game_over_colisao]
	CMP R11, 1
	JZ liberta_pops1
	CMP R2, R7
	JZ renova_linha1_mau
	JMP continua_queda_mau1

renova_linha1_mau:						; renova a linha e o contador do meteoro mau e incrementa o valor
	MOV R2, 1							; que guarda o número de meteoros maus que o jogo permite passar 
	MOV [contador_extra], R2			; sem causar o game over 
	MOV R2, 0
	MOV [linha_meteoro], R2
	MOV R9, 0
	MOV [contador_meteoro1], R9
	MOV R9, [passou_meteoro_mau]
	ADD R9, 1
	MOV [passou_meteoro_mau], R9
	JMP liberta_pops1
	
continua_queda_mau1:					; verifica que tipo de meteoro mau deve desenhar 
	CMP R9, 3
	JLE desenha_mau_default1_1
	CMP R9, 6
	JLE desenha_mau_default2_1
	MOV R8, LINHALIM
	CMP R9, R8
	JLE desenha_mau_pequeno_1
	MOV R8, HELP
	CMP R9, R8
	JLE desenha_mau_medio_1
	JMP desenha_mau_maximo_1

continua_queda_bom1:					; ; verifica que tipo de meteoro bom deve desenhar 
	CMP R9, 3
	JLE desenha_bom_default1_1
	CMP R9, 6
	JLE desenha_bom_default2_1
	MOV R8, LINHALIM
	CMP R9, R8
	JLE desenha_bom_pequeno_1
	MOV R8, HELP
	CMP R9, R8
	JLE desenha_bom_medio_1
	JMP desenha_bom_maximo_1

; #### Mudança de forma dependendo da linha do meteoro mau ###########################

desenha_mau_default1_1:
	CALL desenha_meteoro_mau_queda_default1_1
	JMP liberta_pops1
	
desenha_mau_default2_1:
	CALL desenha_meteoro_mau_queda_default2_1
	JMP liberta_pops1

desenha_mau_pequeno_1:
	CALL desenha_meteoro_mau_queda_pequeno_1
	JMP liberta_pops1

desenha_mau_medio_1:
	CALL desenha_meteoro_mau_queda_medio_1
	JMP liberta_pops1

desenha_mau_maximo_1:
	CALL desenha_meteoro_mau_queda_maximo_1
	JMP liberta_pops1

; #### Mudança de forma dependendo da linha do meteoro bom ###########################

desenha_bom_default1_1:
	CALL desenha_meteoro_bom_queda_default1_1
	JMP liberta_pops1
	
desenha_bom_default2_1:
	CALL desenha_meteoro_bom_queda_default2_1
	JMP liberta_pops1

desenha_bom_pequeno_1:
	CALL desenha_meteoro_bom_queda_pequeno_1
	JMP liberta_pops1

desenha_bom_medio_1:
	CALL desenha_meteoro_bom_queda_medio_1
	JMP liberta_pops1

desenha_bom_maximo_1:
	CALL desenha_meteoro_bom_queda_maximo_1
	JMP liberta_pops1

so_desenha_bom1:									
	CALL desenha_meteoro_bom_queda_default1_1
	ADD R9, 1
	MOV [contador_meteoro1], R9
	MOV R8, ATRASO_LOADING
	JMP pequeno_atraso_1

so_desenha_mau1:
	CALL desenha_meteoro_mau_queda_default1_1
	ADD R9, 1
	MOV [contador_meteoro1], R9
	MOV R8, ATRASO_LOADING
	JMP pequeno_atraso_1
	
pequeno_atraso_1:
	SUB R8, 1
	JNZ pequeno_atraso_1
	JMP liberta_pops1
	

; #### apaga meteoro bom e os seus componentes #####################################

apaga_meteoro_bom_queda_maximo1:
	MOV	R0, DEF_METEORO_BOM_MAXIMO
	MOV	R5, [R0]	
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2
	JZ apaga_piixeis_meteoro_bom_queda1

apaga_piixeis_meteoro_bom_queda1:       				
	MOV	R3, 0										
	MOV [DEFINE_LINHA], R2		
	MOV [DEFINE_COLUNA], R1		
	MOV [DEFINE_PIXEL], R3		
	ADD	R0, 2				
	ADD	R1, 1               							
	SUB	R5, 1											
	JNZ	apaga_piixeis_meteoro_bom_queda1      			
	
	MOV	R5, R10											
	ADD	R2, 1				
	SUB	R1, R5				
	SUB	R6, 1										
    JNZ	apaga_piixeis_meteoro_bom_queda1				
	RET

; #### desenha meteoro bom e os seus componentes #####################################

desenha_meteoro_bom_queda_default1_1:
	MOV	R0, DEF_METEORO1_DEFAULT
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	JMP desenha_pixels_meteoro_bom_queda1

desenha_meteoro_bom_queda_default2_1:
	MOV	R0, DEF_METEORO2_DEFAULT
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_DEFAULTM2
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_bom_queda1

desenha_meteoro_bom_queda_pequeno_1:
	MOV	R0, DEF_METEORO_BOM_PEQUENO
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_MB_PEQUENO
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_bom_queda1

desenha_meteoro_bom_queda_medio_1:
	MOV	R0, DEF_METEORO_BOM_MEDIO
	MOV	R5, [R0]	
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_MB_MEDIO
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_bom_queda1

desenha_meteoro_bom_queda_maximo_1:
	MOV	R0, DEF_METEORO_BOM_MAXIMO
	MOV	R5, [R0]								
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_MB_MAXIMO
	MOV [largura_atual_meteoro], R3				
    JMP desenha_pixels_meteoro_bom_queda1

desenha_pixels_meteoro_bom_queda1:				
	MOV	 R3, [R0]								
	MOV  [DEFINE_LINHA], R2		
	MOV  [DEFINE_COLUNA], R1		
	MOV  [DEFINE_PIXEL], R3		
	ADD	 R0, 2					
	ADD  R1, 1               			
	SUB  R5, 1					
     
	JNZ  desenha_pixels_meteoro_bom_queda1      				
	MOV  R5, R10											
	MOV  R1, [coluna_meteoro]												
	ADD  R2, 1
	SUB  R6, 1
	JNZ  desenha_pixels_meteoro_bom_queda1
	MOV  R9, [contador_meteoro1]
	ADD  R9, 1
	MOV [contador_meteoro1], R9
	RET

; ######################################################################################################
; #### Meteoro mau #####################################################################################
; ######################################################################################################

; #### apaga meteoro mau e os seus componentes #####################################

apaga_meteoro_mau_queda_maximo1:
	MOV	R0, DEF_METEORO_MAU_MAXIMO
	MOV	R5, [R0]	
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2
	JZ apaga_piixeis_meteoro_mau_queda1

apaga_piixeis_meteoro_mau_queda1:       				
	MOV	R3, 0											
	MOV [DEFINE_LINHA], R2		
	MOV [DEFINE_COLUNA], R1		
	MOV [DEFINE_PIXEL], R3		
	ADD	R0, 2				
	ADD	R1, 1               							
	SUB	R5, 1											
	JNZ	apaga_piixeis_meteoro_mau_queda1      			
	
	MOV	R5, R10										
	ADD	R2, 1				
	SUB	R1, R5				
	SUB	R6, 1										
    JNZ	apaga_piixeis_meteoro_mau_queda1			
	RET

; #### desenha meteoro mau e os seus componentes #####################################

desenha_meteoro_mau_queda_default1_1:
	MOV	R0, DEF_METEORO1_DEFAULT
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	JMP desenha_pixels_meteoro_mau_queda1

desenha_meteoro_mau_queda_default2_1:
	MOV	R0, DEF_METEORO2_DEFAULT
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_DEFAULTM2
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_mau_queda1

desenha_meteoro_mau_queda_pequeno_1:
	MOV	R0, DEF_METEORO_MAU_PEQUENO
	MOV	R5, [R0]
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_MM_PEQUENO
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_mau_queda1

desenha_meteoro_mau_queda_medio_1:
	MOV	R0, DEF_METEORO_MAU_MEDIO
	MOV	R5, [R0]	
	MOV R10, R5									
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	MOV R3, LARGURA_MM_MEDIO
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_mau_queda1

desenha_meteoro_mau_queda_maximo_1:
	MOV	R0, DEF_METEORO_MAU_MAXIMO
	MOV	R5, [R0]								
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2					
    MOV R3, LARGURA_MM_MAXIMO
	MOV [largura_atual_meteoro], R3	
	JMP desenha_pixels_meteoro_mau_queda1

desenha_pixels_meteoro_mau_queda1:				
	MOV	 R3, [R0]								
	MOV  [DEFINE_LINHA], R2		
	MOV  [DEFINE_COLUNA], R1		
	MOV  [DEFINE_PIXEL], R3		
	ADD	 R0, 2					
	ADD  R1, 1               			
	SUB  R5, 1					
     
	JNZ  desenha_pixels_meteoro_mau_queda1      				
	MOV  R5, R10											
	MOV  R1, [coluna_meteoro]												
	ADD  R2, 1
	SUB  R6, 1
	JNZ  desenha_pixels_meteoro_mau_queda1
	MOV R9, [contador_meteoro1]
	ADD R9, 1
	MOV [contador_meteoro1], R9
	RET


; ###############################################################################################
; #### Deteta colisões ##########################################################################
; ###############################################################################################

deteta_colisoes:							; esta função é responsável por detetar se existe colisoes
	PUSH R1									; do rover com algum dos meteoros 
	PUSH R2	
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6 
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11

	MOV R1, [coluna_meteoro]
	MOV R2, [linha_meteoro]
	MOV R3, [largura_atual_meteoro]
	ADD R2, R3
	
	MOV R3, LINHA_BONECO
	CMP R3, R2
	JZ existe_colisão_rover_bom
										; é verificado 2 vezes se colidiu com alguma coisa 
	ADD R3, 1
	MOV R3, LINHA_BONECO
	CMP R3, R2
	JZ existe_colisão_rover_bom


	JMP liberta_colisao_pops

existe_colisão_rover_bom: 				; nesta função incrementa-se e decrementa-se a coluna do meteoro
	MOV R7, [coluna_boneco]				; guardado no R1 de modo a veerificar o "hitbox" do meteoro 
	MOV R1, [coluna_meteoro]
	ADD R1, 2

	CMP R1, R7
	JZ continuaAAA
	
	SUB R1, 1
	CMP R1, R7
	JZ continuaAAA

	SUB R1, 1
	CMP R1, R7
	JZ continuaAAA
	
	SUB R1, 1
	CMP R1, R7
	JZ continuaAAA

	SUB R1, 1
	CMP R1, R7
	JZ continuaAAA

	ADD R1, 5
	CMP R1, R7
	JZ continuaAAA
	
	ADD R1, 1
	CMP R1, R7
	JZ continuaAAA

	ADD R1, 1
	CMP R1, R7
	JZ continuaAAA

	ADD R1, 1
	CMP R1, R7
	JZ continuaAAA

	JMP liberta_colisao_pops

continuaAAA:								; esta função retrata a colisão do rover com um meteoro bom
	CALL apaga_meteoro_bom_no_rover 		; o que dá 10 de energia

	MOV R1, [determina_meteoro]
	CMP R1, 2
	JGT continuaAAA2

	MOV R10, 5
	MOV [SELECIONA_SOM], R10

	MOV R10, [energia_atual]
	ADD R10, 5
	ADD R10, 5
	MOV [energia_atual], R10
	CALL atualiza_displays
	MOV R5, 1
	MOV [detetor_de_colisoes], R5			; e ativa a flag detetor_de_colisoes
	JMP liberta_colisao_pops

continuaAAA2:								; esta função retrata a colisão do rover com um meteoro mau
	CALL apaga_meteoro_bom_no_rover 		; iniciando assim o game over 

	MOV R5, 2
	MOV [detetor_de_colisoes], R5
	MOV [game_over_colisao], R5
	JMP liberta_colisao_pops

apaga_meteoro_bom_no_rover:
	MOV R4, DEF_METEORO_BOM_MAXIMO			
	MOV	R5, [R4]				
	ADD	R4, 2
	MOV	R6, [R4]				
	ADD	R4, 2
	MOV R1, [coluna_meteoro]
	MOV R2, LINHA_BONECO
	ADD R2, 7

apaga_pixeis_meteoro_bom_no_rover:
	MOV	 R3, 0								
	MOV  [DEFINE_LINHA], R2		
	MOV  [DEFINE_COLUNA], R1		
	MOV  [DEFINE_PIXEL], R3	
	ADD  R4, 1					
	ADD  R1, 1               			
	SUB  R5, 1					   
	JNZ  apaga_pixeis_meteoro_bom_no_rover    				
	
	MOV  R5, COLUNA_TOTAL											
	ADD  R2, 1
	SUB  R1, R5												
	SUB  R6, 1
	JNZ  apaga_pixeis_meteoro_bom_no_rover
	RET


liberta_colisao_pops:
	POP R11
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET


; ###############################################################################################
; #### Movimentação do tiro da tecla 1  #########################################################
; ###############################################################################################

movimentacao_tiro:				; é fundamentalmente nesta função onde a movimentação do missil 
	PUSH R0						; está feita com ajuda da interrupção
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11

tiro2:							; é guardado o valor da linha máxima onde o missil irá chegar no R7
	MOV R7, ALCANCE_TIRO		; copiando-o para o R10, apara ser usado como comparaçção mais tarde
	MOV R10, R7									
	MOV R2, [linha_tiro]		; é guardado o valor do tiro atual do R2, a partir da memória
	MOV R1, [coluna_perma]		; é também guardado o valor da coluna onde qual o missil foi "disparado"

	MOV R11, [verifica_tiro]	; usando uma flag que demonsta se está ainda um tiro no ecra, é possivel
	CMP R11, 1					; alterar o valor do que é feito, se nao estiver um missil no ecrã entao
	JZ apaga_no_limite			; a interrupção como não tem nada para fazer apaga o "vazio" no limite
								; mas quando se chega a esta fase, entao a flag responsavel por bloquear a tecla 1 é ativada

	CALL deteta_colisoes_tiro			; e é chamada uma funçao que foi implementada para detetar colisoes no tiro com algum dos meteoros 
	MOV R11, [detetor_de_colisoes]		; se for detetada uma colisao do tiro então não faz mais nada e vai para o liberta_pops_2
	CMP R11, 1
	JZ liberta_pops2


	CALL apaga_tiro				; se tudo correr bem o tiro anterior é apagado

	MOV R2, [linha_tiro]
	SUB R2, 1
	MOV [linha_tiro], R2		; e o segundo tiro, após a sua linha ser incrementada e guardada na memória 
								; é desenhado logo a seguir 
	CALL desenha_tiro1 

	CMP R2, R10					; se o ultimo tiro for igual ao alcance maximo do missil entao é dado JUMP para a função volta_para_1
	JZ volta_para_1

	MOV R7, 1					; quando o missil está a ser desenhado é ativava a flag que bloqueia a tecla 1, até esta ser reativada
	MOV [e_possivel_tiro], R7

	JMP liberta_pops2		; quando terminado dá JUMP e dá pops nos registos usados 

volta_para_1:						; aqui quando necessário é reposta a flag a 1 no verifica_tiro e o valor inicial
	MOV R9, LINHA_INICIAL_TIRO		; da linha do tiro é reposta na memória 
	MOV [linha_tiro], R9
	MOV R9, 1
	MOV [verifica_tiro], R9
	JMP liberta_pops2				; assim dá logo JUMP para os pops necessários 


apaga_no_limite:					; esta função apaga o ultimo pixel a ser desenhado e 
	MOV R2, ALCANCE_TIRO			; é a função que "entretem" a interrupção quando esta está "bloqueada"
	MOV R1, [coluna_perma]			; pelo verifica_tiro
	CALL apaga_tiro				
	MOV R7, 0
	MOV [e_possivel_tiro], R7
	JMP liberta_pops2

apaga_tiro:											; esta função está responsavel por apagar o pixel do missil
	MOV	R0, DEF_TIRO
	MOV	R5, [R0]	
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2

apaga_piixeis_tiro:       							; desenha o pixel do missil 
	MOV	R3, 0										; cor para apagar o pixel desejado
	MOV [DEFINE_LINHA], R2		
	MOV [DEFINE_COLUNA], R1		
	MOV [DEFINE_PIXEL], R3							
	RET

desenha_tiro1:										; esta função está responsavel por desenhar o pixel do missil
	MOV	R0, DEF_TIRO
	MOV	R5, [R0]
	ADD	R0, 2									
	MOV	R6, [R0]
	ADD	R0, 2	
	JMP desenha_pixels_tiro

desenha_pixels_tiro:
	MOV	 R3, [R0]								
	MOV  [DEFINE_LINHA], R2		
	MOV  [DEFINE_COLUNA], R1		
	MOV  [DEFINE_PIXEL], R3		
	RET

liberta_pops2:									; ----> dá os pops aos registos necessários
	POP R11
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
 	POP R3
	POP R2
	POP R1
	POP R0
	RET

; #### DETETA COLISOES PARA O TIRO #########################################################

deteta_colisoes_tiro:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7

deteta_colisoes_tiro2:					; esta função vai verificar se existe colisao com a linha do tiro atual
	MOV R1, [linha_tiro]				; e com a linha do meteoro 
	MOV R7, [linha_meteoro]
	ADD R7, LARGURA_MB_MAXIMO
	CMP R1, R7
	JZ existe_colisão_tiro
	JMP nevermind

nevermind:
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

existe_colisão_tiro:				; verifica o "hitbox"
	MOV R7, [coluna_perma]
	MOV R1, [coluna_meteoro]

	CMP R1, R7
	JZ continuaBBB
	
	ADD R1, 1
	CMP R1, R7
	JZ continuaBBB

	ADD R1, 1
	CMP R1, R7
	JZ continuaBBB
	
	ADD R1, 1
	CMP R1, R7
	JZ continuaBBB

	ADD R1, 1
	CMP R1, R7
	JZ continuaBBB
	
	ADD R1, 1
	CMP R1, R7
	JZ continuaBBB

	JMP nevermind

continuaBBB:							
	MOV R5, [determina_meteoro]			; é verificado antes que tipo de meteoro é
	CMP R5, 2
	JLE continuaBBB2

	CALL apaga_tiro_e_meteoro			; colisao do tiro com o meteoro mau
	MOV R6, [energia_atual]
	ADD R6, 5
	MOV [energia_atual], R6				; se houver colisao com um mau entao ganha-se energia, 
	CALL atualiza_displays				; atualiza-se o display e apaga o meteoro, e ativa-se a 
	MOV R5, 6							; flag do detetor_de_colisoes
	MOV [SELECIONA_SOM], R5
	MOV R5, 1
	MOV [detetor_de_colisoes], R5
	JMP nevermind

continuaBBB2:							; colisao do tiro com o meteoro bom
	CALL apaga_tiro_e_meteoro
	MOV R5, 6
	MOV [SELECIONA_SOM], R5				; no caso da colisao do tiro com um meteoro bom 
	MOV R5, 1							; entao só o destroi não ganhando nada com isso 
	MOV [detetor_de_colisoes], R5
	JMP nevermind

apaga_tiro_e_meteoro:				
	MOV R4, DEF_PARA_APAGAR_TIRO_E_METEORO			
	MOV	R5, [R4]				
	ADD	R4, 2
	MOV	R6, [R4]				
	ADD	R4, 2
	MOV R1, [coluna_meteoro]
	MOV R2, [linha_meteoro]

apaga_pixeis_tiro_e_meteoro:
	MOV	 R3, 0								
	MOV  [DEFINE_LINHA], R2		
	MOV  [DEFINE_COLUNA], R1		
	MOV  [DEFINE_PIXEL], R3							
	ADD  R1, 1               			
	SUB  R5, 1					   
	JNZ  apaga_pixeis_tiro_e_meteoro    				
	
	MOV  R5, LARGURA_APAGA											
	ADD  R2, 1
	SUB  R1, R5												
	SUB  R6, 1
	JNZ  apaga_pixeis_tiro_e_meteoro
	RET


; #####################################################################################################
; #### Função que devolve a coluna aleatória e uma flag para determinar se o meteoro é mau ou bom #####
; #####################################################################################################

mega_aleatorio:							; esta função é a função responsável pela característica 	
	PUSH R2								; aleatória dos meteoros e pelo o seu tipo, como está
	PUSH R3								; explícito no enunciado
	PUSH R4	
	
	MOV R2, TEC_LIN						; mete-se o endereço das linhas do teclado no R2
	MOV R3, TEC_COL						; e mete-se também o  endereço das colunas do teclado no R3
	MOVB [R2], R1						; move os bites de 7 a 4
	MOVB R4, [R3]

	SHR R4, 5							; dá se SHR 5 vezes
	MOV [determina_meteoro], R4			; e assim temos um valor entre 7 e 0 no R4, este valor é 
	
	MOV R2, TEC_LIN						; mete-se o endereço das linhas do teclado no R2
	MOV R3, TEC_COL						; e mete-se também o  endereço das colunas do teclado no R3
	MOVB [R2], R1						; move os bites de 7 a 4
	MOVB R4, [R3]
	
	SHR R4, 5
	SHL R4, 3							; primeiro guardado na tabela que escolhe o tipo de meteoro e
	MOV [coluna_meteoro], R4			; depois multiplicando por 8 temos uma coluna aleatoria que 
										; é guardada na tabela do coluna_meteoro
	POP R4
	POP R3
	POP R2

	RET


; ####################################################################################################
; ### Spawn - Meteoro Bom ############################################################################
; ####################################################################################################

; ############################################################################################################
; ### Estes dois ultimos pontos do projeto sãp principalmente facultativos, apenas estão presentes         ###
; ### pois pertenciam ao ficheiro anterior do projeto intermédio, se o utilizador assim permitir           ###
; ### pode ativar a funcionalidade das teclas ao retirar o ponto e virgula que está na função esperateclaK ###
; ### que possui a tecla 3 e 7 que eram responsáveis pelo spawn dos meteoros mau e bom no projeto anterior ###
; ############################################################################################################

spawna_meteoro_bom:					; ----> dá push dos registos necessários para criar 
	PUSH R0							; um meteoro bom
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R9
	PUSH R10
	
posicao_meteoro_bom:
	MOV R9, LINHA_TECLA_MB					; linha do meteoro bom
	MOV R10, COLUNA_TECLA_MB				; coluna do meteoro bom
     
desenha_meteoro_bom:
	MOV	R4, DEF_METEORO_BOM_MAXIMO			; endereço da tabela que define o meteoro bom
	MOV	R5, [R4]							; obtém a largura do meteoro bom
	ADD	R4, 2
	MOV	R6, [R4]							; obtem altura 
	ADD	R4, 2					
     
desenha_pixels_meteoro_bom:				; é fundamentalmente a mesma função que desenha_pixels_boneco
	MOV	R3, [R4]						; mas alterada para criar o meteoro bom no tamanho máximo
	MOV  [DEFINE_LINHA], R9			
	MOV  [DEFINE_COLUNA], R10			
	MOV  [DEFINE_PIXEL], R3			
	ADD	 R4, 2					
	ADD  R10, 1               			
	SUB  R5, 1					
     
	JNZ  desenha_pixels_meteoro_bom      				; continua até percorrer toda a largura do objeto
	MOV  R5, LARGURA_MB_MAXIMO					; continua até percorrer toda a altura do objeto
	MOV  R10, COLUNA_TECLA_MB
	ADD  R9, 1
	SUB  R6, 1
	JNZ  desenha_pixels_meteoro_bom
	
	POP R10								; --> é feito pop dos registos usados
	POP R9
	POP R7
 	POP R6
	POP R5 
	POP R4 
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; ####################################################################################################
; ### Spawn - Meteoro Mau ############################################################################
; ####################################################################################################


spawna_meteoro_mau:					; ----> dá push dos registos necessários para criar 
	PUSH R0							; um meteoro mau
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R9
	PUSH R10

posicao_meteoro_mau:
	MOV  R7, LINHA_TECLA_MM						; linha do meteoro mau
	MOV  R8, COLUNA_TECLA_MM					; coluna do meteoro mau
 

desenha_meteoro_mau:
	MOV	R4, DEF_METEORO_MAU_MAXIMO				; endereço da tabela que define o meteoro mau
	MOV	R5, [R4]								; obtém a largura do meteoro mau
	ADD	R4, 2
	MOV	R6, [R4]								; obtem altura 
	ADD	R4, 2									; endereço da cor do 1º pixel (2 porque a largura é uma word)

desenha_pixels_meteoro_mau: 					; é também fundamentalmente a mesma função que desenha_pixels_boneco
	MOV	R3, [R4]								; mas agora para o meteoro mau no tamanho máximo 
	MOV  [DEFINE_LINHA], R7			
	MOV  [DEFINE_COLUNA], R8			
	MOV  [DEFINE_PIXEL], R3			
	ADD	 R4, 2					
	ADD  R8, 1               			
	SUB  R5, 1					
     
	JNZ  desenha_pixels_meteoro_mau      				; continua até percorrer toda a largura do objeto
	MOV  R5, ALTURA_MM_MAXIMO					; continua até percorrer toda a altura do objeto
	MOV  R8, COLUNA_TECLA_MM
	ADD  R7, 1
	SUB  R6, 1
	JNZ  desenha_pixels_meteoro_mau
	
	POP R10										; --> é feito pop dos registos usados
	POP R9
	POP R7
 	POP R6
	POP R5 
	POP R4 
	POP R3
	POP R2
	POP R1
	POP R0
	RET


; ###############################################################################################
; #### Teclado que devolve R8 como valor de comparação ##########################################
; ###############################################################################################

; --> O teclado foi com certeza o quer deu mais trabalho na versão intermédia pois a versão original deste conceito foi 
; feita para o lab3, foi preciso incluir as rotinas com CALL e RET, tal como PUSHs e POPs, de modo a funcionar
; para todas as teclas comparando o seu valor real como tecla aos valores que permitem que as teclas tenham funcionalidades
; é aqui também que é verificado se existe uma tecla premida, e se as teclas correspondem às variáveis que representam a tecla
; de incrementação e decrementação do valor do display da energia


teclado_push:				; ----> dá push dos registos necessários menos no R8, ele será importante
	PUSH R0					; para guardar o valor tecla da tecla premida
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R9
	PUSH R10
	PUSH R11
	
teclado:		
; inicializacoes
	MOV  R1, 0  
	MOV  R2, TEC_LIN   		; endereço do periférico das linhas
	MOV  R3, TEC_COL   		; endereço do periférico das colunas
	MOV  R4, DISPLAYS  		; endereço do periférico dos displays
	MOV  R5, MASCARA   		; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
	MOV  R6, LINHALIM  		; para guardar o valor que possui o limite para comparar mais tarde
	MOV  R8, CONTADOR  		; para guardar o contador 
	MOV  R9, CONTADOR   
	

teclado_geral:
	MOV R7, 0
	MOV R8, 0
	MOV R1, LINHA       

espera_tecla:           		; neste ciclo espera-se até uma tecla ser premida
	MOVB [R2], R1				; escrever no periférico de saída (linhas)
	MOVB R0, [R3]				; ler do periférico de entrada (colunas)
	AND  R0, R5					; elimina bits para além dos bits 0-3

	MOV R10, [energia_atual]			; sao verificados aqui 3 valores que podem começar o game over ,
	CMP R10, 0							; mas porque aqui?? no caso de acontecer algo que faça o game over 
	JZ liberta_energia					; e o rover estiver parado então, um valor se detetado aqui sai logo do teclado podendo
										; ser analisado na espera_teclaK
	MOV R10, [game_over_colisao]
	CMP R10, 1
	JGT liberta_colisao

	MOV R10, [passou_meteoro_mau]
	CMP R10, 3
	JZ liberta

	CMP  R0, 0					; há tecla premida?         
	JZ   testa_teclas  
    
	MOV R7, R1	
	JMP transforma_valor1   

testa_teclas:				; o testa_teclas e o outra_linha são responsáveis por
	CMP R1, R6				; verificar cada linha do teclado, incrementando a linha
	JNZ outra_linha			; de 1, 2, 4, e a 8; assim que verificar a linha 8 passa de novo 
    						; para a linha 1
	MOV R1, LINHA
	JMP espera_tecla
    
outra_linha: 
	SHL R1, 1
	JMP espera_tecla

transforma_valor1:				; a transforma_valor1 e transforma_valor2 são responsáveis por 
	CMP R0, 0					; tranformar o valor da linha e da coluna correspondentes à 
	JZ transforma_valor2		; tecla premida em valores entre 0, 1, 2 e 3 para serem usados
    							; para calcular o seu valor real na função calcula_valor, 
	SHR R0, 1					; guardando assim o valor da tecla real no R8
	ADD R9, 1
	JMP transforma_valor1

transforma_valor2:
	CMP R1, 0
	JZ calcula_valor
    
	SHR R1, 1
	ADD R8, 1
	JMP transforma_valor2
    
calcula_valor:
	MOV R1, 4
	MUL R8, R1
	ADD R8, R9
	SUB R8, 5
	
verifica_inc_dec:			; é logo verificado se R8 é a tecla correspondente à tecla real de
	CMP R8, TECLAINC		; incrementação e decrementação do valor do display de energia 
	JZ incrementa			; se não for, dá-se logo pop dos registos usados
	CMP R8, TECLADEC
	JZ decrementa
	MOV R11, TECLA_PAUSAR_JOGO
	CMP R8, R11
	JZ ha_tecla
	MOV R11, TECLA_CONTROLOS
	CMP R8, R11
	JZ ha_tecla
	MOV R11, TECLA_START
	CMP R8, R11
	JZ ha_tecla
	MOV R11, TECLA_TIRO
	CMP R8, R11
	JZ ha_tecla


liberta:
	POP R11
	POP R10
	POP R9			; dá pop nos usados menos no R8, para comparar; 
	POP R7
 	POP R6
	POP R5 
	POP R4 
	POP R3
	POP R2
	POP R1
	POP R0
	RET

liberta_energia:
	POP R11
	POP R10
	POP R9			; dá pop nos usados menos no R8, para comparar; 
	POP R7
 	POP R6
	POP R5 
	POP R4 
	POP R3
	POP R2
	POP R1
	POP R0
	MOV R10, 1
	MOV [energia_atual], R10
	RET

liberta_colisao:
	POP R11
	POP R10
	POP R9			; dá pop nos usados menos no R8, para comparar; 
	POP R7
 	POP R6
	POP R5 
	POP R4 
	POP R3
	POP R2
	POP R1
	POP R0
	MOV R10, 2
	MOV [game_over_colisao], R10
	RET

incrementa:							; incrementa o valor de R10, que é guardado ao longo do programa
	MOV R10, [energia_atual]	
	ADD R10, 1						; e volta a introduzi-lo nos displays da energia
	MOV [energia_atual], R10
	CALL atualiza_displays
	JMP ha_tecla
	
decrementa:							; é a mesma função que a anterior, apenas decrementa o valor de R10, a			
	MOV R10, [energia_atual]
	CMP R10, 0
	JLE ha_tecla
	
	SUB R10, 1						; que é guardado ao longo do programa volta a introduzi-lo nos displays da energia
	MOV [energia_atual], R10
	CALL atualiza_displays
	JMP ha_tecla


ha_tecla:               	; neste ciclo espera-se até nenhuma tecla estar premida
	MOV  R1, R7				; esta função apenas serve para o display da energia e a sua incrementação/decrementação			
	MOVB [R2], R1       	; pois não é suposto a tecla continuar a fazer a sua função se for premida continuamente
	MOVB R0, [R3]    		; ou seja as teclas 5 e 6 funcionam só a "clicar", ao contrário do rover.
	AND  R0, R5    			; é testada a linha cuja tecla foi premida;
	CMP  R0, 0 				; há tecla premida?
	JNZ  ha_tecla  			; se ainda houver uma tecla premida, espera até não haver
	JMP  liberta			; caso não haja, procede para dar pop dos registos usados 	
             			
   
    		         	
	
	
	
	






	

	
	
	
