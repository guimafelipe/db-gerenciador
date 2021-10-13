const parseKML = require('parse-kml');
const mysql = require('mysql2/promise');

var inserirDB = async function(con, rota, i){
	try{

		let id = i/3 + 1;
		let datenow = new Date(i);
		let datesql = datenow.toISOString().slice(0, 19).replace('T', ' ');

		console.log("Inserindo rota de id " + id);
		console.log(datesql);

		let queryText = 'insert into rota_desejada(data_insercao) values (?)';
		let result = await con.query(queryText, datesql);
		
		console.log(result);

		// fazer um for na rota
		// inserir a posição com fk pra essa rota

		console.log("Temos " + rota.length + " pontos pra inserir");

		let arrQueries = [];
		for(let i = 0; i < rota.length; i++){
			console.log("	inserindo ponto " + i + " na rota " + id);
			let x = rota[i][0], y = rota[i][1];
			let arrQuery = [x, y, id];

			arrQueries.push(arrQuery);
		}

		let queryRotaText 
			= 'insert into posicao_desejada(latitude, altitude, id_rota_desejada) values ? ';
		let res2 = await con.query(queryRotaText, [arrQueries]); 

	} catch(e){
		console.log(e);
	}

	return true;

}


var main = async function(){
	//await con.connect();

	var docc = await parseKML.toJson('./rota1.kml');

	var rotas = docc.features;

	/*
	console.log(rotas);
	console.log(rotas.length);
	*/

	const con = await mysql.createConnection({
	  host: 'localhost',
	  user: 'root',
	  password: 'root',
	  database: 'gerenciador'
	});

	for(let i = 0; i < rotas.length; i+= 3){
		let res = await inserirDB(con, rotas[i].geometry.coordinates, i);
	}

	await con.end();
}


main();

