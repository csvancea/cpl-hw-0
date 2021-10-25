class Main inherits IO {
    stringizer : Stringizer <- new Stringizer;
    tokenizer : Tokenizer <- new Tokenizer;
    a2i : A2I <- new A2I;

    lists : List <- new List;


    help() : Object {
        out_string("Available commands:\n  help, load, print, merge, filterBy, sortBy\n")
    };

    load() : Object {
        let
            factory : Factory <- new Factory,
            looping : Bool <- true,
            list : List <- new List,
            line : String,
            tokens : List,
            command : String,
            parameters : List
        in
            while looping loop {
                line <- in_string();
                tokens <- tokenizer.tokenize(line);
                
                -- side effect: process will abort if an empty line is typed in
                command <- stringizer.s(tokens.hd());
                parameters <- tokens.tl();

                if command = "END" then looping <- false
                else list <- list.cons(factory.create(command, parameters)) fi;

                lists <- lists.cons(list);
            } pool
    };

    print(listIndex : Int) : Object {
        -- print head list
        case lists.hd() of
            l : List => out_string(l.toString().concat("\n"));
        esac
    };

    merge(listIndex1 : Int, listIndex2 : Int) : Object {
        0
    };

    filterBy(listIndex : Int, filter : String) : Object {
        0
    };

    sortBy(listIndex : Int, comparator : String) : Object {
        0
    };

    main() : Object {
        let
            looping : Bool <- true,
            line : String,
            tokens : List,
            command : String,
            parameters : List
        in
            while looping loop {
                line <- in_string();
                tokens <- tokenizer.tokenize(line);
                
                -- side effect: process will abort if an empty line is typed in
                command <- stringizer.s(tokens.hd());
                parameters <- tokens.tl();

                if command = "load" then load()
                else if command = "print" then print(if parameters.isEmpty() then 0 else a2i.a2i(parameters.hd()) fi)
                else if command = "merge" then merge(a2i.a2i(parameters.hd()), a2i.a2i(parameters.tl().hd()))
                else if command = "filterBy" then filterBy(a2i.a2i(parameters.hd()), stringizer.s(parameters.tl().hd()))
                else if command = "sortBy" then sortBy(a2i.a2i(parameters.hd()), stringizer.s(parameters.tl().hd()))
                else help()
                fi fi fi fi fi;
            } pool
    };
};
