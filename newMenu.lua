
dofile('io.o')
dofile('navs.o')
function ioSaldo()
    dofile('navs.o')
    SESSION.MESA = 0
    SESSION.TVAL = 0
    SESSION.VALUN = {}
    SESSION.LISTA = {}
    SESSION.CRIARMESA = {}
    SESSION.FECHAMESA = {}
    SESSION.QTD = {}
    SESSION.VOLUME = {}
    SESSION.ENVIAR = {}
    SESSION.COD = {}
    SESSION.DATA = ''
    SESSION.HORA = ''
    SESSION.save()

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  menu()")
    echo ("</DATA>")
end

function menu()
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=1.bmp x=0 y=-150 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")

    echo ("<RECTANGLE NAME=1 X=38 Y=60 WIDTH=160 HEIGHT=30 VISIBLE=0>")
    echo ("<RECTANGLE NAME=2 X=38 Y=100 WIDTH=160 HEIGHT=30 VISIBLE=0>")
    echo ("<RECTANGLE NAME=3 X=38 Y=143 WIDTH=160 HEIGHT=30 VISIBLE=0>")
    echo ("<RECTANGLE NAME=4 X=38 Y=180 WIDTH=160 HEIGHT=30 VISIBLE=0>")
    echo ("<RECTANGLE NAME=5 X=38 Y=208 WIDTH=160 HEIGHT=30 VISIBLE=0>")
    echo ("<RECTANGLE NAME=6 X=38 Y=258 WIDTH=160 HEIGHT=30 VISIBLE=0>")

    echo "<CAPTURE NAME=MENU>"
	echo "<GET TYPE=TOUCH>"
	-- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
	echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
    echo "</CAPTURE>"

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  escolheOpc()")
    echo ("</DATA>")
end

function escolheOpc()
    get = loadstring(GET)()
    local menu = get["MENU"]

    echo("<GET TYPE=HIDDEN NAME=MENU VALUE="..get.MENU..">")
    if get.MENU == "1" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=MESA SIZE=3 COL=14 LIN=11 NOENTER=0>")
        echo ("<GET TYPE=DATETIME NAME=DTH>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('mesa.lua')")
        echo ("  verificaMesa()")
        echo ("</DATA>")
    end
    if get.MENU == "2" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=MESA SIZE=3 COL=14 LIN=11 NOENTER=0>")
        echo ("<GET TYPE=DATETIME NAME=DTH>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('newMenu.lua')")
        echo ("  capMESA()")
        echo ("</DATA>")
    end
    if get.MENU == "3" then
        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('newMenu.lua')")
        echo ("  encerrar()")
        echo ("</DATA>")
    end
    if get.MENU == "4" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=MESA SIZE=3 COL=14 LIN=11 NOENTER=0>")
        echo ("<GET TYPE=DATETIME NAME=DTH>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('fecharMesa.lua')")
        echo ("  fechaMESA()")
        echo ("</DATA>")
    end
    if get.MENU == "5" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=MESA SIZE=3 COL=14 LIN=11 NOENTER=0>")
        echo ("<GET TYPE=DATETIME NAME=DTH>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('cancelItem.lua')")
        echo ("  ioSaldo()")
        echo ("</DATA>")
    end
    if get.MENU == "6" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=2.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=MESA SIZE=3 COL=14 LIN=11 NOENTER=0>")
        echo ("<GET TYPE=DATETIME NAME=DTH>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('consultaExterna.lua')")
        echo ("  ioCon()")
        echo ("</DATA>")
    end
end

function consultarPedido()
    echo "<CONSOLE>"
    echo ("<BR><BR><BR><BR>")
        for i, v in ipairs(SESSION.LISTA) do
            var = (i.."- "..v.." "..SESSION.VOLUME[i].." R$"..SESSION.VALUN[i]..": "..SESSION.QTD[i].."<BR><BR>")
            echo (""..var.."")
        end
    echo ("CONSUMO TOTAL: R$"..SESSION.TVAL.."<BR><BR>")
    echo ("MESA: "..SESSION.MESA.."<BR><BR>")
    echo ("<BR><BR><BR>")
    echo "</CONSOLE>"
    echo "<CONLOGO NAME=14.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")


    echo ("<RECTANGLE NAME=1 X=30 Y=240 WIDTH=230 HEIGHT=35 VISIBLE=0>")

    echo "<CAPTURE NAME=MENU>"
	echo "<GET TYPE=TOUCH>"
	-- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
	-- echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
    echo "</CAPTURE>"

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  consultaRealizada()")
    echo ("</DATA>")
