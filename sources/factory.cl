class Factory {
    s : Stringizer <- new Stringizer;
    a2i : A2I <- new A2I;

    (* Instantiate an object of name type 'name'
       TODO: come up with another way of accessing a List instead of chaining tl and hd *)
    create (name : String, parameters : List) : Object {
        -- product
        if name = "Soda" then new Soda.init(s.s(parameters.hd()), s.s(parameters.tl().hd()), a2i.a2i(parameters.tl().tl().hd()))
        else if name = "Coffee" then new Coffee.init(s.s(parameters.hd()), s.s(parameters.tl().hd()), a2i.a2i(parameters.tl().tl().hd()))
        else if name = "Laptop" then new Laptop.init(s.s(parameters.hd()), s.s(parameters.tl().hd()), a2i.a2i(parameters.tl().tl().hd()))
        else if name = "Router" then new Router.init(s.s(parameters.hd()), s.s(parameters.tl().hd()), a2i.a2i(parameters.tl().tl().hd()))
        
        -- ranks
        else if name = "Private" then new Private.init(s.s(parameters.hd()))
        else if name = "Corporal" then new Corporal.init(s.s(parameters.hd()))
        else if name = "Sergent" then new Sergent.init(s.s(parameters.hd()))
        else if name = "Officer" then new Officer.init(s.s(parameters.hd()))
        
        -- primitive types
        else if name = "Bool" then a2i.a2b(parameters.hd())
        else if name = "Int" then a2i.a2i(parameters.hd())
        else if name = "String" then s.s(parameters.hd())
        else if name = "IO" then new IO

        -- unknown type
        else abort()

        fi fi fi fi fi fi fi fi fi fi fi fi
    };

    filter (name : String) : Filter {
        if name = "ProductFilter" then new ProductFilter
        else if name = "RankFilter" then new RankFilter
        else if name = "SamePriceFilter" then new SamePriceFilter
        else new Filter
        fi fi fi
    };

    comparator (name : String) : Comparator {
        if name = "PriceComparator" then new PriceComparator
        else if name = "RankComparator" then new RankComparator
        else if name = "AlphabeticComparator" then new AlphabeticComparator
        else if name = "IntComparator" then new IntComparator
        else new Comparator
        fi fi fi fi
    };
};
