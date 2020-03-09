dofile('io.o')
dofile('navs.o')

function ioSaldo()
    dofile('navs.o')
    get = loadstring(GET)()
    local m = get["MESA"]
    local dth = get["DTH"]  -- Captura data e hora da máquina.
    local mesa = tonumber(m)

    --DATA
    local ano = string.sub(dth, 1, 4)
    local mes = string.sub(dth, 5,6)
    local dia = string.sub(dth, 7,8)
    ------------------------------------------
    --HORA
    local h = string.sub(dth, 9,10)
    local m = string.sub(dth, 11,12)
    local s = string.sub(dth, 13,14)
    ------------------------------------------
    local data = (ano.."-"..mes.."-"..dia)

    SESSION.MESA = mesa
    SESSION.CANCELITEM = {}
    SESSION.LISTA = {}
    SESSION.COD = {}
    SESSION.PORCENT = ''
    SESSION.ID = {}
    SESSION.VAL = {}
    SESSION.PED = ''
    SESSION.QUANT = 0
    SESSION.save()

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('cancelItem.lua')")
    echo ("  Menuprods()")
    echo ("</DATA>")
end

function Menuprods()
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=3.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")

    echo ("<RECTANGLE NAME=1 X=30 Y=44 WIDTH=190 HEIGHT=40 VISIBLE=0>")
    echo ("<RECTANGLE NAME=2 X=30 Y=92 WIDTH=190 HEIGHT=40 VISIBLE=0>")
    echo ("<RECTANGLE NAME=3 X=30 Y=146 WIDTH=190 HEIGHT=40 VISIBLE=0>")
    echo ("<RECTANGLE NAME=4 X=30 Y=198 WIDTH=190 HEIGHT=40 VISIBLE=0>")
    echo ("<RECTANGLE NAME=5 X=30 Y=252 WIDTH=190 HEIGHT=40 VISIBLE=0>")

    echo "<CAPTURE NAME=OPC>"
	echo "<GET TYPE=TOUCH>"
	-- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
	echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
    echo "</CAPTURE>"

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('cancelItem.lua')")
    echo ("  prods()")
    echo ("</DATA>")
end

function prods()
    get = loadstring(GET)()
    local opc = get['OPC']


    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=3_1.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
    
        echo ("<RECTANGLE NAME=1 X=50 Y=80 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=50 Y=125 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=50 Y=164 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=50 Y=203 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=5V X=50 Y=244 WIDTH=125 HEIGHT=30 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        -- echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  setProd()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=3_2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=5 X=50 Y=80 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=6 X=50 Y=126 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=7 X=50 Y=165 WIDTH=125 HEIGHT=30 VISIBLE=0>")
        echo ("<RECTANGLE NAME=5V X=50 Y=215 WIDTH=125 HEIGHT=30 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        -- echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  setProd()")
        echo ("</DATA>")
    end
    if get.OPC == "3" then
        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  consultarPedido()")
        echo ("</DATA>")
    end
    if get.OPC == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" menu()")
        echo ("</DATA>")
    end
    if get.OPC == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" ioSaldo()")
        echo ("</DATA>")
    end
end

function setProd()
    get = loadstring(GET)()
    local opc = get['OPC']


    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Agua()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        -- REFRI
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=5.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=5 X=30 Y=255 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=REFRI>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Refri()")
        echo ("</DATA>")
    end
    if get.OPC == "3" then
        -- SUCO
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=6.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=5 X=30 Y=255 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=SUCO>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Suco()")
        echo ("</DATA>")
    end
    if get.OPC == "4" then
        -- CERVEJA
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=7.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=5 X=30 Y=255 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=CERV>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Cerv()")
        echo ("</DATA>")
    end
    if get.OPC == "5" then
        -- PORÇÕES
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=8.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=PORC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Porc()")
        echo ("</DATA>")
    end
    if get.OPC == "6" then
        -- LANCHE
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=9.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=LANCHE>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Lanc()")
        echo ("</DATA>")
    end
    if get.OPC == "7" then
        -- PIZZA
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=10.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=30 Y=75 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=30 Y=118 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=3 X=30 Y=160 WIDTH=150 HEIGHT=35 VISIBLE=0>")
        echo ("<RECTANGLE NAME=4 X=30 Y=210 WIDTH=150 HEIGHT=35 VISIBLE=0>")

        echo "<CAPTURE NAME=PIZ>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Piz()")
        echo ("</DATA>")
    end
    if get.OPC == "5V" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    if get.OPC == "8" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" menu()")
        echo ("</DATA>")
    end
    if get.OPC == "9" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" ioSaldo()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('cancelItem.lua')")
    echo (" prods()")
    echo ("</DATA>")
end

function Agua()
    get = loadstring(GET)()
    local qtd = get["QTD"]

    local varLista = 'AGUA'    
    table.insert(SESSION.LISTA, varLista)
    SESSION.save()

    local cod = 'A'
    table.insert(SESSION.COD, cod)
    SESSION.save()

    local valor = 2
    table.insert(SESSION.VAL, valor)
    SESSION.save() 

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('cancelItem.lua')")
    echo ("  quantItem()")
    echo ("</DATA>")
