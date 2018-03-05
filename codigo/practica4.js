//
// Ejercicio 1
//
let Bool = {};

function Constante() {};
let TT = new Constante();
let FF = new Constante();

function Funcion(tipo1, tipo2) {
	this.dominio = tipo1;
	this.imagen = tipo2;
}

function Aplicacion(expresion1, expresion2){
	this.funcion = expresion1;
	this.parametro = expresion2;
}

function Abstraccion(variable,tipo,expresion){
	this.variableLibre = variable;
	this.tipo = tipo;
	this.expresion = expresion;
}

function VariableLibre(nombre){
	this.nombre = nombre;
}

//
// Ejercicio 2
//
Bool.toString = function(){
	return "Bool";
}


TT.toString = function(){
	return "True";
};

FF.toString = function(){
	return "False";
};

Funcion.prototype.toString = function(){
	return '(' + this.dominio.toString() + ' -> ' + this.imagen.toString() + ')';
}


Aplicacion.prototype.toString = function(){
	return '(' + this.funcion.toString() + ' ' + this.parametro.toString() + ')';
}


Abstraccion.prototype.toString = function(){
	return '(\\' + this.variableLibre.toString() + ':' + this.tipo.toString() + '.' + this.expresion.toString() + ')';
}



VariableLibre.prototype.toString = function(){
	return this.nombre;
}

//
// Ejercicio 3
//

Bool.deepCopy = function(){
	return this;
}


Constante.prototype.deepCopy = function(){
	return this;
}


let DeepCopyTrait = {};
DeepCopyTrait.deepCopy = function(){
	let newCopy = {};
	for(let property in this){
		if(DeepCopyTrait.prototype.isPrototypeOf(this[property])){
			newCopy[property] = this[property].deepCopy();
		} else if(!Function.prototype.isPrototypeOf(this[property])) {
			newCopy[property] = this[property];
		}
	}
	newCopy.__proto__ = this.__proto__
	return newCopy;
}


function Expresion(){};
Expresion.prototype = Object.assign(Expresion.prototype, DeepCopyTrait);

Bool.__proto__ = Expresion.prototype;
Constante.prototype.__proto__ = Expresion.prototype;
Funcion.prototype.__proto__ = Expresion.prototype;
Aplicacion.prototype.__proto__ = Expresion.prototype;
Abstraccion.prototype.__proto__ = Expresion.prototype;
VariableLibre.prototype.__proto__ = Expresion.prototype;


// Ejercicio 4

TT.sust = function(variableLibre, expresion) {
	return this;
}

FF.sust = function(variableLibre, expresion) {
	return this;
}


Aplicacion.prototype.sust = function(variableLibre, expresion){
	let funcion = this.funcion.sust(variableLibre, expresion);
	let parametro = this.parametro.sust(variableLibre, expresion);
	return new Aplicacion(funcion, parametro);
}

Abstraccion.prototype.sust = function(variableLibre, expresion){
	let nuevaExpresion;
	if(this.variableLibre != variableLibre) {
		nuevaExpresion = this.expresion.sust(variableLibre, expresion);
	} else {
		nuevaExpresion = this.expresion.deepCopy();
	}

	return new Abstraccion(this.variableLibre, this.tipo, nuevaExpresion);
}

VariableLibre.prototype.sust = function(variableLibre, expresion){
	if(this.nombre == variableLibre){
		return expresion.deepCopy();
	} else {
		return this.deepCopy();
	}
}


// Ejercicio 5

function Valor () {};
Valor.prototype.__proto__ = Expresion.prototype;

Constante.prototype.__proto__ = Valor.prototype;
Abstraccion.prototype.__proto__ = Valor.prototype;

Abstraccion.prototype.ejecutar = function(valor){
 	return this.expresion.sust(this.variableLibre.toString(), valor);
}

Aplicacion.prototype.reducir = function(){
 	if(!Valor.prototype.isPrototypeOf(this.funcion)){
 		return new Aplicacion(this.funcion.reducir(), this.parametro);
 	} else if(!Valor.prototype.isPrototypeOf(this.parametro)){
 		return new Aplicacion(this.funcion, this.parametro.reducir())
 	} else {
 		return this.funcion.ejecutar(this.parametro);
 	}
}


//
//Evaluar
//


Expresion.prototype.evaluar = function(){
	if(Valor.prototype.isPrototypeOf(this)){
		return this.deepCopy();
	} else {
		return this.reducir().evaluar();
	}
}

// // Ejemplos
let BoolToBool = new Funcion(new Funcion(Bool,Bool), Bool);

let x = new VariableLibre('x');
let y = new VariableLibre('y');

let funcionIdBool = new Abstraccion(x.deepCopy(), Bool, x.deepCopy());

let esTrue = new Aplicacion(funcionIdBool.deepCopy(), TT);

let funcionQ = new Abstraccion(
  	x.deepCopy(), Bool, 
  	new Aplicacion( x.deepCopy(), y.deepCopy()));

let funcionIdBoolToBool = new Abstraccion(
	new VariableLibre('x'), 
  	new Funcion(Bool, Bool), 
  	new VariableLibre('x'));

let esTrueMNoValor = new Aplicacion(
	new Aplicacion (
		funcionIdBoolToBool, 
		funcionIdBool), 
	TT)