end

function consultaRealizada()
    get = loadstring(GET)()
    local menu = get['MENU']


    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.MENU..">")

    if get.MENU == "1" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
end

function capMESA()
    dofile('navs.o')
    get = loadstring(GET)()
    local m = get["MESA"]
    local dth = get["DTH"]
    local mesa = tonumber(m)
    SESSION.MESA = SESSION.MESA + mesa
    SESSION.save()
    ------------------------------------------
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
    SESSION.DATA = data
    SESSION.save()

    local hora = (h..":"..m..":"..s)
    SESSION.HORA = hora
    SESSION.save()

    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  Menprods()")
    echo ("</DATA>") 
end

function Menprods()
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
    echo ("  dofile('newMenu.lua')")
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
        echo ("  dofile('newMenu.lua')")
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
        echo ("  dofile('newMenu.lua')")
        echo ("  setProd()")
        echo ("</DATA>")
    end
    if get.OPC == "3" then
        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('newMenu.lua')")
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
        echo (" dofile('newMenu.lua')")
        echo (" ioSaldo()")
        echo ("</DATA>")
    end
end

function setProd()
    get = loadstring(GET)()
    local opc = get['OPC']

    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=QTD SIZE=2 COL=14 LIN=11 NOENTER=0>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" calcAgua()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcRefri()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcSuco()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcCerv()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcPorc()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcLanc()")
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
        echo (" dofile('newMenu.lua')")
        echo (" opcPiz()")
        echo ("</DATA>")
    end
    if get.OPC == "5V" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
    if get.OPC == "8" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" menu()")
        echo ("</DATA>")
    end
    if get.OPC == "9" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" ioSaldo()")
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

function calcAgua()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local Agua = 2
    local result = 0

    local volume = '500ml'
    table.insert(SESSION.VOLUME, volume)
    SESSION.save() 

    local varLista = '"AGUA"'    
    table.insert(SESSION.LISTA, varLista)
    SESSION.save()

    local cod = 'A'
    table.insert(SESSION.COD, cod)
    SESSION.save()

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()

    result = Agua * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function encerrar()
    dofile('navs.o')
    for i = 1, #SESSION.LISTA do
        -- JSON
        d = '{"produto":'..SESSION.LISTA[i]..', "qtd":'..SESSION.QTD[i]..', "total":'..SESSION.TVAL..', "valor":'..SESSION.VALUN[i]..', "mesa":'..SESSION.MESA..', "volume":"'..SESSION.VOLUME[i]..'", "cod":"'..SESSION.COD[i]..'", "hora":"'..SESSION.HORA..'", "data":"'..SESSION.DATA..'", "mes":"'..SESSION.MESA..'"}'
        -- Retirar aspas
        d = string.sub(d, 1, -1)
        print(d)
        -- Inserindo o JSON em um array
        table.insert(SESSION.ENVIAR, d)
        SESSION.save()
        print(SESSION.ENVIAR)
    end

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" enviar()")
    echo ("</DATA>")
end

function enviar()
    reqMaker()
end

function opcRefri()
    get = loadstring(GET)()
    refri = get['REFRI']

    
    echo("<GET TYPE=HIDDEN NAME=REFRI VALUE="..get.REFRI..">")

    if get.REFRI == "1" then
        local varLista = '"COCA-COLA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CC'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=11.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        
        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "2" then
        local varLista = '"PEPSI"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'P'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=11.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        
        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "3" then
        local varLista = '"FANTA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'F'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=11.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        
        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "4" then
        local varLista = '"GUARANA-ANTARTICA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'G'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=11.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        
        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volRefri()")
        echo ("</DATA>")
    end
    if get.REFRI == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
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

function volRefri()
    get = loadstring(GET)()
    refri = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local volume = "350ml"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" refriLata()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local volume = "2L"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" refri2L()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" volRefri()")
    echo ("</DATA>")
end

function refriLata()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local refri = 3
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save() 

    result = refri * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function refri2L()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local refri = 5
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = refri * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -------------------------- SUCOS --------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------