end

function Refri()
    get = loadstring(GET)()
    refri = get['REFRI']

    
    echo("<GET TYPE=HIDDEN NAME=REFRI VALUE="..get.REFRI..">")

    if get.REFRI == "1" then
        local varLista = 'COCA-COLA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CC'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "2" then
        local varLista = 'PEPSI'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'P'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "3" then
        local varLista = 'FANTA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'F'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "4" then
        local varLista = 'GUARANA-ANTARTICA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'G'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" ioSaldo()")
    echo ("</DATA>")
end

function Suco()
    get = loadstring(GET)()

    
    echo("<GET TYPE=HIDDEN NAME=SUCO VALUE="..get.SUCO..">")

    if get.SUCO == "1" then
        local varLista = 'LARANJA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'L'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "2" then
        local varLista = 'ABACAXI'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'AB'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "3" then
        local varLista = 'ABACAXI-C/-HORT'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'ABH'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "4" then
        local varLista = 'LIMAO'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'LM'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" ioSaldo()")
    echo ("</DATA>")
end

function Cerv()
    get = loadstring(GET)()

    
    echo("<GET TYPE=HIDDEN NAME=CERV VALUE="..get.CERV..">")

    if get.CERV == "1" then
        local varLista = 'HEINEKEIN'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'HNK'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.CERV == "2" then
        local varLista = 'ORIGINAL'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'OR'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.CERV == "3" then
        local varLista = 'AMSTEL'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'AM'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.CERV == "4" then
        local varLista = 'CHOPP'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CH'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 8
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.CERV == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" prods()")
    echo ("</DATA>")
end
function Porc()
    get = loadstring(GET)()
    porc = get['PORC']

    
    echo("<GET TYPE=HIDDEN NAME=PORC VALUE="..get.PORC..">")

    if get.PORC == "1" then

        local varLista = 'BATATA-FRITA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'BF'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 15
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PORC == "2" then
        local varLista = 'BATATA-FRITA-C/-CHEDDAR'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'BFC'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 18
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PORC == "3" then
        local varLista = 'FRANGO'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'FR'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 21
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PORC == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" prods()")
    echo ("</DATA>")
end
function Lanc()
    get = loadstring(GET)()
    lanche = get['LANCHE']

    
    echo("<GET TYPE=HIDDEN NAME=LANCHE VALUE="..get.LANCHE..">")

    if get.LANCHE == "1" then
        local varLista = 'X-SALADA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XS'
        table.insert(SESSION.COD, cod)
        SESSION.save()
        
        local valor = 13
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.LANCHE == "2" then
        local varLista = 'X-BACON'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XB'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 15
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.LANCHE == "3" then
        local varLista = 'X-TUDO"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XT'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 18
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.LANCHE == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end
function Piz()
    get = loadstring(GET)()
    piz = get['PIZ']

    
    echo("<GET TYPE=HIDDEN NAME=PIZ VALUE="..get.PIZ..">")

    if get.PIZ == "1" then
        local varLista = 'QUATRO-QUEIJOS'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'QQ'
        table.insert(SESSION.COD, cod)
        SESSION.save()
        
        local valor = 27
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PIZ == "2" then
        local varLista = 'PORTUGUESA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'PT'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 30
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PIZ == "3" then
        local varLista = 'CALABRESA'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CL'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local valor = 33
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  quantItem()")
        echo ("</DATA>")
    end
    if get.PIZ == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" Menuprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" prods()")
    echo ("</DATA>")
end

function consultarPedido()
    local mesa = SESSION.MESA
    local data =  SESSION.DATA
    SESSION.save()

    echo("<GET TYPE=HIDDEN NAME=DATACANCEL VALUE="..data..">")
    echo("<GET TYPE=HIDDEN NAME=MESACANCEL VALUE="..mesa..">")
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE=2>")
    echo("<POST>")
end

function cancelResposta()
    dofile('navs.o')
    get = loadstring(GET)()
    local idcancel = get['IDCANCEL']
    local prodcancel = get['PRODCANCEL']
    local pedval = get['PEDVAL']
    local quant = get['QUANT']

    table.insert(SESSION.ID, idcancel)
    SESSION.save()

    local insereSujeira = string.gsub(prodcancel, "-", "sujeira")
    local limpaPorcentagem = string.gsub(insereSujeira, "%%2520", " ")

    echo("<CONSOLE>")
    echo("<BR><BR><BR><BR>")
    for imprimeSub in string.gmatch(limpaPorcentagem, "%a+") do 
        local limpaSujeira = string.gsub(imprimeSub, "sujeira", " ") 
        echo("Produto: "..limpaSujeira.."<BR>") 
    end
    local limpaQuant = string.gsub(quant, "%%2520", " | ")
    echo("Quantidade: "..limpaQuant.."<BR><BR>")
    echo("Num. Pedido: "..idcancel.."<BR>")
    echo("Valor consumido: "..pedval.."<BR>")
    echo("</CONSOLE>")
    echo "<CONLOGO NAME=14.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")

    echo ("<RECTANGLE NAME=1 X=30 Y=240 WIDTH=230 HEIGHT=35 VISIBLE=0>")

    echo "<CAPTURE NAME=MENU>"
	echo "<GET TYPE=TOUCH>"
	-- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
	-- echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
    echo "</CAPTURE>"

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('cancelItem.lua')")
    echo (" Menuprods()")
    echo ("</DATA>")
