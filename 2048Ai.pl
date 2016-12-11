% Board format is:
%   A1 A2 A3 A4
%   B1 B2 B3 B4
%   C1 C2 C3 C4
%   D1 D2 D3 D4
%  and is used as a list:
%   [A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4]

:- use_module(library(clpr)).

:- dynamic(boardScore/2).

aigame(Board, _) :-
	max_list(Board, 2048),
	nl,write('AI succeded!'),nl,
	abort.

aigame(Board, _) :-
	noMoreMoves(Board),
	nl,write('AI failed :('),nl,
	abort.

aigame(Board, Depth, Move) :-
	write('Scores:'),
	once(moveLeft(Board, L)),
	evaluate(Board, L, Depth, ScoreL),
	write(' L='),write(ScoreL),
	once(moveRight(Board, R)),
	evaluate(Board, R, Depth, ScoreR),
	write(' R='),write(ScoreR),
	once(moveUp(Board, U)),
	evaluate(Board, U, Depth, ScoreU),
	write(' U='),write(ScoreU),
	once(moveDown(Board, D)),
	evaluate(Board, D, Depth, ScoreD),
	write(' D='),write(ScoreD),write('\n'),
	selectMove(ScoreL, ScoreR, ScoreU, ScoreD, Move),
	!.

aimove(Board, l, NewBoard) :-
	write(', Move: left'),nl,
	once(moveLeft(Board, B)),
	addNew(B, NewBoard).
aimove(Board, r, NewBoard) :-
	write(', Move: right'),nl,
	once(moveRight(Board, B)),
	addNew(B, NewBoard).
aimove(Board, d, NewBoard) :-
	write(', Move: down'),nl,
	once(moveDown(Board, B)),
	addNew(B, NewBoard).
aimove(Board, u, NewBoard) :-
	write(', Move: up'),nl,
	once(moveUp(Board, B)),
	addNew(B, NewBoard).

% the move with the highest score is selected
selectMove(ScoreL, ScoreR, ScoreU, ScoreD, r) :-
	ScoreR >= ScoreU,
	ScoreR >= ScoreD,
	ScoreR >= ScoreL.
selectMove(ScoreL, ScoreR, ScoreU, ScoreD, u) :-
	ScoreU >= ScoreR,
	ScoreU >= ScoreD,
	ScoreU >= ScoreL.
selectMove(ScoreL, ScoreR, ScoreU, ScoreD, d) :-
	ScoreD >= ScoreU,
	ScoreD >= ScoreR,
	ScoreD >= ScoreL.
selectMove(_, _, _, _, l).

% if the move is not possible, it gets a score of 0
evaluate(Board, NewBoard, _, 0) :-
	equal(Board, NewBoard).

evaluate(_, Board, Level, Score) :-
	Level >= 0,
	NewLevel is Level - 1,
	boardScore(Board, BScore),
	asserta(boardScore(Board, BScore)),
	evalNext(Board, 0, NewLevel, S0),
	evalNext(Board, 1, NewLevel, S1),
	evalNext(Board, 2, NewLevel, S2),
	evalNext(Board, 3, NewLevel, S3),
	evalNext(Board, 4, NewLevel, S4),
	evalNext(Board, 5, NewLevel, S5),
	evalNext(Board, 6, NewLevel, S6),
	evalNext(Board, 7, NewLevel, S7),
	evalNext(Board, 8, NewLevel, S8),
	evalNext(Board, 9, NewLevel, S9),
	evalNext(Board, 10, NewLevel, S10),
	evalNext(Board, 11, NewLevel, S11),
	evalNext(Board, 12, NewLevel, S12),
	evalNext(Board, 13, NewLevel, S13),
	evalNext(Board, 14, NewLevel, S14),
	evalNext(Board, 15, NewLevel, S15),
	Score is 10*BScore+S0+S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13+S14+S15.

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
	once(moveLeft(B2, B2L)),
	evaluate(B2, B2L, Level, S2L),
	once(moveLeft(B4, B4L)),
	evaluate(B4, B4L, Level, S4L),
	once(moveRight(B2, B2R)),
	evaluate(B2, B2R, Level, S2R),
	once(moveRight(B4, B4R)),
	evaluate(B4, B4R, Level, S4R),
	once(moveUp(B2, B2U)),
	evaluate(B2, B2U, Level, S2U),
	once(moveUp(B4, B4U)),
	evaluate(B4, B4U, Level, S4U),
	once(moveDown(B2, B2D)),
	evaluate(B2, B2D, Level, S2D),
	once(moveDown(B4, B4D)),
	evaluate(B4, B4D, Level, S4D),
	Score is 9*(S2L+S2R+S2U+S2D)+S4L+S4R+S4U+S4D.