function opcSuco()
    get = loadstring(GET)()
    refri = get['SUCO']

    
    echo("<GET TYPE=HIDDEN NAME=SUCO VALUE="..get.SUCO..">")

    if get.SUCO == "1" then
        local varLista = '"LARANJA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'L'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=12.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "2" then
        local varLista = '"ABACAXI"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'AB'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=12.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "3" then
        local varLista = '"ABACAXI-C/-HORT"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'ABH'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=12.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "4" then
        local varLista = '"LIMAO"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'LM'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=12.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volSuco()")
        echo ("</DATA>")
    end
    if get.SUCO == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function volSuco()
    get = loadstring(GET)()
    refri = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local volume = "Copo"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" sucoCopo()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local volume = "Jarra"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" sucoJarra()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" volSuco()")
    echo ("</DATA>")
end

function sucoCopo()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local suco = 4
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save() 

    result = suco * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function sucoJarra()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local suco = 5
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = suco * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -------------------------- CERVEJA ------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------

function opcCerv()
    get = loadstring(GET)()
    refri = get['CERV']

    
    echo("<GET TYPE=HIDDEN NAME=CERV VALUE="..get.CERV..">")

    if get.CERV == "1" then
        local varLista = '"HEINEKEIN"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'HNK'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=13.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.CERV == "2" then
        local varLista = '"ORIGINAL"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'OR'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=13.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")
    
        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.CERV == "3" then
        local varLista = '"AMSTEL"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'AM'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=13.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")

        echo ("<RECTANGLE NAME=1 X=25 Y=115 WIDTH=240 HEIGHT=45 VISIBLE=0>")
        echo ("<RECTANGLE NAME=2 X=25 Y=180 WIDTH=240 HEIGHT=50 VISIBLE=0>")

        echo "<CAPTURE NAME=OPC>"
        echo "<GET TYPE=TOUCH>"
        -- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
        echo "</CAPTURE>"

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volCerv()")
        echo ("</DATA>")
    end
    if get.SUCO == "4" then
        local varLista = '"CHOPP"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CH'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" volChopp()")
        echo ("</DATA>")
    end
    if get.CERV == "5" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function volCerv()
    get = loadstring(GET)()
    cerv = get['OPC']

    
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE="..get.OPC..">")

    if get.OPC == "1" then
        local volume = "350ml"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Cerv350ml()")
        echo ("</DATA>")
    end
    if get.OPC == "2" then
        local volume = "600ml"
        table.insert(SESSION.VOLUME, volume)
        SESSION.save()  

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Cerv600ml()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" volCerv()")
    echo ("</DATA>")
end

function volChopp()
    local volume = "CHOPP"
    table.insert(SESSION.VOLUME, volume)
    SESSION.save()  

    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")
    echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Chopp()")
    echo ("</DATA>")
end

function Cerv350ml()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local cerv = 3
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save() 

    result = cerv * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function Cerv600ml()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local cerv = 5
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = cerv * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function Chopp()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local chopp = 8
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = Chopp * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- --------------------------- PORCAO ------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------


function opcPorc()
    get = loadstring(GET)()
    porc = get['PORC']

    
    echo("<GET TYPE=HIDDEN NAME=PORC VALUE="..get.PORC..">")

    if get.PORC == "1" then
        local varLista = '"BATATA-FRITA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'BF'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" porcBatata()")
        echo ("</DATA>")
    end
    if get.PORC == "2" then
        local varLista = '"BATATA-FRITA-CHEDDAR"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'BFC'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" porcCheddar()")
        echo ("</DATA>")
    end
    if get.PORC == "3" then
        local varLista = '"FRANGO"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'FR'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" porcFrango()")
        echo ("</DATA>")
    end
    if get.PORC == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function porcBatata()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local porc = 15
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = porc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function porcCheddar()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local porc = 18
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = porc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function porcFrango()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local porc = 21
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = porc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -------------------------- LANCHES ------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------

function opcLanc()
    get = loadstring(GET)()
    lanche = get['LANCHE']

    
    echo("<GET TYPE=HIDDEN NAME=LANCHE VALUE="..get.LANCHE..">")

    if get.LANCHE == "1" then
        local varLista = '"X-SALADA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XS'
        table.insert(SESSION.COD, cod)
        SESSION.save()
        
        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" xsalada()")
        echo ("</DATA>")
    end
    if get.LANCHE == "2" then
        local varLista = '"X-BACON"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XB'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" xbacon()")
        echo ("</DATA>")
    end
    if get.LANCHE == "3" then
        local varLista = '"X-TUDO"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'XT'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" xtudo()")
        echo ("</DATA>")
    end
    if get.LANCHE == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
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

