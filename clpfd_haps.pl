% Constraint Logic Programming
:- use_module(library(dif)).	% Sound inequality
:- use_module(library(clpfd)).	% Finite domain constraints
:- use_module(library(clpb)).	% Boolean constraints
:- use_module(library(chr)).	% Constraint Handling Rules
:- use_module(library(when)).	% Coroutining
%:- use_module(library(clpq)).  % Constraints over rational numbers

% Your program goes here

fd_length(L, N) :-
   N #>= 0,
   fd_length(L, N, 0).

fd_length([], N, N0) :-
   N #= N0.
fd_length([_|L], N, N0) :-
   N1 #= N0+1,
   N #>= N1,
   fd_length(L, N, N1).

binary_number(Bs, N) :-
   binary_number_min(Bs, 0,N, N).

binary_number_min([], N,N, _M).
binary_number_min([B|Bs], N0,N, M) :-
   B in 0..1,
   N1 #= B+2*N0,
   M #>= N1,
   binary_number_min(Bs, N1,N, M).


conflation(2,0,1). %Heterozygous
conflation(2,1,0). %Heterozygous
conflation(0,0,0). %Homozygous
conflation(1,1,1). %Homozygous.

conflation_seq([],[],[]).
conflation_seq([G|Gs],[HA1|HAs],[HB1|HBs]):-
       conflation(G,HA1,HB1),
       conflation_seq(Gs,HAs,HBs).

gs_hs([],_).
gs_hs([G|G_Rest],Hs):-
    %quick_sort2(Hs,Hs),
    %haplotype(H1),
    %haplotype(H2),
    conflation_seq(G,H1,H2),
    member(H1,Hs),
    member(H2,Hs),
    gs_hs(G_Rest,Hs).

haplotype(_).

/** <examples> Your example queries go here, e.g.
?- X #=<5, fd_length(Haps,X), maplist(binary_number,Haps,Order),chain(Order, #<),gs_hs([[2,1,2],[1,2,1]],Haps).
*/
