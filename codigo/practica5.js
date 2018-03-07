// Esta función esta a forma de debug:
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
    return `${this.r} + ${this.i}i`;
}

console.log(`1.f) c1i`)
console.log(c1i);

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