// Ejercicio 1
// a)
console.log("================================")
console.log("Ejercicio 1")
console.log("================================")

// a
let c1i = {
    r: 1,
    i: 1
}

console.log(`1.a) c1i`)
console.log(c1i);
console.log(' ')

c1i.sumar = function(complejo){
    this.r += complejo.r;
    this.i += complejo.i;
}

console.log(`1.b) c1i`)
console.log( c1i)
c1i.sumar(c1i)
console.log(`1.b) c1i.sumar(c1i); c1i`)
console.log(c1i)
console.log(' ')
c1i.sumar({r: -1, i:-1});


// c)

c1i.sumar = function(complejo){
    let nuevoComplejo = Object.assign({}, this);
    nuevoComplejo.r += complejo.r;
    nuevoComplejo.i += complejo.i;
    return nuevoComplejo;
}

console.log(`1.c) cli`);
console.log(c1i);
console.log(`1.c) c1i.sumar(c1i)`)
console.log(c1i.sumar(c1i));
console.log(`1.c) c1i`)
console.log("c1i", c1i);
console.log(' ')

// d) No tengo que cambiar la solucion
console.log(`1.d) c1i`)
console.log(c1i);
console.log(`1.d) c1i.sumar(c1i).sumar(c1i)`)
console.log(c1i.sumar(c1i).sumar(c1i))
console.log(`1.d) c1i`);
console.log(c1i);
console.log(' ')

// e)
let c = c1i.sumar(c1i)
c.restar = function(complejo){
    let nuevoComplejo = Object.assign({}, this);
    nuevoComplejo.r -= complejo.r;
    nuevoComplejo.i -= complejo.i;
    return nuevoComplejo;
}

console.log("1.e) c") 

console.log("1.e) c")
console.log(c)
console.log("1.e) c1i.restar(c)")
try {
    c1i.restar(c);
} catch(error) {
    console.log(error);
}

console.log(` `)

// f)

c1i.mostrar = function(){
    return `${this.r} + ${(this.i == 1)? '' : this.i}i`;
}

console.log(`1.f) c1i.mostrar() = ${c1i.mostrar()}`)

console.log("1.f) c.mostrar()")
try {
    c.mostrar();
} catch(error) {
    console.log(error);
}
console.log(` `)





console.log("================================")
console.log("Ejercicio 2")
console.log("================================")

// a
let t = {}
let f = {}

t.ite = function(a,b) {
    return a;
}

f.ite = function(a,b) {
    return b;
}

console.log(`2.a) t`)
console.log(t);
console.log(`2.a) f`)
console.log(f);

console.log(' ')


t.mostrar = function() {
    return "Verdadero";
}

f.mostrar = function(){
    return "Falso";
}

console.log(`2.b) t.mostrar() = ${t.mostrar()}`)
console.log(`2.b) f.mostrar() = ${f.mostrar()}`)
console.log(` `)

t.not = function(){
    return f;
}

f.not = function(){
    return t;
}

t.and = function(otroValor) {
    return otroValor;
}

f.and = function(element) {
    return this;
}

console.log(`2.c) t.not() = ${t.not().mostrar()}`)
console.log(`2.c) f.not() = ${f.not().mostrar()}`)
console.log(`2.c) t.and(t) = ${t.and(t).mostrar()}`)
console.log(`2.c) t.and(f) = ${t.and(f).mostrar()}`)
console.log(`2.c) f.and(t) = ${f.and(t).mostrar()}`)
console.log(`2.c) f.and(f) = ${f.and(f).mostrar()}`)


console.log("================================")
console.log("Ejercicio 3")
console.log("================================")

// 3.a)
let Cero = {};

Cero.esCero = function(){
    return true;
};

Cero.succ = function(){
    return new Succ(this);
}


function Succ(predecesor){
    this.predecesor = predecesor;
};

Succ.prototype.__proto__ = Cero;   

Succ.prototype.pred = function(){
    return this.predecesor;
}

console.log(`3.a) Cero`)
console.log(Cero);

console.log(`3.a) Succ`)
console.log(Succ);
console.log(`3.a) Cero.succ()`)
console.log(Cero.succ());
console.log(` `)

// 3.b)
Cero.toNumber = function(){
    return 0;
}

Succ.prototype.toNumber = function(){
    return this.pred().toNumber() + 1;
}

console.log(`3.b) Cero = ${Cero.toNumber()}`)
console.log(`3.b)Cero.succ().succ() = ${Cero.succ().succ().toNumber}`)
console.log(` `)

// 3.c)
Cero.for = function(f){}

Succ.prototype.for = function(f){
    this.pred().for(f);
    f.eval(this);
}

let funcion = {
    eval: function(i){
        console.log(i.toNumber())
    }
}

console.log(`3.c) f.eval`)
console.log(funcion.eval)
console.log(`3.c) Cero.succ().succ().for()`)
Cero.succ().succ().for(funcion);

console.log("================================")
console.log("Ejercicio 4")
console.log("================================")

// a)

