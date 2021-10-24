% s(CASP) Programming
:- use_module(library(scasp)).

% Your program goes here
conflation(2,0,1). %Heterozygous
conflation(2,1,0). %Heterozygous
conflation(0,0,0). %Homozygous
conflation(1,1,1). %Homozygous.

conflation_seq([],[],[]).
conflation_seq([G|Gs],[HA1|HAs],[HB1|HBs]):-
       conflation(G,HA1,HB1),
       conflation_seq(Gs,HAs,HBs).

fd_length(L, N) :-
   N #>= 0,
   fd_length(L, N, 0).

fd_length([], N, N0) :-
   N #= N0.
fd_length([_|L], N, N0) :-
   N1 is N0+1,
   N #>= N1,
   fd_length(L, N, N1).

%List of genome sequesnce and list of haplotype sequences
%Ensure the list is sorted somehow?
gs_hs([],_).
gs_hs([G|G_Rest],Hs):-
    quick_sort2(Hs,Hs),
    haplotype(H1),
    haplotype(H2),
    conflation_seq(G,H1,H2),
    member(H1,Hs),
    member(H2,Hs),
    gs_hs(G_Rest,Hs).

haplotype(_).

pivoting(_H,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X=<H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X>H,pivoting(H,T,L,G).

quick_sort2(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).
/** <examples> Your example queries go here, e.g.
?- ? Y#<5,fd_length(X,Y).
?- ? Y#<5,fd_length(Hs,Y),gs_hs([[2,1,2],[1,2,1]],HS).
?- ? gs_hs([[2,1,2],[1,2,1]],[[0,1,0],[1,1,1],[1,0,1]]).
?- ? fd_length(Hs,Len), haplotype(H1),haplotype(H2),conflation_seq([2,1,2],H1,H2),member(H1,Hs),member(H2,Hs).
?- ? fd_length(Hs,Len), haplotype(H1),haplotype(H2),conflation_seq([2,1,2],H1,H2),member(H1,Hs),member(H2,Hs),haplotype(H1B),haplotype(H2B),conflation_seq([1,2,1],H1B,H2B),member(H1B,Hs),member(H2B,Hs).
*/
