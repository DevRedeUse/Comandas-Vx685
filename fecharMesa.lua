dofile('io.o')
dofile('navs.o')

function fechaMESA()
    dofile('navs.o')
    get = loadstring(GET)()
    local m = get["MESA"]
    local mesa = tonumber(m) 
    local dth = get["DTH"]
    ------------------------------------------
    --HORA
    local h = string.sub(dth, 9,10)
    local m = string.sub(dth, 11,12)
    local s = string.sub(dth, 13,14)
    ------------------------------------------
    local fechahora = '"'..h..':'..m..':'..s..'"'

    SESSION.MESA = mesa
    SESSION.HORA = fechahora
    SESSION.FECHAMESA = {}
    SESSION.CON = ''
    SESSION.PORCENT = ''
    SESSION.ID = 0
    SESSION.save()

    echo("<GET TYPE=HIDDEN NAME=MESA VALUE="..mesa..">")
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE=1>")
    echo("<POST>")
end

function recInv()
    echo("<CONSOLE>")
    echo("<BR><BR><BR>")
    echo("       SEM PEDIDOS PARA ESTA MESA!")
    echo("<BR>")
    echo("         OU MESA INEXISTENTE!")
    echo("</CONSOLE>")
    echo ("<DELAY TIME=4>")


    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" ioSaldo()")
    echo ("</DATA>")
end

function receberval()
    dofile('navs.o')

    get = loadstring(GET)()
    local consulta = get['CONSULTA']
    local produto = get['PRODUTO']
    local id = get['ID']

    if id == '' then
        echo("<CONSOLE>")
        echo("PEDIDO JÁ FOI FINALIZADO!")
        echo("</CONSOLE>")
        echo("<DELAY TIME = 3>")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('newMenu.lua')")
        echo ("  ioSaldo()")
        echo ("</DATA>")
    end

    id = tonumber(id)

    SESSION.ID = SESSION.ID + id
    SESSION.save()

    local insereSujeira = string.gsub(produto, "-", "sujeira")
    
    local limpaPorcentagem = string.gsub(insereSujeira, "%%2520", " ")

    SESSION.CON = consulta
    SESSION.save()

    SESSION.PORCENT = limpaPorcentagem
    SESSION.save()

    echo("<CONSOLE>")
    echo("<BR><BR><BR><BR>")
    for imprimeSub in string.gmatch(limpaPorcentagem, "%a+") do 
        local limpaSujeira = string.gsub(imprimeSub, "sujeira", " ") 
        print(limpaSujeira)
        echo("Produto: "..limpaSujeira.."<BR>") 
    end
    echo('<BR><BR>')
    echo("Num. Pedido: "..id.."<BR>")
    echo("Valor consumido: "..consulta)
    echo("</CONSOLE>")
    echo "<CONLOGO NAME=15.bmp x=0 y=0 WAIT_DISPLAY>"
    echo ("<DELAY TIME=4>")
    
    echo ("<RECTANGLE NAME=1 X=40 Y=230 WIDTH=230 HEIGHT=60 VISIBLE=0>")


    echo "<CAPTURE NAME=MENU>"
	echo "<GET TYPE=TOUCH>"
	-- echo "<GET TYPE=TIMEOUT TIME=10 ACTION=CANCEL>"
	-- echo "<GET TYPE=FIELD SIZE=1 COL=10 LIN=30 NOENTER=1>"
    echo "</CAPTURE>"


    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('fecharMesa.lua')")
    echo ("  enviaMESA()")
    echo ("</DATA>")
end


function enviaMESA()
    -- JSON
    d = '{"fechamesa":'..SESSION.MESA..', "fechaped":'..SESSION.ID..', "fechahora":'..SESSION.HORA..'}'
    -- Retirar aspas
    d = string.sub(d, 1, -1)
    -- Inserindo o JSON em um array
    table.insert(SESSION.FECHAMESA, d)
    SESSION.save()

    print(SESSION.FECHAMESA)

    fechaMesa()
end

function fechaMesa() -- Função de conexão com a POS
    dofile('ws.o')

    WS.IP = '201.73.146.216' -- IP do servidor  
    WS.PORTA = '8080' -- Porta
    WS.HOST = '201.73.146.216' -- Host
    WS.PATH = '/comanda.php' -- Arquivo que executa as funções do DB
    WS.HEADER['Content-Type'] = 'application/x-www-form-urlencoded'
    -- WS.HEADER.Authorization = 'Basic c3VwZXI6MTIzNA=='
    
    WS.MSG = 'Gravando...' -- msg
    WS.CALL_BACK = 'respFecha()' -- resposta do servidor
    WS.CALLER = 'fecharMesa.lua' -- Nome do arquivo lua
    WS.DADO = SESSION.FECHAMESA -- Envia o JSON

    ws.post() -- Requisição POST
end

function respFecha() -- Resposta da requisição
    echo "<PRNFNT DBL_HEIGHT DBL_WIDTH SIZE=4 BOLD>"
        echo "<PRINTER>"
        echo ("     REDE USE <BR><BR>")
        echo "</PRINTER>"

        echo "<PRNFNT SIZE=4 BOLD>"
        echo "<PRINTER>"
        echo "PEDIDO FINALIZADO COM SUCESSO! <BR><BR>"
        for imprimeSub in string.gmatch(SESSION.PORCENT, "%a+") do 
            local limpaSujeira = string.gsub(imprimeSub, "sujeira", " ") 
            print(limpaSujeira)
            echo("Produto: "..limpaSujeira.."<BR>") 
        end
        echo('<BR><BR>')
        echo("Num. Pedido: "..SESSION.ID.."<BR>")
        echo("Valor consumido: "..SESSION.CON)
        echo ("<BR><BR><BR><BR><BR>2")
        echo "</PRINTER>"

    voltar()
end

function voltar()
    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  ioSaldo()")
    echo ("</DATA>")
end 