let PuntoO = {}
PuntoO.new = function (x,y) {
    let p = {
        x: x,
        y: y
    }

    p.mostrar = function(){
        return PuntoO.mostrar(this);
    }

    p.moverX = function(x) {
        return PuntoO.moverX(x, this);
    }

    return p
}

PuntoO.mostrar = function(o) {
    return `Punto(${o.x},${o.y})`    
}

let mostrarAux = PuntoO.mostrar

let p = PuntoO.new(1,2);
console.log(`4.a) p.mostrar() = ${p.mostrar()}`);

PuntoO.mostrar = function(){
    return 'unPunto'
}
console.log(`4.a) Redefinimos Punto.mostrar`)
console.log(PuntoO.mostrar)
console.log(`4.a) p.mostrar() = ${p.mostrar()}`)
console.log(` `)

PuntoO.mostrar = mostrarAux
// 4.b)

let PuntoColoreadoO = {};
PuntoColoreadoO.new =  function(x,y){
    let p = PuntoO.new(x,y)
    
    p.color = 'rojo'
    p.mostrar = function() {
        return PuntoColoreadoO.mostrar(this)
    }
    
    return p
}

PuntoColoreadoO.mostrar = function(o){
    return PuntoO.mostrar(o);
}


let pColoreado = PuntoColoreadoO.new(1,2)

console.log(`4.b) pColoreado.mostrar() = ${pColoreado.mostrar()}`)
PuntoO.mostrar = function(){
    return 'unPunto'
}
console.log(`4.b) Redefinimos Punto.mostrar`)
console.log(PuntoO.mostrar)
console.log(`4.b) p.mostrar() = ${pColoreado.mostrar()}`)

PuntoColoreadoO.mostrar = function() {
    return 'unPuntoColoreado';
}
console.log(`4.b) Definimos PuntoColoreado.mostrar`)
console.log(PuntoColoreadoO.mostrar)
console.log(`4.b) p.mostrar() = ${pColoreado.mostrar()}`)
console.log(` `)


PuntoColoreadoO.mostrar = function(o){
    return PuntoO.mostrar(o);
}

PuntoO.mostrar = mostrarAux
PuntoColoreadoO.coloreadoMostrar = function(o){
    return PuntoO.mostrar(o)
}

// 4.c)
PuntoColoreadoO.newC = function(x, y, color) {
    let p = this.new(x,y)
    p.color = color
    return p
}

console.log(`4.c) PuntoColoreado`)
console.log(PuntoColoreadoO)
console.log(` `)

// 4.d)
let p1 = PuntoO.new(1 ,2) ;
let pc1 = PuntoColoreadoO.new(1 ,2) ;

PuntoO.moverX = function(x, o){
    o.x += x
}

PuntoO.new = function(x,y) {
    let p = {
        x: x,
        y: y
    }

    p.mostrar = function() {
        return PuntoO.mostrar(this)
    }
    
    p.moverX = function(x) {
        return PuntoO.moverX(x, this)
    }
    return p
}

let p2 = PuntoO.new (1 ,2) ;
let pc2 = PuntoColoreadoO.new (1 ,2) ;

console.log(`4.d) p1 = ${p1.mostrar()}`)
console.log(`4.d) p1.moverX(1)`)

try {
    p1.moverX(1)
    console.log(p1.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) pc1 = ${pc1.mostrar()}`)
console.log(`4.d) pc1.moverX(1)`)

try {
    pc1.moverX(1)
    console.log(pc1.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) p2 = ${p2.mostrar()}`)
console.log(`4.d) p2.moverX(1)`)

try {
    p2.moverX(1)
    console.log(p2.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) pc2 = ${pc2.mostrar()}`)
console.log(`4.d) pc2.moverX(1)`)

try {
    pc2.moverX(1)
    console.log(pc2.mostrar())
} catch(error) {
    console.log(error)
}

console.log("================================")
console.log("Ejercicio 5")
console.log("================================")

function Punto(x, y){
    this.x = x;
    this.y = y;
}

Punto.prototype.mostrar = function(){
    return `Punto(${this.x},${this.y})`
}

let mostrar5Aux = Punto.prototype.mostrar

let p5 = new Punto(1,2);
console.log(`5.a) p.mostrar() = ${p5.mostrar()}`);

Punto.prototype.mostrar = function(){
    return 'unPunto'
}

console.log(`5.a) Redefinimos Punto.prototype.mostrar`)
console.log(Punto.prototype.mostrar)
console.log(`5.a) p.mostrar() = ${p5.mostrar()}`)
console.log(` `)

Punto.prototype.mostrar = mostrar5Aux

// 5.b)
function PuntoColoreado(x,y, color) {
    this.x = x
    this.y = y
    this.color = color
}

PuntoColoreado.prototype.__proto__ = Punto.prototype

let pColoreado5 = new PuntoColoreado(1,2)

console.log(`5.b) pColoreado.mostrar() = ${pColoreado5.mostrar()}`)

Punto.prototype.mostrar = function(){
   return 'unPunto'
}

console.log(`5.b) Redefinimos Punto.prototype.mostrar`)
console.log(Punto.prototype.mostrar)
console.log(`5.b) p.mostrar() = ${pColoreado5.mostrar()}`)

PuntoColoreado.prototype.mostrar = function() {
    return 'unPuntoColoreado';
}
console.log(`5.b) Definimos PuntoColoreado.prototype.mostrar`)
console.log(PuntoColoreado.prototype.mostrar)
console.log(`5.b) p.mostrar() = ${pColoreado5.mostrar()}`)
console.log(` `)

delete PuntoColoreado.prototype.mostrar
Punto.prototype.mostrar = mostrar5Aux

console.log(`5.c) PuntoColoreado`)
console.log(PuntoColoreado)
console.log(` `)

// 4.d)
let p15 = new Punto(1 ,2) ;
let pc15 = new PuntoColoreado(1 ,2) ;

Punto.prototype.moverX = function(x){
    this.x += x
}

let p25 = new Punto(1 ,2) ;
let pc25 = new PuntoColoreado(1 ,2) ;

console.log(`4.d) p1 = ${p15.mostrar()}`)
console.log(`4.d) p1.moverX(1)`)

try {
    p15.moverX(1)
    console.log(p15.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) pc1 = ${pc15.mostrar()}`)