% calculates the score for a board. The score is just the sum of squares
% of all tile values
boardScore(Board, Score) :-
	squared(Board, Squared),
	sum_list(Squared, PreScore1),
	%write( 'SumList : ' ), write( PreScore1 ),
	penalty(Board, PreScore1, PreScore2),
	write( ' 0Reward: ' ), write( PreScore2 - PreScore1 ),
	maxOnEdge( Board, PreScore2, PreScore3 ),
	adjacentCell( Board, PreScore3, PreScore4 ),
	monotonic( Board, PreScore4, PreScore5 ),
	corner( Board, PreScore5, Score ).

% most value tile on the corner
corner( [A1,A2,A3,A4, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4], InputScore, Score ):-
    findMax( Board, Value ),
    member( [A1,A4,D1,D4], Value, Bool ),
    ThisScore is 50 * Bool,
    Score is InputScore + ThisScore.

member( [], _, 0 ):- !.

member( [X|Y], X, 1 ):- !.

member( [X|Y] , Value, Bool ):-
    member( Y, Value, Bool ).

findMax( [], 0 ):- !.

findMax( [X|Y], Value ):- !,
    findMax( Y, Value1 ),
    max( X, Value1, Value ).

max( X, Y, X ):-
    X > Y, !.

max( X, Y, Y ):-
    Y >= X, !.

%check monotonic
monotonic( [A1,A2,A3,A4, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4], InputScore, Score ):-
    computeMono( [A1,A2,A3,A4] , Score1),
    computeMono( [B1,B2,B3,B4] , Score2),
    computeMono( [C1,C2,C3,C4] , Score3),
    computeMono( [D1,D2,D3,D4] , Score4),

    computeMono( [A1,B1,C1,D1] , Score5),
    computeMono( [A2,B2,C2,D2] , Score6),
    computeMono( [A3,B3,C3,D3] , Score7),
    computeMono( [A4,B4,C4,D4] , Score8),

    ThisScore is (Score1 + Score2+ Score3+ Score4+ Score5+ Score6+ Score7+ Score8),
    Score is InputScore + ThisScore*0.8,
    write( ' Mono: ' ), write( ThisScore ).

% change expo to linear
log( 0, _, 0 ):- !.

log( X, Y, Z ):-
    { X = Y^Z }, !.

computeMono( [_|[]], 0 ) :- !.

computeMono( [X,Y|Z] , Score):-
    X is Y/2, !,
    computeMono( [Y|Z] , ScoreT ),
    log( X,2,Log1 ), log( Y,2,Log2 ),
    Score is ScoreT + Log1 + Log2.

computeMono( [X,Y|Z] , Score):-
    X is Y/4, !,
    computeMono( [Y|Z] , ScoreT ),
    log( X,2,Log1 ), log( Y,2,Log2 ),
    Score is ScoreT + Log1 + Log2.

computeMono( [X,Y|Z] , Score):-
    X is Y*2, !,
    computeMono( [Y|Z] , ScoreT ),
    log( X,2,Log1 ), log( Y,2,Log2 ),
    Score is ScoreT + Log1 + Log2.

computeMono( [X,Y|Z] , Score):-
    X is Y*4, !,
    computeMono( [Y|Z] , ScoreT ),
    log( X,2,Log1 ), log( Y,2,Log2 ),
    Score is ScoreT + Log1 + Log2.

computeMono( [_, _|Z], Score ):-
     !,
    computeMono( [Y|Z], Score ).

maxOnEdge( [A1,A2,A3,A4, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4], InputScore ,Score ):-
    ThisScore is ((A1 + A2 +A3 +A4 +B1 +B4 +C1 +C4 +D1 +D2 +D3 +D4))*0.3,
    Score is InputScore + ThisScore,
    write( ' Edge: ' ), write( ThisScore ).

% give bonus to open space
penalty([H1|T1] , Hehe, Score) :-
    H1 =\= 0, !,
    penalty( T1, Hehe, Score ), !.

penalty([H1|T1] , Hehe, Score) :-
    H1 is 0,
    penalty( T1, Hehe, Score1 ),
    Score is Score1 + 10, !.

penalty([], Hehe, Hehe).

% same value adjacent to each other
adjacentCell( [A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], InputScore , Score ):-
    adjacent( A1,[A2,B1], Score1 ),
    adjacent( A2,[A1,A3,B2], Score2 ),
    adjacent( A3,[A2,A4,B3], Score3 ),
    adjacent( A4,[A3,B4 ], Score4),

    adjacent( B1,[B2,C1,A1], Score5 ),
    adjacent( B2,[B1,B3,A2,C2], Score6 ),
    adjacent( B3,[B2,B4,A3,C3], Score7 ),
    adjacent( B4,[B3,A4,C4 ], Score8),

    adjacent( C1,[C2,B1,D1], Score9 ),
    adjacent( C2,[C1,C3,B2,D2], Score10 ),
    adjacent( C3,[C2,C4,B3,D3], Score11 ),
    adjacent( C4,[C3,B4,D4 ], Score12),

    adjacent( D1,[D2,C1], Score13 ),
    adjacent( D2,[D1,D3,C2], Score14 ),
    adjacent( D3,[D2,D4,C3], Score15 ),
    adjacent( D4,[D3,C4 ], Score16),
    Score is InputScore + Score1+ Score2+ Score3+ Score4+ Score5+ Score6+ Score7+ Score8+ Score9+ Score10+ Score11+ Score12+ Score13+ Score14+ Score15+ Score16,
    write( ' Adjacent: ' ), write( Score - InputScore ),nl.

