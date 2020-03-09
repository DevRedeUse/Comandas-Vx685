dofile('io.o')
dofile('navs.o')

function ioCon()
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

    echo("<GET TYPE=HIDDEN NAME=DATACON VALUE="..data..">")
    echo("<GET TYPE=HIDDEN NAME=MESACON VALUE="..mesa..">")
    echo("<GET TYPE=HIDDEN NAME=OPC VALUE=5>")
    echo("<POST>")
end


function recebeCon()
    dofile('navs.o')
    get = loadstring(GET)()
    local idcon = get['IDCON']
    local prodcon = get['PRODCON']
    local pedval = get['PEDVAL']
    local quant = get['QUANT']

    local insereSujeira = string.gsub(prodcon, "-", "sujeira")
    local limpaPorcentagem = string.gsub(insereSujeira, "%%2520", " ")

    echo("<CONSOLE>")
    echo("<BR><BR><BR><BR>")
    for imprimeSub in string.gmatch(limpaPorcentagem, "%a+") do 
        local limpaSujeira = string.gsub(imprimeSub, "sujeira", " ") 
        echo("Produto: "..limpaSujeira.."<BR>") 
    end
    local limpaQuant = string.gsub(quant, "%%2520", " | ")
    echo("Quantidade: "..limpaQuant.."<BR><BR>")
    echo("Num. Pedido: "..idcon.."<BR>")
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
    echo (" dofile('newMenu.lua')")
    echo (" ioSaldo()")
    echo ("</DATA>")
end

function recebeResp()
    echo("<CONSOLE>")
    echo("SEM PEDIDOS PARA ESTA MESA!")
    echo("</CONSOLE>")
    echo ("<DELAY TIME=4>")


    echo ("<DATA DESTINATION=PARSER>")
    echo (" dofile('newMenu.lua')")
    echo (" ioSaldo()")
    echo ("</DATA>")
end