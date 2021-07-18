PROGRAM Wildcards;


PROCEDURE BruteSearchLR(s, p: STRING; VAR pos: BYTE; VAR found: BOOLEAN);
    VAR
        sLen, pLen,
        i, j: INTEGER;
        underscore: INTEGER;
    BEGIN
        sLen := Length(s);
        pLen := Length(p);

        i := 1;
        j := 1;

        underscore := 0;

        WHILE (i <= sLen) AND (j <= pLen) DO BEGIN
            j := 1;
            
            WHILE (j <= pLen) AND (s[i] = p[j]) OR (p[j] = '?') OR ((s[i] = '_') AND (s[i+1] = p[j])) DO BEGIN
                IF s[i] = '_' THEN BEGIN
                    Inc(i);
                    Inc(underscore);
                END;
                Inc(i);
                Inc(j);
            END;
            i := i - j + 2;  
        END;

        IF (j > pLen) THEN BEGIN
            pos := i - 1 - underscore;
            found := TRUE;
        END ELSE BEGIN
            pos := 0;
            found := FALSE;
        END;
    END;


VAR
    pos: BYTE;
    found: BOOLEAN;

BEGIN
    BruteSearchLR('Land der Berge', 'Berg', pos, found);
    WriteLn('string: ', 'Land der Berge','; pattern: ', 'Berg');
    WriteLn('position: ',pos, '; found: ', found); 
    WriteLn;

    BruteSearchLR('Land der Berge', 'Be?g', pos, found);
    WriteLn('string: ', 'Land der Berge','; pattern: ', 'Be?g');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('Land der Berge', 'B??g', pos, found);
    WriteLn('string: ', 'Land der Berge','; pattern: ', 'B??g');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('Land der Berge', 'B??t', pos, found);
    WriteLn('string: ', 'Land der Berge','; pattern: ', 'B??t');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('Land der Berge', '?er', pos, found);
    WriteLn('string: ', 'Land der Berge','; pattern: ', '?er');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('var str_len: int', 'strlen', pos, found);
    WriteLn('string: ', 'var str_len: int','; pattern: ', 'strlen');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('Die Politiker_innen', 'Politikerin', pos, found);
    WriteLn('string: ', 'Die Politiker_innen','; pattern: ', 'Politikerin');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('ab_de', 'ab?de', pos, found);
    WriteLn('string: ', 'ab_de','; pattern: ', 'ab?de');
    WriteLn('position: ',pos, '; found: ', found);
    WriteLn;

    BruteSearchLR('ab_cde', 'ab?de', pos, found);
    WriteLn('string: ', 'ab_cde','; pattern: ', 'ab?de');
    WriteLn('position: ',pos, '; found: ', found);


END.