adjacent( _,[], 0 ):- !.

adjacent( Z ,[X|Y], Score ):-
    Z =\= X, !,
    adjacent( Z, Y, Score ).

adjacent( Z, [Z|Y], Score ):-
    adjacent( Z, Y, Score1 ),
    Score is Score1 + 1.


% square every value of a list
squared([], []).
squared([H1|T1], [H2|T2]) :-
	H2 is H1 * H1 *H1 *H1,
	squared(T1,T2).



% check if there are no more available moves
noMoreMoves(Board) :-
	once(moveLeft(Board, X)),
	equal(Board, X),
	once(moveRight(Board, Y)),
	equal(Board, Y),
	once(moveUp(Board, Z)),
	equal(Board,Z),
	once(moveDown(Board, W)),
	equal(Board,W).

% checks if two lists are equal
equal([],[]).
equal([H1|T1],[H2|T2]) :-
	H1 == H2,
	equal(T1,T2).

% rotate the board to the right
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

% rotate the board to the left
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

% only moveLeft is actually implemented. Every other move just rotates
% the board first and then uses moveLeft.
moveUp(Board, NewBoard):-
	rotateLeft(Board, Temp1),
	moveLeft(Temp1, Temp2),
	rotateRight(Temp2, NewBoard).

moveDown(Board, NewBoard):-
	rotateRight(Board, Temp1),
	moveLeft(Temp1, Temp2),
	rotateLeft(Temp2, NewBoard).

moveRight(Board, NewBoard):-
	rotateLeft(Board, Temp1),
	rotateLeft(Temp1, Temp2),
	moveLeft(Temp2, Temp3),
	rotateRight(Temp3, Temp4),
	rotateRight(Temp4, NewBoard).

moveLeft([], []).
% X|X|X|X -> 2X|2X|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X3 \= 0,
	X1 == X2,
	X3 == X4,
	N1 is X1 + X2,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X, N).
% X|X|X|Y -> 2X|X|Y|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X2 == X3,
	N1 is X1 + X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% X|X|Y|Z -> 2X|Y|Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X3 \= 0,
	N1 is X1 + X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% X|Y|Z|Z -> X|Y|2Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X1 \= X2,
	X2 \= X3,
	X3 == X4,
	N1 is X1,
	N2 is X2,
	N3 is X3 + X4,
	N4 is 0,
	moveLeft(X,N).
% X|Y|Y|Z -> X|2Y|Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X2 == X3,
	N1 is X1,
	N2 is X2 + X3,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% 0|0|0|X -> X|0|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	X3 == 0,
	N1 is X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|0|X|X -> 2X|0|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	X3 == X4,
	N1 is X3 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|0|X|Y -> X|Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == 0,
	N1 is X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|X|0|X -> 2X|0|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X3 == 0,
	X2 == X4,
	N1 is X2 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|X|0|Y -> X|Y|0|)
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X3 == 0,
	N1 is X2,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|X|X|Y -> 2X|Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 == X3,
	N1 is X2 + X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% 0|X|Y|Z -> X|Y|Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 \= 0,
	X3 \= 0,
	X2 \= X3,
	X3 \= X4,
	N1 is X2,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% 0|X|Y|Y -> X|2Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 == 0,
	X2 \= 0,
	X3 == X4,
	N1 is X2,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|0|Y|Y -> X|2Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == X4,
	N1 is X1,
	N2 is X3 + X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|0|X|Y -> 2X|Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X1 == X3,
	N1 is X1 + X3,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|0|Y|Z -> X|Y|Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 \= 0,
	N1 is X1,
	N2 is X3,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% X|0|0|X -> 2X|0|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == 0,
	X1 == X4,
	N1 is X1 + X4,
	N2 is 0,
	N3 is 0,
	N4 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|0|0|Y -> X|Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 == 0,
	X3 == 0,
	N1 is X1,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|X|0|Y -> 2X|Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X1 == X2,
	X3 == 0,
	N1 is X1 + X2,
	N2 is X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|Y|0|Y -> X|2Y|0|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X1 \= X2,
	X3 == 0,
	X2 == X4,
	N1 is X1,
	N2 is X2 + X4,
	N3 is 0,
	N4 is 0,
	moveLeft(X,N).
% X|Y|0|Z -> X|Y|Z|0
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X3 == 0,
	N1 is X1,
	N2 is X2,
	N3 is X4,
	N4 is 0,
	moveLeft(X,N).
% X|Y|Z|W -> X|Y|Z|W
moveLeft([X1,X2,X3,X4|X], [N1,N2,N3,N4|N]) :-
	X1 \= 0,
	X2 \= 0,
	X3 \= 0,
	N1 is X1,
	N2 is X2,
	N3 is X3,
	N4 is X4,
	moveLeft(X,N).

