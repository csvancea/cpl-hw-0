class List inherits Stringizable {
    isEmpty() : Bool { true };

    hd() : Object { { abort(); self; } };
    tl() : List { { abort(); self; } };

    get(i : Int) : Object { abort() };
    remove(i : Int) : List { { abort(); self; } };
    add(i : Int, h : Object) : List { cons(h) };

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

    filterBy(ft : Filter) : List { self };
    sortBy(cmp : Comparator) : List { self };
    sortByHelper(e : Object, cmp : Comparator) : List { cons(e) };

    toStringElementSeparator() : String { "" };
    toStringHelper() : String { "" };
    toString() : String { "[  ]" };
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

    get(i : Int) : Object {
        if i = 0
            then hd()
            else tl().get(i - 1)
        fi
    };

    remove(i : Int) : List {
        if i = 0
            then tl
            else new Cons.init(hd, tl.remove(i - 1))
        fi
    };

    add(i : Int, h : Object) : List {
        if i = 0
            then cons(h)
            else tl.add(i - 1, h).cons(hd)
        fi
    };

    append(l : List) : List {
        new Cons.init(hd, tl.append(l))
    };

    reverse() : List {
        tl.reverse().append(new List.cons(hd))
    };

    filterBy(ft : Filter) : List {
        if ft.filter(hd)
            then new Cons.init(hd, tl.filterBy(ft))
            else tl.filterBy(ft)
        fi
    };

    sortBy(cmp : Comparator) : List {
        (tl.sortBy(cmp)).sortByHelper(hd, cmp)
    };

    sortByHelper(e : Object, cmp : Comparator) : List {
        if cmp.compareTo(e, hd) < 0 then
            (new Cons).init(e, self)
        else
            (new Cons).init(hd, tl.sortByHelper(e, cmp))
        fi
    };

    toStringElementSeparator() : String { ", " };
    toStringHelper() : String {
        stringizer.toString(hd)
            .concat(tl.toStringElementSeparator())
            .concat(tl.toStringHelper())
    };
    toString() : String { "[ ".concat(toStringHelper()).concat(" ]") };
};