end

function volRefri()
    get = loadstring(GET)()
    refri = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local valor = 3
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local valor = 5
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
end

function volCerv()
    get = loadstring(GET)()
    refri = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local valor = 3
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local valor = 5
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
end

function volSuco()
    get = loadstring(GET)()
    refri = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local valor = 4
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local valor = 5
        table.insert(SESSION.VAL, valor)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('cancelItem.lua')")
        echo (" quantItem()")
        echo ("</DATA>")
    end
end

function quantItem()
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")

    echo ("<GET TYPE=FIELD NAME=QTD SIZE=2 COL=14 LIN=11 NOENTER=0>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('cancelItem.lua')")
    echo (" cancelItem()")
    echo ("</DATA>")
end

function cancelItem()
    dofile('navs.o')
    get = loadstring(GET)()
    local qtd = get['QTD']
    local item = SESSION.LISTA[1]
    local id = SESSION.ID[1]
    local cval = SESSION.VAL[1]
    

    print(qtd)
    print(item)
    print(id)
    print(cval)


    echo("<GET TYPE=HIDDEN NAME=CANCELID VALUE="..id..">")
    echo("<GET TYPE=HIDDEN NAME=CANCELITEM VALUE="..item..">")
    echo("<GET TYPE=HIDDEN NAME=CANCELQTD VALUE="..qtd..">")
    echo("<GET TYPE=HIDDEN NAME=CVAL VALUE="..cval..">")
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE=3>")
    echo("<POST>")    
end

-- function cancelItem()
--     dofile('navs.o')
--     get = loadstring(GET)()
--     local qtd = get['QTD']

--     qtd = tonumber(qtd)
 
--     for i = 1, #SESSION.LISTA do
--         -- JSON
--         d = '{"cancelmesa":'..SESSION.MESA..', "cancelitem":'..SESSION.LISTA[i]..', "cancelcod":"'..SESSION.COD[i]..'", "canceldata":"'..SESSION.DATA..'", "cancelqtd":"'..qtd..'", "cancelid":"'..SESSION.ID..'"}'
--         -- Retirar aspas
--         d = string.sub(d, 1, -1)
--         -- Inserindo o JSON em um array
--         table.insert(SESSION.CANCELITEM, d)
--         SESSION.save()

--         print(SESSION.CANCELITEM)
--     end

--     criaMesa()
-- end

-- function criaMesa() -- Função de conexão com a POS
--     dofile('ws.o')

--     WS.IP = '201.73.146.216' -- IP do servidor  
--     WS.PORTA = '8080' -- Porta
--     WS.HOST = '201.73.146.216' -- Host
--     WS.PATH = '/comanda.php' -- Arquivo que executa as funções do DB
--     WS.HEADER['Content-Type'] = 'application/x-www-form-urlencoded'
--     -- WS.HEADER.Authorization = 'Basic c3VwZXI6MTIzNA=='
    
--     WS.MSG = 'Gravando...' -- msg
--     WS.CALL_BACK = 'resposta()' -- resposta do servidor
--     WS.CALLER = 'newMenu.lua' -- Nome do arquivo lua
--     WS.DADO = SESSION.CANCELITEM -- Envia o JSON

--     ws.post() -- Requisição POST

--     echo ("<DATA DESTINATION=PARSER>")
--     echo ("  dofile('cancelItem.lua')")
--     echo ("  resposta()")
--     echo ("</DATA>")
-- end

function resposta() -- Resposta da requisição
    dofile('navs.o')
    get = loadstring(GET)()
    local r = get['RESULT']
    local result = tonumber(r);

    if result == 0 then
        echo("<CONSOLE>")
        echo("<BR><BR><BR>")
        echo("    ITEM DELETADO COM SUCESSO!!!")
        echo("</CONSOLE>")
        echo("<DELAY TIME = 4>")
    end
    if result == 1 then
        echo("<CONSOLE>")
        echo("<BR><BR><BR>")
        echo("    ITEM ALTERADO COM SUCESSO!!!")
        echo("</CONSOLE>")
        echo("<DELAY TIME = 4>")
    end
    if result == 2 then
        echo("<CONSOLE>")
        echo("<BR><BR><BR>")
        echo("    SEM PEDIDOS PARA ESTA MESA!")
        echo("</CONSOLE>")
        echo ("<DELAY TIME=4>")
    end
    
    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  ioSaldo()")
    echo ("</DATA>")
end