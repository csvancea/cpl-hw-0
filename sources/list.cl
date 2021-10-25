class List inherits Stringizable {
    isEmpty() : Bool { true };

    hd() : Object { { abort(); self; } };
    tl() : List { { abort(); self; } };

    cons(h : Object) : Cons {
        new Cons.init(h, self)
    };

    (* in fact, rcons always returns a non-empty list (aka Cons), but its
       static type is List because append' static type is List.
       As an ugly hack, I could have casted the result to Cons, but List as
       static type is fine too, I guess
    *)
    rcons(h : Object) : List { 
        append(new Cons.init(h, new List))
    };

    append(l : List) : List { l };
    reverse() : List { self };

    toStringElementSeparator() : String { "" };
    toStringHelper() : String { "" };
    toString() : String { "[ ]" };
};

class Cons inherits List {
    stringizer : Stringizer <- new Stringizer;
    hd : Object;
    tl : List;

    init(h : Object, t : List) : Cons {
        {
            hd <- h;
            tl <- t;
            self;
        }
    };

    isEmpty() : Bool { false };

    hd() : Object { hd };
    tl() : List { tl };

    append(l : List) : List {
        new Cons.init(hd, tl.append(l))
    };

    reverse() : List {
        tl.reverse().append(new List.cons(hd))
    };

    toStringElementSeparator() : String { ", " };
    toStringHelper() : String {
        stringizer.toString(hd)
            .concat(tl.toStringElementSeparator())
            .concat(tl.toStringHelper())
    };
    toString() : String { "[ ".concat(toStringHelper()).concat(" ]") };
};
