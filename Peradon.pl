
guessLevel( [X|Y], Depth, Avg ) :-

	genTableTwo( [X|Y],1, BoardTwo1 ),
	expectimax( BoardTwo1, Depth, ScoreTwo1 ,_),

	genTableTwo( [X|Y],2, BoardTwo2 ),
	expectimax( BoardTwo2, Depth, ScoreTwo2 ,_),

	genTableTwo( [X|Y],3, BoardTwo3 ),
	expectimax( BoardTwo3, Depth, ScoreTwo3 ,_),

	genTableTwo( [X|Y],4, BoardTwo4 ),
	expectimax( BoardTwo4, Depth, ScoreTwo4 ,_),

	genTableTwo( [X|Y],5, BoardTwo5 ),
	expectimax( BoardTwo5, Depth, ScoreTwo5 ,_),

	genTableTwo( [X|Y],6, BoardTwo6 ),
	expectimax( BoardTwo6, Depth, ScoreTwo6 ,_),

	genTableTwo( [X|Y],7, BoardTwo7 ),
	expectimax( BoardTwo7, Depth, ScoreTwo7 ,_),

	genTableTwo( [X|Y],8, BoardTwo8 ),
	expectimax( BoardTwo8, Depth, ScoreTwo8 ,_),

	genTableTwo( [X|Y],9, BoardTwo9 ),
	expectimax( BoardTwo9, Depth, ScoreTwo9 ,_),

	genTableTwo( [X|Y],10, BoardTwo10 ),
	expectimax( BoardTwo10, Depth, ScoreTwo10 ,_),

	genTableTwo( [X|Y],11, BoardTwo11 ),
	expectimax( BoardTwo11, Depth, ScoreTwo11 ,_),

	genTableTwo( [X|Y],12, BoardTwo12 ),
	expectimax( BoardTwo12, Depth, ScoreTwo12 ,_),

	genTableTwo( [X|Y],13, BoardTwo13 ),
	expectimax( BoardTwo13, Depth, ScoreTwo13 ,_),

	genTableTwo( [X|Y],14, BoardTwo14 ),
	expectimax( BoardTwo14, Depth, ScoreTwo14 ,_),

	genTableTwo( [X|Y],15, BoardTwo15 ),
	expectimax( BoardTwo15, Depth, ScoreTwo15 ,_),

	genTableTwo( [X|Y],16, BoardTwo16 ),
	expectimax( BoardTwo16, Depth, ScoreTwo16 ,_),

	genTableFour( [X|Y],1, BoardFour1 ),
	expectimax( BoardFour1, Depth, ScoreFour1 ,_),

	genTableFour( [X|Y],2, BoardFour2 ),
	expectimax( BoardFour2, Depth, ScoreFour2 ,_),

	genTableFour( [X|Y],3, BoardFour3 ),
	expectimax( BoardFour3, Depth, ScoreFour3 ,_),

	genTableFour( [X|Y],4, BoardFour4 ),
	expectimax( BoardFour4, Depth, ScoreFour4 ,_),

	genTableFour( [X|Y],5, BoardFour5 ),
	expectimax( BoardFour5, Depth, ScoreFour5 ,_),

	genTableFour( [X|Y],6, BoardFour6 ),
	expectimax( BoardFour6, Depth, ScoreFour6 ,_),

	genTableFour( [X|Y],7, BoardFour7 ),
	expectimax( BoardFour7, Depth, ScoreFour7 ,_),

	genTableFour( [X|Y],8, BoardFour8 ),
	expectimax( BoardFour8, Depth, ScoreFour8 ,_),

	genTableFour( [X|Y],9, BoardFour9 ),
	expectimax( BoardFour9, Depth, ScoreFour9 ,_),

	genTableFour( [X|Y],10, BoardFour10 ),
	expectimax( BoardFour10, Depth, ScoreFour10 ,_),

	genTableFour( [X|Y],11, BoardFour11 ),
	expectimax( BoardFour11, Depth, ScoreFour11 ,_),

	genTableFour( [X|Y],12, BoardFour12 ),
	expectimax( BoardFour12, Depth, ScoreFour12 ,_),

	genTableFour( [X|Y],13, BoardFour13 ),
	expectimax( BoardFour13, Depth, ScoreFour13 ,_),

	genTableFour( [X|Y],14, BoardFour14 ),
	expectimax( BoardFour14, Depth, ScoreFour14 ,_),

	genTableFour( [X|Y],15, BoardFour15 ),
	expectimax( BoardFour15, Depth, ScoreFour15 ,_),

	genTableFour( [X|Y],16, BoardFour16 ),
	expectimax( BoardFour16, Depth, ScoreFour16 ,_),

	Score is ( ScoreTwo1 +ScoreTwo2 +ScoreTwo3 +ScoreTwo4 +ScoreTwo5 +ScoreTwo6 +ScoreTwo7 +ScoreTwo8 +ScoreTwo9 +ScoreTwo10 +ScoreTwo11 +ScoreTwo12 +ScoreTwo13 +ScoreTwo14 +ScoreTwo15 +ScoreTwo16 )*0.9
				+ ( ScoreFour1 +ScoreFour2 +ScoreFour3 +ScoreFour4 +ScoreFour5 +ScoreFour6 +ScoreFour7 +ScoreFour8 +ScoreFour9 +ScoreFour10 +ScoreFour11 +ScoreFour12 +ScoreFour13 +ScoreFour14 +ScoreFour15 +ScoreFour16 ) *0.1,

	Avg is Score/32.


solve( [X|Y], Depth, Avg, Action ):-
    write('in'),
	expectimax( [X|Y], Depth, Avg, Action ).

expectimax( [], _, 0, _ ).

