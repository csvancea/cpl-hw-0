class Tokenizer {
    separator : String <- " "; -- must be exactly 1 char long
    tokens : List;             -- holds the tokens list
    token : String;            -- holds the current (to be constructed) token
    ch : String;               -- holds the current examined char (temp var)

    (*
        Split input string in a List of strings. Implicit separator = " "
        This method is not reentrant (it doesn't matter though)
    *)
    tokenize(input : String) : List {{
        -- reset vars
        tokens <- new List;
        token <- "";

        while not input.length() = 0 loop {
            ch <- input.substr(0, 1);
            input <- input.substr(1, input.length() - 1);

            if ch = separator then
                add_token_if_necessary()
            else
                -- found a non-separator character; append it to the current token
                token <- token.concat(ch)
            fi;
        } pool;

        -- reached end of string; insert the last token (if needed)
        add_token_if_necessary();

        -- return tokens list in correct order
        tokens.reverse();
    }};

    (*
        Helper function. Adds token to the list of tokens only if token not empty.
    *)
    add_token_if_necessary() : Object {
        if token.length() = 0 then
            -- empty token; do not add it to the tokens list
            ""
        else {
            -- parsed an entire token; add it to the list
            tokens <- tokens.cons(token);
            token <- "";
        }
        fi
    };
};
