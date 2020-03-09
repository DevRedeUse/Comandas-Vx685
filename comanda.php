<?php

	$opc = $_GET["OPC"];

	if ($opc == '1'){
		$mesaEnvio = $_GET["MESA"];

		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;

		$result = pg_query($bdcon, "SELECT ped_id FROM pedido WHERE mes_id = ('$mesaEnvio') AND sts_id = 1");
		$row = pg_fetch_assoc($result);
		$id = $row['ped_id'];

		$result = pg_query($bdcon, "SELECT ped_val_conta FROM pedido WHERE mes_id =('$mesaEnvio') AND ped_id = ('$id')");
		$row = pg_fetch_assoc($result);
		$ped_val = $row['ped_val_conta'];

		$result = pg_query($bdcon, "Select
		nome_itens.nom_nome
		From
			item
			Inner Join nome_itens On nome_itens.nom_id = item.nom_id
		WHERE 
		ped_id_pedido = ('$id')");

		$row = pg_fetch_all($result);
		$rowEncode = json_encode($row);
		$rowString = strval($rowEncode);

		$rowSub = substr($rowString, 1, -3);
		$firstReplace = preg_replace('/{"nom_nome":"/', '', $rowSub);
		$finalReplace = preg_replace('/"},/', '%20', $firstReplace); 
		$encoder = preg_replace('/ /', '%20', $finalReplace); 

		pg_close($bdcon);
		echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

		// if($id == ''){
		// 	echo "<DATA DESTINATION=PARSER>";
		// 	echo "  dofile('fecharMesa.lua')";
		// 	echo "  recInv()";
		// 	echo "</DATA>";
		// } else{
			echo "<GET TYPE=HIDDEN NAME=ID VALUE=".$id.">";
			echo "<GET TYPE=HIDDEN NAME=PRODUTO VALUE=".$encoder.">";
			echo "<GET TYPE=HIDDEN NAME=CONSULTA VALUE=".$ped_val.">";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('fecharMesa.lua')";
			echo "  receberval()";
			echo "</DATA>";
		// }
	} elseif ($opc == '2') {
		$datacancel = $_GET["DATACANCEL"];
		$mesacancel = $_GET["MESACANCEL"];

		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;

		$result = pg_query($bdcon, "SELECT ped_id FROM pedido WHERE mes_id = ('$mesacancel') AND sts_id = 1");
		$row = pg_fetch_assoc($result);
		$idcancel = $row['ped_id'];

		$result = pg_query($bdcon, "Select
		nome_itens.nom_nome
		From
			item
			Inner Join nome_itens On nome_itens.nom_id = item.nom_id
		WHERE 
		ped_id_pedido = ('$idcancel') ORDER BY nome_itens.nom_nome ASC");

		$row = pg_fetch_all($result);
		$rowEncode = json_encode($row);
		$rowString = strval($rowEncode);

		$rowSub = substr($rowString, 1, -3);
		$firstReplace = preg_replace('/{"nom_nome":"/', '', $rowSub);
		$finalReplace = preg_replace('/"},/', '%20', $firstReplace); 
		$pc = preg_replace('/ /', '%20', $finalReplace);

		$result = pg_query($bdcon, "SELECT ite_quant FROM item WHERE mes_id = ('$mesacancel') AND ped_id_pedido = ('$idcancel') ORDER BY ite_quant DESC");
		$row = pg_fetch_all($result);
		$rowEncode = json_encode($row);
		$rowString = strval($rowEncode);

		$rowSub = substr($rowString, 1, -3);
		$firstReplace = preg_replace('/{"ite_quant":"/', '', $rowSub);
		$finalReplace = preg_replace('/"},/', '%20', $firstReplace); 
		$qc = preg_replace('/ /', '%20', $finalReplace);

		$result = pg_query($bdcon, "SELECT ped_val_conta FROM pedido WHERE mes_id =('$mesacancel') AND ped_id = ('$idcancel')");
		$row = pg_fetch_assoc($result);
		$ped_val = $row['ped_val_conta'];

		pg_close($bdcon);
		echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

		if($idcancel == ''){
			echo "<GET TYPE=HIDDEN NAME=RESULT VALUE=2>";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('cancelItem.lua')";
			echo "  resposta()";
			echo "</DATA>"; 
		} else{
			echo "<GET TYPE=HIDDEN NAME=IDCANCEL VALUE=".$idcancel.">";
			echo "<GET TYPE=HIDDEN NAME=PRODCANCEL VALUE=".$pc.">";
			echo "<GET TYPE=HIDDEN NAME=PEDVAL VALUE=".$ped_val.">";
			echo "<GET TYPE=HIDDEN NAME=QUANT VALUE=".$qc.">";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('cancelItem.lua')";
			echo "  cancelResposta()";
			echo "</DATA>";
		}
	}elseif ($opc == '3') {
		$cancelid = $_GET["CANCELID"];
		$cancelitem = $_GET["CANCELITEM"];
		$cancelqtd = $_GET["CANCELQTD"];
		$cancelval = $_GET["CVAL"];

		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;

		$result = pg_query($bdcon, "SELECT ite_quant FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$cancelitem')) AND ped_id_pedido = ('$cancelid')");
		$row = pg_fetch_assoc($result);
		$cquant = $row['ite_quant'];
		$q = intval($cquant);

		$resultcancel = $q - $cancelqtd;
		$attval = ($resultcancel * $cancelval);

		if($resultcancel <= 0){
			pg_query($bdcon, "DELETE FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$cancelitem')) AND ped_id_pedido = ('$cancelid')");

			pg_query($bdcon, "UPDATE pedido SET ped_val_conta = (SELECT SUM(ite_valor) FROM item WHERE ped_id_pedido = ('$cancelid')) WHERE ped_id = ('$cancelid')");

			pg_close($bdcon);
			echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

			echo "<GET TYPE=HIDDEN NAME=CONSULTA VALUE=0>";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('cancelItem.lua')";
			echo "  resposta()";
			echo "</DATA>"; 
	}else{
			pg_query($bdcon, "UPDATE item SET ite_quant = ('$resultcancel') WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$cancelitem')) AND ped_id_pedido = ('$cancelid')");

			pg_query($bdcon, "UPDATE item SET ite_valor = ('$attval') WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$cancelitem')) AND ped_id_pedido = ('$cancelid')");

			pg_query($bdcon, "UPDATE pedido SET ped_val_conta = (SELECT SUM(ite_valor) FROM item WHERE ped_id_pedido = ('$cancelid')) WHERE ped_id = ('$cancelid')");

			pg_close($bdcon);
			echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

			echo "<GET TYPE=HIDDEN NAME=CONSULTA VALUE=1>";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('cancelItem.lua')";
			echo "  resposta()";
			echo "</DATA>";
		}		
	} elseif($opc == '4') {
		$mesa = $_GET["MESA"];

		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;


		$result = pg_query($bdcon, "SELECT mes_id_status FROM mesa WHERE mes_id = ('$mesa')");
		$row = pg_fetch_assoc($result);
		$verificaMesa = $row['mes_id_status'];
		$vm = strval($verificaMesa);

		pg_close($bdcon);
		echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

		if($vm == 2){
			echo "<GET TYPE=HIDDEN NAME=V VALUE=1>";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('mesa.lua')";
			echo "  mesa()";
			echo "</DATA>";
		} else{
			echo "<GET TYPE=HIDDEN NAME=V VALUE=2>";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('mesa.lua')";
			echo "  mesa()";
			echo "</DATA>";
		}
	}elseif ($opc == '5') {
		$datacon = $_GET["DATACON"];
		$mesacon = $_GET["MESACON"];

		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;

		$result = pg_query($bdcon, "SELECT ped_id FROM pedido WHERE mes_id = ('$mesacon') AND sts_id = 1");
		$row = pg_fetch_assoc($result);
		$idcon = $row['ped_id'];

		$result = pg_query($bdcon, "Select
		nome_itens.nom_nome
		From
			item
			Inner Join nome_itens On nome_itens.nom_id = item.nom_id
		WHERE 
		ped_id_pedido = ('$idcon') ORDER BY nome_itens.nom_nome ASC");

		$row = pg_fetch_all($result);
		$rowEncode = json_encode($row);
		$rowString = strval($rowEncode);

		$rowSub = substr($rowString, 1, -3);
		$firstReplace = preg_replace('/{"nom_nome":"/', '', $rowSub);
		$finalReplace = preg_replace('/"},/', '%20', $firstReplace); 
		$pc = preg_replace('/ /', '%20', $finalReplace);

		$result = pg_query($bdcon, "SELECT ite_quant FROM item WHERE mes_id = ('$mesacon') AND ped_id_pedido = ('$idcon') ORDER BY ite_quant DESC");
		$row = pg_fetch_all($result);
		$rowEncode = json_encode($row);
		$rowString = strval($rowEncode);

		$rowSub = substr($rowString, 1, -3);
		$firstReplace = preg_replace('/{"ite_quant":"/', '', $rowSub);
		$finalReplace = preg_replace('/"},/', '%20', $firstReplace); 
		$qc = preg_replace('/ /', '%20', $finalReplace);

		$result = pg_query($bdcon, "SELECT ped_val_conta FROM pedido WHERE mes_id =('$mesacon') AND ped_id = ('$idcon')");
		$row = pg_fetch_assoc($result);
		$ped_val = $row['ped_val_conta'];

		pg_close($bdcon);
		echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

		if($idcon == ''){
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('consultaExterna.lua')";
			echo "  recebeResp()";
			echo "</DATA>";
		} else{
			echo "<GET TYPE=HIDDEN NAME=IDCON VALUE=".$idcon.">";
			echo "<GET TYPE=HIDDEN NAME=PRODCON VALUE=".$pc.">";
			echo "<GET TYPE=HIDDEN NAME=PEDVAL VALUE=".$ped_val.">";
			echo "<GET TYPE=HIDDEN NAME=QUANT VALUE=".$qc.">";
			echo "<DATA DESTINATION=PARSER>";
			echo "  dofile('consultaExterna.lua')";
			echo "  recebeCon()";
			echo "</DATA>";
		}
	}
	

	// Recebe os arquivos que a máquina envia
	$var = file_get_contents('php://input');
	
	// Limpando sujeiras
	$respVar = substr($var, 2, -2);
	$test = preg_replace('/}"/', '}', $respVar);
	$final = preg_replace('/,"/', ',', $test);

	// Monta JSON final
	$decode = json_decode('{ "items" : ['.$final.'] }', true);	

		// CONEXÃO AO BANCO DE DADOS 
		$bdcon = pg_connect("host=localhost port=5432 dbname=CMD user=postgres password=HugE1*2928!Wqg");
		echo 'Conexão aberta <br><br>'.PHP_EOL.PHP_EOL;

			// INSERÇÃO PEDIDOS
			foreach ($decode["items"] as $key => $values) {
				$mesa = $values["criamesa"];
				$criadata = $values["criadata"];
				$criatotal = $values["criatotal"];
				$criastatus = $values["criastatus"];	
				$criahora = $values["criahora"];
				pg_query($bdcon,"INSERT INTO pedido (ped_val_conta, ped_data, ped_hora) VALUES ('$criatotal', '$criadata', '$criahora')");
			}

			// UPDATE DA CRIAÇÃO DO PEDIDO
			foreach ($decode["items"] as $key => $values) {
				$criamesa = $values["criamesa"];
				$criastatus = $values["criastatus"];
				$criahora = $values["criahora"];
				$criadata = $values["criadata"];	
				pg_query($bdcon,"UPDATE pedido SET sts_id = ('$criastatus'), mes_id = ('$criamesa') WHERE ped_data = ('$criadata') AND ped_hora = ('$criahora')");
			}

			//UPDATE DA MESA NA CRIAÇÃO DO PEDIDO
			foreach ($decode["items"] as $key => $values) {
				$criamesa = $values["criamesa"];
				$criamesastatus = $values["criamesastatus"];
				pg_query($bdcon,"UPDATE mesa SET mes_id_status = ('$criamesastatus') WHERE mes_id = ('$criamesa')");
			}


			// INSERÇÃO DA QUANTIDADE, VALOR DE CADA ITEM, DATA DE PEDIDOS
			foreach ($decode["items"] as $key => $values) {
			$qtd = $values["qtd"];
			$valor = $values["valor"];
			$cod = $values["cod"];
			$data = $values["data"];
			$hora = $values["hora"];
			pg_query($bdcon,"INSERT INTO item (ite_quant, ite_valor, dmc_ite_cod, ite_data, ite_hora) VALUES ('$qtd', '$valor', '$cod', '$data', '$hora')");
			}

			// MESA
			foreach ($decode["items"] as $key => $values) {
				$data = $values["data"];	
				$mesa = $values["mesa"];
				$hora = $values["hora"];
				$cod = $values["cod"];
				pg_query($bdcon, "UPDATE item SET mes_id = ('$mesa') WHERE ite_data = ('$data') AND ite_hora = ('$hora') AND dmc_ite_cod = ('$cod')");
			}


			//PEDIDO
			foreach ($decode["items"] as $key => $values) {
				$data = $values["data"];
				$mesa = $values["mesa"];	
				$cod = $values["cod"];
				$hora = $values["hora"];
				pg_query($bdcon, "UPDATE item SET ped_id_pedido = (SELECT MAX(ped_id) FROM pedido WHERE mes_id = ('$mesa')) WHERE ite_data = ('$data') AND ite_hora = ('$hora')");
			}

			// NOME DO PRODUTO
			foreach ($decode["items"] as $key => $values) {
				$produto = $values["produto"];	
				$hora = $values["hora"];
				$cod = $values["cod"];
				pg_query($bdcon, "UPDATE item SET nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) WHERE ite_hora = ('$hora') AND dmc_ite_cod = ('$cod')");
			}

			// VOLUME
			foreach ($decode["items"] as $key => $values) {
				$data = $values["data"];
				$volume = $values["volume"];	
				$mesa = $values["mesa"];
				$cod = $values["cod"];	
				$hora = $values["hora"];
				pg_query($bdcon, "UPDATE item SET nomv_id = (SELECT nomv_id FROM nomv WHERE nom_nome = ('$volume')) WHERE ite_hora = ('$hora') AND dmc_ite_cod = ('$cod')");
			}

			//VALOR TOTAL
			foreach ($decode["items"] as $key => $values) {
				$mesa = $values["mesa"];
				pg_query($bdcon, "UPDATE pedido SET ped_val_conta = (SELECT SUM(ite_valor) FROM item WHERE ped_id_pedido = (SELECT MAX(ped_id) FROM pedido WHERE mes_id = ('$mesa'))) WHERE ped_hora = (SELECT ped_hora FROM pedido WHERE ped_id = (SELECT MAX(ped_id) FROM pedido WHERE mes_id = ('$mesa')));");
			}

			// FECHA MESA
			foreach ($decode["items"] as $key => $values) {
				$fechamesa = $values["fechamesa"];	
				$fechaped = $values["fechaped"];
				$fechahora = $values["fechahora"];
				pg_query($bdcon, "UPDATE pedido SET sts_id = 2 WHERE mes_id = ('$fechamesa') AND ped_hora = (SELECT ped_hora FROM pedido WHERE ped_id = ('$fechaped'))");
			}

			// HORA DE FECHAMENTO
			foreach ($decode["items"] as $key => $values) {
				$fechamesa = $values["fechamesa"];	
				$fechaped = $values["fechaped"];
				$fechahora = $values["fechahora"];
				pg_query($bdcon, "UPDATE pedido SET ped_hfec = ('$fechahora')  WHERE mes_id = ('$fechamesa') AND ped_hora = (SELECT ped_hora FROM pedido WHERE ped_id = ('$fechaped'))");
			}


			// MESA DISPONÍVEL
			foreach ($decode["items"] as $key => $values) {
				$fechamesa = $values["fechamesa"];	
				pg_query($bdcon, "UPDATE mesa SET mes_id_status = 1  WHERE mes_id = ('$fechamesa')");

				echo "<GET TYPE=HIDDEN NAME=FECHADA VALUE=fechado>";
				echo "<DATA DESTINATION=PARSER>";
				echo "  dofile('fecharMesa.lua')";
				echo "  resposta()";
				echo "</DATA>";
			}

			// CANCELA ITEM
			// foreach ($decode["items"] as $key => $values) {
			// 	$cancelmesa = $values["cancelmesa"];
			// 	$cancelitem = $values["cancelitem"];
			// 	$cancelcod = $values["cancelcod"];
			// 	$canceldata = $values["canceldata"];
			// 	$cancelid = $values["cancelid"];
			// 	$cancelqtd = $values["cancelqtd"];

			// 	$cancelqtd = intval($ccq);

			// 	$resultcancel = $q - $ccq;

				
			// }
			
			// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			// FATURAÇÃO
			foreach ($decode["items"] as $key => $values) {
				$query = "SELECT fat_data FROM faturacao WHERE fat_id = (SELECT MAX(fat_id) FROM faturacao);"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$fatdata = $row['fat_data'];

				$data  = $values["data"];
				$valor = 0;

				$f = strval($fatdata);
				$d = strval($data);

				if ($f == '') {
					pg_query($bdcon, "INSERT INTO faturacao (fat_data, fat_valor) VALUES ('$data', '$valor')");
					
					pg_query($bdcon, "UPDATE faturacao SET fat_valor = (SELECT SUM(ped_val_conta) FROM pedido WHERE ped_data = ('$data')) WHERE fat_data = ('$data')");
				}
				elseif ($f != $d) {
					pg_query($bdcon, "INSERT INTO faturacao (fat_data, fat_valor) VALUES ('$data', '$valor')");
					
					pg_query($bdcon, "UPDATE faturacao SET fat_valor = (SELECT SUM(ped_val_conta) FROM pedido WHERE ped_data = ('$data')) WHERE fat_data = ('$data')");
				} else {
					pg_query($bdcon, "UPDATE faturacao SET fat_valor = (SELECT SUM(ped_val_conta) FROM pedido  WHERE ped_data = ('$data')) WHERE fat_data = ('$data')");

					pg_query($bdcon, "UPDATE faturacao SET fat_itens_vend = (SELECT SUM(ite_quant) FROM item WHERE ite_data = ('$data')) WHERE fat_data = ('$data')");

					pg_query($bdcon, "UPDATE faturacao SET fat_quant_ped = (SELECT COUNT(ped_id) FROM pedido WHERE ped_data = ('$data')) WHERE fat_data = ('$data')");
				}
			}

			// VENDA DE ITENS
			foreach ($decode["items"] as $key => $values) {
				$produto = $values["produto"];	
				$data = $values["data"];
				$cod = $values["cod"];

				$query = "SELECT nom_id FROM nome_itens WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto'))"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$prod = $row['nom_id'];	

				$p = intval($prod);			

				// SELECIONA SE O PRODUTO JA ESTÁ CONTIDO NA TABELA
				$query = "SELECT nom_id FROM venda_itens WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) AND fat_id = (SELECT fat_id FROM faturacao WHERE fat_data = ('$data'))"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$nomid = $row['nom_id'];

				$n = intval($nomid);

				// SELECIONA A QUANTIDADE DE UM DETERMINADO PRODUTO
				$query = "SELECT SUM(ite_quant) FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) AND ite_data = ('$data')"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$quant = $row['sum'];

				$q = intval($quant);

				// SELECIONA A SOMA DE UM DETERMINADO PRODUTO
				$query = "SELECT SUM(ite_valor) FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) AND ite_data = ('$data')"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$val = $row['sum'];

				$v = intval($val);


				if ($p == ''){
					pg_query($bdcon, "INSERT INTO venda_itens (ven_quant, ven_total, ven_hora, ven_data, ven_cod) VALUES ('$q', '$v', '$hora', '$data', '$cod')");

					pg_query($bdcon, "UPDATE venda_itens SET fat_id = (SELECT fat_id FROM faturacao WHERE fat_data = ('$data')) WHERE ven_data = ('$data')");

					pg_query($bdcon, "UPDATE venda_itens SET nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) WHERE ven_data = ('$data') AND ven_cod = ('$cod')");
				}
				elseif ($p != $n) {
					pg_query($bdcon, "INSERT INTO venda_itens (ven_quant, ven_total, ven_hora, ven_data, ven_cod) VALUES ('$q', '$v', '$hora', '$data', '$cod')");

					pg_query($bdcon, "UPDATE venda_itens SET fat_id = (SELECT fat_id FROM faturacao WHERE fat_data = ('$data')) WHERE ven_data = ('$data')");

					pg_query($bdcon, "UPDATE venda_itens SET nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) WHERE ven_data = ('$data') AND ven_cod = ('$cod')");
				} else {
					pg_query($bdcon, "UPDATE venda_itens SET ven_quant = ('$q') WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) AND fat_id = (SELECT fat_id FROM faturacao WHERE fat_data = ('$data'))"); 

					pg_query($bdcon, "UPDATE venda_itens SET ven_total = ('$v') WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto')) AND fat_id = (SELECT fat_id FROM faturacao WHERE fat_data = ('$data'))");
				}
			}

			//TOTAL POR CATEGORIA
			foreach ($decode["items"] as $key => $values) {
				$mes = $values["mes"];
				$data = $values["data"];
				$mes = strval($mes);

				$d = strval($data);

				$query = "SELECT MAX(tot_data) FROM total_cat"; 
				$result = pg_query($bdcon, $query);
				$row = pg_fetch_assoc($result);
				$mescat = $row['max'];	

				$m = strval($mescat);	

				if($m == '' || $m != $d){
					pg_query($bdcon, "INSERT INTO total_cat (tot_data ,cat_id) VALUES ('$data' ,1)");

					pg_query($bdcon, "INSERT INTO total_cat (tot_data, cat_id) VALUES ('$data', 2)");

					pg_query($bdcon, "INSERT INTO total_cat (tot_data, cat_id) VALUES ('$data', 3)");

					pg_query($bdcon, "INSERT INTO total_cat (tot_data, cat_id) VALUES ('$data', 4)");
				}
				else{
					$data = $values["data"];
					$d = strval($data);

					$query = "SELECT tot_id FROM total_cat WHERE tot_data = ('$data') AND cat_id = 1"; 
					$result = pg_query($bdcon, $query);
					$row = pg_fetch_assoc($result);
					$t1 = $row['tot_id'];
					$beb = strval($t1);

					$query = "SELECT tot_id FROM total_cat WHERE tot_data = ('$data') AND cat_id = 2"; 
					$result = pg_query($bdcon, $query);
					$row = pg_fetch_assoc($result);
					$t2 = $row['tot_id'];
					$porc = strval($t2);

					$query = "SELECT tot_id FROM total_cat WHERE tot_data = ('$data') AND cat_id = 3"; 
					$result = pg_query($bdcon, $query);
					$row = pg_fetch_assoc($result);
					$t3 = $row['tot_id'];
					$lanc = strval($t3);

					$query = "SELECT tot_id FROM total_cat WHERE tot_data = ('$data') AND cat_id = 4"; 
					$result = pg_query($bdcon, $query);
					$row = pg_fetch_assoc($result);
					$t4 = $row['tot_id'];
					$piz = strval($t4);

					$query = "SELECT MAX(ext_data) FROM categoria_extrato"; 
					$result = pg_query($bdcon, $query);
					$row = pg_fetch_assoc($result);
					$totdata = $row['max'];
					$td = strval($totdata);	

					if($td == '' || $td != $d){
						// Bebidas menores
						//AGUA
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (2, 0, 0, 'A', '$data', '$beb', 1, 1)");
						
						// REFRIGERANTE
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (3, 0, 0, 'CC', '$data', '$beb', 1, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (4, 0, 0, 'P', '$data', '$beb', 1, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (5, 0, 0, 'F', '$data', '$beb', 1, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (6, 0, 0, 'G', '$data', '$beb', 1, 1)");
						
						// REFRIGERANTE 2L
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (2, 0, 0, 'A', '$data', '$beb', 2, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (3, 0, 0, 'CC', '$data', '$beb', 2, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (4, 0, 0, 'P', '$data', '$beb', 2, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (5, 0, 0, 'F', '$data', '$beb', 2, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (6, 0, 0, 'G', '$data', '$beb', 2, 1)");

						// SUCOS COPO
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (7, 0, 0, 'L', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (8, 0, 0, 'AB', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (9, 0, 0, 'ABH', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (10, 0, 0, 'LM', '$data', '$beb', 3, 1)");

						// SUCOS JARRA
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (7, 0, 0, 'L', '$data', '$beb', 4, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (8, 0, 0, 'AB', '$data', '$beb', 4, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (9, 0, 0, 'ABH', '$data', '$beb', 4, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (10, 0, 0, 'LM', '$data', '$beb', 4, 1)");

						//CERVEJA
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (11, 0, 0, 'HNK', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (12, 0, 0, 'OR', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (13, 0, 0, 'AM', '$data', '$beb', 3, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (14, 0, 0, 'CH', '$data', '$beb', 8, 1)");

						//CERVEJA 600ML
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (11, 0, 0, 'HNK', '$data', '$beb', 5, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (12, 0, 0, 'OR', '$data', '$beb', 5, 1)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (13, 0, 0, 'AM', '$data', '$beb', 5, 1)");

						//PORCOES 
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (15, 0, 0, 'BF', '$data', '$porc', 7, 2)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (16, 0, 0, 'BFC', '$data', '$porc', 7, 2)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (17, 0, 0, 'FR', '$data', '$porc', 7, 2)");

						//LANCHES
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (18, 0, 0, 'XS', '$data', '$lanc', 7, 3)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (19, 0, 0, 'XB', '$data', '$lanc', 7, 3)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (20, 0, 0, 'XT', '$data', '$lanc', 7, 3)");

						//PIZZAS 
						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (21, 0, 0, 'QQ', '$data', '$piz', 7, 4)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (22, 0, 0, 'PT', '$data', '$piz', 7, 4)");

						pg_query($bdcon, "INSERT INTO categoria_extrato (nom_id, ext_quant, ext_valor, ext_cod, ext_data, tot_id, nomv_id, cat_id) VALUES (23, 0, 0, 'CL', '$data', '$piz', 7, 4)");
					} else{
						$produto = $values["produto"];
						$data = $values["data"];
						$cod = $values["cod"];

						pg_query($bdcon, "UPDATE categoria_extrato SET ext_quant = (SELECT SUM(ite_quant) FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto'))) WHERE ext_cod = ('$cod') AND ext_data = ('$data')");

						pg_query($bdcon, "UPDATE categoria_extrato SET ext_valor = (SELECT SUM(ite_valor) FROM item WHERE nom_id = (SELECT nom_id FROM nome_itens WHERE nom_nome = ('$produto'))) WHERE ext_cod = ('$cod') AND ext_data = ('$data')");
					}
				}
			}		

			

    pg_close($bdcon);
	echo 'Conexão fechada <br><br>'.PHP_EOL.PHP_EOL;

?>