% Q1
% Write a prolog predicate insert(Num, List, NewList) that takes a number Num 
% along with a list of numbers List which is already sorted in increasing order, 
% and binds NewList to the list obtained by inserting Num into List so that the 
% resulting list is still sorted in increasing order.
%
% Base Case
insert(New,[],[New]).

% New node goes at front of list
insert(New,[Head|Tail],[New,Head|Tail]) :-
   New =< Head.

% New node is inserted into existing list
insert(New,[Head|Tail],[Head|Tail1]) :-
   New > Head,
   insert(New,Tail,Tail1).
-------------------------------------------
% Q2
% Write a predicate isort(List,NewList) that takes a List of numbers in any order, and 
% binds NewList to the list containing the same numbers sorted in increasing order. 
% Base Case
isort([],[]).

% Sort the Tail and then insert the Head
isort([Head|Tail],List) :-
   isort(Tail,Tail_Sorted),
   insert(Head,Tail_Sorted,List).
-------------------------------------------  
% Q3
% Write a predicate split(BigList,List1,List2) which takes a list BigList and divides 
% the items into two smaller lists List1 and List2, as evenly as possible 
% (i.e. so that the number of items in List1 and List2 differs by no more that 1).
% Base Case 0: empty list
split([],[],[]).

% Base Case 1: list with one item
split([A],[A],[]).

% Assign first item to first list, second item to second list
% and recursively split the rest of the list.
split([A,B|T],[A|R],[B|S]) :-
   split(T,R,S).
-------------------------------------------  
% Q4
% Write a predicate merge(Sort1,Sort2,Sort) which takes two lists Sort1 and Sort2 
% that are already sorted in increasing order, and binds Sort to a new list which 
% combines the elements from Sort1 and Sort2, and is sorted in increasing order.
% If one list is empty, return the other list
merge(A,[],A).
merge([],B,B).

% If first item of first list is smaller,
% it becomes first item of the merged list
merge([A|R],[B|S],[A|T]) :-
   A =< B,
   merge(R,[B|S],T).

% If first item of second list is smaller,
% it becomes first item of the merged list
merge([A|R],[B|S],[B|T]) :-
   A > B,
   merge([A|R],S,T).
-------------------------------------------  
% Q5
% Write a predicate mergesort(List,NewList) which has the same functionality as 
% the isort() predicate from part (2) above, but uses the MergeSort algorithm. 
% Base Cases: empty list or list with one item
mergesort([],[]).
mergesort([A],[A]).

% If the list has more than one item,
% split it into two lists of (nearly) equal size,
% sort the two smaller lists, and merge them. 
mergesort([A,B|T],S) :-  
   split([A,B|T],L1,L2),
   mergesort(L1,S1),
   mergesort(L2,S2),
   merge(S1,S2,S).