%last depth so find score

expectimax( Board, 0, Score, _ ):-
	edgeMostScore( Board, EdgeScore ),
	Score is EdgeScore.


expectimax( [X|Y], Depth, Avg, Action ):-
	NewDepth is Depth -1,

	move([X|Y], u, BoardMovedUp),
	guessLevel( BoardMovedUp, NewDepth, AvgUp ),
	move([X|Y], d, BoardMovedDown),
	guessLevel( BoardMovedDown, NewDepth, AvgDown ),
	move([X|Y], l, BoardMovedLeft),
	guessLevel( BoardMovedLeft, NewDepth, AvgLeft ),
	move([X|Y], r, BoardMovedRight),
	guessLevel( BoardMovedRight, NewDepth, AvgRight ),
	chooseAction( AvgUp, AvgDown, AvgLeft, AvgRight, Avg, Action ).

chooseAction( AvgUp, AvgDown, AvgLeft, AvgRight, AvgUp, 'up' ):-
	AvgUp >= AvgDown,
	AvgUp >= AvgLeft,
	AvgUp >= AvgRight.

chooseAction( AvgUp, AvgDown, AvgLeft, AvgRight, AvgDown,'down' ):-
	AvgDown >= AvgUp,
	AvgDown >= AvgLeft,
	AvgDown >= AvgRight.

chooseAction( AvgUp, AvgDown, AvgLeft, AvgRight, AvgLeft,'left' ):-
	AvgLeft >= AvgDown,
	AvgLeft >= AvgUp,
	AvgLeft >= AvgRight.

chooseAction( AvgUp, AvgDown, AvgLeft, AvgRight, AvgRight,'right' ):-
	AvgRight > AvgDown,
	AvgRight > AvgLeft,
	AvgRight > AvgUp.

chooseAction( _,_,_, AvgLeft, 'left' ).


% genTableTwo
genTableTwo( [ 0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 1, [ 2,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,0,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 2, [ A0,2,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,0,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 3, [ A0,A1,2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,0, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 4, [ A0,A1,A2,2, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, 0,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 5, [ A0,A1,A2,A3, 2,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,0,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 6, [ A0,A1,A2,A3, B1,2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,0,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 7, [ A0,A1,A2,A3, B1,B2,2,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,0, C1,C2,C3,C4, D1,D2,D3,D4  ], 8, [ A0,A1,A2,A3, B1,B2,B3,2, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, 0,C2,C3,C4, D1,D2,D3,D4  ], 9, [ A0,A1,A2,A3, B1,B2,B3,B4, 2,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,0,C3,C4, D1,D2,D3,D4  ], 10, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,2,C3,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,0,C4, D1,D2,D3,D4  ], 11, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,2,C4, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,0, D1,D2,D3,D4  ], 12, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,2, D1,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, 0,D2,D3,D4  ], 13, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, 2,D2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,0,D3,D4  ], 14, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,2,D3,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,0,D4  ], 15, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,2,D4  ] ).
genTableTwo( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,0  ], 16, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,2  ] ).
genTableTwo( _,_,[] ).

% genTableFour
genTableFour( [ 0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 1, [ 4,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,0,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 2, [ A0,4,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,0,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 3, [ A0,A1,4,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,0, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 4, [ A0,A1,A2,4, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, 0,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 5, [ A0,A1,A2,A3, 2,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,0,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 6, [ A0,A1,A2,A3, B1,4,B3,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,0,B4, C1,C2,C3,C4, D1,D2,D3,D4  ], 7, [ A0,A1,A2,A3, B1,B2,4,B4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,0, C1,C2,C3,C4, D1,D2,D3,D4  ], 8, [ A0,A1,A2,A3, B1,B2,B3,4, C1,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, 0,C2,C3,C4, D1,D2,D3,D4  ], 9, [ A0,A1,A2,A3, B1,B2,B3,B4, 2,C2,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,0,C3,C4, D1,D2,D3,D4  ], 10, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,4,C3,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,0,C4, D1,D2,D3,D4  ], 11, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,4,C4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,0, D1,D2,D3,D4  ], 12, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,4, D1,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, 0,D2,D3,D4  ], 13, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, 2,D2,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,0,D3,D4  ], 14, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,4,D3,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,0,D4  ], 15, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,4,D4  ] ).
genTableFour( [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,0  ], 16, [ A0,A1,A2,A3, B1,B2,B3,B4, C1,C2,C3,C4, D1,D2,D3,4  ] ).
genTableFour( _,_,[] ).

findZeroAmount( [], 0 ).

findZeroAmount( [X|Y], Num ):-
	X is 0,
	findZeroAmount( Y, Num1 ),
	Num is Num1 +1.

findZeroAmount( [X|Y], Num ):-
	findZeroAmount( Y, Num ).

isEdge( [A1,A2,A3,A4], 2 ):-
	A1 =< A2,
	A2 =< A3,
	A3 =< A4.

isEdge( _, 0 ).

edgeMostScore( [A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4], Score ):-
	% horizontal
	isEdge( [A1,A2,A3,A4], Hor1 ),
	isEdge( [B1,B2,B3,B4], Hor2 ),
	isEdge( [C1,C2,C3,C4], Hor3 ),
	isEdge( [D1,D2,D3,D4], Hor4 ),
	% verticle
	isEdge( [A1,B1,C1,D1], Ver1 ),
	isEdge( [A2,B2,C2,D2], Ver2 ),
	isEdge( [A3,B3,C3,D3], Ver3 ),
	isEdge( [A4,B4,C4,D4], Ver4 ),
	Score is Hor1 + Hor2 + Hor3 + Hor4 + Ver1 + Ver2 + Ver3 + Ver4.




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


