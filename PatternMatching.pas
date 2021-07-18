PROGRAM PatternMatching;

TYPE 
    Node = ^NodeRec;
    NodeRec = RECORD
        sub: STRING;
        start1: INTEGER;
        start2: INTEGER;
        next: Node;
    END;
    List = Node;


PROCEDURE InitList(VAR l: List);
    BEGIN
        l := NIL;
    END;


PROCEDURE DisposeList(VAR l: List);
    VAR
        n, next: Node;
    BEGIN
        n := l;
        WHILE n <> NIL DO BEGIN
            next := n^.next;
            Dispose(n);
            n := next;
        END;
    END;


PROCEDURE DisplayList(l: List);
    VAR
        n: Node;
    BEGIN
        n := l;
        WriteLn;
        WriteLn('List: ');
        WHILE n <> NIL DO BEGIN
            WriteLn('sub: ', n^.sub,', start1: ', n^.start1,', start2: ', n^.start2);
            n := n^.next;
        END;
        WriteLn;
    END;


PROCEDURE FindLongestMatch(s1, s2: STRING; VAR sub: STRING; VAR start1, start2: INTEGER);
    VAR
        longStr, shortStr: STRING;
        changed: BOOLEAN;
        sLen, pLen, i, j: INTEGER;
        l: List;
        n: Node;
        newNode: Node;

    BEGIN
        WriteLn('Input: s1: ', s1, ', s2: ', s2);
        InitList(l);
        n := l;

        changed := FALSE;
        IF Length(s1) < Length(s2) THEN BEGIN
            longStr := s2;
            shortStr := s1;
            changed := TRUE;
        END ELSE BEGIN
            longStr := s1;
            shortStr := s2;
        END;

        sub := '';
        start1 := 0;
        start2 := 0;

        sLen := Length(longStr);
        pLen := Length(shortStr);

        i := 1;
        j := 1;

        WHILE (i <= sLen) DO BEGIN
            IF longStr[i] = shortStr[j] THEN BEGIN
                IF n = NIL THEN BEGIN
                    New(newNode);
                    newNode^.sub := shortStr[j];
                    newNode^.start1 := i;
                    newNode^.start2 := j;
                    newNode^.next := l;
                    l := newNode;
                    n := l;
                    
                    Inc(j);
                    IF j <= pLen THEN
                        Inc(i)
                END ELSE BEGIN
                    newNode^.sub := newNode^.sub + shortStr[j];
                    Inc(i);
                    Inc(j);
                END;
            END ELSE IF (j <= pLen) AND (longStr[i] <> shortStr[j]) THEN BEGIN
                Inc(j);
                n := NIL;
            END ELSE IF j > pLen THEN BEGIN
                Inc(i);
                j := 1;
                n := NIL;
            END;
        END;

        n := l;

        WHILE n <> NIL DO BEGIN
            IF Length(n^.sub) > Length(sub) THEN BEGIN
                sub := n^.sub;
                IF changed = FALSE THEN BEGIN
                    start1 := n^.start1;
                    start2 := n^.start2;
                END ELSE BEGIN
                    start1 := n^.start2;
                    start2 := n^.start1;
                END;
            END;
            n := n^.next;
        END;
        DisplayList(l);
    END;




VAR
    sub: STRING;
    start1, start2: INTEGER;
BEGIN

    FindLongestMatch('abcdefg', 'adeb', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('uvwxy', 'rstqvwxz', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('uvwuvwuvw', 'uvw', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('uvwuvw', 'uvwuvw', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('abcdefg', 'hij', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('abcdefgh', 'h', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('abcdef', 'abcdef', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);
    WriteLn;
    FindLongestMatch('uvwxy', 'abcdexy', sub, start1, start2);
    WriteLn('Results: sub: ',sub,', start1: ', start1,', start2: ', start2);


END.
