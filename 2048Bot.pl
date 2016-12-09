move(Board, u, NewBoard) :- once(goUp(Board, NewBoard)).
move(Board, d, NewBoard) :- once(goDown(Board, NewBoard)).
move(Board, l, NewBoard) :- once(goLeft(Board, NewBoard)).
move(Board, r, NewBoard) :- once(goRight(Board, NewBoard)).

rotateRight([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[E1,E2,E3,E4,F1,F2,F3,F4,G1,G2,G3,G4,H1,H2,H3,H4]) :-
	E1 is D1,
	E2 is C1,
	E3 is B1,
	E4 is A1,
	F1 is D2,
	F2 is C2,
	F3 is B2,
	F4 is A2,
	G1 is D3,
	G2 is C3,
	G3 is B3,
	G4 is A3,
	H1 is D4,
	H2 is C4,
	H3 is B4,
	H4 is A4.

rotateLeft([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[E1,E2,E3,E4,F1,F2,F3,F4,G1,G2,G3,G4,H1,H2,H3,H4]) :-
	E1 is A4,
	E2 is B4,
	E3 is C4,
	E4 is D4,
	F1 is A3,
	F2 is B3,
	F3 is C3,
	F4 is D3,
	G1 is A2,
	G2 is B2,
	G3 is C2,
	G4 is D2,
	H1 is A1,
	H2 is B1,
	H3 is C1,
	H4 is D1.

goUp(Board, NewBoard):-
	rotateLeft(Board, Temp1),
	goLeft(Temp1, Temp2),
	rotateRight(Temp2, NewBoard).

goDown(Board, NewBoard):-
	rotateRight(Board, Temp1),
	goLeft(Temp1, Temp2),
	rotateLeft(Temp2, NewBoard).

goRight(Board, NewBoard):-
	rotateLeft(Board, Temp1),
	rotateLeft(Temp1, Temp2),
	goLeft(Temp2, Temp3),
	rotateRight(Temp3, Temp4),
	rotateRight(Temp4, NewBoard).

goLeft([], []).
% X|X|X|X -> 2X|2X|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X3 \= 0,
	X1 == X2,
	X3 == X4,
	N1 is X1 + X2,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	goLeft(X, N).
% X|X|X|Y -> 2X|X|Y|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X2 == X3,
	N1 is X1 + X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% X|X|Y|Z -> 2X|Y|Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X3 \= 0,
	N1 is X1 + X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% X|Y|Z|Z -> X|Y|2Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X1 \= X2,
	X2 \= X3,
	X3 == X4,
	N1 is X1,
	N2 is X2,
	N3 is X3 + X4,
	N4 is 0,
	goLeft(X,N).
% X|Y|Y|Z -> X|2Y|Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X2 == X3,
	N1 is X1,
	N2 is X2 + X3,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% 0|0|0|X -> X|0|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	X3 == 0,
	N1 is X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|0|X|X -> 2X|0|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	X3 == X4,
	N1 is X3 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|0|X|Y -> X|Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	N1 is X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|X|0|X -> 2X|0|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X3 == 0,
	X2 == X4,
	N1 is X2 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|X|0|Y -> X|Y|0|)
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X3 == 0,
	N1 is X2,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|X|X|Y -> 2X|Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == X3,
	N1 is X2 + X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% 0|X|Y|Z -> X|Y|Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 \= 0,
	X3 \= 0,
	X2 \= X3,
	X3 \= X4,
	N1 is X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% 0|X|Y|Y -> X|2Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 \= 0,
	X3 == X4,
	N1 is X2,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|0|Y|Y -> X|2Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == X4,
	N1 is X1,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|0|X|Y -> 2X|Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X1 == X3,
	N1 is X1 + X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|0|Y|Z -> X|Y|Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 \= 0,
	N1 is X1,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% X|0|0|X -> 2X|0|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == 0,
	X1 == X4,
	N1 is X1 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	N4 is 0,
	goLeft(X,N).
% X|0|0|Y -> X|Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == 0,
	N1 is X1,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|X|0|Y -> 2X|Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X3 == 0,
	N1 is X1 + X2,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|Y|0|Y -> X|2Y|0|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X1 \= X2,
	X3 == 0,
	X2 == X4,
	N1 is X1,
	N2 is X2 + X4,
	N3 is 0,
	N4 is 0,
	goLeft(X,N).
% X|Y|0|Z -> X|Y|Z|0
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X3 == 0,
	N1 is X1,
	N2 is X2,
	N3 is X4,
	N4 is 0,
	goLeft(X,N).
% X|Y|Z|W -> X|Y|Z|W
goLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X3 \= 0,
	N1 is X1,
	N2 is X2,
	N3 is X3,
	N4 is X4,
	goLeft(X,N).


solve(Board,Depth) :-
    once(goUp(Board, BoardUp)),
    expected(Board, BoardUp, Depth, ScoreUp),

    once(goDown(Board, BoardDown)),
    expected(Board, BoardDown, Depth, ScoreDown),

    once(goLeft(Board, BoardLeft)),
    expected(Board, BoardLeft, Depth, ScoreLeft),

    once(goRight(Board, BoardRight)),
    expected(Board, BoardRight, Depth, ScoreRight),

    getMax(ScoreUp,ScoreDown,ScoreLeft,ScoreRight, NextMove),
    performMove(Board, NextMove, NewBoard),
    solve(NewBoard,Depth).

performMove(Board, l, NewBoard) :-
	once(goLeft(Board, B)),
	addNew(B, NewBoard).
performMove(Board, r, NewBoard) :-
	once(goRight(Board, B)),
	addNew(B, NewBoard).
performMove(Board, d, NewBoard) :-
	once(goDown(Board, B)),
	addNew(B, NewBoard).
performMove(Board, u, NewBoard) :-
	once(goUp(Board, B)).

getMax(ScoreL, ScoreR, ScoreU, ScoreD, r) :-
	ScoreR >= ScoreU,
	ScoreR >= ScoreD,
	ScoreR >= ScoreL.
getMax(ScoreL, ScoreR, ScoreU, ScoreD, u) :-
	ScoreU >= ScoreR,
	ScoreU >= ScoreD,
	ScoreU >= ScoreL.
getMax(ScoreL, ScoreR, ScoreU, ScoreD, d) :-
	ScoreD >= ScoreU,
	ScoreD >= ScoreR,
	ScoreD >= ScoreL.
getMax(_, _, _, _, l).

equal([H1|T1], [H2 |T2]) :-
    H1 == H2,
    equal(T1,T2).

expected(Board, NewBoard, _, 0) :-
    equal(Board,NewBoard).

expected(_,Board, Depth, Score) :-
    Depth >= 0,
    NextDepth is Depth - 1,
    getScore(Board,BoardScore),
    evalNext(Board, 0, NextDepth, Score0),
    evalNext(Board, 1, NextDepth, Score1),
    evalNext(Board, 2, NextDepth, Score2),
    evalNext(Board, 3, NextDepth, Score3),
    evalNext(Board, 4, NextDepth, Score4),
    evalNext(Board, 5, NextDepth, Score5),
    evalNext(Board, 6, NextDepth, Score6),
    evalNext(Board, 7, NextDepth, Score7),
    evalNext(Board, 8, NextDepth, Score8),
    evalNext(Board, 9, NextDepth, Score9),
    evalNext(Board, 10, NextDepth, Score10),
    evalNext(Board, 11, NextDepth, Score11),
    evalNext(Board, 12, NextDepth, Score12),
    evalNext(Board, 13, NextDepth, Score13),
    evalNext(Board, 14, NextDepth, Score14),
    evalNext(Board, 15, NextDepth, Score15),
    Score is 10 * BoardScore + Score0 + Score1 + Score2 + Score3 + Score4 + Score5 + Score6 + Score7 + Score8 + Score9 + Score10 + Score11 + Score12 + Score13 + Score14 + Score15.

evalNext([0,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 0, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([2,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[4,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,0,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 1, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,4,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,0,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 2, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,2,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,4,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,0,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 3, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,2,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,0,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 4, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,2,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,4,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,0,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], 5, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,4,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,0,B4,C1,C2,C3,C4,D1,D2,D3,D4], 6, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,2,B4,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,4,B4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,0,C1,C2,C3,C4,D1,D2,D3,D4], 7, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,2,C1,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,4,C1,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,0,C2,C3,C4,D1,D2,D3,D4], 8, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,2,C2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,4,C2,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,0,C3,C4,D1,D2,D3,D4], 9, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,2,C3,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,4,C3,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,0,C4,D1,D2,D3,D4], 10, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,2,C4,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,4,C4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,0,D1,D2,D3,D4], 11, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,2,D1,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,4,D1,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,0,D2,D3,D4], 12, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,2,D2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,4,D2,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,0,D3,D4], 13, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,2,D3,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,4,D3,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,0,D4], 14, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,2,D4],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,4,D4],NewLevel,Score).
evalNext([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,0], 15, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	evalMoves([A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,2],[A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,4],NewLevel,Score).
evalNext(_, _, _, 0).

evalMoves(B2, B4, Level, Score) :-
	once(goLeft(B2, B2L)),
	expected(B2, B2L, Level, S2L),
	once(goLeft(B4, B4L)),
	expected(B4, B4L, Level, S4L),
	once(goRight(B2, B2R)),
	expected(B2, B2R, Level, S2R),
	once(goRight(B4, B4R)),
	expected(B4, B4R, Level, S4R),
	once(goUp(B2, B2U)),
	expected(B2, B2U, Level, S2U),
	once(goUp(B4, B4U)),
	expected(B4, B4U, Level, S4U),
	once(goDown(B2, B2D)),
	expected(B2, B2D, Level, S2D),
	once(goDown(B4, B4D)),
	expected(B4, B4D, Level, S4D),
	Score is 9*(S2L+S2R+S2U+S2D)+S4L+S4R+S4U+S4D.

getScore(Board,BoardScore) :-
    squared(Board, Squared),
    sum_list(Squared, Score).

squared([], []).
squared([H1|T1], [H2|T2]) :-
	H2 is H1 * H1,
	squared(T1,T2).