function xsalada()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local lanc = 13
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = lanc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function xbacon()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local lanc = 15
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = lanc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function xtudo()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local lanc = 18
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = lanc * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end


-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- --------------------------- PIZZA -------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------
-- -- -----------------------------------------------------------------

function opcPiz()
    get = loadstring(GET)()
    piz = get['PIZ']

    
    echo("<GET TYPE=HIDDEN NAME=PIZ VALUE="..get.PIZ..">")

    if get.PIZ == "1" then
        local varLista = '"QUATRO-QUEIJOS"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'QQ'
        table.insert(SESSION.COD, cod)
        SESSION.save()
        
        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" quatroqueijos()")
        echo ("</DATA>")
    end
    if get.PIZ == "2" then
        local varLista = '"PORTUGUESA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'PT'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" portuguesa()")
        echo ("</DATA>")
    end
    if get.PIZ == "3" then
        local varLista = '"CALABRESA"'    
        table.insert(SESSION.LISTA, varLista)
        SESSION.save()

        local cod = 'CL'
        table.insert(SESSION.COD, cod)
        SESSION.save()

        local volume = 'NENHUM'
        table.insert(SESSION.VOLUME, volume)
        SESSION.save() 

        echo ("<CONSOLE></CONSOLE>")
        echo "<CONLOGO NAME=4.bmp x=0 y=0 WAIT_DISPLAY>"
        echo ("<DELAY TIME=4>")
        echo ("<GET TYPE=FIELD NAME=QTD SIZE=QTD COL=14 LIN=11 NOENTER=1>")

        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" calabresa()")
        echo ("</DATA>")
    end
    if get.PIZ == "4" then
        echo ("<DATA DESTINATION=PARSER>")
        echo (" dofile('newMenu.lua')")
        echo (" Menprods()")
        echo ("</DATA>")
    end
    echo ("<CONSOLE></CONSOLE>")
    echo "<CONLOGO NAME=00.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=2>")

    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function quatroqueijos()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local piz = 27
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = piz * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function portuguesa()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local piz = 30
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = piz * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end

function calabresa()
    get = loadstring(GET)()
    local qtd = get["QTD"]
    local piz = 33
    local result = 0

    qtd = tonumber(qtd)
    table.insert(SESSION.QTD, qtd)
    SESSION.save()  

    result = piz * qtd
    table.insert(SESSION.VALUN, result)
    SESSION.save()

    SESSION.TVAL = SESSION.TVAL + result
    SESSION.save()
    
    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" Menprods()")
    echo ("</DATA>")
end


function reqMaker() -- Função de conexão com a POS
    dofile('ws.o')

    WS.IP = '201.73.146.216' -- IP do servidor  
    WS.PORTA = '8080' -- Porta
    WS.HOST = '201.73.146.216' -- Host
    WS.PATH = '/comanda.php' -- Arquivo que executa as funções do DB
    WS.HEADER['Content-Type'] = 'application/x-www-form-urlencoded'
    -- WS.HEADER.Authorization = 'Basic c3VwZXI6MTIzNA=='
    
    WS.MSG = 'Gravando...' -- msg
    WS.CALL_BACK = 'respReq()' -- resposta do servidor
    WS.CALLER = 'newMenu.lua' -- Nome do arquivo lua
    WS.DADO = SESSION.ENVIAR -- Envia o JSON

    ws.post() -- Requisição POST
end

function respReq() -- Resposta da requisição
    dofile('navs.o')

    echo "<PRNFNT DBL_HEIGHT DBL_WIDTH SIZE=4 BOLD>"
    echo "<PRINTER>"
    echo ("           REDE USE <BR><BR>")
    echo "</PRINTER>"
    echo "<PRNFNT SIZE=4 BOLD>"
    echo "<PRINTER>"
    echo "    PEDIDO ENVVIADO COM SUCESSO! <BR><BR>"
    echo ("<BR>")
    for i, v in ipairs(SESSION.LISTA) do
        var = (i.."- "..v.." "..SESSION.VOLUME[i].." R$"..SESSION.VALUN[i]..": "..SESSION.QTD[i].."<BR><BR>")
        echo (""..var.."")
    end
    echo ("CONSUMO TOTAL: R$"..SESSION.TVAL.."<BR><BR>")
    echo ("MESA: "..SESSION.MESA.."<BR><BR>")
    echo ("<BR><BR><BR><BR>")
    echo "</PRINTER>"

    
    ioSaldo()
end