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