let esTrueNNoValor = new Aplicacion(funcionIdBool, esTrue);

console.log(`===================================================================`)
console.log(`toString`)
console.log(`===================================================================`)
console.log(`(1) Bool: ${Bool.toString()}`)
console.log(`(2) Funcion: ${BoolToBool.toString()}`)
console.log(`(3) TT: ${TT.toString()}`)
console.log(`(4) FF: ${FF.toString()}`)
console.log(`(5) VariableLibre: ${x.toString()}`)
console.log(`(6) Abstraccion: ${funcionIdBool.toString()}`)
console.log(`(7) Applicacion: ${esTrue.toString()}`)


console.log(`===================================================================`)
console.log(`deepCopy - Las Bool, TT y FF se devuelven a si mismas porque nunca cambian`)
console.log(`===================================================================`)
console.log(`(1) Expresion: ${BoolToBool.toString()}`)
console.log(`(1) DeepCopyChecks: ${BoolToBool != BoolToBool.deepCopy() && BoolToBool.toString() == BoolToBool.deepCopy().toString()}`)
console.log(`\n`)
console.log(`(2) Expresion: ${x.toString()}`)
console.log(`(2) DeepCopyChecks: ${x != x.deepCopy() && x.toString() == x.deepCopy().toString()}`)
console.log(`\n`)
console.log(`(3) Expresion: ${funcionIdBool.toString()}`)
console.log(`(3) DeepCopyChecks: ${funcionIdBool != funcionIdBool.deepCopy() && funcionIdBool.toString() == funcionIdBool.deepCopy().toString()}`)
console.log(`\n`)
console.log(`(4) Expresion: ${esTrue.toString()}`)
console.log(`(4) DeepCopyChecks: ${esTrue != esTrue.deepCopy() && esTrue.toString() == esTrue.deepCopy().toString()}`)


console.log(`===================================================================`)
console.log(`sust - Devuelve expresiones nuevas, no las modifica. Bool y Funcion, no saben responder sust.`)
console.log(`===================================================================`)
console.log(`(1) Expresion: ${TT.toString()}`)
console.log(`(1) Sustituir x por False: ${TT.sust('x', FF).toString()}`);
console.log(`\n`)
console.log(`(2) Expresion: ${FF.toString()}`)
console.log(`(2) Sustituir x por True: ${FF.sust('x', TT).toString()}`);
console.log(`\n`)
console.log(`(3) Expresion: ${x.toString()}`)
console.log(`(3) Sustituir x por y: ${x.sust('x',new VariableLibre('y')).toString()}`)
console.log(`(3) Sustituir y por z: ${x.sust('y',new VariableLibre('z')).toString()}`)
console.log(`\n`)
console.log(`(4) Expresion: ${funcionIdBool.toString()}`)
console.log(`(4) Sustituir x por y: ${funcionIdBool.sust('x',new VariableLibre('y')).toString()}`)
console.log(`\n`)
console.log(`(5) Expresion: ${funcionQ.toString()}`)
console.log(`(5) Sustituir x por y: ${funcionQ.sust('x',new VariableLibre('y')).toString()}`)
console.log(`(5) Sustituir y por z: ${funcionQ.sust('y',new VariableLibre('z')).toString()}`)


console.log(`===================================================================`)
console.log(`reducir y Evaluar - Devuelven expresiones nuevas, no las modifica. Bool y Funcion no saben responder reducir.`)
console.log(`===================================================================`)
console.log(`(1) Expresion: ${esTrue.toString()}`)
console.log(`(1) Reduccion: ${esTrue.reducir().toString()}`)
console.log(`(1) Evaluacion: ${esTrue.evaluar().toString()}`)
console.log(`\n`)
console.log(`(4) Expresion: ${esTrueMNoValor.toString()}`);
console.log(`(4) Reduccion: ${esTrueMNoValor.reducir().toString()}`);
console.log(`(4) Evaluacion: ${esTrueMNoValor.evaluar().toString()}`);
console.log(`\n`)
console.log(`(5) Expresion: ${esTrueNNoValor.toString()}`);
console.log(`(5) Reduccion: ${esTrueNNoValor.reducir().toString()}`);
console.log(`(5) Evaluacion: ${esTrueNNoValor.evaluar().toString()}`);


console.log(`===================================================================`)
console.log(`Cadenas de prototipado`)
console.log(`===================================================================`)
console.log(`Bool - ${Bool.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
}`)

console.log(`Funcion - ${Funcion.prototype.__proto__.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
} ` )

console.log(`TT - ${TT.constructor.name} - ${Constante.prototype.__proto__.constructor.name
} - ${Valor.prototype.__proto__.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
} ` )

console.log(`FF - ${FF.constructor.name} - ${Constante.prototype.__proto__.constructor.name
} - ${Valor.prototype.__proto__.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
} ` )

console.log(`Abstraccion - ${Abstraccion.prototype.__proto__.constructor.name} - ${Valor.prototype.__proto__.constructor.name
} - ${Expresion.prototype.__proto__.constructor.name
} ` )

console.log(`VariableLibre - ${VariableLibre.prototype.__proto__.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
} ` )


console.log(`Aplicacion - ${Aplicacion.prototype.__proto__.constructor.name} - ${Expresion.prototype.__proto__.constructor.name
} ` )
