class Main inherits IO {
    stringizer : Stringizer <- new Stringizer;
    tokenizer : Tokenizer <- new Tokenizer;
    factory : Factory <- new Factory;
    a2i : A2I <- new A2I;

    lists : List <- new List;


    help() : Object {
        out_string("Available commands:\n  help, load, print, merge, filterBy, sortBy\n")
    };

    load() : Object {
        let
            looping : Bool <- true,
            list : List <- new List,
            line : String,
            tokens : List,
            command : String,
            parameters : List
        in {
            while looping loop {
                line <- in_string();
                tokens <- tokenizer.tokenize(line);
                
                -- side effect: process will abort if an empty line is typed in
                command <- stringizer.s(tokens.hd());
                parameters <- tokens.tl();

                if command = "END" then looping <- false
                else list <- list.cons(factory.create(command, parameters)) fi;
            } pool;

            lists <- lists.rcons(list.reverse());
        }
    };

    print(listIndex : Int) : Object {
        if listIndex = 0 then
            let
                ll : List <- lists
            in
                while not ll.isEmpty() loop {
                    case ll.hd() of
                        l : List => out_string(stringizer.s(listIndex + 1).concat(": ").concat(l.toString()).concat("\n"));
                    esac;

                    ll <- ll.tl();
                    listIndex <- listIndex + 1;
                }
                pool
        else
            case lists.get(listIndex - 1) of
                l : List => out_string(l.toString().concat("\n"));
            esac
        fi
    };

    merge(listIndex1 : Int, listIndex2 : Int) : Object {
        let
            list1 : List,
            list2 : List
        in {
            case lists.get(listIndex1 - 1) of
                l : List => list1 <- l;
            esac;
            case lists.get(listIndex2 - 1) of
                l : List => list2 <- l;
            esac;

            lists <- lists
                            .remove(listIndex1 - 1) -- remove first list
                            .remove(listIndex2 - 2) -- remove second list
                            .rcons(list1.append(list2)); -- add the merged list to the end
        }
    };

    filterBy(listIndex : Int, filter : String) : Object {
        let
            list : List
        in {
            case lists.get(listIndex - 1) of
                l : List => list <- l;
            esac;

            lists <- lists
                            .remove(listIndex - 1)
                            .add(listIndex - 1, list.filterBy(factory.filter(filter)));
        }
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
