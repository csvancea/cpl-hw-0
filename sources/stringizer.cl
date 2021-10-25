class Stringizable {
    toString() : String { { abort(); ""; } };
};

class Stringizer inherits A2I {
    toString(obj : Object) : String {
        case obj of
	        stringizable : Stringizable => stringizable.toString();
            b : Bool => "Bool(".concat(b2a(b)).concat(")");
	        i : Int => "Int(".concat(i2a(i)).concat(")");
	        s : String => "String(".concat(s).concat(")");
	        io : IO => "IO()";
	        o : Object => { abort(); "Object()"; };
        esac
    };
};
