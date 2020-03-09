dofile('io.o')
dofile('navs.o')

function ioSaldo()
    dofile('navs.o')
    
    SESSION.CRIARMESA = {}
    SESSION.MESA = 0
    SESSION.DTH = ''
    SESSION.save()
end

function verificaMesa()
    dofile('navs.o')
    get = loadstring(GET)()
    local m = get["MESA"]
    local dth = get["DTH"]
    local mesa = tonumber(m)

    SESSION.MESA = mesa
    SESSION.DTH = dth
    SESSION.save()
    
    echo("<GET TYPE=HIDDEN NAME=MESA VALUE="..SESSION.MESA..">")
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE=4>")
    echo("<POST>")
end

function mesa()
    dofile('navs.o')
    get = loadstring(GET)()
    local v = get["V"]

    if v == '2' then
        local total = 0
        local status = 1
        local statusmesa = 2
        local dth = SESSION.DTH
        local mesa = SESSION.MESA
        SESSION.save()

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
        local hora = '"'..h..':'..m..':'..s..'"'
        local data = (ano.."-"..mes.."-"..dia)

        -- JSON
        d = '{"criamesa":'..SESSION.MESA..', "criamesastatus":'..statusmesa..', "criatotal":'..total..', "criadata":"'..data..'", "criastatus":'..status..', "criahora":'..hora..'}'
        -- Retirar aspas
        d = string.sub(d, 1, -1)
        -- Inserindo o JSON em um array
        table.insert(SESSION.CRIARMESA, d)
        SESSION.save()

        print(SESSION.CRIARMESA)

        criaMesa()
    else
        echo("<CONSOLE>")
        echo("<BR><BR><BR>")
        echo("           MESA OCUPADA!!! <BR><BR>")
        echo("         ESCOLHA OUTRA MESA")
        echo("</CONSOLE>")
        echo("<DELAY TIME=3")

        echo ("<DATA DESTINATION=PARSER>")
        echo ("  dofile('newMenu.lua')")
        echo ("  ioSaldo()")
        echo ("</DATA>")
    end
end

function criaMesa() -- Função de conexão com a POS
    dofile('ws.o')

    
    WS.IP = '201.73.146.216' -- IP do servidor  
    WS.PORTA = '8080' -- Porta
    WS.HOST = '201.73.146.216' -- Host
    WS.PATH = '/comanda.php' -- Arquivo que executa as funções do DB
    WS.HEADER['Content-Type'] = 'application/x-www-form-urlencoded'
    -- WS.HEADER.Authorization = 'Basic c3VwZXI6MTIzNA=='
    
    WS.MSG = 'Gravando...' -- msg
    WS.CALL_BACK = 'resposta()' -- resposta do servidor
    WS.CALLER = 'mesa.lua' -- Nome do arquivo lua
    WS.DADO = SESSION.CRIARMESA -- Envia o JSON

    ws.post() -- Requisição POST
end

function resposta() -- Resposta da requisição
    dofile('navs.o')
    
    voltar()
end

function voltar()
    echo ("<DATA DESTINATION=PARSER>")
    echo ("  dofile('newMenu.lua')")
    echo ("  ioSaldo()")
    echo ("</DATA>")
end 