console.log(`4.d) pc1.moverX(1)`)

try {
    pc15.moverX(1)
    console.log(pc15.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) p2 = ${p25.mostrar()}`)
console.log(`4.d) p2.moverX(1)`)

try {
    p25.moverX(1)
    console.log(p2.mostrar())
} catch(error) {
    console.log(error)
}
console.log(`4.d) pc2 = ${pc25.mostrar()}`)
console.log(`4.d) pc2.moverX(1)`)

try {
    pc25.moverX(1)
    console.log(pc25.mostrar())
} catch(error) {
    console.log(error)
}



console.log("================================")
console.log("Ejercicio 6")
console.log("================================")

function C1(){};
C1.prototype.g = " Hola ";

function C2 () {};
C2.prototype.g = " Mundo ";

let a = new C1();
C1.prototype = C2.prototype;
let b = new C1();

console.log(`6.a)`)
console.log(a.g);
console.log(b.g);

function C1b(){};
C1b.prototype.g = " Hola ";

function C2b () {};
C2b.prototype.g = " Mundo ";

let ab = new C1b();
C1b.prototype.g = C2b.prototype.g;
let bb = new C1b();

console.log(`6.b)`)
console.log(ab.g);
console.log(bb.g);

console.log("================================")
console.log("Ejercicio 7")
console.log("================================")

// 7.a)
let o = { 
    a: 1,
    b: function(x){
        return x + a 
    }
};

let o1 = Object.create(o);
o1.c = true;

let o1Keys = new Array;
let o1Values = new Array;

for (let k in o1){
    o1Keys.push(k);
    o1Values.push(o1[k])
}

console.log(`7.a)`)
console.log(o1Keys)
console.log(o1Values)
console.log(` `)
// 7.b)
function extender(o1, o2){
    let res = Object.assign({},o2);

    for(var key in o1) {
        if(res[key] == undefined) res[key] = o1[key]
    }

    return res;
}

console.log(`7.b) extender({a:1, b:true, c:"Hola"}, {b:1, d:"Mundo"})`)
console.log(extender({a:1, b:true, c:"Hola"}, {b:1, d:"Mundo"}))
console.log(` `)

// 7.c)

let A = {
    inicializar: function(n,a){
        this.nombre = n
        this.apellido = a
        this
    },

    presentar: function(){
        return this.nombre + " " + this.apellido;
    }
}

let B = Object.create(A);
B.saludar = function(){
    alert("Hola"+this.presentar()+".")
};

let a7 = Object.create(A);
a7.inicializar("Juan", "Perez");

let b7 = Object.create(B);
b7.inicializar("Pedro","Juarez");

B.presentar = A.presentar
delete A.presentar

console.log(`7.c) a.presentar`)
try {
    a7.presentar()
} catch(error){
    console.log(error)
}

console.log(`7.c) b.presentar`)
console.log(b7.presentar())
console.log(` `)
// 7.d)
let A7d = function(){}
A7d.prototype.inicializar = function(n,a){
    this.nombre = n
    this.apellido = a
    return this
},

A7d.prototype.presentar = function(){
    return this.nombre + " " + this.apellido;
}

let B7d = function(){}
B7d.prototype.__proto__ = A7d.prototype;
B7d.prototype.saludar = function(){
    alert("Hola"+this.presentar()+".")
};

let a7d = new A7d().inicializar("Juan", "Perez");
let b7d = new B7d().inicializar("Pedro","Juarez");

B7d.prototype.presentar = A7d.prototype.presentar
delete A7d.prototype.presentar

console.log(`7.d) a.presentar`)
try {
    a7d.presentar()
} catch(error){
    console.log(error)
}

console.log(`7.d) b.presentar`)
console.log(b7d.presentar())
