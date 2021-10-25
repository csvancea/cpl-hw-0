(* abstract class *)
class Stringizable {
    toString() : String { { abort(); ""; } };
};

(* static class with functions regarding object-to-string conversions *)
class Stringizer inherits A2I {
    (* returns object as string for primitive types *)
    toSimpleString(obj : Object) : String {
        case obj of
            b : Bool => b2a(b);
            i : Int => i2a(i);
            s : String => s;
            io : IO => "";
        esac        
    };

    (* shortcut for toSimpleString; to be used in main.cl *)
    s(obj : Object) : String {
        toSimpleString(obj)
    };

    (* returns object as string in the preferred output format for
    primitive types + stringizable types; implicit abort for any other type *)
    toString(obj : Object) : String {
        case obj of
            stringizable : Stringizable => stringizable.toString();
            o : Object => o
                            .type_name()
                            .concat("(")
                            .concat(toSimpleString(o))
                            .concat(")");
        esac
    };
};
