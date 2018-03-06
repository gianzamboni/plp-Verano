    var Punto = {};
    Punto.new=function (x,y) {
    	var p = {};
    	p.mostrar = function () {
            return Punto.mostrar(this);
        };
    	p.x=x;
    	p.y=y;
    	return p;
    }
    Punto.mostrar=function (o) {
    	return (o.x+" "+o.y);
    }
    var p = Punto.new(1 ,2);
    console.log(p.mostrar());
    Punto.mostrar=function (){ return "unPunto"};
    console.log(p.mostrar());