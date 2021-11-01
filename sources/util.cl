(* Think of these as abstract classes *)
class Comparator {
    compareTo(o1 : Object, o2 : Object) : Int { 0 };
};

class Filter {
    filter(o : Object) : Bool { true };
};

class ProductFilter inherits Filter {
    filter(o : Object) : Bool {
        case o of
            p : Product => true;
            x : Object => false;
        esac
    };
};

class RankFilter inherits Filter {
    filter(o : Object) : Bool {
        case o of
            r : Rank => true;
            x : Object => false;
        esac
    };
};

class SamePriceFilter inherits Filter {
    filter(o : Object) : Bool {
        case o of
            p : Product => p.getprice() = p@Product.getprice();
        esac
    };
};

class PriceComparator inherits Comparator {
    compareTo(o1 : Object, o2 : Object) : Int {
        case o1 of
            a : Product => 
                case o2 of
                        b : Product => a.getprice() - b.getprice();
                esac;
        esac
    };
};

class RankComparator inherits Comparator {
    compareTo(o1 : Object, o2 : Object) : Int {
        case o1 of
            a : Rank => 
                case o2 of
                        b : Rank => a.getrank() - b.getrank();
                esac;
        esac
    };
};

class AlphabeticComparator inherits Comparator {
    compareTo(o1 : Object, o2 : Object) : Int {
        case o1 of
            a : String => 
                case o2 of
                        b : String =>
                            if a < b then ~1
                            else if a = b then 0
                            else 1
                            fi fi;
                esac;
        esac
    };
};

class IntComparator inherits Comparator {
    compareTo(o1 : Object, o2 : Object) : Int {
        case o1 of
            a : Int => 
                case o2 of
                        b : Int => a - b;
                esac;
        esac
    };
};

class ReverseComparator inherits Comparator {
    cmp : Comparator;

    init (c : Comparator) : Comparator {{
        cmp <- c;
        self;
    }};

    compareTo(o1 : Object, o2 : Object) : Int {
        ~cmp.compareTo(o1, o2)
    };
};
